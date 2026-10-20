---
name: after-effects-playbooks
description: "Use when the user asks what Manus can do with After Effects or needs an existing After Effects project or template customized, localized, versioned, rendered, collected, or prepared for handoff. Routes each workflow by retained state among Manus file and data preparation, reproduced After Effects automation or rendering routes, and After Effects through Computer Use for visual or project-state work."
---

# After Effects Playbooks (Manus for After Effects)

Route by the state that must survive. A flat video, a folder of prepared assets, a data-driven project, and a visually approved editable `.aep` are different products.

## Step 0: Classify the durable state

```text
F0 PREPARED FILES OR FLAT MEDIA
   The user needs validated source assets, a translation table, a manifest,
   a rendered derivative, or another portable file result. Use Manus-native
   media or sandbox file tooling only after probing current exposure.

A1 REPRODUCED AFTER EFFECTS AUTOMATION
   The result must retain project state, but a structured data, script, render,
   or collection route has been reproduced on the installed build. Use only
   the exact observed atoms and preserve their receipts.

P1 AFTER EFFECTS PROJECT STATE
   The result must preserve compositions, layers, expressions, placeholders,
   linked footage, timing, typography, plug-ins, or another named `.aep` object.
   Use After Effects through Computer Use only after current-build O1.

G0 BOUNDED GUIDANCE
   The app or route is unavailable, or only a current first-party candidate
   procedure exists. Explain the route and verification contract without
   pretending it was executed.
```

An explicit request for an editable After Effects project controls the output contract. Never silently substitute a generated or flattened video.

Read `formats/route-contract.md` before routing, `formats/desktop-runtime.md` before any local or app execution, and `formats/verification-manifest.md` before reporting completion.

## Step 0.5: Safety and ownership

- Work on a dated project copy. Never overwrite the only `.aep`, template, footage, translation table, or render.
- Confirm the user owns or is licensed to use every template, font, plug-in, asset, music track, and output destination.
- Treat font, plug-in, codec, language, and Media Encoder availability as runtime facts, not package assumptions.
- Never call a successful render proof that the editable project is complete.
- Run all After Effects CU work serially. File inventory, data validation, and independent output checks may run in parallel on separate copies.

## Step 1: Routing map

| User outcome | Card | Read | Default route |
|---|---|---|---|
| Brand an existing template and retain the editable project | 1 Template brand refresh | `references/template-customization.md` | F0 preparation; A1 for reproduced structured replacements; P1 for visual and project-state work |
| Produce localized or personalized versions | 2 Localization and variants | `references/localization-and-variants.md` | F0 data validation; A1 for reproduced data/script/render routes; P1 for visual exceptions |
| Render, collect, or hand off the result | Supporting operations | `references/render-and-handoff.md` | A1 only after reproduction; P1 only when app state or UI diagnosis is required |

## Step 2: Completion gates

1. State F0, A1, P1, or G0 and the exact retained object the user will receive.
2. Hash originals and define a collision-free project, version, and output naming policy.
3. Probe the actual app/version, fonts, plug-ins, data route, script or renderer, and Desktop capability before selecting them.
4. Approve a representative scene or locale before scaling visual decisions.
5. Verify every variant against the source-data manifest and review visual exceptions separately.
6. For retained project state, save, close, reopen, and inspect named compositions, layers, links, fonts, effects, and data bindings.
7. Validate rendered files independently; preserve logs and reconcile completed items before retrying.
8. Report blocked assets, missing dependencies, unverified languages, partial renders, and remaining human review.
