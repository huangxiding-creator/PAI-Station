---
name: power-bi-playbooks
description: "Use when the user asks what Manus can do with Power BI Desktop or needs to prepare data, inspect an exported Performance Analyzer file, plan or validate report/model/project changes, diagnose refresh, or work with published Power BI state. Routes each workflow by retained state among sandbox files, capabilities exposed in the current Manus session, My Browser, and conditional Windows Desktop guidance."
---

# Power BI Playbooks (Manus for Power BI Desktop)

Route by the state that must remain editable, refreshable, or governed. A cleaned source file, an analyzer report, a PBIP project, an open Desktop model, and a published Service report are different products.

## 0. Current execution boundary

- Power BI Desktop is a Windows application. Microsoft publishes a local Desktop Bridge preview for a narrow status, open, reload, and screenshot surface. That upstream surface is not a Manus runtime capability until the exact target session exposes an authorized host-local client and the route passes its own qualification gate.
- This package has no current-build Power BI Desktop O1 procedure and no reproduced Desktop Bridge run, so it contains no Desktop UI steps and must not claim a Desktop or Bridge action passed.
- A public Power BI API, XMLA endpoint, or MCP server is not a Manus runtime capability. Use a connection only when its exact tools and authentication state are exposed in the current session.
- My Browser is a separate authenticated browser route, not Computer Use. Use it only when enabled, online, signed in to the intended tenant, and suitable for the required Service state.
- Portable file work may run in the sandbox. A mounted file does not prove arbitrary host execution or an open Power BI model connection.

Read `formats/state-and-route-contract.md` before selecting a workflow. Read `formats/desktop-runtime.md` before discussing any Desktop handoff, and `formats/verification-contract.md` before reporting completion.

## 1. Retained-state router

| Code | State the user must keep | Current route |
|---|---|---|
| D0 | Clean, reusable source files and a data-quality report | Sandbox file work; executable in this package |
| A0 | Analysis of a user-supplied timing JSON | Sandbox analysis; executable only after the observed shape is mapped to the normalized contract |
| P0 | PBIP, TMDL, or PBIR project source | Read-only inventory and diff planning in this package; edits remain conditional on current schemas, model-aware validation, and app round trip |
| L0 | PBIX, an open Desktop model, rendered Desktop canvas, Power Query lineage, or Desktop refresh state | Windows Desktop handoff; a narrow official Bridge route is conditional and unreproduced, while UI mutation remains live-blocked |
| C0 | Published report, semantic model, workspace, permissions, binding, gateway, or schedule | Exact current-session connection or My Browser after preflight; otherwise guidance |

Do not silently substitute one code for another. If the user has not chosen the retained state, explain the tradeoff and ask which object must remain authoritative.

## 2. Workflow map

| User outcome | Card | Primary route now | Escalation or stop | Read |
|---|---|---|---|---|
| Build a trustworthy KPI report | W01 | D0 source profiling, reconciliation, and acceptance specification | Stop before claiming P0, L0, or C0 unless that exact route is available and verified | `references/data-and-refresh.md` |
| Make recurring file preparation refreshable | W02 | D0 deterministic staging, quarantine, and idempotence checks | L0 only when Power Query lineage or a Desktop-only connector is required | `references/data-and-refresh.md` |
| Build or repair relationships, measures, or RLS | W03 | P0 read-only inventory and change plan | Use an exact current-session model tool only after attachment and transaction checks; otherwise stop before mutation | `references/model-and-project-state.md` |
| Redesign or accessibility-check a report | W04 | P0 audit/specification; D0 theme or asset preparation | Rendered evidence needs C0 through My Browser or a qualified L0 Bridge screenshot; interaction and UI mutation still need their own route | `references/report-and-performance.md` |
| Add navigation, drillthrough, bookmarks, or interactions | W05 | Interaction graph and test plan | Behavior remains blocked without a rendered Power BI surface | `references/report-and-performance.md` |
| Diagnose a slow report | W06 | A0 timing analysis from supplied evidence | Capture and app/model remediation remain conditional | `references/report-and-performance.md` |
| Diagnose a refresh failure | W07 | D0 file, path, and shape classification first | Route credential, gateway, schedule, or Desktop state only after the exact locus and runtime are known | `references/data-and-refresh.md` |
| Put a project under source control or batch-refactor it | W08 | P0 inventory, protected-path scan, and proposed minimal diff | Structured edits remain conditional; an official Bridge may reload and capture a copied project only after runtime qualification | `references/model-and-project-state.md` |
| Publish, update, rebind, or govern a report | W09 | C0 through an exact exposed connection; My Browser for visible cloud review | Stop without immutable target identity, permission, disposable scope, and immediate approval | `references/service-state.md` |
| Query or export from a published semantic model | W10 | C0 through an exact exposed read/query/export tool | My Browser is a visible fallback; Desktop is not a fallback for cloud-only state | `references/service-state.md` |

## 3. Package-wide rules

1. Preserve the original. Use a named copy or branch for source, project, model, or report changes.
2. Never binary-patch PBIX or present a valid JSON/text diff as proof that Power BI accepted or rendered it.
3. Separate source correction, model correction, report correction, and tenant governance into independently verified stages.
4. Probe the current tool surface before choosing a connection, My Browser, host-local, or Computer Use route. Documentation and generic plumbing are not availability.
5. For W02, use `scripts/stage_csv.py` only with an explicit JSON contract. For W06, use `scripts/analyze_performance.py` only with its normalized timing schema; preserve any source-to-normalized field map.
6. Publishing, overwriting, rebinding, permission, credential, gateway, or schedule changes require immutable target preview and immediate user approval.
7. Report the route used, authoritative retained state, input/output paths or cloud IDs, checks performed, and every blocked or unverified state.

For the optional Windows Bridge branch, also read `references/desktop-bridge.md`.
