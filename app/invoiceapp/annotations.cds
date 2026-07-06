// // using AdminService as service from '../../srv/admin-service';

// // // ============================================================
// // // LIST REPORT (Invoice list page) + Object Page
// // // ============================================================

// // annotate service.Invoices with @(

// //     // Only allow Edit/Delete while the invoice is still in DRAFT
// //     Capabilities.UpdateRestrictions.Updatable : isEditable,
// //     //Capabilities.DeleteRestrictions.Deletable : isEditable,

// //     UI.SelectionFields : [
// //         vendor_ID,
// //         status,
// //         currency,
// //         invoiceDate,
// //     ],

// //     UI.LineItem : [
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Invoice Number',
// //             Value : invoiceNumber,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Vendor',
// //             Value : vendor.vendorName,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Invoice Date',
// //             Value : invoiceDate,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Due Date',
// //             Value : dueDate,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Amount',
// //             Value : amount,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Currency',
// //             Value : currency,
// //         },
// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },
// //     ],

// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [
// //             { Property : invoiceDate, Descending : true }
// //         ],
// //         Visualizations : ['@UI.LineItem'],
// //     },

// //     // -------------------- Object Page header --------------------
// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Invoice',
// //         TypeNamePlural : 'Invoices',
// //         Title : { Value : invoiceNumber },
// //         Description : { Value : status },
// //         TypeImageUrl : 'sap-icon://customer-order-entry',
// //     },

// //     UI.HeaderFacets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HeaderVendorFacet',
// //             Label : 'Vendor',
// //             Target : '@UI.FieldGroup#HeaderVendor',
// //         },
// //     ],

// //     UI.FieldGroup #HeaderVendor : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Vendor',   Value : vendor.vendorName },
// //             { $Type : 'UI.DataField', Label : 'Amount',   Value : amount },
// //             { $Type : 'UI.DataField', Label : 'Currency', Value : currency },
// //         ],
// //     },

// //     UI.FieldGroup #HeaderStatus : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Submitted By',     Value : submittedBy },
// //             { $Type : 'UI.DataField', Label : 'Submitted At',     Value : submittedAt },
// //             { $Type : 'UI.DataField', Label : 'Approved By',      Value : approvedBy },
// //             { $Type : 'UI.DataField', Label : 'Approved At',      Value : approvedAt },
// //             { $Type : 'UI.DataField', Label : 'Rejected By',      Value : rejectedBy },
// //             { $Type : 'UI.DataField', Label : 'Rejected At',      Value : rejectedAt },
// //             { $Type : 'UI.DataField', Label : 'Rejection Reason', Value : rejectionReason },
// //         ],
// //     },

// //     // -------------------- Object Page facets (sections) --------------------
// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'GeneralInfoFacet',
// //             Label : 'General Information',
// //             Target : '@UI.FieldGroup#GeneralInfo',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'LineItemsFacet',
// //             Label : 'Items',
// //             Target : 'items/@UI.LineItem',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'AttachmentsFacet',
// //             Label : 'Attachments',
// //             Target : 'attachments/@UI.LineItem',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HistoryFacet',
// //             Label : 'Approval History',
// //             Target : 'history/@UI.LineItem',
// //         },
// //     ],

// //     UI.FieldGroup #GeneralInfo : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
// //             { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor_ID },
// //             { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
// //             { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
// //             { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
// //             { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
// //             { $Type : 'UI.DataField', Label : 'Status',         Value : status },
// //             { $Type : 'UI.DataField', Label : 'Created By',     Value : createdBy },
// //             { $Type : 'UI.DataField', Label : 'Created At',     Value : createdAt },
// //         ],
// //     },

// //     // -------------------- Actions shown on the Object Page --------------------
// //     UI.Identification : [
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.submitForApproval',
// //             Label : 'Submit for Approval',
// //             ![@UI.Hidden] : (status != 'DRAFT'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.approveInvoice',
// //             Label : 'Approve',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.rejectInvoice',
// //             Label : 'Reject',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.markAsPaid',
// //             Label : 'Mark as Paid',
// //             ![@UI.Hidden] : (status != 'APPROVED'),
// //         },
// //     ],
// // );

// // // Vendor dropdown value help (kept simple - name only)
// // annotate service.Invoices with {
// //     vendor @(
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Vendors',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : vendor_ID,
// //                     ValueListProperty : 'ID',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'vendorName',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Vendor',
// //     )
// // };

// // annotate service.Invoices with {
// //     invoiceNumber @Common.Label : 'Invoice Number';
// //     isEditable @(UI.Hidden: true, Core.Computed: true);
// // };

// // // Status & Currency dropdowns
// // annotate service.Invoices with {
// //     status @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'InvoiceStatuses',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : status,
// //                     ValueListProperty : 'code',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'name',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Status',
// //     );
// //     currency @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Currencies',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : currency,
// //                     ValueListProperty : 'code',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'name',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Currency',
// //     );
// // };

// // // ============================================================
// // // LINE ITEMS (inline-editable table in the "Items" facet + its own Object Page)
// // // ============================================================
// // annotate service.InvoiceItems with @(
// //     UI.HeaderFacets : [],

// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
// //         { $Type : 'UI.DataField', Label : 'Description',  Value : description },
// //         { $Type : 'UI.DataField', Label : 'Quantity',      Value : quantity },
// //         { $Type : 'UI.DataField', Label : 'Unit Price',    Value : unitPrice },
// //         { $Type : 'UI.DataField', Label : 'Total Amount',  Value : totalAmount },
// //     ],

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Line Item',
// //         TypeNamePlural : 'Line Items',
// //         Title : { Value : description },
// //         Description : { Value : totalAmount },
// //         TypeImageUrl : 'sap-icon://my-sales-order',
// //     },

// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'ItemDetailsFacet',
// //             Label : 'Item Details',
// //             Target : '@UI.FieldGroup#ItemDetails',
// //         },
// //     ],

// //     UI.FieldGroup #ItemDetails : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Description',  Value : description },
// //             { $Type : 'UI.DataField', Label : 'Quantity',     Value : quantity },
// //             { $Type : 'UI.DataField', Label : 'Unit Price',   Value : unitPrice },
// //             { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
// //             { $Type : 'UI.DataField', Label : 'Line Number',  Value : lineNumber },
// //         ],
// //     },
// // );

// // annotate service.InvoiceItems with {
// //     totalAmount @Core.Computed : true;
// //     lineNumber  @(Core.Computed : true, UI.HiddenFilter : true);
// // };

// // // ============================================================
// // // ATTACHMENTS (inline table + its own Object Page)
// // // ============================================================
// // annotate service.Attachments with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// //     ],

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Attachment',
// //         TypeNamePlural : 'Attachments',
// //         Title : { Value : fileName },
// //         Description : { Value : uploadedBy },
// //         TypeImageUrl : 'sap-icon://sales-order-item',
// //     },

// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'AttachmentDetailsFacet',
// //             Label : 'Attachment Details',
// //             Target : '@UI.FieldGroup#AttachmentDetails',
// //         },
// //     ],

// //     UI.FieldGroup #AttachmentDetails : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //             { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //             { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //             { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //             { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// //         ],
// //     },
// // );

// // annotate service.Attachments with {
// //     uploadedBy @(Core.Computed : true, UI.HiddenFilter : true);
// //     mimeType   @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'FileTypes',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : mimeType, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         },
// //         Common.Label : 'File Type',
// //     );
// // };

// // // ============================================================
// // // APPROVAL HISTORY (read-only timeline table)
// // // ============================================================
// // annotate service.ApprovalHistory with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
// //         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
// //         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
// //         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
// //     ],
// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [{ Property : timestamp, Descending : false }],
// //     },
// // );
// // annotate service.Invoices with {
// //     invoiceDate @Common.Label : 'Invoice Date'
// // };

// //---------------------------------------

// // using AdminService as service from '../../srv/admin-service';

// // // ============================================================
// // // LIST REPORT (Invoice list page) + Object Page
// // // ============================================================

// // annotate service.Invoices with @(

// //     // Only allow Edit/Delete while the invoice is still in DRAFT
// //     Capabilities.UpdateRestrictions.Updatable : isEditable,
// //     //Capabilities.DeleteRestrictions.Deletable : isEditable,

// //     UI.SelectionFields : [
// //         vendor_ID,
// //         status,
// //         currency,
// //         invoiceDate,
// //     ],

// //     UI.LineItem : [
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Invoice Number',
// //             Value : invoiceNumber,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Vendor',
// //             Value : vendor.vendorName,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Invoice Date',
// //             Value : invoiceDate,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Due Date',
// //             Value : dueDate,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Amount',
// //             Value : amount,
// //         },
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Currency',
// //             Value : currency,
// //         },
// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },
// //     ],

// //     // -------------------- Analytics: enable Table/Chart toggle --------------------
// //     Aggregation.ApplySupported : {
// //         $Type : 'Aggregation.ApplySupportedType',
// //         Transformations : ['aggregate', 'groupby', 'filter'],
// //         Rollup : #None,
// //         PropertyRestrictions : true,
// //         GroupableProperties : [status, currency, vendor_ID],
// //         AggregatableProperties : [
// //             { Property : amount },
// //         ],
// //     },

// //     Analytics.AggregatedProperties : [
// //         {
// //             Name : 'TotalAmount',
// //             AggregationMethod : 'sum',
// //             AggregatableProperty : amount,
// //             ![@Common.Label] : 'Total Amount',
// //         },
// //         {
// //             Name : 'InvoiceCount',
// //             AggregationMethod : 'countdistinct',
// //             AggregatableProperty : ID,
// //             ![@Common.Label] : 'Number of Invoices',
// //         },
// //     ],

// //     UI.Chart : {
// //         $Type : 'UI.ChartDefinitionType',
// //         ChartType : #Column,
// //         Title : 'Invoice Amount by Status',
// //         Dimensions : [status],
// //         DimensionAttributes : [
// //             { Dimension : status, Role : #Category },
// //         ],
// //         DynamicMeasures : ['@Analytics.AggregatedProperty#TotalAmount'],
// //         MeasureAttributes : [
// //             { DynamicMeasure : '@Analytics.AggregatedProperty#TotalAmount', Role : #Axis1 },
// //         ],
// //     },

// //     // Dashboard KPI tiles (consumed by SAP Build Work Zone / Launchpad, or a future Overview Page)
// //     UI.KPI #TotalAmount : {
// //         $Type : 'UI.KPIType',
// //         DataPoint : {
// //             $Type : 'UI.DataPointType',
// //             Value : amount,
// //             Title : 'Total Invoice Amount',
// //         },
// //         Detail : {
// //             $Type : 'UI.KPIDetailType',
// //             DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
// //         },
// //     },
// //     UI.KPI #PendingApproval : {
// //         $Type : 'UI.KPIType',
// //         DataPoint : {
// //             $Type : 'UI.DataPointType',
// //             Value : amount,
// //             Title : 'Pending Approval',
// //         },
// //         SelectionVariant : {
// //             $Type : 'UI.SelectionVariantType',
// //             SelectOptions : [{
// //                 PropertyName : status,
// //                 Ranges : [{ Sign : #I, Option : #EQ, Low : 'SUBMITTED' }],
// //             }],
// //         },
// //         Detail : {
// //             $Type : 'UI.KPIDetailType',
// //             DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
// //         },
// //     },

// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [
// //             { Property : invoiceDate, Descending : true }
// //         ],
// //         Visualizations : ['@UI.LineItem', '@UI.Chart'],
// //     },

// //     // -------------------- Object Page header --------------------
// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Invoice',
// //         TypeNamePlural : 'Invoices',
// //         Title : { Value : invoiceNumber },
// //         Description : { Value : status },
// //         TypeImageUrl : 'sap-icon://customer-order-entry',
// //     },

// //     UI.HeaderFacets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HeaderVendorFacet',
// //             Label : 'Vendor',
// //             Target : '@UI.FieldGroup#HeaderVendor',
// //         },
// //     ],

// //     UI.FieldGroup #HeaderVendor : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Vendor',   Value : vendor.vendorName },
// //             { $Type : 'UI.DataField', Label : 'Amount',   Value : amount },
// //             { $Type : 'UI.DataField', Label : 'Currency', Value : currency },
// //         ],
// //     },

// //     UI.FieldGroup #HeaderStatus : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Submitted By',     Value : submittedBy },
// //             { $Type : 'UI.DataField', Label : 'Submitted At',     Value : submittedAt },
// //             { $Type : 'UI.DataField', Label : 'Approved By',      Value : approvedBy },
// //             { $Type : 'UI.DataField', Label : 'Approved At',      Value : approvedAt },
// //             { $Type : 'UI.DataField', Label : 'Rejected By',      Value : rejectedBy },
// //             { $Type : 'UI.DataField', Label : 'Rejected At',      Value : rejectedAt },
// //             { $Type : 'UI.DataField', Label : 'Rejection Reason', Value : rejectionReason },
// //         ],
// //     },

// //     // -------------------- Object Page facets (sections) --------------------
// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'GeneralInfoFacet',
// //             Label : 'General Information',
// //             Target : '@UI.FieldGroup#GeneralInfo',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'LineItemsFacet',
// //             Label : 'Items',
// //             Target : 'items/@UI.LineItem',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'AttachmentsFacet',
// //             Label : 'Attachments',
// //             Target : 'attachments/@UI.LineItem',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HistoryFacet',
// //             Label : 'Approval History',
// //             Target : 'history/@UI.LineItem',
// //         },
// //     ],

// //     UI.FieldGroup #GeneralInfo : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
// //             { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor_ID },
// //             { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
// //             { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
// //             { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
// //             { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
// //             { $Type : 'UI.DataField', Label : 'Status',         Value : status },
// //             { $Type : 'UI.DataField', Label : 'Created By',     Value : createdBy },
// //             { $Type : 'UI.DataField', Label : 'Created At',     Value : createdAt },
// //         ],
// //     },

// //     // -------------------- Actions shown on the Object Page --------------------
// //     UI.Identification : [
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.submitForApproval',
// //             Label : 'Submit for Approval',
// //             ![@UI.Hidden] : (status != 'DRAFT'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.approveInvoice',
// //             Label : 'Approve',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.rejectInvoice',
// //             Label : 'Reject',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.markAsPaid',
// //             Label : 'Mark as Paid',
// //             ![@UI.Hidden] : (status != 'APPROVED'),
// //         },
// //     ],
// // );

// // // Vendor dropdown value help (kept simple - name only)
// // annotate service.Invoices with {
// //     vendor @(
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Vendors',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : vendor_ID,
// //                     ValueListProperty : 'ID',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'vendorName',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Vendor',
// //     )
// // };

// // annotate service.Invoices with {
// //     invoiceNumber @Common.Label : 'Invoice Number';
// //     isEditable @(UI.Hidden: true, Core.Computed: true);
// //     amount @Aggregation.default : #SUM;
// // };

// // // Status & Currency dropdowns
// // annotate service.Invoices with {
// //     status @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'InvoiceStatuses',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : status,
// //                     ValueListProperty : 'code',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'name',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Status',
// //     );
// //     currency @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Currencies',
// //             Parameters : [
// //                 {
// //                     $Type : 'Common.ValueListParameterInOut',
// //                     LocalDataProperty : currency,
// //                     ValueListProperty : 'code',
// //                 },
// //                 {
// //                     $Type : 'Common.ValueListParameterDisplayOnly',
// //                     ValueListProperty : 'name',
// //                 },
// //             ],
// //         },
// //         Common.Label : 'Currency',
// //     );
// // };

// // // ============================================================
// // // LINE ITEMS (inline-editable table in the "Items" facet + its own Object Page)
// // // ============================================================
// // annotate service.InvoiceItems with @(
// //     UI.HeaderFacets : [],

// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
// //         { $Type : 'UI.DataField', Label : 'Description',  Value : description },
// //         { $Type : 'UI.DataField', Label : 'Quantity',      Value : quantity },
// //         { $Type : 'UI.DataField', Label : 'Unit Price',    Value : unitPrice },
// //         { $Type : 'UI.DataField', Label : 'Total Amount',  Value : totalAmount },
// //     ],

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Line Item',
// //         TypeNamePlural : 'Line Items',
// //         Title : { Value : description },
// //         Description : { Value : totalAmount },
// //         TypeImageUrl : 'sap-icon://my-sales-order',
// //     },

// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'ItemDetailsFacet',
// //             Label : 'Item Details',
// //             Target : '@UI.FieldGroup#ItemDetails',
// //         },
// //     ],

// //     UI.FieldGroup #ItemDetails : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Description',  Value : description },
// //             { $Type : 'UI.DataField', Label : 'Quantity',     Value : quantity },
// //             { $Type : 'UI.DataField', Label : 'Unit Price',   Value : unitPrice },
// //             { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
// //             { $Type : 'UI.DataField', Label : 'Line Number',  Value : lineNumber },
// //         ],
// //     },
// // );

// // annotate service.InvoiceItems with {
// //     totalAmount @Core.Computed : true;
// //     lineNumber  @(Core.Computed : true, UI.HiddenFilter : true);
// // };

// // // ============================================================
// // // ATTACHMENTS (inline table + its own Object Page)
// // // ============================================================
// // annotate service.Attachments with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// //     ],

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Attachment',
// //         TypeNamePlural : 'Attachments',
// //         Title : { Value : fileName },
// //         Description : { Value : uploadedBy },
// //         TypeImageUrl : 'sap-icon://sales-order-item',
// //     },

// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'AttachmentDetailsFacet',
// //             Label : 'Attachment Details',
// //             Target : '@UI.FieldGroup#AttachmentDetails',
// //         },
// //     ],

// //     UI.FieldGroup #AttachmentDetails : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //             { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //             { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //             { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //             { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// //         ],
// //     },
// // );

// // annotate service.Attachments with {
// //     uploadedBy @(Core.Computed : true, UI.HiddenFilter : true);
// //     mimeType   @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'FileTypes',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : mimeType, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         },
// //         Common.Label : 'File Type',
// //     );
// // };

// // // ============================================================
// // // APPROVAL HISTORY (read-only timeline table)
// // // ============================================================
// // annotate service.ApprovalHistory with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
// //         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
// //         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
// //         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
// //     ],
// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [{ Property : timestamp, Descending : false }],
// //     },
// // );
// // annotate service.Invoices with {
// //     invoiceDate @Common.Label : 'Invoice Date'
// // };



// using AdminService as service from '../../srv/admin-service';

// // ============================================================
// // LIST REPORT (Invoice list page) + Object Page
// // ============================================================

// annotate service.Invoices with @(

// // Only allow Edit/Delete while the invoice is still in DRAFT
// Capabilities.UpdateRestrictions.Updatable : isEditable,

// UI.SelectionFields : [
//     vendor_ID,
//     status,
//     currency,
//     invoiceDate,
// ],

// UI.LineItem : [
//     {
//         $Type : 'UI.DataField',
//         Label : 'Invoice Number',
//         Value : invoiceNumber,
//     },
//     {
//         $Type : 'UI.DataField',
//         Label : 'Vendor',
//         Value : vendor.vendorName,
//     },
//     {
//         $Type : 'UI.DataField',
//         Label : 'Invoice Date',
//         Value : invoiceDate,
//     },
//     {
//         $Type : 'UI.DataField',
//         Label : 'Due Date',
//         Value : dueDate,
//     },
//     {
//         $Type : 'UI.DataField',
//         Label : 'Amount',
//         Value : amount,
//     },
//     {
//         $Type : 'UI.DataField',
//         Label : 'Currency',
//         Value : currency,
//     },
//     {
//         $Type : 'UI.DataFieldWithCriticality',
//         Label : 'Status',
//         Value : status,
//         Criticality : criticality,
//     },
// ],

// // ============================================================
// // ANALYTICS + VISUALIZATION
// // ============================================================

// Aggregation.ApplySupported : {
//     $Type : 'Aggregation.ApplySupportedType',
//     Transformations : [
//         'aggregate',
//         'groupby',
//         'filter',
//     ],
//     Rollup : #None,
//     PropertyRestrictions : true,
//     GroupableProperties : [
//         status,
//         currency,
//         vendor_ID,
//     ],
//     AggregatableProperties : [
//         {
//             Property : amount,
//         },
//     ],
// },

// Analytics.AggregatedProperties : [
//     {
//         Name : 'TotalAmount',
//         AggregationMethod : 'sum',
//         AggregatableProperty : amount,
//         ![@Common.Label] : 'Total Invoice Amount',
//     },
// ],

// UI.Chart : {
//     $Type : 'UI.ChartDefinitionType',
//     ChartType : #Column,
//     Title : 'Invoices by Status',
//     Dimensions : [
//         status,
//     ],
//     DimensionAttributes : [
//         {
//             Dimension : status,
//             Role : #Category,
//         },
//     ],
//     DynamicMeasures : [
//         '@Analytics.AggregatedProperty#TotalAmount',
//     ],
//     MeasureAttributes : [
//         {
//             DynamicMeasure : '@Analytics.AggregatedProperty#TotalAmount',
//             Role : #Axis1,
//         },
//     ],
// },

// UI.Visualizations : [
//     '@UI.LineItem',
//     '@UI.Chart',
// ],

// UI.PresentationVariant : {
//     $Type : 'UI.PresentationVariantType',
//     SortOrder : [
//         { Property : invoiceDate, Descending : true }
//     ],
//     Visualizations : [
//         '@UI.LineItem',
//         '@UI.Chart',
//     ],
// },

// // -------------------- Object Page header --------------------
// UI.HeaderInfo : {
//     $Type : 'UI.HeaderInfoType',
//     TypeName : 'Invoice',
//     TypeNamePlural : 'Invoices',
//     Title : { Value : invoiceNumber },
//     Description : { Value : status },
//     TypeImageUrl : 'sap-icon://customer-order-entry',
// },

// UI.HeaderFacets : [
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'HeaderVendorFacet',
//         Label : 'Vendor',
//         Target : '@UI.FieldGroup#HeaderVendor',
//     },
// ],

// UI.FieldGroup #HeaderVendor : {
//     $Type : 'UI.FieldGroupType',
//     Data : [
//         { $Type : 'UI.DataField', Label : 'Vendor',   Value : vendor.vendorName },
//         { $Type : 'UI.DataField', Label : 'Amount',   Value : amount },
//         { $Type : 'UI.DataField', Label : 'Currency', Value : currency },
//     ],
// },

// UI.FieldGroup #HeaderStatus : {
//     $Type : 'UI.FieldGroupType',
//     Data : [
//         { $Type : 'UI.DataField', Label : 'Submitted By',     Value : submittedBy },
//         { $Type : 'UI.DataField', Label : 'Submitted At',     Value : submittedAt },
//         { $Type : 'UI.DataField', Label : 'Approved By',      Value : approvedBy },
//         { $Type : 'UI.DataField', Label : 'Approved At',      Value : approvedAt },
//         { $Type : 'UI.DataField', Label : 'Rejected By',      Value : rejectedBy },
//         { $Type : 'UI.DataField', Label : 'Rejected At',      Value : rejectedAt },
//         { $Type : 'UI.DataField', Label : 'Rejection Reason', Value : rejectionReason },
//     ],
// },

// // -------------------- Object Page facets (sections) --------------------
// UI.Facets : [
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'GeneralInfoFacet',
//         Label : 'General Information',
//         Target : '@UI.FieldGroup#GeneralInfo',
//     },
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'LineItemsFacet',
//         Label : 'Items',
//         Target : 'items/@UI.LineItem',
//     },
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'AttachmentsFacet',
//         Label : 'Attachments',
//         Target : 'attachments/@UI.LineItem',
//     },
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'HistoryFacet',
//         Label : 'Approval History',
//         Target : 'history/@UI.LineItem',
//     },
// ],

// UI.FieldGroup #GeneralInfo : {
//     $Type : 'UI.FieldGroupType',
//     Data : [
//         { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
//         { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor_ID },
//         { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
//         { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
//         { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
//         { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
//         { $Type : 'UI.DataField', Label : 'Status',         Value : status },
//         { $Type : 'UI.DataField', Label : 'Created By',     Value : createdBy },
//         { $Type : 'UI.DataField', Label : 'Created At',     Value : createdAt },
//     ],
// },

// // -------------------- Actions shown on the Object Page --------------------
// UI.Identification : [
//     {
//         $Type : 'UI.DataFieldForAction',
//         Action : 'AdminService.submitForApproval',
//         Label : 'Submit for Approval',
//         ![@UI.Hidden] : (status != 'DRAFT'),
//     },
//     {
//         $Type : 'UI.DataFieldForAction',
//         Action : 'AdminService.approveInvoice',
//         Label : 'Approve',
//         ![@UI.Hidden] : (status != 'SUBMITTED'),
//     },
//     {
//         $Type : 'UI.DataFieldForAction',
//         Action : 'AdminService.rejectInvoice',
//         Label : 'Reject',
//         ![@UI.Hidden] : (status != 'SUBMITTED'),
//     },
//     {
//         $Type : 'UI.DataFieldForAction',
//         Action : 'AdminService.markAsPaid',
//         Label : 'Mark as Paid',
//         ![@UI.Hidden] : (status != 'APPROVED'),
//     },
// ],

// );

// // Vendor dropdown value help (kept simple - name only)
// annotate service.Invoices with {
// vendor @(
// Common.ValueList : {
// $Type : 'Common.ValueListType',
// CollectionPath : 'Vendors',
// Parameters : [
// {
// $Type : 'Common.ValueListParameterInOut',
// LocalDataProperty : vendor_ID,
// ValueListProperty : 'ID',
// },
// {
// $Type : 'Common.ValueListParameterDisplayOnly',
// ValueListProperty : 'vendorName',
// },
// ],
// },
// Common.Label : 'Vendor',
// )
// };

// annotate service.Invoices with {
// invoiceNumber @Common.Label : 'Invoice Number';
// isEditable @(UI.Hidden: true, Core.Computed: true);
// };

// // Status & Currency dropdowns
// annotate service.Invoices with {
// status @(
// Common.ValueListWithFixedValues : true,
// Common.ValueList : {
// $Type : 'Common.ValueListType',
// CollectionPath : 'InvoiceStatuses',
// Parameters : [
// {
// $Type : 'Common.ValueListParameterInOut',
// LocalDataProperty : status,
// ValueListProperty : 'code',
// },
// {
// $Type : 'Common.ValueListParameterDisplayOnly',
// ValueListProperty : 'name',
// },
// ],
// },
// Common.Label : 'Status',
// );
// currency @(
// Common.ValueListWithFixedValues : true,
// Common.ValueList : {
// $Type : 'Common.ValueListType',
// CollectionPath : 'Currencies',
// Parameters : [
// {
// $Type : 'Common.ValueListParameterInOut',
// LocalDataProperty : currency,
// ValueListProperty : 'code',
// },
// {
// $Type : 'Common.ValueListParameterDisplayOnly',
// ValueListProperty : 'name',
// },
// ],
// },
// Common.Label : 'Currency',
// );
// };

// // ============================================================
// // LINE ITEMS
// // ============================================================

// annotate service.InvoiceItems with @(
// UI.HeaderFacets : [],

// UI.LineItem : [
//     { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
//     { $Type : 'UI.DataField', Label : 'Description', Value : description },
//     { $Type : 'UI.DataField', Label : 'Quantity',    Value : quantity },
//     { $Type : 'UI.DataField', Label : 'Unit Price',  Value : unitPrice },
//     { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
// ],

// UI.HeaderInfo : {
//     $Type : 'UI.HeaderInfoType',
//     TypeName : 'Line Item',
//     TypeNamePlural : 'Line Items',
//     Title : { Value : description },
//     Description : { Value : totalAmount },
//     TypeImageUrl : 'sap-icon://my-sales-order',
// },

// UI.Facets : [
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'ItemDetailsFacet',
//         Label : 'Item Details',
//         Target : '@UI.FieldGroup#ItemDetails',
//     },
// ],

// UI.FieldGroup #ItemDetails : {
//     $Type : 'UI.FieldGroupType',
//     Data : [
//         { $Type : 'UI.DataField', Label : 'Description', Value : description },
//         { $Type : 'UI.DataField', Label : 'Quantity', Value : quantity },
//         { $Type : 'UI.DataField', Label : 'Unit Price', Value : unitPrice },
//         { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
//         { $Type : 'UI.DataField', Label : 'Line Number', Value : lineNumber },
//     ],
// },

// );

// annotate service.InvoiceItems with {
// totalAmount @Core.Computed : true;
// lineNumber @(Core.Computed : true, UI.HiddenFilter : true);
// };

// // ============================================================
// // ATTACHMENTS
// // ============================================================

// annotate service.Attachments with @(
// UI.LineItem : [
// { $Type : 'UI.DataField', Label : 'File Name', Value : fileName },
// { $Type : 'UI.DataField', Label : 'File Type', Value : mimeType },
// { $Type : 'UI.DataField', Label : 'File Size', Value : fileSize },
// { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// ],

// UI.HeaderInfo : {
//     $Type : 'UI.HeaderInfoType',
//     TypeName : 'Attachment',
//     TypeNamePlural : 'Attachments',
//     Title : { Value : fileName },
//     Description : { Value : uploadedBy },
//     TypeImageUrl : 'sap-icon://sales-order-item',
// },

// UI.Facets : [
//     {
//         $Type : 'UI.ReferenceFacet',
//         ID : 'AttachmentDetailsFacet',
//         Label : 'Attachment Details',
//         Target : '@UI.FieldGroup#AttachmentDetails',
//     },
// ],

// UI.FieldGroup #AttachmentDetails : {
//     $Type : 'UI.FieldGroupType',
//     Data : [
//         { $Type : 'UI.DataField', Label : 'File Name', Value : fileName },
//         { $Type : 'UI.DataField', Label : 'File Type', Value : mimeType },
//         { $Type : 'UI.DataField', Label : 'File Size', Value : fileSize },
//         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
//         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
//     ],
// },

// );

// annotate service.Attachments with {
// uploadedBy @(Core.Computed : true, UI.HiddenFilter : true);
// };

// // ============================================================
// // APPROVAL HISTORY
// // ============================================================

// annotate service.ApprovalHistory with @(
// UI.LineItem : [
// { $Type : 'UI.DataField', Label : 'Action', Value : action },
// { $Type : 'UI.DataField', Label : 'Actor', Value : actor },
// { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
// { $Type : 'UI.DataField', Label : 'Comments', Value : comments },
// ],

// UI.PresentationVariant : {
//     $Type : 'UI.PresentationVariantType',
//     SortOrder : [{ Property : timestamp, Descending : false }],
// },

// );

// annotate service.Invoices with {
// invoiceDate @Common.Label : 'Invoice Date'
// };



// using AdminService as service from '../../srv/admin-service';

// // ============================================================
// // LIST REPORT (Invoice list page) + Object Page
// // ============================================================

// annotate service.Invoices with @(

//     // Only allow Edit/Delete while the invoice is still in DRAFT
//     Capabilities.UpdateRestrictions.Updatable : isEditable,
//     //Capabilities.DeleteRestrictions.Deletable : isEditable,

//     UI.SelectionFields : [
//         vendor_ID,
//         status,
//         currency,
//         invoiceDate,
//     ],

//     UI.LineItem : [
//         {
//             $Type : 'UI.DataField',
//             Label : 'Invoice Number',
//             Value : invoiceNumber,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Vendor',
//             Value : vendor.vendorName,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Invoice Date',
//             Value : invoiceDate,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Due Date',
//             Value : dueDate,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Amount',
//             Value : amount,
//         },
//         {
//             $Type : 'UI.DataField',
//             Label : 'Currency',
//             Value : currency,
//         },
//         {
//             $Type : 'UI.DataFieldWithUrl',
//             Label : 'Status',
//             Value : status,
//             Criticality : criticality,
//         },
//     ],

//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [
//             { Property : invoiceDate, Descending : true }
//         ],
//         Visualizations : ['@UI.LineItem'],
//     },

//     // -------------------- Object Page header --------------------
//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Invoice',
//         TypeNamePlural : 'Invoices',
//         Title : { Value : invoiceNumber },
//         Description : { Value : status },
//         TypeImageUrl : 'sap-icon://customer-order-entry',
//     },

//     UI.HeaderFacets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HeaderVendorFacet',
//             Label : 'Vendor',
//             Target : '@UI.FieldGroup#HeaderVendor',
//         },
//     ],

//     UI.FieldGroup #HeaderVendor : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Vendor',   Value : vendor.vendorName },
//             { $Type : 'UI.DataField', Label : 'Amount',   Value : amount },
//             { $Type : 'UI.DataField', Label : 'Currency', Value : currency },
//         ],
//     },

//     UI.FieldGroup #HeaderStatus : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Submitted By',     Value : submittedBy },
//             { $Type : 'UI.DataField', Label : 'Submitted At',     Value : submittedAt },
//             { $Type : 'UI.DataField', Label : 'Approved By',      Value : approvedBy },
//             { $Type : 'UI.DataField', Label : 'Approved At',      Value : approvedAt },
//             { $Type : 'UI.DataField', Label : 'Rejected By',      Value : rejectedBy },
//             { $Type : 'UI.DataField', Label : 'Rejected At',      Value : rejectedAt },
//             { $Type : 'UI.DataField', Label : 'Rejection Reason', Value : rejectionReason },
//         ],
//     },

//     // -------------------- Object Page facets (sections) --------------------
//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneralInfoFacet',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneralInfo',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'LineItemsFacet',
//             Label : 'Items',
//             Target : 'items/@UI.LineItem',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'AttachmentsFacet',
//             Label : 'Attachments',
//             Target : 'attachments/@UI.LineItem',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HistoryFacet',
//             Label : 'Approval History',
//             Target : 'history/@UI.LineItem',
//         },
//     ],

//     UI.FieldGroup #GeneralInfo : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
//             { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor_ID },
//             { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
//             { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
//             { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
//             { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
//             { $Type : 'UI.DataField', Label : 'Status',         Value : status },
//             { $Type : 'UI.DataField', Label : 'Created By',     Value : createdBy },
//             { $Type : 'UI.DataField', Label : 'Created At',     Value : createdAt },
//         ],
//     },

//     // -------------------- Actions shown on the Object Page --------------------
//     UI.Identification : [
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.submitForApproval',
//             Label : 'Submit for Approval',
//             ![@UI.Hidden] : (status != 'DRAFT'),
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.approveInvoice',
//             Label : 'Approve',
//             ![@UI.Hidden] : (status != 'SUBMITTED'),
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.rejectInvoice',
//             Label : 'Reject',
//             ![@UI.Hidden] : (status != 'SUBMITTED'),
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.markAsPaid',
//             Label : 'Mark as Paid',
//             ![@UI.Hidden] : (status != 'APPROVED'),
//         },
//     ],
// );

// // Vendor dropdown value help (kept simple - name only)
// annotate service.Invoices with {
//     vendor @(
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Vendors',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : vendor_ID,
//                     ValueListProperty : 'ID',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'vendorName',
//                 },
//             ],
//         },
//         Common.Label : 'Vendor',
//     )
// };

// annotate service.Invoices with {
//     invoiceNumber @Common.Label : 'Invoice Number';
//     isEditable @(UI.Hidden: true, Core.Computed: true);
// };

// // Status & Currency dropdowns
// annotate service.Invoices with {
//     status @(
//         Common.ValueListWithFixedValues : true,
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'InvoiceStatuses',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : status,
//                     ValueListProperty : 'code',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name',
//                 },
//             ],
//         },
//         Common.Label : 'Status',
//     );
//     currency @(
//         Common.ValueListWithFixedValues : true,
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Currencies',
//             Parameters : [
//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : currency,
//                     ValueListProperty : 'code',
//                 },
//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name',
//                 },
//             ],
//         },
//         Common.Label : 'Currency',
//     );
// };

// // ============================================================
// // LINE ITEMS (inline-editable table in the "Items" facet + its own Object Page)
// // ============================================================
// annotate service.InvoiceItems with @(
//     UI.HeaderFacets : [],

//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
//         { $Type : 'UI.DataField', Label : 'Description',  Value : description },
//         { $Type : 'UI.DataField', Label : 'Quantity',      Value : quantity },
//         { $Type : 'UI.DataField', Label : 'Unit Price',    Value : unitPrice },
//         { $Type : 'UI.DataField', Label : 'Total Amount',  Value : totalAmount },
//     ],

//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Line Item',
//         TypeNamePlural : 'Line Items',
//         Title : { Value : description },
//         Description : { Value : totalAmount },
//         TypeImageUrl : 'sap-icon://my-sales-order',
//     },

//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'ItemDetailsFacet',
//             Label : 'Item Details',
//             Target : '@UI.FieldGroup#ItemDetails',
//         },
//     ],

//     UI.FieldGroup #ItemDetails : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Description',  Value : description },
//             { $Type : 'UI.DataField', Label : 'Quantity',     Value : quantity },
//             { $Type : 'UI.DataField', Label : 'Unit Price',   Value : unitPrice },
//             { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
//             { $Type : 'UI.DataField', Label : 'Line Number',  Value : lineNumber },
//         ],
//     },
// );

// annotate service.InvoiceItems with {
//     totalAmount @Core.Computed : true;
//     lineNumber  @(Core.Computed : true, UI.HiddenFilter : true);
// };

// // ============================================================
// // ATTACHMENTS (inline table + its own Object Page)
// // ============================================================
// annotate service.Attachments with @(
//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
//         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
//         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
//         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
//         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
//     ],

//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Attachment',
//         TypeNamePlural : 'Attachments',
//         Title : { Value : fileName },
//         Description : { Value : uploadedBy },
//         TypeImageUrl : 'sap-icon://sales-order-item',
//     },

//     UI.Facets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'AttachmentDetailsFacet',
//             Label : 'Attachment Details',
//             Target : '@UI.FieldGroup#AttachmentDetails',
//         },
//     ],

//     UI.FieldGroup #AttachmentDetails : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
//             { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
//             { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
//             { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
//             { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
//         ],
//     },
// );

// annotate service.Attachments with {
//     uploadedBy @(Core.Computed : true, UI.HiddenFilter : true);
//     mimeType   @(
//         Common.ValueListWithFixedValues : true,
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'FileTypes',
//             Parameters : [
//                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : mimeType, ValueListProperty : 'code' },
//                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
//             ],
//         },
//         Common.Label : 'File Type',
//     );
// };

// // ============================================================
// // APPROVAL HISTORY (read-only timeline table)
// // ============================================================
// annotate service.ApprovalHistory with @(
//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
//         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
//         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
//         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
//     ],
//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [{ Property : timestamp, Descending : false }],
//     },
// );
// annotate service.Invoices with {
//     invoiceDate @Common.Label : 'Invoice Date'
// };



using AdminService as service from '../../srv/admin-service';

// ============================================================
// LIST REPORT (Invoice list page) + Object Page
// ============================================================

annotate service.Invoices with @(

    // Only allow Edit/Delete while the invoice is still in DRAFT
    Capabilities.UpdateRestrictions.Updatable : isEditable,
    //Capabilities.DeleteRestrictions.Deletable : isEditable,

    UI.SelectionFields : [
        vendor_ID,
        status,
        currency,
        invoiceDate,
    ],

    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Invoice Number',
            Value : invoiceNumber,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Vendor',
            Value : vendor.vendorName,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Invoice Date',
            Value : invoiceDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Due Date',
            Value : dueDate,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Amount',
            Value : amount,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Currency',
            Value : currency,
        },
        {
            $Type : 'UI.DataFieldWithUrl',
            Label : 'Status',
            Value : status,
            Criticality : criticality,
        },
    ],

    // -------------------- Analytics: enable Table/Chart toggle --------------------
    Aggregation.ApplySupported : {
        $Type : 'Aggregation.ApplySupportedType',
        Transformations : ['aggregate', 'groupby', 'filter'],
        Rollup : #None,
        PropertyRestrictions : true,
        GroupableProperties : [status, currency, vendor_ID],
        AggregatableProperties : [
            { Property : amount },
        ],
    },

    Analytics.AggregatedProperties : [
        {
            Name : 'TotalAmount',
            AggregationMethod : 'sum',
            AggregatableProperty : amount,
            ![@Common.Label] : 'Total Amount',
        },
        {
            Name : 'InvoiceCount',
            AggregationMethod : 'countdistinct',
            AggregatableProperty : ID,
            ![@Common.Label] : 'Number of Invoices',
        },
    ],

    UI.Chart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Title : 'Invoice Amount by Status',
        Dimensions : [status],
        DimensionAttributes : [
            { Dimension : status, Role : #Category },
        ],
        DynamicMeasures : ['@Analytics.AggregatedProperty#TotalAmount'],
        MeasureAttributes : [
            { DynamicMeasure : '@Analytics.AggregatedProperty#TotalAmount', Role : #Axis1 },
        ],
    },

    // Dashboard KPI tiles (consumed by SAP Build Work Zone / Launchpad, or a future Overview Page)
    UI.KPI #TotalAmount : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : amount,
            Title : 'Total Invoice Amount',
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
        },
    },
    UI.KPI #PendingApproval : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : amount,
            Title : 'Pending Approval',
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [{
                PropertyName : status,
                Ranges : [{ Sign : #I, Option : #EQ, Low : 'SUBMITTED' }],
            }],
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
        },
    },

    UI.PresentationVariant : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [
            { Property : invoiceDate, Descending : true }
        ],
        Visualizations : ['@UI.LineItem', '@UI.Chart'],
    },

    // -------------------- Object Page header --------------------
    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Invoice',
        TypeNamePlural : 'Invoices',
        Title : { Value : invoiceNumber },
        Description : { Value : status },
        TypeImageUrl : 'sap-icon://customer-order-entry',
    },

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'HeaderVendorFacet',
            Label : 'Vendor',
            Target : '@UI.FieldGroup#HeaderVendor',
        },
    ],

    UI.FieldGroup #HeaderVendor : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Vendor',   Value : vendor.vendorName },
            { $Type : 'UI.DataField', Label : 'Amount',   Value : amount },
            { $Type : 'UI.DataField', Label : 'Currency', Value : currency },
        ],
    },

    UI.FieldGroup #HeaderStatus : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Submitted By',     Value : submittedBy },
            { $Type : 'UI.DataField', Label : 'Submitted At',     Value : submittedAt },
            { $Type : 'UI.DataField', Label : 'Approved By',      Value : approvedBy },
            { $Type : 'UI.DataField', Label : 'Approved At',      Value : approvedAt },
            { $Type : 'UI.DataField', Label : 'Rejected By',      Value : rejectedBy },
            { $Type : 'UI.DataField', Label : 'Rejected At',      Value : rejectedAt },
            { $Type : 'UI.DataField', Label : 'Rejection Reason', Value : rejectionReason },
        ],
    },

    // -------------------- Object Page facets (sections) --------------------
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'GeneralInfoFacet',
            Label : 'General Information',
            Target : '@UI.FieldGroup#GeneralInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'LineItemsFacet',
            Label : 'Items',
            Target : 'items/@UI.LineItem',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'AttachmentsFacet',
            Label : 'Attachments',
            Target : 'attachments/@UI.LineItem',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'HistoryFacet',
            Label : 'Approval History',
            Target : 'history/@UI.LineItem',
        },
    ],

    UI.FieldGroup #GeneralInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
            { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor_ID },
            { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
            { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
            { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
            { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
            { $Type : 'UI.DataField', Label : 'Status',         Value : status },
            { $Type : 'UI.DataField', Label : 'Created By',     Value : createdBy },
            { $Type : 'UI.DataField', Label : 'Created At',     Value : createdAt },
        ],
    },

    // -------------------- Actions shown on the Object Page --------------------
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.submitForApproval',
            Label : 'Submit for Approval',
            ![@UI.Hidden] : (status != 'DRAFT'),
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.approveInvoice',
            Label : 'Approve',
            ![@UI.Hidden] : (status != 'SUBMITTED'),
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.rejectInvoice',
            Label : 'Reject',
            ![@UI.Hidden] : (status != 'SUBMITTED'),
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.markAsPaid',
            Label : 'Mark as Paid',
            ![@UI.Hidden] : (status != 'APPROVED'),
        },
    ],
);

// Vendor dropdown value help (kept simple - name only)
annotate service.Invoices with {
    vendor @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Vendors',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : vendor_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'vendorName',
                },
            ],
        },
        Common.Label : 'Vendor',
    )
};

annotate service.Invoices with {
    invoiceNumber @Common.Label : 'Invoice Number';
    isEditable @(UI.Hidden: true, Core.Computed: true);
    amount @Aggregation.default : #SUM;
};

// Status & Currency dropdowns
annotate service.Invoices with {
    status @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'InvoiceStatuses',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : status,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.Label : 'Status',
    );
    currency @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currencies',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : currency,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.Label : 'Currency',
    );
};

// ============================================================
// LINE ITEMS (inline-editable table in the "Items" facet + its own Object Page)
// ============================================================
annotate service.InvoiceItems with @(
    UI.HeaderFacets : [],

    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
        { $Type : 'UI.DataField', Label : 'Description',  Value : description },
        { $Type : 'UI.DataField', Label : 'Quantity',      Value : quantity },
        { $Type : 'UI.DataField', Label : 'Unit Price',    Value : unitPrice },
        { $Type : 'UI.DataField', Label : 'Total Amount',  Value : totalAmount },
    ],

    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Line Item',
        TypeNamePlural : 'Line Items',
        Title : { Value : description },
        Description : { Value : totalAmount },
        TypeImageUrl : 'sap-icon://my-sales-order',
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'ItemDetailsFacet',
            Label : 'Item Details',
            Target : '@UI.FieldGroup#ItemDetails',
        },
    ],

    UI.FieldGroup #ItemDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Description',  Value : description },
            { $Type : 'UI.DataField', Label : 'Quantity',     Value : quantity },
            { $Type : 'UI.DataField', Label : 'Unit Price',   Value : unitPrice },
            { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
            { $Type : 'UI.DataField', Label : 'Line Number',  Value : lineNumber },
        ],
    },
);

annotate service.InvoiceItems with {
    totalAmount @Core.Computed : true;
    lineNumber  @(Core.Computed : true, UI.HiddenFilter : true);
};

// ============================================================
// ATTACHMENTS (inline table + its own Object Page)
// ============================================================
annotate service.Attachments with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
        { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
        { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
        { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
        { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
    ],

    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Attachment',
        TypeNamePlural : 'Attachments',
        Title : { Value : fileName },
        Description : { Value : uploadedBy },
        TypeImageUrl : 'sap-icon://sales-order-item',
    },

    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'AttachmentDetailsFacet',
            Label : 'Attachment Details',
            Target : '@UI.FieldGroup#AttachmentDetails',
        },
    ],

    UI.FieldGroup #AttachmentDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
            { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
            { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
            { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
            { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
        ],
    },
);

annotate service.Attachments with {
    uploadedBy @(Core.Computed : true, UI.HiddenFilter : true);
    mimeType   @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'FileTypes',
            Parameters : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : mimeType, ValueListProperty : 'code' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
            ],
        },
        Common.Label : 'File Type',
    );
};

// ============================================================
// APPROVAL HISTORY (read-only timeline table)
// ============================================================
annotate service.ApprovalHistory with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Action',    Value : action },
        { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
        { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
        { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
    ],
    UI.PresentationVariant : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [{ Property : timestamp, Descending : false }],
    },
);
annotate service.Invoices with {
    invoiceDate @Common.Label : 'Invoice Date'
};



