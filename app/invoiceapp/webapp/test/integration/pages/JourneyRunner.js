sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"invoiceapp/test/integration/pages/InvoicesList",
	"invoiceapp/test/integration/pages/InvoicesObjectPage"
], function (JourneyRunner, InvoicesList, InvoicesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('invoiceapp') + '/test/flp.html#app-preview',
        pages: {
			onTheInvoicesList: InvoicesList,
			onTheInvoicesObjectPage: InvoicesObjectPage
        },
        async: true
    });

    return runner;
});

