using { vendorinvoice.db as db } from '../db/schema';

service VendorService @(requires: ['VendorManager', 'Admin']) {

  // Admin sees all vendors; a VendorManager only sees vendors assigned to them, and only if approved
  @(restrict: [
      { grant: 'READ', to: 'Admin' },
      { grant: 'READ', to: 'VendorManager', where: 'assignedManager = $user and status = ''APPROVED''' }
  ])
  entity Vendors as projection on db.Vendors;

  @(restrict: [
      { grant: ['READ', 'UPDATE', 'DELETE', 'submitForApproval'], to: 'Admin' },
      { grant: ['READ', 'UPDATE', 'DELETE', 'submitForApproval'], to: 'VendorManager', where: 'vendor.assignedManager = $user' },
      { grant: ['CREATE'] }
  ])@odata.draft.enabled
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
    action submitForApproval() returns Invoices;
  };

  @(restrict: [
      { grant: ['READ', 'UPDATE', 'DELETE'], to: 'Admin' },
      { grant: ['READ', 'UPDATE', 'DELETE'], to: 'VendorManager', where: 'invoice.vendor.assignedManager = $user' },
      { grant: ['CREATE'] }
  ])
  entity InvoiceItems as projection on db.InvoiceItems;

  @(restrict: [
      { grant: ['READ', 'UPDATE', 'DELETE'], to: 'Admin' },
      { grant: ['READ', 'UPDATE', 'DELETE'], to: 'VendorManager', where: 'invoice.vendor.assignedManager = $user' },
      { grant: ['CREATE'] }
  ])
  entity Attachments as projection on db.Attachments;

  @(restrict: [
      { grant: 'READ', to: 'Admin' },
      { grant: 'READ', to: 'VendorManager', where: 'invoice.vendor.assignedManager = $user' }
  ])
  entity ApprovalHistory as projection on db.ApprovalHistory;

  @readonly entity InvoiceStatuses as projection on db.InvoiceStatuses;
  @readonly entity Currencies      as projection on db.Currencies;
  @readonly entity FileTypes       as projection on db.FileTypes;
}

annotate VendorService.Invoices with @(Capabilities.DeleteRestrictions.Deletable: false);