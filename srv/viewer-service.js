const cds = require('@sap/cds');

// Read-only service — no custom business logic required.
// This file exists so the service can be extended later if needed
// (e.g. custom analytics calculations).
module.exports = cds.service.impl(async function () {
  // Intentionally empty for now.
});