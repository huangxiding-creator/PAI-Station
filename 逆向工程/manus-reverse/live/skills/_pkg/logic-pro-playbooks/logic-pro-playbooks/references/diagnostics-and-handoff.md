# Diagnostics and handoff

Load this reference for LP6 or LP8.

## Project handoff without native execution

When Logic O1 is unavailable, create a handoff manifest from supplied files and user answers. Include:

- source and intended destination as separate locations;
- recipient Logic/macOS environment;
- project form if known;
- external audio, MIDI, samples, instruments, Audio Units, controller software, and license dependencies;
- portable companions already present or still required;
- hashes and inventory of the supplied staged files;
- which state a portable audio or interchange file cannot preserve;
- the unexecuted live checks: authoritative copy, asset inclusion, open, save, close, reopen, and missing-media review.
- the intended project alternative and whether its corresponding automatic-backup state must be retained;
- whether the authoritative deliverable should be a separately saved project copy with app-native asset consolidation after O1;

Never call a ZIP, stem set, interchange file, or manifest a complete Logic project merely because it is portable.

When a future O1 route exists, create the handoff from a separately saved copy and use Logic's own asset-consolidation behavior rather than copying guessed dependencies into the project bundle. Verify the copied project, each required alternative, included assets, missing-media state, and reopen result. Compress a package before transport through a non-Apple filesystem or internet channel only as a distinct delivery step; compression does not prove dependency completeness.

## Reversible diagnostic plan

Collect the exact symptom, reproduction boundary, Logic/macOS version, hardware, audio device, storage location, recent change, project scope, and plug-in scope. Then order tests from least consequential to most consequential.

Each test record must contain:

```text
Hypothesis
Protected input or project copy
One changed variable
Expected observation
Actual observation, if executed
Restore action
Cause confidence
Next safe test
```

Start with observation and a protected copy. A future live run may compare the affected copy with a minimal empty test project, but this package does not contain a current UI procedure for doing so.

Moving preferences or plug-ins, resetting settings, reinstalling software, deleting files, or changing global audio configuration is consequential. Present the exact proposed change and restoration plan, then obtain separate approval immediately before execution.

## Objective postconditions

- Handoff planning: the manifest separates supplied facts, user decisions, missing dependencies, known losses, and unexecuted Logic checks.
- Diagnosis planning: every test is reversible, changes one variable, and has an explicit restore action.
- Executed diagnosis: a cause is confirmed only by a reproduced A/B result. Otherwise label it provisional.
