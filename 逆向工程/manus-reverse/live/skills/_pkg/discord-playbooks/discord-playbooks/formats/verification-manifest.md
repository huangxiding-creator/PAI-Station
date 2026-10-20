# Discord Verification Manifest

Record status, identity, server/channel/object IDs, authority, granted scopes/intents, source completeness, fixture identities, target/content/mentions, secret exclusions, rollback, completed/skipped/failed counts, and ambiguous state.

## Official app or bot API

- runtime and app/bot identity;
- exact permissions/scopes/intents and denied-permission test;
- before snapshot and created/changed object IDs;
- semantic read-back and test-identity behavior;
- timeout query-before-retry, revoke/uninstall, and receipt-scoped cleanup.

## Webhook

- secret stored only in an approved surface;
- non-secret webhook identity and exact channel;
- `wait=true` or equivalent message receipt, resulting message ID/body, payload hash, and allowed-mention policy;
- application-level dedupe and ambiguous-timeout reconciliation;
- revoke/rotation test and no URL/token in artifacts.

## Personal Data Package

- verified-email prerequisite and active-request state;
- desktop/browser category selection or mobile all-data scope;
- request submission state, destination email at submission, and expected delivery window;
- original archive hash and detected package sections;
- exact requesting-account scope;
- object counts and parse exceptions;
- no claim of complete server or other-member history.

Never infer a compliant identity, complete inventory, retained server state, or delivery from UI access or request dispatch alone.
