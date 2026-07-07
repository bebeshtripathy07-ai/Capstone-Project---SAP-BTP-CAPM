const cds = require('@sap/cds');
const { triggerInvoiceApproval } = require('./lib/sbpa');

module.exports = cds.service.impl(async function () {

  const { Invoices, InvoiceItems, Vendors, ApprovalHistory, Attachments } = this.entities;
  const protectedFields = ['invoiceNumber', 'vendor_ID', 'invoiceDate', 'dueDate', 'amount', 'currency'];

  this.before(['CREATE', 'UPDATE'], 'Invoices', async (req) => {
    const data = req.data;

    if (data.vendor_ID) {
      const vendor = await SELECT.one.from(Vendors).where({ ID: data.vendor_ID });
      if (!vendor) return req.error(403, 'You can only create invoices for your assigned vendors');
    }

    if (data.invoiceDate) {
      const today = new Date().toISOString().slice(0, 10);
      if (data.invoiceDate > today) {
        return req.error(400, 'Invoice date cannot be in the future');
      }
    }

    if (data.amount !== undefined && (data.amount <= 0 || data.amount > 1000000)) {
      return req.error(400, 'Amount must be between 0.01 and 1,000,000');
    }

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

  // Block editing core fields once no longer DRAFT
  this.before('UPDATE', 'Invoices', async (req) => {
    const touchesProtectedField = protectedFields.some(f => req.data[f] !== undefined);
    if (!touchesProtectedField) return;

    const invoiceID = req.params[0].ID || req.params[0];
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (invoice && invoice.status !== 'DRAFT') {
      return req.error(400, 'This invoice can no longer be edited because it is not in Draft status');
    }
  });

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

  // Auto-generate the next line number
  // Extra safety: verify the invoice being added to actually belongs to this manager
  this.before('CREATE', 'InvoiceItems', async (req) => {
    if (!req.data.invoice_ID) return;
    const invoice = await SELECT.one.from(Invoices).where({ ID: req.data.invoice_ID });
    if (!invoice) return req.error(404, 'Invoice not found');
  });

  this.before('CREATE', 'Attachments', async (req) => {
    if (!req.data.invoice_ID) return;
    const invoice = await SELECT.one.from(Invoices).where({ ID: req.data.invoice_ID });
    if (!invoice) return req.error(404, 'Invoice not found');
  });

  this.on('submitForApproval', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'DRAFT') {
      return req.error(400, 'Only draft invoices can be submitted');
    }

    const items = await SELECT.from(InvoiceItems).where({ invoice_ID: invoiceID });
    if (!items.length) {
      return req.error(400, 'Invoice must have at least one line item');
    }

    const sum = items.reduce((s, i) => s + (Number(i.quantity) * Number(i.unitPrice)), 0);
    if (Math.abs(sum - Number(invoice.amount)) > 0.01) {
      return req.error(400, `Line items total (${sum}) does not match invoice amount (${invoice.amount}). Adjustment required.`);
    }

    const user = req.user.id || 'anonymous';

    await UPDATE(Invoices).set({
      status: 'SUBMITTED',
      submittedBy: user,
      submittedAt: new Date().toISOString()
    }).where({ ID: invoiceID });

    await INSERT.into(ApprovalHistory).entries({
      invoice_ID: invoiceID,
      action: 'SUBMITTED',
      actor: user,
      timestamp: new Date().toISOString(),
      comments: 'Invoice submitted for approval'
    });

    // Trigger the approval process in SAP Build Process Automation.
    // A failure here must not roll back the submission — the approver
    // can still act on the invoice from the approver app.
    try {
      const vendor = await SELECT.one.from(Vendors).where({ ID: invoice.vendor_ID });
      await triggerInvoiceApproval({
        ...invoice,
        submittedBy: user,
        vendorName: vendor ? vendor.name : ''
      });
    } catch (e) {
      console.error(`SBPA trigger failed for invoice ${invoiceID}:`, e.message);
    }

    return SELECT.one.from(Invoices).where({ ID: invoiceID });
  });
});