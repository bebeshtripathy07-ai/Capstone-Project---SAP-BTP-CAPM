/**
 * Automated service tests for the Vendor Invoice Management System.
 * Runs against an in-memory SQLite database seeded from db/data/*.csv.
 *
 *   npm test
 */
const cds = require('@sap/cds');
const { GET, POST, PATCH } = cds.test(__dirname + '/..');

jest.setTimeout(60000);

// Mock users from package.json cds.requires.auth.users
const admin = { auth: { username: 'admin', password: 'Admin@123' } };
const manager1 = { auth: { username: 'manager1', password: 'Admin@123' } };
const manager2 = { auth: { username: 'manager2', password: '@123' } };
const approver1 = { auth: { username: 'approver1', password: 'Approver@123' } };
const viewer1 = { auth: { username: 'viewer1', password: 'Viewer@123' } };

// Stable IDs from db/data/vendorinvoice.db-Vendors.csv / -Invoices.csv
const APPROVED_VENDOR = '16156972-e7ef-40b3-8e07-3b12fb480727';
const APPROVED_VENDOR_2 = '16156982-f5b5-45b1-ac59-9680ddc5dc6b';
const PENDING_VENDOR = '6648354f-1b9d-462e-a4de-c8c1b7308553';
const SUBMITTED_INVOICE = '620955ce-3a44-4743-8c35-80ac3868ba74';

/** Create a draft invoice (optionally with items) and activate it. Returns the invoice ID. */
async function createInvoice(service, user, data) {
  const { data: draft, status } = await POST(`/odata/v4/${service}/Invoices`, data, user);
  expect(status).toBe(201);
  const svcName = service === 'admin' ? 'AdminService' : 'VendorService';
  await POST(
    `/odata/v4/${service}/Invoices(ID=${draft.ID},IsActiveEntity=false)/${svcName}.draftActivate`,
    {},
    user
  );
  return draft.ID;
}

const validInvoice = (nr, vendor = APPROVED_VENDOR, amount = 10000) => ({
  invoiceNumber: nr,
  vendor_ID: vendor,
  invoiceDate: '2026-06-01',
  dueDate: '2026-08-01',
  amount,
  currency: 'USD',
  items: [{ lineNumber: 1, description: 'Consulting', quantity: 2, unitPrice: amount / 2 }]
});

describe('Authentication & authorization', () => {
  test('rejects anonymous access with 401', async () => {
    await expect(GET('/odata/v4/admin/Invoices')).rejects.toThrow(/401/);
  });

  test('viewer cannot access the admin service', async () => {
    await expect(GET('/odata/v4/admin/Invoices', viewer1)).rejects.toThrow(/403/);
  });

  test('manager cannot call approver actions', async () => {
    await expect(
      POST(
        `/odata/v4/approver/Invoices(${SUBMITTED_INVOICE})/ApproverService.approveInvoice`,
        { comments: 'not allowed' },
        manager1
      )
    ).rejects.toThrow(/403/);
  });
});

describe('Admin service - invoice lifecycle', () => {
  test('admin can read vendors and invoices', async () => {
    const { data: vendors } = await GET('/odata/v4/admin/Vendors?$top=5', admin);
    expect(vendors.value.length).toBeGreaterThan(0);
    const { data: invoices } = await GET(
      '/odata/v4/admin/Invoices?$top=5&$filter=IsActiveEntity eq true',
      admin
    );
    expect(invoices.value.length).toBeGreaterThan(0);
  });

  test('create + activate a valid invoice results in status DRAFT', async () => {
    const id = await createInvoice('admin', admin, validInvoice('INV-AUTO-001'));
    const { data } = await GET(`/odata/v4/admin/Invoices(ID=${id},IsActiveEntity=true)`, admin);
    expect(data.status).toBe('DRAFT');
  });

  test('rejects invoices for non-approved vendors', async () => {
    await expect(
      createInvoice('admin', admin, validInvoice('INV-AUTO-002', PENDING_VENDOR))
    ).rejects.toThrow(/400/);
  });

  test('rejects future-dated invoices', async () => {
    const bad = { ...validInvoice('INV-AUTO-003'), invoiceDate: '2027-01-01' };
    await expect(createInvoice('admin', admin, bad)).rejects.toThrow(/400/);
  });

  test('rejects negative amounts', async () => {
    const bad = { ...validInvoice('INV-AUTO-004'), amount: -100, items: [] };
    await expect(createInvoice('admin', admin, bad)).rejects.toThrow(/400/);
  });

  test('submit fails when line items do not match the amount', async () => {
    const mismatch = validInvoice('INV-AUTO-005');
    mismatch.items[0].unitPrice = 1; // sum 2 ≠ amount 10000
    const id = await createInvoice('admin', admin, mismatch);
    await expect(
      POST(`/odata/v4/admin/Invoices(ID=${id},IsActiveEntity=true)/AdminService.submitForApproval`, {}, admin)
    ).rejects.toThrow(/400/);
  });

  test('submitForApproval moves DRAFT to SUBMITTED and writes history', async () => {
    const id = await createInvoice('admin', admin, validInvoice('INV-AUTO-006'));
    const { data } = await POST(
      `/odata/v4/admin/Invoices(ID=${id},IsActiveEntity=true)/AdminService.submitForApproval`,
      {},
      admin
    );
    expect(data.status).toBe('SUBMITTED');
    const { data: history } = await GET(
      `/odata/v4/admin/ApprovalHistory?$filter=invoice_ID eq ${id} and action eq 'SUBMITTED'`,
      admin
    );
    expect(history.value.length).toBe(1);
  });
});

describe('Approver service - approval rules', () => {
  let invoiceId;
  beforeAll(async () => {
    invoiceId = await createInvoice('admin', admin, validInvoice('INV-AUTO-010'));
    await POST(
      `/odata/v4/admin/Invoices(ID=${invoiceId},IsActiveEntity=true)/AdminService.submitForApproval`,
      {},
      admin
    );
  });

  test('submitter cannot approve their own invoice', async () => {
    await expect(
      POST(
        `/odata/v4/approver/Invoices(${invoiceId})/ApproverService.approveInvoice`,
        { comments: 'self-approval' },
        admin
      )
    ).rejects.toThrow(/400/);
  });

  test('a different approver can approve', async () => {
    const { data } = await POST(
      `/odata/v4/approver/Invoices(${invoiceId})/ApproverService.approveInvoice`,
      { comments: 'verified' },
      approver1
    );
    expect(data.status).toBe('APPROVED');
  });

  test('cannot reject an already-approved invoice', async () => {
    await expect(
      POST(
        `/odata/v4/approver/Invoices(${invoiceId})/ApproverService.rejectInvoice`,
        { reason: 'too late' },
        approver1
      )
    ).rejects.toThrow(/400/);
  });

  test('rejection requires a reason', async () => {
    await expect(
      POST(`/odata/v4/approver/Invoices(${SUBMITTED_INVOICE})/ApproverService.rejectInvoice`, {}, approver1)
    ).rejects.toThrow(/400/);
  });

  test('rejection with reason moves invoice to REJECTED', async () => {
    const { data } = await POST(
      `/odata/v4/approver/Invoices(${SUBMITTED_INVOICE})/ApproverService.rejectInvoice`,
      { reason: 'missing documents' },
      approver1
    );
    expect(data.status).toBe('REJECTED');
  });
});

describe('Vendor service - row-level security', () => {
  beforeAll(async () => {
    // Seed data has placeholder managers; assign one vendor to each test manager
    await PATCH(`/odata/v4/admin/Vendors(${APPROVED_VENDOR})`, { assignedManager: 'manager1' }, admin);
    await PATCH(`/odata/v4/admin/Vendors(${APPROVED_VENDOR_2})`, { assignedManager: 'manager2' }, admin);
  });

  test('managers see only their own approved vendors', async () => {
    const { data } = await GET('/odata/v4/vendor/Vendors', manager1);
    expect(data.value.length).toBe(1);
    expect(data.value[0].ID).toBe(APPROVED_VENDOR);
  });

  test('managers see disjoint vendor sets', async () => {
    const { data } = await GET('/odata/v4/vendor/Vendors', manager2);
    expect(data.value.map(v => v.ID)).not.toContain(APPROVED_VENDOR);
  });

  test('manager can create + submit an invoice for their own vendor', async () => {
    const id = await createInvoice('vendor', manager1, validInvoice('INV-AUTO-M1-001', APPROVED_VENDOR, 3000));
    const { data } = await POST(
      `/odata/v4/vendor/Invoices(ID=${id},IsActiveEntity=true)/VendorService.submitForApproval`,
      {},
      manager1
    );
    expect(data.status).toBe('SUBMITTED');
  });

  test("manager cannot create an invoice for another manager's vendor", async () => {
    await expect(
      createInvoice('vendor', manager1, validInvoice('INV-AUTO-M1-002', APPROVED_VENDOR_2, 3000))
    ).rejects.toThrow(/40[03]/);
  });

  test("manager cannot read another manager's invoice", async () => {
    await expect(
      GET(`/odata/v4/vendor/Invoices(ID=${SUBMITTED_INVOICE},IsActiveEntity=true)`, manager1)
    ).rejects.toThrow(/404/);
  });
});

describe('Viewer service - read-only', () => {
  test('viewer sees only APPROVED/PAID invoices', async () => {
    const { data } = await GET('/odata/v4/viewer/Invoices?$top=50', viewer1);
    for (const inv of data.value) {
      expect(['APPROVED', 'PAID']).toContain(inv.status);
    }
  });

  test('viewer cannot create invoices', async () => {
    await expect(
      POST('/odata/v4/viewer/Invoices', validInvoice('INV-SHOULD-FAIL'), viewer1)
    ).rejects.toThrow(/40[35]/);
  });
});
