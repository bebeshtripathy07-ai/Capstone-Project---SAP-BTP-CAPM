sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"portalapp/test/integration/pages/InvoicesList",
	"portalapp/test/integration/pages/InvoicesObjectPage"
], function (JourneyRunner, InvoicesList, InvoicesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('portalapp') + '/test/flp.html#app-preview',
        pages: {
			onTheInvoicesList: InvoicesList,
			onTheInvoicesObjectPage: InvoicesObjectPage
        },
        async: true
    });

    return runner;
});

