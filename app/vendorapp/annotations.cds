// // using VendorService as service from '../../srv/vendor-service';

// // annotate service.Invoices with @(

// //     Capabilities.UpdateRestrictions.Updatable : isEditable,

// //     UI.SelectionFields : [
// //         vendor_ID,
// //         status,
// //         currency,
// //         invoiceDate
// //     ],

// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
// //         { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor.vendorName },
// //         { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
// //         { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
// //         { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
// //         { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },
// //     ],

// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [{ Property : invoiceDate, Descending : true }],
// //         Visualizations : ['@UI.LineItem'],
// //     },

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Invoice',
// //         TypeNamePlural : 'Invoices',
// //         Title : { Value : invoiceNumber },
// //         Description : { Value : status },
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
// //         ],
// //     },

// //     UI.Identification : [
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'VendorService.submitForApproval',
// //             Label : 'Submit for Approval',
// //             ![@UI.Hidden] : (status != 'DRAFT'),
// //         },
// //     ],
// // );

// // annotate service.Invoices with {
// //     vendor @Common.ValueList : {
// //         $Type : 'Common.ValueListType',
// //         CollectionPath : 'Vendors',
// //         Parameters : [
// //             { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : vendor_ID, ValueListProperty : 'ID' },
// //             { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'vendorName' },
// //         ],
// //     }
// // };

// // annotate service.Invoices with {
// //     isEditable @(UI.Hidden: true, Core.Computed: true);
// //     status @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'InvoiceStatuses',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : status, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         }
// //     );
// //     currency @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Currencies',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : currency, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         }
// //     );
// // };

// // annotate service.InvoiceItems with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
// //         { $Type : 'UI.DataField', Label : 'Description', Value : description },
// //         { $Type : 'UI.DataField', Label : 'Quantity',    Value : quantity },
// //         { $Type : 'UI.DataField', Label : 'Unit Price',  Value : unitPrice },
// //         { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
// //     ],
// // );
// // annotate service.InvoiceItems with {
// //     totalAmount @Core.Computed : true;
// //     lineNumber  @Core.Computed : true;
// // };

// // annotate service.Attachments with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
// //     ],
// // );
// // annotate service.Attachments with {
// //     uploadedBy @Core.Computed : true;
// //     mimeType @(
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

// // annotate service.ApprovalHistory with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
// //         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
// //         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
// //         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
// //     ],
// // );

// // using VendorService as service from '../../srv/vendor-service';

// // annotate service.Invoices with @(

// //     Capabilities.UpdateRestrictions.Updatable : isEditable,

// //     // Added: Delete restriction
// //     Capabilities.DeleteRestrictions.Deletable : isEditable,

// //     UI.SelectionFields : [
// //         vendor_ID,
// //         status,
// //         currency,
// //         invoiceDate
// //     ],

// //     // Added: Default filter and search support
// //     Search.Searchable : true,

// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
// //         { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor.vendorName },
// //         { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
// //         { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
// //         { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
// //         { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },

// //         // Added: Criticality visualization
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Approval Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },

// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },

// //         // Added: Editable status display
// //         {
// //             $Type : 'UI.DataField',
// //             Label : 'Editable',
// //             Value : isEditable,
// //         },
// //     ],

// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [{ Property : invoiceDate, Descending : true }],
// //         Visualizations : ['@UI.LineItem'],
// //     },

// //     // Added: Chart visualization
// //     UI.Chart #InvoiceAmountChart : {
// //         $Type : 'UI.ChartDefinitionType',
// //         ChartType : #Column,
// //         Dimensions : [status],
// //         Measures : [amount],
// //         DimensionAttributes : [
// //             {
// //                 $Type : 'UI.ChartDimensionAttributeType',
// //                 Dimension : status,
// //                 Role : #Category,
// //             }
// //         ],
// //         MeasureAttributes : [
// //             {
// //                 $Type : 'UI.ChartMeasureAttributeType',
// //                 Measure : amount,
// //                 Role : #Axis1,
// //             }
// //         ],
// //     },

// //     // Added: KPI
// //     UI.DataPoint #InvoiceAmountKPI : {
// //         $Type : 'UI.DataPointType',
// //         Value : amount,
// //         Title : 'Invoice Amount',
// //         Criticality : criticality,
// //     },

// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Invoice',
// //         TypeNamePlural : 'Invoices',
// //         Title : { Value : invoiceNumber },
// //         Description : { Value : status },
// //     },

// //     UI.HeaderFacets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HeaderVendorFacet',
// //             Label : 'Vendor',
// //             Target : '@UI.FieldGroup#HeaderVendor',
// //         },

// //         // Added: KPI Header Facet
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HeaderAmountFacet',
// //             Label : 'Invoice KPI',
// //             Target : '@UI.DataPoint#InvoiceAmountKPI',
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

// //     UI.Facets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'GeneralInfoFacet',
// //             Label : 'General Information',
// //             Target : '@UI.FieldGroup#GeneralInfo',
// //         },

// //         // Added: Analytics facet
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'AnalyticsFacet',
// //             Label : 'Analytics',
// //             Target : '@UI.Chart#InvoiceAmountChart',
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

// //             // Added: Editable field
// //             { $Type : 'UI.DataField', Label : 'Editable',       Value : isEditable },
// //         ],
// //     },

// //     // Added: Quick create support
// //     UI.CreateHidden : false,

// //     UI.Identification : [
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'VendorService.submitForApproval',
// //             Label : 'Submit for Approval',
// //             ![@UI.Hidden] : (status != 'DRAFT'),
// //         },

// //         // Added: Approve Action
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'VendorService.approveInvoice',
// //             Label : 'Approve Invoice',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },

// //         // Added: Reject Action
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'VendorService.rejectInvoice',
// //             Label : 'Reject Invoice',
// //             ![@UI.Hidden] : (status != 'SUBMITTED'),
// //         },
// //     ],
// // );

// // annotate service.Invoices with {
// //     vendor @Common.ValueList : {
// //         $Type : 'Common.ValueListType',
// //         CollectionPath : 'Vendors',
// //         Parameters : [
// //             { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : vendor_ID, ValueListProperty : 'ID' },
// //             { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'vendorName' },
// //         ],
// //     }
// // };

// // annotate service.Invoices with {
// //     isEditable @(UI.Hidden: true, Core.Computed: true);

// //     // Added: Criticality calculation
// //     criticality @Core.Computed : true;

// //     status @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'InvoiceStatuses',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : status, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         }
// //     );

// //     currency @(
// //         Common.ValueListWithFixedValues : true,
// //         Common.ValueList : {
// //             $Type : 'Common.ValueListType',
// //             CollectionPath : 'Currencies',
// //             Parameters : [
// //                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : currency, ValueListProperty : 'code' },
// //                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
// //             ],
// //         }
// //     );

// //     // Added: Amount formatting
// //     amount @Measures.ISOCurrency : currency;
// // };

// // annotate service.InvoiceItems with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
// //         { $Type : 'UI.DataField', Label : 'Description', Value : description },
// //         { $Type : 'UI.DataField', Label : 'Quantity',    Value : quantity },
// //         { $Type : 'UI.DataField', Label : 'Unit Price',  Value : unitPrice },
// //         { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },

// //         // Added: Currency support
// //         { $Type : 'UI.DataField', Label : 'Currency', Value : parent.currency },
// //     ],
// // );

// // annotate service.InvoiceItems with {
// //     totalAmount @Core.Computed : true;
// //     lineNumber  @Core.Computed : true;

// //     // Added: Currency formatting
// //     totalAmount @Measures.ISOCurrency : parent.currency;
// // };

// // annotate service.Attachments with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
// //         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
// //         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
// //         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
// //         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },

// //         // Added: Download URL
// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Download',
// //             Value : fileName,
// //             Url : url,
// //         },
// //     ],
// // );

// // annotate service.Attachments with {
// //     uploadedBy @Core.Computed : true;

// //     mimeType @(
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

// // annotate service.ApprovalHistory with @(
// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
// //         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
// //         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
// //         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },

// //         // Added: Status tracking
// //         { $Type : 'UI.DataField', Label : 'Status', Value : status },
// //     ],
// // );

// using VendorService as service from '../../srv/vendor-service';

// // ============================================================
// // INVOICES
// // ============================================================

// annotate service.Invoices with @(

//     Capabilities.UpdateRestrictions.Updatable : isEditable,
//     Capabilities.DeleteRestrictions.Deletable : isEditable,

//     Search.Searchable : true,

//     UI.SelectionFields : [
//         vendor_ID,
//         status,
//         currency,
//         invoiceDate
//     ],

//     UI.LineItem : [

//         {
//             $Type : 'UI.DataField',
//             Label : 'Invoice Number',
//             Value : invoiceNumber
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Vendor',
//             Value : vendor.vendorName
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Invoice Date',
//             Value : invoiceDate
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Due Date',
//             Value : dueDate
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Amount',
//             Value : amount
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Currency',
//             Value : currency
//         },

//         // FIXED: Removed invalid DataFieldWithUrl
//         {
//             $Type : 'UI.DataField',
//             Label : 'Status',
//             Value : status,
//             Criticality : criticality
//         }
//     ],

//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',

//         SortOrder : [
//             {
//                 Property : invoiceDate,
//                 Descending : true
//             }
//         ],

//         Visualizations : [
//             '@UI.LineItem'
//         ]
//     },

//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Invoice',
//         TypeNamePlural : 'Invoices',

//         Title : {
//             Value : invoiceNumber
//         },

//         Description : {
//             Value : status
//         }
//     },

//     UI.HeaderFacets : [

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HeaderVendorFacet',
//             Label : 'Vendor Summary',
//             Target : '@UI.FieldGroup#HeaderVendor'
//         },

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'AmountFacet',
//             Label : 'Amount KPI',
//             Target : '@UI.DataPoint#AmountKPI'
//         }
//     ],

//     UI.DataPoint #AmountKPI : {
//         $Type : 'UI.DataPointType',
//         Value : amount,
//         Title : 'Invoice Amount',
//         Criticality : criticality
//     },

//     UI.Chart #InvoiceChart : {
//         $Type : 'UI.ChartDefinitionType',
//         ChartType : #Column,

//         Dimensions : [
//             status
//         ],

//         Measures : [
//             amount
//         ],

//         DimensionAttributes : [
//             {
//                 $Type : 'UI.ChartDimensionAttributeType',
//                 Dimension : status,
//                 Role : #Category
//             }
//         ],

//         MeasureAttributes : [
//             {
//                 $Type : 'UI.ChartMeasureAttributeType',
//                 Measure : amount,
//                 Role : #Axis1
//             }
//         ]
//     },

//     UI.FieldGroup #HeaderVendor : {
//         $Type : 'UI.FieldGroupType',

//         Data : [

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Vendor',
//                 Value : vendor.vendorName
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Amount',
//                 Value : amount
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Currency',
//                 Value : currency
//             }
//         ]
//     },

//     UI.Facets : [

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'GeneralInfoFacet',
//             Label : 'General Information',
//             Target : '@UI.FieldGroup#GeneralInfo'
//         },

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'AnalyticsFacet',
//             Label : 'Analytics',
//             Target : '@UI.Chart#InvoiceChart'
//         },

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'ItemsFacet',
//             Label : 'Items',
//             Target : 'items/@UI.LineItem'
//         },

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'AttachmentsFacet',
//             Label : 'Attachments',
//             Target : 'attachments/@UI.LineItem'
//         },

//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HistoryFacet',
//             Label : 'Approval History',
//             Target : 'history/@UI.LineItem'
//         }
//     ],

//     UI.FieldGroup #GeneralInfo : {
//         $Type : 'UI.FieldGroupType',

//         Data : [

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Invoice Number',
//                 Value : invoiceNumber
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Vendor',
//                 Value : vendor_ID
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Invoice Date',
//                 Value : invoiceDate
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Due Date',
//                 Value : dueDate
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Amount',
//                 Value : amount
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Currency',
//                 Value : currency
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Status',
//                 Value : status
//             },

//             {
//                 $Type : 'UI.DataField',
//                 Label : 'Editable',
//                 Value : isEditable
//             }
//         ]
//     },

//     UI.Identification : [

//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'VendorService.submitForApproval',
//             Label : 'Submit For Approval',
//             ![@UI.Hidden] : (status != 'DRAFT')
//         },

//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'VendorService.approveInvoice',
//             Label : 'Approve',
//             ![@UI.Hidden] : (status != 'SUBMITTED')
//         },

//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'VendorService.rejectInvoice',
//             Label : 'Reject',
//             ![@UI.Hidden] : (status != 'SUBMITTED')
//         }
//     ]
// );

// // ============================================================
// // VALUE HELP
// // ============================================================

// annotate service.Invoices with {

//     vendor_ID @Common.ValueList : {
//         $Type : 'Common.ValueListType',

//         CollectionPath : 'Vendors',

//         Parameters : [

//             {
//                 $Type : 'Common.ValueListParameterInOut',
//                 LocalDataProperty : vendor_ID,
//                 ValueListProperty : 'ID'
//             },

//             {
//                 $Type : 'Common.ValueListParameterDisplayOnly',
//                 ValueListProperty : 'vendorName'
//             }
//         ]
//     };

//     status @(
//         Common.ValueListWithFixedValues : true,

//         Common.ValueList : {
//             $Type : 'Common.ValueListType',

//             CollectionPath : 'InvoiceStatuses',

//             Parameters : [

//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : status,
//                     ValueListProperty : 'code'
//                 },

//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name'
//                 }
//             ]
//         }
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
//                     ValueListProperty : 'code'
//                 },

//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name'
//                 }
//             ]
//         }
//     );

//     amount @Measures.ISOCurrency : currency;

//     isEditable @(
//         UI.Hidden : true,
//         Core.Computed : true
//     );

//     criticality @Core.Computed : true;
// };

// // ============================================================
// // INVOICE ITEMS
// // ============================================================

// annotate service.InvoiceItems with @(

//     UI.LineItem : [

//         {
//             $Type : 'UI.DataField',
//             Label : 'Line',
//             Value : lineNumber
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Description',
//             Value : description
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Quantity',
//             Value : quantity
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Unit Price',
//             Value : unitPrice
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Total Amount',
//             Value : totalAmount
//         }
//     ]
// );

// annotate service.InvoiceItems with {

//     totalAmount @Core.Computed : true;
//     lineNumber  @Core.Computed : true;
// };

// // ============================================================
// // ATTACHMENTS
// // ============================================================

// annotate service.Attachments with @(

//     UI.LineItem : [

//         {
//             $Type : 'UI.DataField',
//             Label : 'File Name',
//             Value : fileName
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'File Type',
//             Value : mimeType
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'File Size',
//             Value : fileSize
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Uploaded By',
//             Value : uploadedBy
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Uploaded At',
//             Value : createdAt
//         }
//     ]
// );

// annotate service.Attachments with {

//     uploadedBy @Core.Computed : true;

//     mimeType @(
//         Common.ValueListWithFixedValues : true,

//         Common.ValueList : {
//             $Type : 'Common.ValueListType',

//             CollectionPath : 'FileTypes',

//             Parameters : [

//                 {
//                     $Type : 'Common.ValueListParameterInOut',
//                     LocalDataProperty : mimeType,
//                     ValueListProperty : 'code'
//                 },

//                 {
//                     $Type : 'Common.ValueListParameterDisplayOnly',
//                     ValueListProperty : 'name'
//                 }
//             ]
//         }
//     );
// };

// // ============================================================
// // APPROVAL HISTORY
// // ============================================================

// annotate service.ApprovalHistory with @(

//     UI.LineItem : [

//         {
//             $Type : 'UI.DataField',
//             Label : 'Action',
//             Value : action
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Actor',
//             Value : actor
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Timestamp',
//             Value : timestamp
//         },

//         {
//             $Type : 'UI.DataField',
//             Label : 'Comments',
//             Value : comments
//         }
//     ]
// );

// using VendorService as service from '../../srv/vendor-service';

// annotate service.Invoices with @(

//     Capabilities.UpdateRestrictions.Updatable : isEditable,

//     UI.SelectionFields : [
//         vendor_ID,
//         status,
//         currency,
//         invoiceDate
//     ],

//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
//         { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor.vendorName },
//         { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
//         { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
//         { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
//         { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
//         {
//             $Type : 'UI.DataFieldWithUrl',
//             Label : 'Status',
//             Value : status,
//             Criticality : criticality,
//         },
//     ],

//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [{ Property : invoiceDate, Descending : true }],
//         Visualizations : ['@UI.LineItem'],
//     },

//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Invoice',
//         TypeNamePlural : 'Invoices',
//         Title : { Value : invoiceNumber },
//         Description : { Value : status },
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
//         ],
//     },

//     UI.Identification : [
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'VendorService.submitForApproval',
//             Label : 'Submit for Approval',
//             ![@UI.Hidden] : (status != 'DRAFT'),
//         },
//     ],
// );

// annotate service.Invoices with {
//     vendor @Common.ValueList : {
//         $Type : 'Common.ValueListType',
//         CollectionPath : 'Vendors',
//         Parameters : [
//             { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : vendor_ID, ValueListProperty : 'ID' },
//             { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'vendorName' },
//         ],
//     }
// };

// annotate service.Invoices with {
//     isEditable @(UI.Hidden: true, Core.Computed: true);
//     status @(
//         Common.ValueListWithFixedValues : true,
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'InvoiceStatuses',
//             Parameters : [
//                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : status, ValueListProperty : 'code' },
//                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
//             ],
//         }
//     );
//     currency @(
//         Common.ValueListWithFixedValues : true,
//         Common.ValueList : {
//             $Type : 'Common.ValueListType',
//             CollectionPath : 'Currencies',
//             Parameters : [
//                 { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : currency, ValueListProperty : 'code' },
//                 { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
//             ],
//         }
//     );
// };

// annotate service.InvoiceItems with @(
//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
//         { $Type : 'UI.DataField', Label : 'Description', Value : description },
//         { $Type : 'UI.DataField', Label : 'Quantity',    Value : quantity },
//         { $Type : 'UI.DataField', Label : 'Unit Price',  Value : unitPrice },
//         { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
//     ],
// );
// annotate service.InvoiceItems with {
//     totalAmount @Core.Computed : true;
//     lineNumber  @Core.Computed : true;
// };

// annotate service.Attachments with @(
//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
//         { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
//         { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
//         { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
//         { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
//     ],
// );
// annotate service.Attachments with {
//     uploadedBy @Core.Computed : true;
//     mimeType @(
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

// annotate service.ApprovalHistory with @(
//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Action',    Value : action },
//         { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
//         { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
//         { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
//     ],
// );



using VendorService as service from '../../srv/vendor-service';

annotate service.Invoices with @(

    Capabilities.UpdateRestrictions.Updatable : isEditable,

    UI.SelectionFields : [
        vendor_ID,
        status,
        currency,
        invoiceDate
    ],

    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Invoice Number', Value : invoiceNumber },
        { $Type : 'UI.DataField', Label : 'Vendor',         Value : vendor.vendorName },
        { $Type : 'UI.DataField', Label : 'Invoice Date',   Value : invoiceDate },
        { $Type : 'UI.DataField', Label : 'Due Date',       Value : dueDate },
        { $Type : 'UI.DataField', Label : 'Amount',         Value : amount },
        { $Type : 'UI.DataField', Label : 'Currency',       Value : currency },
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
    ],

    UI.Chart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Column,
        Title : 'My Invoices by Status',
        Dimensions : [status],
        DimensionAttributes : [
            { Dimension : status, Role : #Category },
        ],
        DynamicMeasures : ['@Analytics.AggregatedProperty#TotalAmount'],
        MeasureAttributes : [
            { DynamicMeasure : '@Analytics.AggregatedProperty#TotalAmount', Role : #Axis1 },
        ],
    },

    // Dashboard KPI tile
    UI.KPI #MyTotalAmount : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : amount,
            Title : 'My Total Invoice Amount',
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
        },
    },
    UI.KPI #MyPending : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : amount,
            Title : 'My Pending Invoices',
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
        SortOrder : [{ Property : invoiceDate, Descending : true }],
        Visualizations : ['@UI.LineItem', '@UI.Chart'],
    },

    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Invoice',
        TypeNamePlural : 'Invoices',
        Title : { Value : invoiceNumber },
        Description : { Value : status },
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
        ],
    },

    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'VendorService.submitForApproval',
            Label : 'Submit for Approval',
            ![@UI.Hidden] : (status != 'DRAFT'),
        },
    ],
);

annotate service.Invoices with {
    vendor @Common.ValueList : {
        $Type : 'Common.ValueListType',
        CollectionPath : 'Vendors',
        Parameters : [
            { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : vendor_ID, ValueListProperty : 'ID' },
            { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'vendorName' },
        ],
    }
};

annotate service.Invoices with {
    isEditable @(UI.Hidden: true, Core.Computed: true);
    amount @Aggregation.default : #SUM;
    status @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'InvoiceStatuses',
            Parameters : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : status, ValueListProperty : 'code' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
            ],
        }
    );
    currency @(
        Common.ValueListWithFixedValues : true,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currencies',
            Parameters : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : currency, ValueListProperty : 'code' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'name' },
            ],
        }
    );
};

annotate service.InvoiceItems with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Line',        Value : lineNumber },
        { $Type : 'UI.DataField', Label : 'Description', Value : description },
        { $Type : 'UI.DataField', Label : 'Quantity',    Value : quantity },
        { $Type : 'UI.DataField', Label : 'Unit Price',  Value : unitPrice },
        { $Type : 'UI.DataField', Label : 'Total Amount', Value : totalAmount },
    ],
);
annotate service.InvoiceItems with {
    totalAmount @Core.Computed : true;
    lineNumber  @Core.Computed : true;
};

annotate service.Attachments with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'File Name',   Value : fileName },
        { $Type : 'UI.DataField', Label : 'File Type',   Value : mimeType },
        { $Type : 'UI.DataField', Label : 'File Size',   Value : fileSize },
        { $Type : 'UI.DataField', Label : 'Uploaded By', Value : uploadedBy },
        { $Type : 'UI.DataField', Label : 'Uploaded At', Value : createdAt },
    ],
);
annotate service.Attachments with {
    uploadedBy @Core.Computed : true;
    mimeType @(
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

annotate service.ApprovalHistory with @(
    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Action',    Value : action },
        { $Type : 'UI.DataField', Label : 'Actor',     Value : actor },
        { $Type : 'UI.DataField', Label : 'Timestamp', Value : timestamp },
        { $Type : 'UI.DataField', Label : 'Comments',  Value : comments },
    ],
);