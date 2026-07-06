const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const { Invoices, InvoiceItems, Vendors, ApprovalHistory } = this.entities;

  // Plain DB-level entities - used inside workflow actions to avoid draft complications
  const db = cds.entities('vendorinvoice.db');
  const { Invoices: DBInvoices, InvoiceItems: DBInvoiceItems, ApprovalHistory: DBApprovalHistory, Attachments } = db;

  // ---------- Block editing of core fields once invoice is no longer DRAFT ----------
  const protectedFields = ['invoiceNumber', 'vendor_ID', 'invoiceDate', 'dueDate', 'amount', 'currency'];

  this.before('UPDATE', 'Invoices', async (req) => {
    const touchesProtectedField = protectedFields.some(f => req.data[f] !== undefined);
    if (!touchesProtectedField) return; // this update is only our own action (status, approvedBy, etc.) - allow it

    const invoiceID = req.params[0].ID || req.params[0];
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (invoice && invoice.status !== 'DRAFT') {
      return req.error(400, 'This invoice can no longer be edited because it is not in Draft status');
    }
  });

  this.before('DELETE', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID || req.params[0];
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (invoice && invoice.status !== 'DRAFT') {
      return req.error(400, 'This invoice can no longer be deleted because it is not in Draft status');
    }
  });

  // ---------- Validate invoice header on create/update ----------
  this.before(['CREATE', 'UPDATE'], 'Invoices', async (req) => {
    const data = req.data;

    if (data.vendor_ID) {
      const vendor = await SELECT.one.from(Vendors).where({ ID: data.vendor_ID });
      if (!vendor) return req.error(400, 'Vendor not found');
      if (vendor.status !== 'APPROVED') {
        return req.error(400, 'Please select an approved vendor');
      }
    }

    if (data.invoiceDate) {
      const today = new Date().toISOString().slice(0, 10);
      if (data.invoiceDate > today) {
        return req.error(400, 'Invoice date cannot be in the future');
      }
    }

    if (data.dueDate && data.invoiceDate && data.dueDate < data.invoiceDate) {
      return req.error(400, 'Due date must be on or after invoice date');
    }

    if (data.amount !== undefined && (data.amount <= 0 || data.amount > 1000000)) {
      return req.error(400, 'Amount must be between 0.01 and 1,000,000');
    }

    // Invoice number unique per vendor
    if (data.invoiceNumber && data.vendor_ID) {
      const existing = await SELECT.one.from(Invoices).where({
        invoiceNumber: data.invoiceNumber,
        vendor_ID: data.vendor_ID
      });
      if (existing && existing.ID !== data.ID) {
        return req.error(400, `Invoice number ${data.invoiceNumber} already exists for this vendor`);
      }
    }
  });

  // ---------- Auto-calculate line item totals ----------
  this.before(['CREATE', 'UPDATE'], 'InvoiceItems', (req) => {
    const item = req.data;
    if (item.quantity !== undefined && item.quantity <= 0) {
      return req.error(400, 'Quantity must be greater than zero');
    }
    if (item.unitPrice !== undefined && item.unitPrice <= 0) {
      return req.error(400, 'Unit price must be greater than zero');
    }
    if (item.quantity !== undefined && item.unitPrice !== undefined) {
      item.totalAmount = item.quantity * item.unitPrice;
    }
  });

  // Auto-generate the next line number - no more manual typing
  this.before('CREATE', 'InvoiceItems', async (req) => {
    if (req.data.lineNumber) return; // don't override if somehow already set
    const invoiceID = req.data.invoice_ID;
    if (!invoiceID) return;
    const existing = await SELECT.from(InvoiceItems).where({ invoice_ID: invoiceID });
    const maxLine = existing.reduce((max, i) => Math.max(max, i.lineNumber || 0), 0);
    req.data.lineNumber = maxLine + 1;
  });

  // Auto-populate uploadedBy from the logged-in user - no more manual typing
  this.before('CREATE', 'Attachments', (req) => {
    if (!req.data.uploadedBy) {
      req.data.uploadedBy = req.user.id || 'anonymous';
    }
  });

  // ---------- Submit for Approval ----------
  this.on('submitForApproval', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const invoice = await SELECT.one.from(DBInvoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'DRAFT') {
      return req.error(400, 'Only draft invoices can be submitted');
    }

    const items = await SELECT.from(DBInvoiceItems).where({ invoice_ID: invoiceID });
    if (!items.length) {
      return req.error(400, 'Invoice must have at least one line item');
    }

    const sum = items.reduce((s, i) => s + (Number(i.quantity) * Number(i.unitPrice)), 0);
    if (Math.abs(sum - Number(invoice.amount)) > 0.01) {
      return req.error(400, `Line items total (${sum}) does not match invoice amount (${invoice.amount}). Adjustment required.`);
    }

    const user = req.user.id || 'anonymous';

    await UPDATE(DBInvoices).set({
      status: 'SUBMITTED',
      submittedBy: user,
      submittedAt: new Date().toISOString()
    }).where({ ID: invoiceID });

    await INSERT.into(DBApprovalHistory).entries({
      invoice_ID: invoiceID,
      action: 'SUBMITTED',
      actor: user,
      timestamp: new Date().toISOString(),
      comments: 'Invoice submitted for approval'
    });

    return SELECT.one.from(DBInvoices).where({ ID: invoiceID });
  });

  // ---------- Approve ----------
  this.on('approveInvoice', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const { comments } = req.data;
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'SUBMITTED') {
      return req.error(400, 'Only submitted invoices can be approved');
    }

    const user = req.user.id || 'anonymous';
    const isAdmin = req.user.role === 'Admin';

    if (!isAdmin && invoice.submittedBy === user) {
      return req.error(400, 'You cannot approve your own submitted invoice');
    }

    await UPDATE(Invoices).set({
      status: 'APPROVED',
      approvedBy: user,
      approvedAt: new Date().toISOString(),
      approvalComments: comments || null
    }).where({ ID: invoiceID });

    await INSERT.into(ApprovalHistory).entries({
      invoice_ID: invoiceID,
      action: 'APPROVED',
      actor: user,
      timestamp: new Date().toISOString(),
      comments: comments || 'Invoice approved'
    });

    return SELECT.one.from(Invoices).where({ ID: invoiceID });
  });

  // ---------- Reject ----------
  this.on('rejectInvoice', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const { reason } = req.data;
    if (!reason || !reason.trim()) {
      return req.error(400, 'Rejection reason is mandatory');
    }

    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'SUBMITTED') {
      return req.error(400, 'Only submitted invoices can be rejected');
    }

    const user = req.user.id || 'anonymous';

    await UPDATE(Invoices).set({
      status: 'REJECTED',
      rejectedBy: user,
      rejectedAt: new Date().toISOString(),
      rejectionReason: reason
    }).where({ ID: invoiceID });

    await INSERT.into(ApprovalHistory).entries({
      invoice_ID: invoiceID,
      action: 'REJECTED',
      actor: user,
      timestamp: new Date().toISOString(),
      comments: reason
    });

    return SELECT.one.from(Invoices).where({ ID: invoiceID });
  });

  // ---------- Mark as Paid (bonus feature) ----------
  this.on('markAsPaid', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'APPROVED') {
      return req.error(400, 'Only approved invoices can be marked as paid');
    }

    const user = req.user.id || 'anonymous';

    await UPDATE(Invoices).set({
      status: 'PAID',
      paidBy: user,
      paidAt: new Date().toISOString()
    }).where({ ID: invoiceID });

    await INSERT.into(ApprovalHistory).entries({
      invoice_ID: invoiceID,
      action: 'PAID',
      actor: user,
      timestamp: new Date().toISOString(),
      comments: 'Invoice marked as paid'
    });

    return SELECT.one.from(Invoices).where({ ID: invoiceID });
  });

  // ---------- Vendor field validation ----------
  this.before(['CREATE', 'UPDATE'], 'Vendors', (req) => {
    const v = req.data;
    if (v.vendorName !== undefined && !v.vendorName.trim()) {
      return req.error(400, 'Vendor name is required');
    }
    if (v.country !== undefined && !v.country.trim()) {
      return req.error(400, 'Country is required');
    }
    if (v.currency !== undefined && !v.currency.trim()) {
      return req.error(400, 'Currency is required');
    }
    if (v.taxID !== undefined && !v.taxID.trim()) {
      return req.error(400, 'Tax ID is required');
    }
  });

  // ---------- Prevent deleting a vendor that still has invoices ----------
  this.before('DELETE', 'Vendors', async (req) => {
    const vendorID = req.params[0].ID || req.params[0];
    const linkedInvoices = await SELECT.from(Invoices).where({ vendor_ID: vendorID });
    if (linkedInvoices.length > 0) {
      return req.error(400, 'Cannot delete a vendor that has existing invoices. Suspend it instead.');
    }
  });

  // ---------- Approve Vendor ----------
  this.on('approveVendor', 'Vendors', async (req) => {
    const vendorID = req.params[0].ID;
    const vendor = await SELECT.one.from(Vendors).where({ ID: vendorID });
    if (!vendor) return req.error(404, 'Vendor not found');
    if (vendor.status !== 'PENDING' && vendor.status !== 'SUSPENDED') {
      return req.error(400, 'Only pending or suspended vendors can be approved');
    }

    await UPDATE(Vendors).set({ status: 'APPROVED' }).where({ ID: vendorID });
    return SELECT.one.from(Vendors).where({ ID: vendorID });
  });

  // ---------- Suspend Vendor ----------
  this.on('suspendVendor', 'Vendors', async (req) => {
    const vendorID = req.params[0].ID;
    const vendor = await SELECT.one.from(Vendors).where({ ID: vendorID });
    if (!vendor) return req.error(404, 'Vendor not found');
    if (vendor.status !== 'APPROVED') {
      return req.error(400, 'Only approved vendors can be suspended');
    }

    await UPDATE(Vendors).set({ status: 'SUSPENDED' }).where({ ID: vendorID });
    return SELECT.one.from(Vendors).where({ ID: vendorID });
  });
  
});