---
name: audacity-playbooks
description: "Use when the user asks what Manus can do with Audacity or needs an audiobook, spoken-word podcast, or noisy voice recording prepared, finished, restored, or checked. Routes the workflow among portable audio-file processing, reproduced Audacity Macros or app automation, Audacity through Computer Use for recording, listening, waveform judgment, or retained project state, and bounded guidance when the required runtime is unavailable."
---

# Audacity Playbooks (Manus for Audacity)

Route by the state that must survive. A checked audio file, a reproducible fixed chain, an editable Audacity project, and a listening decision are different products.

## Step 0: Classify the durable state

```text
F0 PORTABLE AUDIO OR FILE RESULT
   The user needs protected source files, technical inventory, converted or
   packaged derivatives, or another portable result. Use only an exposed and
   probed file-processing route, then verify the output independently.

M1 REPRODUCED AUDACITY AUTOMATION
   A fixed Audacity Macro or other app-local automation preserves the required
   state and has been reproduced on the installed build. Use only the observed
   commands, inputs, outputs, failures, and recovery behavior.

P1 AUDACITY PROJECT, RECORDING, OR LISTENING STATE
   The workflow needs recording-device state, waveform/listening judgment,
   plug-in UI, track/timeline edits, labels, or another named Audacity project
   object. Use Audacity through Computer Use only after current-build O1.

G0 BOUNDED GUIDANCE
   The app, processing runtime, O1/O3, permission, or reliable quality oracle is
   unavailable. Explain the route, safe stop, and next observable test without
   pretending execution occurred.
```

Do not choose Audacity merely because the input is audio. An explicit request for a reusable Audacity project controls the retained-state contract, but it does not waive availability or verification gates.

Read [formats/route-contract.md](formats/route-contract.md) before routing, [formats/desktop-runtime.md](formats/desktop-runtime.md) before any file, local, Macro, or CU action, and [formats/verification-manifest.md](formats/verification-manifest.md) before reporting completion.

## Step 0.5: Global invariants

- Preserve the original recording and record its identity before processing. Work on a distinct copy.
- Keep audio provenance explicit. A processed recording must never be represented as untouched.
- Separate objective technical checks from listening quality. Passing headers or metrics does not prove intelligibility or natural speech.
- Use a short representative A/B review before scaling judgment-sensitive processing.
- Stop when speech damage, clipping, ambiguous source material, or nonstationary overlap exceeds the agreed acceptance rule.
- Probe the current runtime. Never assume ffmpeg, sox, a codec, a filter, Audacity, a Macro, or an experimental module exists.
- Do not treat `mod-script-pipe` as shipped. Select it only if the exact installed module is observed, enabled, authorized, and reproduced.
- Run all Audacity Computer Use work serially. Independent file inventory and output verification may run in parallel on separate copies.

## Step 1: Routing map

| User outcome | Card | Read | Default route |
|---|---|---|---|
| Prepare a self-recorded audiobook for delivery | 1 Audiobook preparation | [references/audiobook-preparation.md](references/audiobook-preparation.md) | F0 for protection, inventory, and technical checks; M1 only after reproduction; P1 for listening or retained project state after O1 |
| Finish a spoken-word podcast episode | 2 Podcast finish | [references/podcast-finish.md](references/podcast-finish.md) | F0 for portable preflight and verification; M1 for reproduced fixed atoms; P1 for editorial listening and project state after O1 |
| Improve a noisy interview or voice recording | 3 Voice restoration | [references/voice-restoration.md](references/voice-restoration.md) | G0 and protected F0 assessment first; P1 only for a bounded A/B trial after O1 |
| Apply one fixed operation to many clips | Supporting batch operation | [references/batch-operations.md](references/batch-operations.md) | Supporting only; prefer a verified portable route or reproduced M1, never a blind CU loop |

## Step 2: Completion gates

1. State F0, M1, P1, or G0 and name the exact retained output.
2. Freeze the source set, working copies, provenance, and output identities.
3. Probe the real file-processing tools, app, version, Macro/module state, permissions, and Computer Use readiness before selecting them.
4. Define objective technical checks and a separate listening/A/B oracle.
5. Test one representative copy before scaling and obtain approval for judgment-sensitive changes.
6. Reconcile every source, working copy, output, exception, and approval before retrying.
7. For promised project state, save, close, reopen, and inspect the named project objects after current-build O1 exists.
8. Report technical results, listening limits, provenance, blocked routes, and remaining human review separately.

For uncompressed WAV inventory, use `scripts/inspect_wav.py`. It verifies container properties and checksums only; it does not evaluate loudness, compliance, intelligibility, or sound quality.
