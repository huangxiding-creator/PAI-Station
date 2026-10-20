# CapCut Route Contract

## Route precedence

1. Preserve an explicit CapCut client or draft request.
2. Name the durable-state class: T0, F1, G1, M1, W1, or C1.
3. Probe runtime, files, browser/app, account, region, version, and feature visibility.
4. Choose the least fragile route that preserves the accepted product.
5. State the route and truth label before mutation.
6. Escalate only for required retained state, observed route failure, or explicit in-app teaching.

## Truth labels

| State | Completion label | Must not be called |
|---|---|---|
| T0 | Standalone transcript with named timing/speaker properties | SRT or CapCut captions unless those objects exist |
| F1 | Standalone media/subtitle file set | CapCut draft or editable timeline state |
| G1 | New or semantically varied short MP4 | Deterministic edit, key, or CapCut draft |
| M1 | Manus Video Editor scene available for user editing | Agent-edited CapCut project |
| W1 | Saved CapCut Web project with named retained objects | Desktop draft or cross-client template proof |
| C1 | CapCut Desktop draft with named retained objects | Complete merely because an export succeeded |

## Material questions

- Does the user need transcript text, subtitle files, burn-in, or editable CapCut captions?
- Is a standalone MP4 enough, or must a Web project/Desktop draft remain editable?
- Which state must survive: clip order, captions, masks, keyframes, effects, template/Auto Cut state, or relinks?
- Which client/account/region actually exposes the requested feature?
- Is the goal completion, reusable project state, recovery, or learning?

Ask only when the answer changes the route or acceptance oracle.

## Feature-gate record

For captions, Auto Cut, templates, cutout, and other changing features, record client/platform, account, region, app version, visible entry point, result, and fallback. Never universalize one observed rollout.
