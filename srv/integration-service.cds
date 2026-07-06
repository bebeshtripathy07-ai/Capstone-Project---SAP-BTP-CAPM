using { vendorinvoice.db as db } from '../db/schema';

service IntegrationService @(requires: 'Admin') {

  action syncVendorsFromS4() returns {
    totalInS4      : Integer;
    newVendors     : Integer;
    updatedVendors : Integer;
    syncedAt       : Timestamp;
  };
}