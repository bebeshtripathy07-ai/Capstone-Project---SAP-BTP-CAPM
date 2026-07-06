using { vendorinvoice.db as db } from '../db/schema';

service ApproverService @(requires: 'Approver') {

  entity Invoices as projection on db.Invoices actions {
    action approveInvoice(comments: String) returns Invoices;
    action rejectInvoice(reason: String)    returns Invoices;
  };

  @readonly entity Vendors         as projection on db.Vendors;
  @readonly entity InvoiceItems    as projection on db.InvoiceItems;
  @readonly entity Attachments     as projection on db.Attachments;
  @readonly entity ApprovalHistory as projection on db.ApprovalHistory;
}