---
name: capcut-playbooks
description: "Use when the user asks what Manus can do with CapCut or needs workflows for transcripts and captions, cutout and backgrounds, short-video editing, batch production, templates, delivery, draft recovery, or CapCut guidance. Routes each workflow by required durable state among speech-to-text and deterministic media processing, Manus video surfaces, CapCut Web in My Browser, and CapCut Desktop through Computer Use."
---

# CapCut Playbooks (Manus for CapCut)

Route by the state the user needs to keep. Transcript text, an SRT, a flattened MP4, a Manus Video Editor scene, a CapCut Web project, and a CapCut Desktop draft are different products.

## Step 0: Classify the durable state

```text
T0 STANDALONE TRANSCRIPT
   Speech-derived text is sufficient. Probe the active speech-to-text route and
   report whether timestamps or speakers are actually present.

F1 STANDALONE MEDIA OR SUBTITLE FILES
   Deterministic trim, transcode, crop, resize, concatenate, chroma key, subtitle
   conversion, burn-in, or delivery derivatives are sufficient. Probe the active
   media runtime, codecs, and filters before use.

G1 SHORT GENERATED OR SEMANTICALLY VARIED CLIP
   Use Manus video generation only inside the current tool's model, duration,
   aspect, resolution, quota, and quality limits. It is not deterministic editing.

M1 MANUS VIDEO EDITOR SCENE
   The user may continue editing a Manus scene. Checked code proves the user editor
   and export surface, not an agent timeline-control tool or CapCut-draft conversion.

W1 CAPCUT WEB PROJECT STATE
   The user accepts the authenticated web client and the exact requested feature is
   available there. Use My Browser and verify save/reopen in that client.

C1 CAPCUT DESKTOP DRAFT STATE
   The result must retain a desktop draft, timeline, editable captions, layer order,
   masks/keyframes/effects, relinks, Auto Cut state, or an explicit Desktop lesson.
   Use Computer Use only after app/version/account/region availability and a fixture-
   specific saved postcondition are established.
```

If the user explicitly asks for CapCut Desktop or a desktop draft, preserve that choice. If the user says only CapCut, select Web or Desktop from the required state and current availability. A template or feature visible on Web/Mobile does not prove Desktop availability.

Read `formats/route-contract.md` before routing and `formats/desktop_runtime.md` before browser, local-file, media-tool, or CU execution.

## Step 0.5: Hard boundaries

- Edit only footage the user owns or is licensed to use. Remove a watermark, logo, or outro only from the user's own or authorized material.
- Never work around account, platform, regional, or rollout restrictions.
- Preserve source media and the only draft. Use copied inputs, a new draft/project, and separate exports.
- Run CapCut Desktop CU work serially; only one desktop-control session can own the lease.
- For taste-sensitive work, lock references and approve a short sample before scaling.

## Step 1: Routing map

| User outcome | Card | Read | Default route |
|---|---|---|---|
| Create transcript text, subtitle files, or editable CapCut captions | 1 Transcript and captions | `references/one-click.md` | T0 text; F1 subtitle transforms; W1/C1 for retained caption state |
| Remove or replace a video background | 2 Cutout and background | `references/one-click.md` | F1 deterministic chroma; G1 short semantic variation; W1/C1 retained timeline state |
| Build a multi-clip short video | 3 Short-video edit | `references/production.md` | F1 deterministic assembly; M1 user handoff; W1/C1 for retained CapCut state |
| Produce many clips in one style | 4 Batch production | `references/production.md` | F1/G1 independent outputs; W1/C1 only for a reusable project or available CapCut feature |
| Remove an authorized mark or outro | 5 Owned-footage cleanup | `references/one-click.md` | F1 fixed trim/crop/cover; W1/C1 for timeline judgment or retained state |
| Create platform delivery variants | 6 Delivery | `references/production.md` | F1 mechanical variants; W1/C1 for sequence-aware versions |
| Find, apply, or recreate a template | 7 Template workflow | `references/production.md` | Discover/evaluate in the actual supported client; never infer cross-client availability |
| Diagnose drafts, links, and local media | 8 Draft and media care | `references/guidance.md` | Read-only file inventory first; W1/C1 for proved in-client state |
| Teach a CapCut procedure | 9 In-app lesson | `references/guidance.md` | One Web or Desktop lesson after its own fixture and live replay |

Read `formats/verification-manifest.md` before reporting completion.

## Step 2: Completion gates

1. State the selected client, route, and durable-state code before mutation.
2. Record source/draft-copy hashes and a media/output manifest where practical.
3. Record CapCut client, version, account, region, and visible feature gate for any rollout-sensitive workflow.
4. Approve a representative sample: transcript excerpt, five caption cues, a cutout frame set, or fifteen-second edit.
5. Verify the promised state independently. A valid MP4 does not prove a CapCut caption track, draft, template, or relink.
6. Reopen any promised Web project or Desktop draft and inspect the exact retained objects and media-online state.
7. Reconcile interrupted outputs by manifest; do not click a running generation/export twice.
8. Report unavailable features, skipped assets, uncertain results, and remaining human review.
