# Data preparation and refresh workflows

Read for W01, W02, and W07.

## W01: trustworthy KPI report

### Contract

- **Primary route now:** sandbox source profiling, data-quality checks, KPI definitions, reconciliation, and a retained-state plan.
- **Escalation:** only after the required P0, L0, or C0 route is detected and its acceptance surface is available.
- **Fallback:** deliver a clean source pack, KPI/source map, model/report specification, and blocked handoff. Do not claim a Power BI report exists.
- **Verification:** every KPI names source, grain, formula, expected total, and intended retained object.
- **CU display:** no in this source revision; local report creation and acceptance lack Power BI Desktop O1.

Ask for source access, KPI semantics, target audience, refresh expectations, and whether the authoritative result must be PBIX, PBIP, or Service state. Reconcile source totals before any model or report work. A visually plausible report with unreconciled metrics fails.

## W02: recurring source preparation

### Contract

- **Primary route:** D0 sandbox staging under an explicit contract.
- **Escalation:** L0 only when Power Query lineage or a Desktop-only connector is itself an acceptance requirement.
- **Hybrid handoff:** prove transformation rules on copied source files before transferring them to another retained state.
- **Fallback:** clean and quarantine outputs plus the contract and validation report.
- **Verification:** accepted plus quarantined rows reconcile to input; control totals match; a second run adds no duplicate business keys.
- **CU display:** no for deterministic cleanup; Desktop remains a conditional state handoff.

Use `scripts/stage_csv.py` when the input is CSV and the rules fit its explicit contract. The contract may declare required columns, strict date formats, integer or decimal fields, allowed values, a business key, and multiplication-based totals. Inspect the generated report before accepting the outputs.

Do not guess duplicate keys, invalid-row policy, date format, or whether trimming whitespace changes a business identifier. If these rules are unresolved, produce a diagnostic only.

## W07: refresh failure diagnosis

### Contract

- **Primary route:** classify the failure locus before changing state.
- **Local executable branch:** reproduce file, path, schema, type, and data-quality faults on the smallest copied input.
- **Conditional branches:** Desktop connector/model refresh belongs to L0; credentials, gateway, schedule, and published-dataset state belong to C0.
- **Fallback:** owner-specific runbook with exact error, last success, source, locus, and blocked permission.
- **Verification:** rerun at the original failure locus and reconcile rows and metrics; a local file success does not prove Service refresh.
- **CU display:** no until a card-specific Power BI Desktop O1 exists.

Capture the exact error and timestamp, source type, Desktop-versus-Service locus, owner, gateway involvement, and last known success. Never respond to an unclassified refresh failure by repeatedly changing credentials or gateway mappings.
