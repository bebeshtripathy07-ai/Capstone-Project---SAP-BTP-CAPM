using { vendorinvoice.db as db } from '../db/schema';

service AdminService @(requires: 'Admin') {

  @odata.draft.enabled
  @cds.redirection.target
  entity Invoices as projection on db.Invoices {
    *,
    case status
      when 'DRAFT'     then 5
      when 'SUBMITTED' then 2
      when 'APPROVED'  then 3
      when 'REJECTED'  then 1
      when 'PAID'      then 3
      else 0
    end as criticality : Integer,
    case status
      when 'DRAFT' then true
      else false
    end as isEditable : Boolean
  } actions {
    action submitForApproval()              returns Invoices;
    action approveInvoice(comments: String) returns Invoices;
    action rejectInvoice(reason: String)    returns Invoices;
    action markAsPaid()                     returns Invoices;
  };

  
  entity Vendors as projection on db.Vendors {
    *,
    case status
      when 'PENDING'   then 2
      when 'APPROVED'  then 3
      when 'SUSPENDED' then 1
      when 'DELETED'   then 0
      else 0
    end as criticality : Integer
  } actions {
    action approveVendor() returns Vendors;
    action suspendVendor() returns Vendors;
  };

  @readonly entity InvoiceStatuses as projection on db.InvoiceStatuses;
  @readonly entity Currencies      as projection on db.Currencies;
  @readonly entity FileTypes as projection on db.FileTypes;

  entity InvoiceItems    as projection on db.InvoiceItems;
  entity Attachments     as projection on db.Attachments;
  entity ApprovalHistory as projection on db.ApprovalHistory;

  @readonly
  entity InvoiceAnalytics as select from db.Invoices {
    key vendor.vendorName as vendorName,
    key status,
    key currency,
        count(*)    as invoiceCount : Integer,
        sum(amount) as totalAmount  : Decimal(15,2)
  } group by vendor.vendorName, status, currency;

  @readonly
  @cds.redirection.target : false
  entity VendorAnalytics as select from db.Vendors {
    key status,
    key country,
        count(*) as vendorCount : Integer
  } group by status, country;
}

// ============================================================
// Embedded analytics: turn Invoices / Vendors into aggregatable
// entities so the List Report can offer a Table <-> Chart toggle.
// ============================================================
annotate AdminService.Invoices with @(Aggregation.ApplySupported : {
  $Type                       : 'Aggregation.ApplySupportedType',
  Transformations             : ['aggregate', 'groupby', 'filter', 'search'],
  Rollup                      : #None,
  PropertyRestrictions        : true,
});

annotate AdminService.Invoices with {
  status   @Analytics.Dimension : true;
  currency @Analytics.Dimension : true;
  amount   @(Analytics.Measure : true, Aggregation.default : #SUM);
};

annotate AdminService.Vendors with @(Aggregation.ApplySupported : {
  $Type                       : 'Aggregation.ApplySupportedType',
  Transformations             : ['aggregate', 'groupby', 'filter', 'search'],
  Rollup                      : #None,
  PropertyRestrictions        : true,
});

annotate AdminService.Vendors with {
  status  @Analytics.Dimension : true;
  country @Analytics.Dimension : true;
};