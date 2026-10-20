# Audacity Route Contract

## Route precedence

1. Preserve an explicit request for editable Audacity state.
2. Name the required state as F0, M1, P1, or G0.
3. Inspect authorized files and current runtime before mutation.
4. Prefer a verified portable route when the user needs only portable outputs.
5. Use M1 only for an exact fixed chain reproduced on the installed build.
6. Escalate to P1 only for required recording, listening, waveform, plug-in, track, label, or project state and only after current-build O1.
7. State the route and completion truth label before execution.

## Truth labels

| State | Completion label | Must not be called |
|---|---|---|
| F0 | Protected, inspected, transformed, or packaged portable audio files | Audacity project editing or listening approval |
| M1 | Exact fixed app operation reproduced on the installed build | Universal Audacity automation |
| P1 | Named Audacity state that survives save and reopen, plus an explicit listening decision where required | Complete merely because an export exists |
| G0 | Current bounded guidance, safe stop, and next test | Executed audio processing |

## Material questions

- Does the user need portable files, an editable Audacity project, or both?
- Which source files are authoritative, and what provenance must be retained?
- Which technical standard and delivery set control acceptance?
- Which decisions require listening, and who approves the representative A/B sample?
- Is the source evidentiary, legal, journalistic, or otherwise provenance-sensitive?
- Which exact audio runtime, Audacity build, Macro, module, plug-in, and Computer Use surface are currently available?

Ask only when the answer changes the route, safety boundary, or acceptance oracle.

## Route-change record

When escalating, record the original route, observed limitation, newly required state, added permission or risk, and revised verification oracle.
