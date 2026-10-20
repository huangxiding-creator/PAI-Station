# FCPXML and structured handoffs

Use this reference for FCPXML, structured assemblies, roles, or metadata. Treat FCPXML as a portable interchange artifact, not retained Final Cut project state.

## C03 — Candidate editable handoff

- **Outcome:** Prepare and preflight a candidate structured handoff, then distinguish the artifact from an editable Final Cut destination.
- **Primary:** Sandbox file work.
- **Escalation:** The user requests verified import, the file has unresolved references, the version or construct is unsupported, or visual refinement is required.
- **Hybrid:** Prepare or review the candidate FCPXML, run deterministic preflight, then stop before the Final Cut import tail in this package revision.
- **Fallback:** Deliver the candidate artifact and report with status `not imported`; provide a handoff checklist rather than an app-completion claim.
- **Verification:** Check well-formedness, internal reference closure, expected names, and declared structure. If the user supplies the matching vendor DTD and a DTD-capable validator is available, run that as a separate validation layer. A future live run must separately verify app acceptance, order, duration, and online media.
- **Computer Use reason:** Computer Use is justified only when editable library, event, project, or timeline state must be materialized and observed in Final Cut.
- **Current status:** Artifact preflight is executable; the app tail is live-blocked.

### Execution contract

1. Ask whether the user needs only an artifact or a verified Final Cut import.
2. Preserve the original and collect an explicit structure and resource oracle.
3. Run `scripts/preflight_fcpxml.py` on the candidate.
4. If a matching vendor DTD is supplied, validate against it and report the result separately; otherwise mark DTD validation `not run`.
5. Do not call a hand-authored, parser-valid, reference-closed, or DTD-valid file Final Cut-compatible.
6. If native state is required, return the preflight result and the exact live qualification still missing.

## C07 — Roles and metadata handoff

- **Outcome:** Plan or review a narrow metadata or role change while preserving a baseline and an explicit diff.
- **Primary:** Sandbox file work on an existing, parseable baseline.
- **Escalation:** No Final Cut-emitted baseline exists, a requested field is unsupported, the diff exceeds the allowlist, or the user requires verified native retention.
- **Hybrid:** Obtain a baseline from the user or a future qualified app export, inspect and diff the proposed narrow change, then reserve native import and spot-check for a later live-qualified run.
- **Fallback:** Deliver a metadata plan and reviewable diff without claiming library mutation.
- **Verification:** Only declared fields may differ; internal references must still close. Native role or metadata retention and role-dependent output remain unverified until observed in Final Cut.
- **Computer Use reason:** Roles and metadata matter as app state only if they survive in the Final Cut library.
- **Current status:** Planning and preflight only. No Final Cut-emitted baseline or round-trip fixture has passed.

### Execution contract

Do not invent an FCPXML field mapping. Require a real baseline and an explicit allowlist. If either is absent, stop at a proposed mapping or inventory. Keep the original, proposed file, and diff separate.

## C10 — FCPXML preflight

- **Outcome:** Validate FCPXML syntax and internal references, with optional future app proof kept separate.
- **Primary:** Sandbox file work.
- **Escalation:** Malformed XML, duplicate IDs, unresolved references, an unknown compatibility target, or a request for Final Cut acceptance or round-trip proof.
- **Hybrid:** Run file preflight first. Add a disposable Final Cut import/export comparison only after a future current-build live qualification.
- **Fallback:** Return the parser and reference report with Final Cut acceptance marked `not tested`.
- **Verification:** XML parses; the unnamespaced root is `fcpxml`; a declared version matches `1.<non-negative integer>`; IDs are unique; internal references close; expected event and project names are reported. If the matching vendor DTD and a DTD-capable validator are both available, DTD validity is an additional named check. The version check is syntax only and does not prove that a target Final Cut build supports it. None of these checks proves media reachability, app acceptance, or semantic fidelity.
- **Computer Use reason:** Computer Use is needed only for app acceptance or native round-trip proof, not for file validation.
- **Current status:** Preflight is locally reproduced; Final Cut acceptance is live-blocked.

### Execution contract

Run `scripts/preflight_fcpxml.py` on a preserved copy. Reject a wrong root, a missing version, or a version that is not shaped as `1.<non-negative integer>` before reporting reference closure. Report every document issue, missing reference, and duplicate ID. If no matching vendor DTD or validator is available, state `DTD validation: not run`; do not substitute a remembered schema or silently fetch a different version. A syntactically valid declared version or a successful DTD check is not a compatibility claim. Never change `final_cut_acceptance` from `not_tested` without a separate current-build app run and observable postcondition.
