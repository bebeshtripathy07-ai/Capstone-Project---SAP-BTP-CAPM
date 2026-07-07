const cds = require('@sap/cds');
const LOG = cds.log('sbpa');

/**
 * Resolve SAP Build Process Automation credentials.
 * Priority: bound service instance (VCAP_SERVICES, label "process-automation")
 * then plain environment variables (local testing / cf set-env).
 * Returns null when SBPA is not configured — callers must treat that as "skip".
 */
function getConfig() {
  const definitionId = process.env.SBPA_PROCESS_DEFINITION_ID;

  try {
    const vcap = JSON.parse(process.env.VCAP_SERVICES || '{}');
    const bound = (vcap['process-automation'] || [])[0];
    if (bound) {
      const c = bound.credentials;
      return {
        apiUrl: c.endpoints?.api || c.api,
        tokenUrl: `${c.uaa.url}/oauth/token`,
        clientId: c.uaa.clientid,
        clientSecret: c.uaa.clientsecret,
        definitionId
      };
    }
  } catch (e) {
    LOG.warn('Could not parse VCAP_SERVICES', e.message);
  }

  if (process.env.SBPA_API_URL) {
    return {
      apiUrl: process.env.SBPA_API_URL,
      tokenUrl: process.env.SBPA_TOKEN_URL,
      clientId: process.env.SBPA_CLIENT_ID,
      clientSecret: process.env.SBPA_CLIENT_SECRET,
      definitionId
    };
  }

  return null;
}

async function fetchToken(cfg) {
  const res = await fetch(cfg.tokenUrl, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
      Authorization: 'Basic ' + Buffer.from(`${cfg.clientId}:${cfg.clientSecret}`).toString('base64')
    },
    body: 'grant_type=client_credentials'
  });
  if (!res.ok) throw new Error(`SBPA token request failed: ${res.status} ${await res.text()}`);
  return (await res.json()).access_token;
}

/**
 * Start the invoice-approval process in SAP Build Process Automation.
 * The context payload must match the input parameters defined on the
 * process's API trigger.
 * Never throws on missing configuration; throws on real API errors so the
 * caller can decide whether to fail the transaction.
 */
async function triggerInvoiceApproval(invoice) {
  const cfg = getConfig();
  if (!cfg || !cfg.definitionId) {
    LOG.warn('SBPA not configured (no binding / SBPA_PROCESS_DEFINITION_ID) — skipping process trigger');
    return null;
  }

  const token = await fetchToken(cfg);
  const res = await fetch(`${cfg.apiUrl}/workflow/rest/v1/workflow-instances`, {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
      Authorization: `Bearer ${token}`
    },
    body: JSON.stringify({
      definitionId: cfg.definitionId,
      context: {
        invoiceId: invoice.ID,
        invoiceNumber: invoice.invoiceNumber || String(invoice.ID),
        vendorName: invoice.vendorName || '',
        amount: Number(invoice.amount),
        currency: invoice.currency_code || invoice.currency || '',
        submittedBy: invoice.submittedBy || ''
      }
    })
  });
  if (!res.ok) throw new Error(`SBPA trigger failed: ${res.status} ${await res.text()}`);

  const instance = await res.json();
  LOG.info(`Started SBPA process instance ${instance.id} for invoice ${invoice.ID}`);
  return instance;
}

module.exports = { triggerInvoiceApproval };
