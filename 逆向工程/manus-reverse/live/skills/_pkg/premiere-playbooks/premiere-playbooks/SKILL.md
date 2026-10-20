---
name: premiere-playbooks
description: "Use when the user asks what Manus can do with Premiere Pro or needs workflows for transcripts and captions, sequence editing, project recovery, proxies, color, delivery, project hygiene, or Premiere guidance. Routes each workflow by required durable state among speech-to-text and deterministic media processing, Manus video surfaces, and Premiere Pro through Computer Use."
---

# Premiere Playbooks (Manus for Premiere Pro)

Route by the state that must survive. Transcript text, an SRT, a burned-in MP4, a Manus Video Editor scene, and an editable Premiere sequence are different products.

## Step 0: Classify the durable state

```text
T0 STANDALONE TRANSCRIPT
   Speech-derived text is sufficient. Use the speech-to-text route only after
   probing the active runtime and reporting whether timestamps or speakers exist.

F1 STANDALONE MEDIA OR SUBTITLE FILES
   Deterministic trim, transcode, remux, crop, concatenate, subtitle conversion,
   burn-in, or delivery derivatives are sufficient. Use sandbox media tooling
   after probing the required executable, codec, and filter.

G1 SHORT GENERATED OR SEMANTICALLY VARIED CLIP
   Use Manus video generation only within the current tool's duration, aspect,
   resolution, quota, and quality limits. This is not deterministic editing.

M1 MANUS VIDEO EDITOR SCENE
   The user may continue editing a Manus CE.SDK scene. Treat this as a user handoff;
   checked code proves the editor and scene export, not an agent timeline-control tool.

P1 PREMIERE PROJECT STATE
   The result must retain a sequence, editable caption track, proxies, media links,
   effects, Lumetri state, recovery version, plugin state, or authoritative sequence
   render. Use Premiere through Computer Use only after app/version availability and
   a fixture-specific observable postcondition are established.
```

If the user explicitly asks for Premiere Pro or a Premiere project, preserve that choice. Do not open Premiere merely because the source is video or the requested result could be imported later.

Read `formats/route-contract.md` before routing and `formats/desktop_runtime.md` before any local-file, media-tool, or CU execution.

## Step 0.5: Safety boundaries

- Never overwrite the original project. Work on a dated copy and preserve Auto-Save/recovery candidates before opening them.
- Never delete or relocate media, caches, previews, or project dependencies without an itemized manifest and separate explicit approval.
- Use only owned or licensed media and music.
- Run all Premiere CU tasks serially; only one desktop-control session can own the lease.
- For taste-sensitive editing, lock references and approve a short sample before scaling.

## Step 1: Routing map

| User outcome | Card | Read | Default route |
|---|---|---|---|
| Create transcript text, subtitle files, or an editable caption track | 1 Transcript and captions | `references/captions-editing.md` | T0 text; F1 existing-subtitle transforms; P1 editable Premiere caption state |
| Recover a crashed or unreadable project | 2 Recovery | `references/rescue.md` | File preservation/inventory first; P1 candidate validation only after live proof |
| Build or revise a multi-clip edit | 3 Sequence edit | `references/captions-editing.md` | F1 deterministic assembly when no project is required; P1 for editable Premiere sequence state |
| Render a sequence or create delivery variants | 4 Delivery | `references/pipeline.md` | F1 approved-master derivatives; P1 authoritative sequence render or app failure |
| Create and attach proxies | 5 Proxies | `references/pipeline.md` | F1 unattached proxy files; P1 for attached proxy state |
| Match or grade color | 6 Color | `references/captions-editing.md` | F1 verified deterministic transform; P1 for editable Lumetri/sequence state |
| Reduce project or cache bloat | 7 Project hygiene | `references/rescue.md` | Read-only inventory first; P1 project-aware changes remain guarded |
| Teach a Premiere procedure | 8 In-app lesson | `references/pipeline.md` | One client/version-specific lesson after its own fixture and live replay |

Read `formats/verification-manifest.md` before reporting completion.

## Step 2: Completion gates

1. State the route, durable-state code, and whether the user receives a file, Manus scene, or Premiere project state.
2. Record source/project-copy hashes and a media/dependency manifest where practical.
3. Approve a representative sample: transcript excerpt, subtitle cues, fifteen-second edit, or reference frames.
4. Verify the promised state independently. A valid MP4 does not prove a caption track, proxy mapping, Lumetri state, or recovered project.
5. Reopen any promised Premiere project copy and inspect media-online state plus the exact retained objects.
6. Reconcile interrupted outputs by manifest; never submit a running transcription/export twice.
7. Report blocked features, skipped media, uncertain results, and remaining human review.
