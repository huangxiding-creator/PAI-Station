# State and route contract

Use this contract before loading a workflow reference.

## State inventory

| State | What it means | Safe work in this package | What remains conditional |
|---|---|---|---|
| Portable source data | CSV or another inspectable staged input | Profile, clean under an explicit contract, quarantine invalid rows, reconcile totals, and write a new output | Authenticated source refresh and Power Query lineage |
| Normalized timing evidence | A copied JSON document with observed fields mapped to `name`, `total_ms`, and optional components | Validate, rank, calculate unreported time, and identify the dominant component | Capturing a real Performance Analyzer export or changing the report/model |
| PBIX | Monolithic local Desktop file | Copy, hash, inventory, and route | Conversion, refresh, model/report edits, render, save, and reopen |
| PBIP project | Pointer plus report and semantic-model project trees | Read-only inventory, protected-path scan, and proposed diff | Format-aware edit, app reload, render, and acceptance |
| TMDL or PBIR source | Structured model or report-definition state | Read-only inspection and change planning | Mutation until a current schema/model validator and Power BI round trip pass |
| Open Desktop state | Session model, Power Query state, local refresh, or rendered report | A narrow status/reload/screenshot route only after the official Desktop Bridge is detected and separately qualified | Authoring, interaction, refresh, model mutation, and every unqualified Desktop operation |
| Service state | Published report/model and workspace governance | Read through an exact exposed tool or signed-in My Browser when available | Mutation without exact runtime schema, permission, target, and approval |

## Route order

1. Ask what state must remain authoritative.
2. Inspect available input objects without mutating them.
3. Probe the exact tools exposed in the current session.
4. Select the cheapest route that preserves the required state.
5. If a required route is unavailable, produce the useful bounded artifact or diagnosis and name the blocked handoff.

## Channel meanings

- **Sandbox files**: computation and file transformation in the sandbox or authorized shared root. This is not Computer Use and not arbitrary host execution.
- **Current-session connection**: a connector or MCP tool whose exact schema and authentication state are visible now. Public vendor availability does not qualify.
- **My Browser**: the user's enabled browser connection and signed-in web session. It is not Computer Use.
- **Host-local route**: a permission-gated host terminal or registered local protocol that is actually advertised. It is not implied by a local app install. The official Desktop Bridge is one possible Windows-local protocol, but public documentation does not prove that Manus has its client, CLI, or permissions.
- **Computer Use**: semantic operation of the real Windows app. It is live-blocked for Power BI in this package because no current-build O1 procedure is included.
- **Guidance**: a retained-state decision, acceptance contract, diagnostic plan, or user handoff that does not claim execution.

## Non-substitution rules

- A portable CSV is not Power Query lineage.
- A PBIP/TMDL/PBIR diff is not an accepted PBIX or rendered report.
- A local Desktop model is not a published Service semantic model.
- A Service web report is not the user's local Desktop file.
- A public REST, XMLA, or MCP surface is not a Manus connection.
- My Browser is not Desktop CU.
- A Desktop Bridge screenshot or reload receipt is not report authoring, semantic-model mutation, interaction replay, refresh success, or broad Desktop control.
