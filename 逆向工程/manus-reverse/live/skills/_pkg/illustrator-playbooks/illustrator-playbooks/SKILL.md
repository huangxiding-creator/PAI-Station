---
name: illustrator-playbooks
description: "Use when the user asks what Manus can do with Adobe Illustrator or needs workflows for vector references, standards SVG files, variable-data artwork, export plans, packaging handoffs, brand or icon systems, or Illustrator guidance. Routes work by retained state among Manus-native visual generation, deterministic file tooling, explicitly available Adobe automation, Illustrator Web in My Browser, and Illustrator Desktop after live capability checks."
---

# Adobe Illustrator Playbooks (Manus for Adobe Illustrator)

Route by the state the user must keep, not by the word "Illustrator" or by a file extension alone. A raster concept, standards SVG, cloud document, desktop AI master, reusable Variables setup, and complete Illustrator package are different deliverables.

## Step 0: Classify the retained state

```text
N1 VISUAL REFERENCE OR RASTER DERIVATIVE
   Use an exposed Manus-native image capability for concepts or standalone raster
   results. Do not label the result editable vector artwork. Unless the current
   tool schema proves otherwise, assume native image output is raster.

F1 PORTABLE FILE STATE
   Use deterministic file tooling for a standards SVG, variable-data preflight,
   export specification, or package inventory. Portable checks do not create AI,
   AIC, Variables, Action, link, font, or Illustrator Package state.

A1 OFFICIAL ADOBE AUTOMATION STATE
   Use a supported Adobe Action, Variables workflow, script, plug-in, or Firefly
   service only when that exact mechanism is already configured, authorized, and
   invocable in the current environment. Public documentation is not a Manus
   runtime and does not prove credentials, compatibility, or recovery.

W1 ILLUSTRATOR WEB CLOUD STATE
   Use the signed-in Illustrator Web product through My Browser only after the
   exact requested feature and cloud document are visible for this account. My
   Browser is browser control, not Computer Use. Web state is not desktop AI state.

D1 ILLUSTRATOR DESKTOP STATE
   Desktop AI layers, paths, type, artboards, swatches, links, effects, Variables,
   Actions, and package state belong to Illustrator Desktop. Use Computer Use only
   after the installed app, version, permissions, exact surface, recovery path, and
   saved postcondition have current-build live evidence. This package contains no
   released Illustrator Desktop procedure; keep Desktop mutation live-blocked.
```

There is no verified Manus Illustrator connector or MCP route in this package. Do not infer one from public Adobe APIs, community servers, or generic connector support.

Read `formats/route-contract.md` before selecting a route. Read `formats/verification.md` before reporting completion.

## Step 1: Intent map

| User outcome | Card | Read | Current route |
|---|---|---|---|
| Turn source art into a vector master or derivative | 1 Vector reconstruction | `references/creative-and-app-state.md` | N1 reference or F1 standards SVG; editable AI remains A1/D1 conditional |
| Prepare personalized badges, labels, or variants | 2 Variable data | `references/portable-file-workflows.md` | F1 preflight and manifest; binding/production requires proved A1 or future D1 |
| Plan and verify multi-artboard exports | 3 Export matrix | `references/automation-and-delivery.md` | F1 specification/verification; actual Illustrator export is A1 or future D1 |
| Prepare packaging or label handoff | 4 Packaging | `references/creative-and-app-state.md` | F1 asset/inventory preparation; editable print state remains future D1 |
| Apply exact or visually judged color variants | 5 Recolor | `references/creative-and-app-state.md` | F1 exact mapping plan; A1 for proved automation; W1/D1 only after feature proof |
| Develop approved brand lockups and delivery state | 6 Brand system | `references/creative-and-app-state.md` | N1 concepts; W1/D1 only for separately proved editable state |
| Normalize an icon or illustration system | 7 Vector system | `references/creative-and-app-state.md` | N1 references or F1 deterministic rules; source-specific craft remains conditional |
| Normalize standards SVG or preserve private state | 8 Portable vector state | `references/portable-file-workflows.md` | F1 for the tested standards subset; W1/D1 when private state must survive |
| Inventory missing links, fonts, and handoff files | 9 Rescue and handoff | `references/automation-and-delivery.md` | F1 candidate/package inventory; relink and Package remain future D1 |
| Turn repeated work into a reusable mechanism | 10 Automation choice | `references/automation-and-delivery.md` | Choose A1 before repeated CU; recording is only a future observed setup aid |

## Step 2: Universal execution rules

1. Ask what state must remain editable or reusable and which client the user explicitly requires.
2. Detect the chosen route in the current session. A vendor capability or public API is not enough.
3. Preserve source files and write portable outputs or reports to a separate destination.
4. Use a small pilot before scaling variable data, deterministic mappings, or visual changes.
5. Keep taste and identity decisions supervised. Manus may propose directions and execute an approved specification; it must not silently choose brand identity.
6. Treat send, publish, overwrite, font copying, relink ambiguity, print settings, and external delivery as immediate approval boundaries.
7. Verify the promised state with its own oracle. A good PNG does not prove SVG structure, AI editability, Variables binding, or an Illustrator package.

## Step 3: Deterministic portable preflight

Use `scripts/preflight.py` only for files that are attached, retrieved, or inside an explicitly shared root. It supports:

- `svg`: validate and normalize the tested portable standards subset;
- `variables`: create a row-level data and asset preflight manifest;
- `inventory`: create a hash-based file inventory and ambiguity report.

Read `references/portable-file-workflows.md` for the command contracts and limitations. These commands never prove Illustrator lifecycle state.
