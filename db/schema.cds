namespace vendorinvoice.db;

using { cuid, managed } from '@sap/cds/common';

type VendorStatus  : String enum { PENDING; APPROVED; SUSPENDED; DELETED; }
type InvoiceStatus : String enum { DRAFT; SUBMITTED; APPROVED; REJECTED; PAID; }
type HistoryAction : String enum { SUBMITTED; APPROVED; REJECTED; PAID; }


entity Vendors : cuid, managed {
  vendorName       : String(100)  @mandatory;
  email            : String(100);
  phone            : String(20);
  address          : String(255);
  country          : String(50)   @mandatory;
  currency         : String(3)    @mandatory;
  taxID            : String(50)   @mandatory;
  externalID       : String(50);      
  status           : VendorStatus default #PENDING;
  assignedManager  : String(100);     
  invoices         : Composition of many Invoices on invoices.vendor = $self;
}

entity Invoices : cuid, managed {
  invoiceNumber    : String(50)   @mandatory;
  vendor           : Association to Vendors @mandatory;
  invoiceDate      : Date         @mandatory;
  dueDate          : Date;
  amount           : Decimal(15,2) @mandatory;
  currency         : String(3)   @mandatory;
  status           : InvoiceStatus default #DRAFT;

  submittedBy      : String(100);
  submittedAt      : Timestamp;

  approvedBy       : String(100);
  approvedAt       : Timestamp;
  approvalComments : String(500);

  rejectedBy       : String(100);
  rejectedAt       : Timestamp;
  rejectionReason  : String(500);

  paidBy           : String(100);
  paidAt           : Timestamp;

  items            : Composition of many InvoiceItems     on items.invoice = $self;
  attachments      : Composition of many Attachments      on attachments.invoice = $self;
  history          : Composition of many ApprovalHistory  on history.invoice = $self;
}

entity InvoiceItems : cuid {
  invoice      : Association to Invoices @mandatory;
  lineNumber   : Integer;
  description  : String(255) @mandatory;
  quantity     : Decimal(10,2) @mandatory;
  unitPrice    : Decimal(15,2) @mandatory;
  totalAmount  : Decimal(15,2); 
}

entity Attachments : cuid, managed {
  invoice     : Association to Invoices @mandatory;
  fileName    : String(255) @mandatory;
  fileSize    : Integer;
  mimeType    : String(100);
  uploadedBy  : String(100);
}

entity ApprovalHistory : cuid {
  invoice    : Association to Invoices @mandatory;
  action     : HistoryAction;
  actor      : String(100);
  timestamp  : Timestamp;
  comments   : String(500);
}


entity InvoiceStatuses {
  key code : String(20);
      name : String(30);
}

entity Currencies {
  key code : String(3);
      name : String(30);
}

entity FileTypes {
  key code : String(100);
      name : String(50);
}