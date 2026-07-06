const cds = require('@sap/cds');
const mockResponse = require('./external/mock-suppliers.json');

// Simple country-code -> default currency lookup.
// (A real integration would instead call A_SupplierCompany for the
// contractual currency - out of scope for this project, so we default
// sensibly by country instead.)
const currencyByCountry = {
  US: 'USD', GB: 'GBP', DE: 'EUR', FR: 'EUR', NO: 'EUR', IN: 'INR', AU: 'AUD', CA: 'USD'
};

module.exports = cds.service.impl(async function () {

  const { Vendors } = cds.entities('vendorinvoice.db');

  this.on('syncVendorsFromS4', async (req) => {

    // ---- Fetch step ----
    // TODO (Day 44): replace this with a real remote call once a destination exists, e.g.:
    //   const bp = await cds.connect.to('API_BUSINESS_PARTNER');
    //   const suppliers = await bp.run(
    //     SELECT.from('A_BusinessPartner')
    //       .columns('BusinessPartner', 'BusinessPartnerFullName',
    //         'to_BusinessPartnerAddress.Country',
    //         'to_BusinessPartnerAddress.to_EmailAddress.EmailAddress',
    //         'to_BusinessPartnerAddress.to_PhoneNumber.PhoneNumber')
    //   );
    // For now, we read the same shape from a local mock file:
    const suppliers = mockResponse;

    let created = 0;
    let updated = 0;

    for (const bp of suppliers) {
      // ---- Map step: real API field names -> our Vendors schema ----
      const address = bp.to_BusinessPartnerAddress?.results?.[0] || {};
      const email = address.to_EmailAddress?.results?.[0]?.EmailAddress || null;
      const phone = address.to_PhoneNumber?.results?.[0]?.PhoneNumber || null;
      const country = address.Country || null;
      const currency = currencyByCountry[country] || 'USD';

      const mapped = {
        vendorName: bp.BusinessPartnerFullName,
        email,
        phone,
        country,
        currency,
        externalID: bp.BusinessPartner
      };

      const existing = await SELECT.one.from(Vendors).where({ externalID: mapped.externalID });

      if (existing) {
        await UPDATE(Vendors).set(mapped).where({ ID: existing.ID });
        updated++;
      } else {
        await INSERT.into(Vendors).entries({
          ...mapped,
          status: 'PENDING'
        });
        created++;
      }
    }

    return {
      totalInS4: suppliers.length,
      newVendors: created,
      updatedVendors: updated,
      syncedAt: new Date().toISOString()
    };
  });
});