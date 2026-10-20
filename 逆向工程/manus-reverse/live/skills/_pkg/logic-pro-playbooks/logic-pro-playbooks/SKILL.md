---
name: logic-pro-playbooks
description: "Use when the user asks what Manus can do with Logic Pro or needs Logic-related workflows for music and MIDI production, vocal editing, mixing and exports, spoken audio, project handoff, Scripter MIDI effects, or troubleshooting. Routes portable audio, MIDI, source preparation, and diagnostics through available Manus file tools while reserving Logic-native project state for a current-build verified Logic Desktop session."
---

# Logic Pro Playbooks

Route by the state the user needs to retain. A WAV file, a MIDI file, reviewed Scripter source, an analysis report, and an editable Logic project are different deliverables.

## Step 0: Classify the durable state

```text
P1 PORTABLE AUDIO OR MIDI
   A WAV, MP3, MIDI file, manifest, or QA report is sufficient.
   Use available Manus-native generation or Sandbox file tools. Do not open Logic
   merely to inspect metadata, prepare source files, or validate portable outputs.

S1 SCRIPTER SOURCE
   Reviewed JavaScript and deterministic MIDI input/output vectors are sufficient.
   Prepare and validate the source outside Logic. Do not claim Scripter execution,
   preset persistence, or project persistence.

L1 LOGIC-NATIVE PROJECT STATE
   Tracks, regions, takes, comp maps, Flex state, instruments, routing, plug-ins,
   automation, Scripter state, or project relationships must remain editable.
   This requires Logic Desktop. The current package has no current-build O1 path,
   so live mutation stays blocked until the runtime gate passes.

D1 DIAGNOSTIC OR HANDOFF PLAN
   An observation log, dependency inventory, loss report, or reversible test plan
   is sufficient. Use guidance and read-only file analysis first.
```

Read [the route contracts](references/route-contracts.md) before selecting a card.

## Step 0.5: Runtime truth gate

- Inspect the tools exposed in the current session. Static source code does not prove that a Manus-native music tool, mounted folder, host terminal, Computer Use, or recorder is available.
- Treat a shared or mounted file as Sandbox-visible input, not arbitrary host execution. Use host-local commands only when the current session exposes an authorized terminal root.
- Do not use My Browser, a connector, or an assumed external protocol for Logic project state. This package has no evidence for those routes.
- Do not operate Logic Desktop unless the exact app record, current build, Computer Use permissions, writable disposable project, audio-monitoring path, and objective state read-back are live-observed.
- Without that O1 preflight, keep all exact Logic controls and procedures out of the response. Deliver the portable preparation, specification, or diagnostic handoff instead and label native execution blocked.

Read [Logic-native state](references/logic-native-state.md) before any L1 branch.

## Step 1: Select the outcome card

| User outcome | Card | Default route | Read |
|---|---|---|---|
| Create original music or continue into an editable production | LP1 | Active Manus-native audio generation for P1; L1 blocked until O1 | [Portable artifacts](references/portable-artifacts.md), [Logic-native state](references/logic-native-state.md) |
| Arrange supplied audio and MIDI | LP2 | Sandbox preflight; L1 blocked until O1 | [Portable artifacts](references/portable-artifacts.md), [Logic-native state](references/logic-native-state.md) |
| Comp and tune vocals while preserving alternatives | LP3 | Guidance and decision map; L1 blocked until O1 | [Logic-native state](references/logic-native-state.md) |
| Retain a mix and export masters, tracks, or stems | LP4 | Export specification and QA of existing files; L1 blocked until O1 | [Portable artifacts](references/portable-artifacts.md), [Logic-native state](references/logic-native-state.md) |
| Clean and assemble spoken audio | LP5 | Portable Sandbox route unless L1 is explicit | [Portable artifacts](references/portable-artifacts.md) |
| Archive or hand off a Logic project | LP6 | Dependency/loss manifest now; authoritative project copy blocked until O1 | [Diagnostics and handoff](references/diagnostics-and-handoff.md), [Logic-native state](references/logic-native-state.md) |
| Prepare deterministic Scripter MIDI logic | LP7 | Sandbox source preparation; Logic runtime and persistence blocked until O1 | [Scripter source](references/scripter-source.md), [Logic-native state](references/logic-native-state.md) |
| Diagnose project, plug-in, or performance failures | LP8 | Reversible guidance and read-only evidence first | [Diagnostics and handoff](references/diagnostics-and-handoff.md) |

## Step 2: Global completion gates

1. State the selected card, durable-state code, available route, blocked tail, and verification before changing anything.
2. Preserve source media and the sole project. Portable transformations write new outputs; native work, when eventually enabled, uses a separately approved project copy.
3. For portable files, report the actual runtime and tool used. Validate structure and metadata with `scripts/inspect_wav_midi.py`, then add listening where audio quality or continuity matters.
4. For Scripter source, keep expected MIDI vectors beside the JavaScript. Source preparation never proves Logic execution or persistence.
5. For an L1 request without current-build O1, stop at a manifest, brief, source pack, test oracle, or guidance handoff. Never label that handoff an editable Logic project.
6. Require separate, immediate approval before overwriting, flattening alternatives, replacing a master, moving preferences or plug-ins, resetting settings, reinstalling software, deleting caches or media, or publishing audio.
7. Report exact delivered files, retained state, checks performed, listening still required, native state not created, and the next live verification needed.
