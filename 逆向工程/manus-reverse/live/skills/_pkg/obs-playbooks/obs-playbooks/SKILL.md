---
name: obs-playbooks
description: "Use when the user asks what Manus can do with OBS Studio or needs workflows for stream assets and overlays, scenes and sources, audio, capture and performance, output settings, plugins, runtime control, or OBS guidance. Routes each workflow by required durable state among Manus asset and site creation, deterministic file and log analysis, a separately proven authenticated OBS protocol client, and OBS Desktop through Computer Use."
---

# OBS Playbooks (Manus for OBS Studio)

Route by the state the user needs to keep. A PNG overlay, a deployed web page, an analysis report, OBS scene state, and a running public stream are different products with different permissions and verification.

## Step 0: Classify the durable state

```text
A1 STANDALONE ASSET
   Image, video, audio, subtitle, or deterministic media output is sufficient.
   Use the matching Manus creation or file-processing route.

H1 HOSTED OVERLAY
   A tested interactive page and deployment URL are sufficient upstream products.
   Use Manus site building and deployment; OBS remains the downstream renderer.

F1 FILE OR DIAGNOSTIC REPORT
   Logs, recording files, asset inventories, blueprints, checksums, or recovery plans
   are sufficient. Use read-only file and Sandbox analysis.

P1 RETAINED OBS PROTOCOL STATE
   Scenes, sources, transforms, filters, audio state, or runtime state must persist.
   Use only a version-pinned, allowlisted OBS WebSocket client after terminal access,
   live capabilities, credential handling, redaction, receipts, and recovery pass.
   Current package evidence does not establish that this client is shipped.

D1 RETAINED OBS DESKTOP STATE
   A protocol-external control, plugin, permission, capture target, or visual property
   must persist in OBS. Use Computer Use only through a current-build observed path.

R1 CONSEQUENTIAL OUTPUT STATE
   Streaming, recording, replay buffer, or virtual camera changes live output state.
   Require an immediate user confirmation and independent state read-back.
```

Read `formats/route-contract.md` before choosing a route. Read `formats/websocket_channel.md` before proposing P1 and `formats/desktop_runtime.md` before D1 or R1.

## Step 0.5: Hard boundaries

- Never ask the user to paste a stream key, OBS WebSocket password, webhook secret, or secret-bearing URL into ordinary chat, files, screenshots, recordings, or logs.
- Do not disable authentication to make protocol control easier.
- Do not claim that OBS protocol control is available merely because OBS ships obs-websocket. A compatible client, secure secret path, capability receipt, and request-level verification are separate gates.
- Never start a public stream, recording, replay buffer, or virtual camera without the required confirmation for that exact action and target.
- Preserve both a recoverable Profile artifact and a recoverable Scene Collection artifact before structural or output mutation. A Profile is not a scene backup, and a Scene Collection is not an output-settings backup.
- Treat exported Profile material as sensitive because it may retain connected-account or stream-service state. Never expose or transport credentials through chat, recordings, reports, command arguments, or ordinary files.
- Run all Computer Use tests serially. Do not race protocol and CU mutations against the same OBS fixture.

## Step 1: Routing map

| User outcome | Card | Read | Default route |
|---|---|---|---|
| Connect Manus to OBS | E1 Connection readiness | `references/setup.md` | D1 enablement guidance; P1 remains HOLD until client and secret gates pass |
| Build a complete stream setup | A1 Full setup | `references/setup.md` | F1 blueprint + A1/H1 assets; P1/D1 only after their own gates |
| Wire existing assets and overlays | A2 Asset wiring | `references/setup.md` | F1 validation; P1 or D1 only for retained source placement |
| Diagnose dropped frames or lag | B1 Performance triage | `references/performance.md` | F1 logs first; read-only P1 or observed D1 only when available |
| Configure encoder, bitrate, or quality | B2 Output quality | `references/performance.md` | F1 recommendation; current-build P1/D1 after live schema/control proof |
| Fix black capture | B3 Capture troubleshooting | `references/performance.md` | OS-specific D1 plus F1 logs and screenshots |
| Improve microphone sound | C1 Microphone chain | `references/audio-and-runtime.md` | F1 diagnosis/sample; P1/D1 for one proved chain, never a universal preset |
| Correct audio sync | C2 Audio sync | `references/audio-and-runtime.md` | F1 measurement; P1/D1 only for the measured constant offset |
| Switch scenes or control outputs | D1 Runtime control | `references/audio-and-runtime.md` | P1 when the audited runtime exists; R1 confirmation for consequential outputs |
| Change platform or stream destination | D2 Platform and credentials | `references/audio-and-runtime.md` | My Browser for authorization; user-direct secret entry; P1/D1 only after gates |
| Build alerts, goals, chat, or scoreboards | F1 Interactive overlay | `references/handoffs.md` | H1 site build/deploy; P1/D1 for downstream Browser Source only |
| Install an OBS plugin | F2 Plugin installation | `references/handoffs.md` | F1 compatibility review + user-approved D1/system handoff |
| Create overlay artwork or media | F3 Asset creation | `references/handoffs.md` | A1 native generation or deterministic processing |
| Explain or demonstrate OBS | G1 Teaching | `references/teaching.md` | Guidance or one current-build D1 lesson after fixture and replay |

Read `formats/verification-manifest.md` before reporting completion.

## Step 2: Completion gates

1. State the route, durable-state code, fixture, and truth label before mutation.
2. Validate upstream assets, pages, logs, and blueprints before opening OBS.
3. For P1, retain the capability receipt, allowlisted request/response receipt, timeout reconciliation, and redacted log. Without them, stop at F1 planning or D1 guidance.
4. For D1, use a disposable Profile/Scene Collection or other bounded fixture and re-observe the exact saved state after each mutation.
5. Verify both sides of a hybrid handoff. A deployed page is not installed in OBS; a source entry is not visibly rendered merely because it exists.
6. Separate a configuration save, local recording, test connection, and public live output. Passing one never proves another.
7. Report exact retained objects, unsupported state, skipped items, recovery point, and remaining human action without exposing secrets.
