# Published Service-state workflows

Read for W09 and W10.

## Runtime preflight

1. Inspect the exact connector or MCP tools exposed in the current Manus session.
2. If no suitable current-session connection exists, check whether My Browser is enabled, online, and signed in to the intended tenant.
3. Record the available tool schema, authentication state, caller, tenant, workspace, report or semantic-model identity, and requested operation.
4. If neither route exists, provide guidance or a dry-run plan. Do not present a public API, XMLA endpoint, or MCP server as connected.

My Browser is not Computer Use. The Windows Desktop app is not a fallback for cloud-only Service state.

## W09: publish, update, rebind, or govern

### Contract

- **Primary route:** an exact current-session connection whose exposed schema covers the operation.
- **Escalation:** My Browser for a visible authenticated cloud step or governance review that the connection does not cover.
- **Fallback:** immutable-ID inventory, dry-run payload or change plan, permission gap, and rollback plan.
- **Verification:** resulting definition or binding, intended authorized access, denied access where relevant, and operation receipt.
- **CU display:** no; this is Service cloud state.

Before mutation, show the immutable target identity, affected object, overwrite or binding effect, permissions, and rollback. Obtain immediate approval for the exact action. Do not target by display name alone when duplicates can exist.

## W10: query or export from a published semantic model

### Contract

- **Primary route:** an exact exposed read/query/export tool under the intended user identity.
- **Escalation:** My Browser as a visible authenticated fallback when the requested result is available there.
- **Fallback:** schema/query/export plan and the precise permission or runtime blocker.
- **Verification:** model and workspace identity, caller, timestamp, query grain, totals, and RLS/permission behavior.
- **CU display:** no; no Desktop launch belongs in this route.

Discover schema before generating a query. Preserve the difference between read, Build, export, and administrative permissions. Do not bypass RLS with a privileged identity and present the result as user-scoped.
