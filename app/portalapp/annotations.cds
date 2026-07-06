// // using AdminService as service from '../../srv/admin-service';

// // // ============================================================
// // // VENDORS (List Report + Object Page)
// // // ============================================================

// // annotate service.Vendors with @(

// //     UI.SelectionFields : [
// //         status,
// //         country,
// //         currency
// //     ],

// //     UI.LineItem : [
// //         { $Type : 'UI.DataField', Label : 'Vendor Name', Value : vendorName },
// //         { $Type : 'UI.DataField', Label : 'Email',        Value : email },
// //         { $Type : 'UI.DataField', Label : 'Phone',        Value : phone },
// //         { $Type : 'UI.DataField', Label : 'Country',      Value : country },
// //         { $Type : 'UI.DataField', Label : 'Currency',     Value : currency },
// //         { $Type : 'UI.DataField', Label : 'Tax ID',       Value : taxID },
// //         {
// //             $Type : 'UI.DataFieldWithUrl',
// //             Label : 'Status',
// //             Value : status,
// //             Criticality : criticality,
// //         },
// //     ],

// //     UI.PresentationVariant : {
// //         $Type : 'UI.PresentationVariantType',
// //         SortOrder : [{ Property : vendorName, Descending : false }],
// //         Visualizations : ['@UI.LineItem'],
// //     },

// //     // -------------------- Object Page header --------------------
// //     UI.HeaderInfo : {
// //         $Type : 'UI.HeaderInfoType',
// //         TypeName : 'Vendor',
// //         TypeNamePlural : 'Vendors',
// //         Title : { Value : vendorName },
// //         Description : { Value : status },
// //         TypeImageUrl : 'sap-icon://group',
// //     },

// //     UI.HeaderFacets : [
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'HeaderStatusFacet',
// //             Label : 'Status',
// //             Target : '@UI.FieldGroup#HeaderStatus',
// //         },
// //     ],

// //     UI.FieldGroup #HeaderStatus : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
// //             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
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
// //             ID : 'ContactInfoFacet',
// //             Label : 'Contact Information',
// //             Target : '@UI.FieldGroup#ContactInfo',
// //         },
// //         {
// //             $Type : 'UI.ReferenceFacet',
// //             ID : 'VendorDetailsFacet',
// //             Label : 'Vendor Details',
// //             Target : '@UI.FieldGroup#VendorDetails',
// //         },
// //     ],

// //     UI.FieldGroup #GeneralInfo : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Vendor Name',      Value : vendorName },
// //             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
// //             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
// //         ],
// //     },

// //     UI.FieldGroup #ContactInfo : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Email',   Value : email },
// //             { $Type : 'UI.DataField', Label : 'Phone',   Value : phone },
// //             { $Type : 'UI.DataField', Label : 'Address', Value : address },
// //             { $Type : 'UI.DataField', Label : 'Country', Value : country },
// //         ],
// //     },

// //     UI.FieldGroup #VendorDetails : {
// //         $Type : 'UI.FieldGroupType',
// //         Data : [
// //             { $Type : 'UI.DataField', Label : 'Currency',    Value : currency },
// //             { $Type : 'UI.DataField', Label : 'Tax ID',      Value : taxID },
// //             { $Type : 'UI.DataField', Label : 'External ID', Value : externalID },
// //         ],
// //     },

// //     // -------------------- Actions on the Object Page --------------------
// //     UI.Identification : [
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.approveVendor',
// //             Label : 'Approve Vendor',
// //             ![@UI.Hidden] : (status = 'APPROVED' or status = 'DELETED'),
// //         },
// //         {
// //             $Type : 'UI.DataFieldForAction',
// //             Action : 'AdminService.suspendVendor',
// //             Label : 'Suspend Vendor',
// //             ![@UI.Hidden] : (status != 'APPROVED'),
// //         },
// //     ],
// // );

// // // Currency dropdown
// // annotate service.Vendors with {
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

// // annotate service.Vendors with {
// //     vendorName @Common.Label : 'Vendor Name';
// //     taxID      @Common.Label : 'Tax ID';
// // };


// using AdminService as service from '../../srv/admin-service';

// // ============================================================
// // VENDORS (List Report + Object Page)
// // ============================================================

// annotate service.Vendors with @(

//     UI.SelectionFields : [
//         status,
//         country,
//         currency
//     ],

//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Vendor Name', Value : vendorName },
//         { $Type : 'UI.DataField', Label : 'Email',        Value : email },
//         { $Type : 'UI.DataField', Label : 'Phone',        Value : phone },
//         { $Type : 'UI.DataField', Label : 'Country',      Value : country },
//         { $Type : 'UI.DataField', Label : 'Currency',     Value : currency },
//         { $Type : 'UI.DataField', Label : 'Tax ID',       Value : taxID },
//         {
//             $Type : 'UI.DataFieldWithUrl',
//             Label : 'Status',
//             Value : status,
//             Criticality : criticality,
//         },
//     ],

//     // -------------------- Analytics: enable Table/Chart toggle --------------------
//     Analytics.AggregatedProperties : [
//         {
//             Name : 'VendorCount',
//             AggregationMethod : 'countdistinct',
//             AggregatableProperty : ID,
//             ![@Common.Label] : 'Number of Vendors',
//         },
//     ],

//     UI.Chart : {
//         $Type : 'UI.ChartDefinitionType',
//         ChartType : #Donut,
//         Title : 'Vendors by Status',
//         Dimensions : [status],
//         DimensionAttributes : [
//             { Dimension : status, Role : #Category },
//         ],
//         DynamicMeasures : ['@Analytics.AggregatedProperty#VendorCount'],
//         MeasureAttributes : [
//             { DynamicMeasure : '@Analytics.AggregatedProperty#VendorCount', Role : #Axis1 },
//         ],
//     },

//     UI.Chart #byCountry : {
//         $Type : 'UI.ChartDefinitionType',
//         ChartType : #Bar,
//         Title : 'Vendors by Country',
//         Dimensions : [country],
//         DimensionAttributes : [
//             { Dimension : country, Role : #Category },
//         ],
//         DynamicMeasures : ['@Analytics.AggregatedProperty#VendorCount'],
//         MeasureAttributes : [
//             { DynamicMeasure : '@Analytics.AggregatedProperty#VendorCount', Role : #Axis1 },
//         ],
//     },

//     // Dashboard KPI tile
//     UI.KPI #TotalVendors : {
//         $Type : 'UI.KPIType',
//         DataPoint : {
//             $Type : 'UI.DataPointType',
//             Value : ID,
//             Title : 'Total Vendors',
//         },
//         Detail : {
//             $Type : 'UI.KPIDetailType',
//             DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
//         },
//     },
//     UI.KPI #PendingVendors : {
//         $Type : 'UI.KPIType',
//         DataPoint : {
//             $Type : 'UI.DataPointType',
//             Value : ID,
//             Title : 'Pending Vendors',
//         },
//         SelectionVariant : {
//             $Type : 'UI.SelectionVariantType',
//             SelectOptions : [{
//                 PropertyName : status,
//                 Ranges : [{ Sign : #I, Option : #EQ, Low : 'PENDING' }],
//             }],
//         },
//         Detail : {
//             $Type : 'UI.KPIDetailType',
//             DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
//         },
//     },

//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [{ Property : vendorName, Descending : false }],
//         Visualizations : ['@UI.LineItem', '@UI.Chart'],
//     },

//     // -------------------- Object Page header --------------------
//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Vendor',
//         TypeNamePlural : 'Vendors',
//         Title : { Value : vendorName },
//         Description : { Value : status },
//         TypeImageUrl : 'sap-icon://group',
//     },

//     UI.HeaderFacets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HeaderStatusFacet',
//             Label : 'Status',
//             Target : '@UI.FieldGroup#HeaderStatus',
//         },
//     ],

//     UI.FieldGroup #HeaderStatus : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
//             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
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
//             ID : 'ContactInfoFacet',
//             Label : 'Contact Information',
//             Target : '@UI.FieldGroup#ContactInfo',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'VendorDetailsFacet',
//             Label : 'Vendor Details',
//             Target : '@UI.FieldGroup#VendorDetails',
//         },
//     ],

//     UI.FieldGroup #GeneralInfo : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Vendor Name',      Value : vendorName },
//             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
//             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
//         ],
//     },

//     UI.FieldGroup #ContactInfo : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Email',   Value : email },
//             { $Type : 'UI.DataField', Label : 'Phone',   Value : phone },
//             { $Type : 'UI.DataField', Label : 'Address', Value : address },
//             { $Type : 'UI.DataField', Label : 'Country', Value : country },
//         ],
//     },

//     UI.FieldGroup #VendorDetails : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Currency',    Value : currency },
//             { $Type : 'UI.DataField', Label : 'Tax ID',      Value : taxID },
//             { $Type : 'UI.DataField', Label : 'External ID', Value : externalID },
//         ],
//     },

//     // -------------------- Actions on the Object Page --------------------
//     UI.Identification : [
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.approveVendor',
//             Label : 'Approve Vendor',
//             ![@UI.Hidden] : (status = 'APPROVED' or status = 'DELETED'),
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.suspendVendor',
//             Label : 'Suspend Vendor',
//             ![@UI.Hidden] : (status != 'APPROVED'),
//         },
//     ],
// );

// // Currency dropdown
// annotate service.Vendors with {
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

// annotate service.Vendors with {
//     vendorName @Common.Label : 'Vendor Name';
//     taxID      @Common.Label : 'Tax ID';
// };

// using AdminService as service from '../../srv/admin-service';

// // ============================================================
// // VENDORS (List Report + Object Page)
// // ============================================================

// annotate service.Vendors with @(

//     UI.SelectionFields : [
//         status,
//         country,
//         currency
//     ],

//     UI.LineItem : [
//         { $Type : 'UI.DataField', Label : 'Vendor Name', Value : vendorName },
//         { $Type : 'UI.DataField', Label : 'Email',        Value : email },
//         { $Type : 'UI.DataField', Label : 'Phone',        Value : phone },
//         { $Type : 'UI.DataField', Label : 'Country',      Value : country },
//         { $Type : 'UI.DataField', Label : 'Currency',     Value : currency },
//         { $Type : 'UI.DataField', Label : 'Tax ID',       Value : taxID },
//         {
//             $Type : 'UI.DataFieldWithUrl',
//             Label : 'Status',
//             Value : status,
//             Criticality : criticality,
//         },
//     ],

//     UI.PresentationVariant : {
//         $Type : 'UI.PresentationVariantType',
//         SortOrder : [{ Property : vendorName, Descending : false }],
//         Visualizations : ['@UI.LineItem'],
//     },

//     // -------------------- Object Page header --------------------
//     UI.HeaderInfo : {
//         $Type : 'UI.HeaderInfoType',
//         TypeName : 'Vendor',
//         TypeNamePlural : 'Vendors',
//         Title : { Value : vendorName },
//         Description : { Value : status },
//         TypeImageUrl : 'sap-icon://group',
//     },

//     UI.HeaderFacets : [
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'HeaderStatusFacet',
//             Label : 'Status',
//             Target : '@UI.FieldGroup#HeaderStatus',
//         },
//     ],

//     UI.FieldGroup #HeaderStatus : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
//             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
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
//             ID : 'ContactInfoFacet',
//             Label : 'Contact Information',
//             Target : '@UI.FieldGroup#ContactInfo',
//         },
//         {
//             $Type : 'UI.ReferenceFacet',
//             ID : 'VendorDetailsFacet',
//             Label : 'Vendor Details',
//             Target : '@UI.FieldGroup#VendorDetails',
//         },
//     ],

//     UI.FieldGroup #GeneralInfo : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Vendor Name',      Value : vendorName },
//             { $Type : 'UI.DataField', Label : 'Status',           Value : status },
//             { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
//         ],
//     },

//     UI.FieldGroup #ContactInfo : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Email',   Value : email },
//             { $Type : 'UI.DataField', Label : 'Phone',   Value : phone },
//             { $Type : 'UI.DataField', Label : 'Address', Value : address },
//             { $Type : 'UI.DataField', Label : 'Country', Value : country },
//         ],
//     },

//     UI.FieldGroup #VendorDetails : {
//         $Type : 'UI.FieldGroupType',
//         Data : [
//             { $Type : 'UI.DataField', Label : 'Currency',    Value : currency },
//             { $Type : 'UI.DataField', Label : 'Tax ID',      Value : taxID },
//             { $Type : 'UI.DataField', Label : 'External ID', Value : externalID },
//         ],
//     },

//     // -------------------- Actions on the Object Page --------------------
//     UI.Identification : [
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.approveVendor',
//             Label : 'Approve Vendor',
//             ![@UI.Hidden] : (status = 'APPROVED' or status = 'DELETED'),
//         },
//         {
//             $Type : 'UI.DataFieldForAction',
//             Action : 'AdminService.suspendVendor',
//             Label : 'Suspend Vendor',
//             ![@UI.Hidden] : (status != 'APPROVED'),
//         },
//     ],
// );

// // Currency dropdown
// annotate service.Vendors with {
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

// annotate service.Vendors with {
//     vendorName @Common.Label : 'Vendor Name';
//     taxID      @Common.Label : 'Tax ID';
// };


using AdminService as service from '../../srv/admin-service';

// ============================================================
// VENDORS (List Report + Object Page)
// ============================================================

annotate service.Vendors with @(

    UI.SelectionFields : [
        status,
        country,
        currency
    ],

    UI.LineItem : [
        { $Type : 'UI.DataField', Label : 'Vendor Name', Value : vendorName },
        { $Type : 'UI.DataField', Label : 'Email',        Value : email },
        { $Type : 'UI.DataField', Label : 'Phone',        Value : phone },
        { $Type : 'UI.DataField', Label : 'Country',      Value : country },
        { $Type : 'UI.DataField', Label : 'Currency',     Value : currency },
        { $Type : 'UI.DataField', Label : 'Tax ID',       Value : taxID },
        {
            $Type : 'UI.DataFieldWithUrl',
            Label : 'Status',
            Value : status,
            Criticality : criticality,
        },
    ],

    // -------------------- Analytics: enable Table/Chart toggle --------------------
    Analytics.AggregatedProperties : [
        {
            Name : 'VendorCount',
            AggregationMethod : 'countdistinct',
            AggregatableProperty : ID,
            ![@Common.Label] : 'Number of Vendors',
        },
    ],

    UI.Chart : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Donut,
        Title : 'Vendors by Status',
        Dimensions : [status],
        DimensionAttributes : [
            { Dimension : status, Role : #Category },
        ],
        DynamicMeasures : ['@Analytics.AggregatedProperty#VendorCount'],
        MeasureAttributes : [
            { DynamicMeasure : '@Analytics.AggregatedProperty#VendorCount', Role : #Axis1 },
        ],
    },

    UI.Chart #byCountry : {
        $Type : 'UI.ChartDefinitionType',
        ChartType : #Bar,
        Title : 'Vendors by Country',
        Dimensions : [country],
        DimensionAttributes : [
            { Dimension : country, Role : #Category },
        ],
        DynamicMeasures : ['@Analytics.AggregatedProperty#VendorCount'],
        MeasureAttributes : [
            { DynamicMeasure : '@Analytics.AggregatedProperty#VendorCount', Role : #Axis1 },
        ],
    },

    // Dashboard KPI tile
    UI.KPI #TotalVendors : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : ID,
            Title : 'Total Vendors',
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
        },
    },
    UI.KPI #PendingVendors : {
        $Type : 'UI.KPIType',
        DataPoint : {
            $Type : 'UI.DataPointType',
            Value : ID,
            Title : 'Pending Vendors',
        },
        SelectionVariant : {
            $Type : 'UI.SelectionVariantType',
            SelectOptions : [{
                PropertyName : status,
                Ranges : [{ Sign : #I, Option : #EQ, Low : 'PENDING' }],
            }],
        },
        Detail : {
            $Type : 'UI.KPIDetailType',
            DefaultPresentationVariant : { Visualizations : ['@UI.Chart'] },
        },
    },

    UI.PresentationVariant : {
        $Type : 'UI.PresentationVariantType',
        SortOrder : [{ Property : vendorName, Descending : false }],
        Visualizations : ['@UI.LineItem', '@UI.Chart'],
    },

    // -------------------- Object Page header --------------------
    UI.HeaderInfo : {
        $Type : 'UI.HeaderInfoType',
        TypeName : 'Vendor',
        TypeNamePlural : 'Vendors',
        Title : { Value : vendorName },
        Description : { Value : status },
        TypeImageUrl : 'sap-icon://group',
    },

    UI.HeaderFacets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'HeaderStatusFacet',
            Label : 'Status',
            Target : '@UI.FieldGroup#HeaderStatus',
        },
    ],

    UI.FieldGroup #HeaderStatus : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Status',           Value : status },
            { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
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
            ID : 'ContactInfoFacet',
            Label : 'Contact Information',
            Target : '@UI.FieldGroup#ContactInfo',
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'VendorDetailsFacet',
            Label : 'Vendor Details',
            Target : '@UI.FieldGroup#VendorDetails',
        },
    ],

    UI.FieldGroup #GeneralInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Vendor Name',      Value : vendorName },
            { $Type : 'UI.DataField', Label : 'Status',           Value : status },
            { $Type : 'UI.DataField', Label : 'Assigned Manager', Value : assignedManager },
        ],
    },

    UI.FieldGroup #ContactInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Email',   Value : email },
            { $Type : 'UI.DataField', Label : 'Phone',   Value : phone },
            { $Type : 'UI.DataField', Label : 'Address', Value : address },
            { $Type : 'UI.DataField', Label : 'Country', Value : country },
        ],
    },

    UI.FieldGroup #VendorDetails : {
        $Type : 'UI.FieldGroupType',
        Data : [
            { $Type : 'UI.DataField', Label : 'Currency',    Value : currency },
            { $Type : 'UI.DataField', Label : 'Tax ID',      Value : taxID },
            { $Type : 'UI.DataField', Label : 'External ID', Value : externalID },
        ],
    },

    // -------------------- Actions on the Object Page --------------------
    UI.Identification : [
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.approveVendor',
            Label : 'Approve Vendor',
            ![@UI.Hidden] : (status = 'APPROVED' or status = 'DELETED'),
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'AdminService.suspendVendor',
            Label : 'Suspend Vendor',
            ![@UI.Hidden] : (status != 'APPROVED'),
        },
    ],
);

// Currency dropdown
annotate service.Vendors with {
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

annotate service.Vendors with {
    vendorName @Common.Label : 'Vendor Name';
    taxID      @Common.Label : 'Tax ID';
};