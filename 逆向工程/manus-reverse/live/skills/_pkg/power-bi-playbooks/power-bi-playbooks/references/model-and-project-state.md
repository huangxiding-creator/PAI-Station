# Model and project-state workflows

Read for W03 and W08.

## W03: semantic model, measures, and RLS

### Contract

- **Primary route now:** read-only P0 inventory and a reviewable change/test plan.
- **Escalation:** use a model tool only when its exact current-session schema is exposed, the intended model attachment is proved, and transaction or rollback behavior is known.
- **Fallback:** return a proposed diff, DAX assertions, relationship checks, and RLS identity matrix without claiming application.
- **Verification:** relationship cardinality and filter direction, orphan keys, exact measure values, rollback receipt, and named RLS identities.
- **CU display:** no in this source revision; Desktop apply/reload lacks O1.

Keep three model surfaces separate:

1. TMDL or other structured project source in a copied PBIP tree;
2. a session-specific model attached to the open Desktop process;
3. a published Service semantic model under cloud identity and capacity rules.

Do not infer that a public modeling server is connected to Manus. Do not use a privileged identity as an RLS acceptance test. Do not edit report visuals to conceal a model error.

## W08: source control and batch refactoring

### Contract

- **Primary route now:** copy/hash the input, inventory PBIX versus PBIP/TMDL/PBIR, scan protected paths, and produce a minimal proposed diff.
- **Escalation:** official PBIX conversion belongs to an independently qualified Desktop route. Final reload/screenshot may use the official Desktop Bridge only after the host-local gate passes. Applying structured edits still requires current schemas or model-aware validators plus a Power BI round trip.
- **Fallback:** if only PBIX exists, stop with a conversion handoff. Never treat PBIX as a general archive.
- **Verification:** original hash unchanged, intended file allowlist, protected-path exclusion, minimal diff, parse/schema result, model result, and rendered result tracked separately.
- **CU display:** no. A qualified Bridge reload/screenshot is a host-local protocol route, not CU; conversion and visual interaction still require their own current O1.

In this package, PBIP/TMDL/PBIR source handling is deliberately read-only. It may inspect paths, identifiers, schemas declared by the project, and potential batch changes. It must not apply a mutation merely because the files are text or JSON.

Protected content includes credentials, tokens, local settings, caches, machine paths, and any file not in the approved change set. A clean static diff does not prove Desktop accepted the model or rendered the report.

If the target runtime exposes the official Desktop Bridge, read `desktop-bridge.md`. Use it only to reopen or reload a copied project and collect bounded state/screenshot evidence. Never infer that the bridge authored the proposed diff or validated model semantics.
