using { vendorinvoice.db as db } from '../db/schema';

service ViewerService @(requires: 'Viewer') {

  @readonly @cds.redirection.target  entity Invoices as projection on db.Invoices where status = 'APPROVED' or status = 'PAID';
  @readonly entity Vendors  as projection on db.Vendors  where status = 'APPROVED';
  @readonly entity InvoiceItems    as projection on db.InvoiceItems;
  @readonly entity ApprovalHistory as projection on db.ApprovalHistory;

  @readonly
  entity InvoiceAnalytics as select from db.Invoices {
    key vendor.vendorName as vendorName,
    key status,
    key currency,
        count(*)    as invoiceCount : Integer,
        sum(amount) as totalAmount  : Decimal(15,2)
  } group by vendor.vendorName, status, currency;
}