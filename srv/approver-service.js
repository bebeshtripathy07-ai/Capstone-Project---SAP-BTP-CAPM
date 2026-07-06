const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {

  const { Invoices, ApprovalHistory } = this.entities;

  this.on('approveInvoice', 'Invoices', async (req) => {
    const invoiceID = req.params[0].ID;
    const { comments } = req.data;
    const invoice = await SELECT.one.from(Invoices).where({ ID: invoiceID });
    if (!invoice) return req.error(404, 'Invoice not found');
    if (invoice.status !== 'SUBMITTED') {
      return req.error(400, 'Only submitted invoices can be approved');
    }

    const user = req.user.id || 'anonymous';
    if (invoice.submittedBy === user) {
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
});