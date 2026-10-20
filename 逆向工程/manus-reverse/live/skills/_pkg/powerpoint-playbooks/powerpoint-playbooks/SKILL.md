---
name: powerpoint-playbooks
description: "Use when the user asks what Manus can do with PowerPoint, WPS Presentation, or LibreOffice Impress, or needs a presentation workflow routed by the presentation state that must survive. Covers creation and editing, templates, masters, motion and media, slide organization, conversion, repair, and instruction; routes generic deck work to the presentation runtime or Slides and app-specific state to the exact installed or web presentation app only after capability and runtime checks."
---

# PowerPoint Playbooks (Manus for PowerPoint)

Treat this skill as a retained-state router for the presentation-app family. A `.pptx`, `.odp`, or compatible-suite request does not automatically require an app window, and neither a Manus Slides resource nor a reconstructed deck is an in-place edit of the user's original file.

## 1. Identify the canonical object

Name the object that must remain after the task:

- **A new local `.pptx` or an edited `.pptx` copy**: use the presentation-native runtime only when its current imported-deck and export tools are exposed and the requested state can be round-trip verified.
- **A new or existing Manus Slides resource**: use the Slides addon only when its current tools are exposed. Initialize a new resource or attach the existing `manus-resource://` deck before editing it.
- **An authenticated PowerPoint for web deck**: use My Browser only when its connector is enabled, an extension client is online, and the required web feature is present for the user's account.
- **The user's existing `.pptx` as the canonical file**: edit a copy through the presentation-native runtime only for supported, inspectable objects with an objective round trip. Escalate residual PowerPoint-native state separately.
- **PowerPoint application state**: use conditional Computer Use only when an O1 operation record exists for the installed OS, PowerPoint version, fixture, and postcondition.
- **A static derivative**: use the source-native export or a verified converter unless exact PowerPoint rendering, print layout, or playback-derived output is required.

Resolve compatible suites by component before choosing a route:

| Detected or requested surface | Ownership and boundary |
|---|---|
| Microsoft PowerPoint | This playbook; PowerPoint-native masters, motion, media, rendering, and playback require exact PowerPoint evidence |
| WPS Presentation | This playbook; generic PPTX work remains presentation-native, while WPS regional/account/cloud/macro and compatibility state require exact WPS evidence |
| LibreOffice Impress | This playbook; generic PPTX work remains presentation-native, while ODP/OTP, Impress template/master state, and PowerPoint round-trip acceptance require exact Impress evidence |
| WPS Writer or LibreOffice Writer | `word-playbooks` |
| WPS Spreadsheets or LibreOffice Calc | `excel-playbooks` |
| WPS PDF or ordinary PDF output | PDF capability |

The default `.pptx` or `.odp` app is a delivery and compatibility signal, not route proof. A PowerPoint O1 record cannot authorize WPS Presentation or Impress, and a headless converter cannot prove an installed GUI route.

Read `formats/pptx_capability_map.md` before choosing among these objects. Probe the current session; code-backed or first-party capability is not proof that a route is exposed now.

## 2. Canonical card contracts

| Card | User outcome | Primary route | Escalation trigger | Hybrid handoff | Objective verification | CU display and reason |
|---|---|---|---|---|---|---|
| N1 | Create a new deck, or reconstruct/style-match a reference without preserving it as the same file | Presentation-native runtime for a local `.pptx`; Slides addon for a Slides resource; each only when exposed | Required output mode, template path, or export is absent from the current tool schema | Inspect source material first; create the chosen canonical presentation object; export only through an exposed route | Render every slide, inspect the deck montage, confirm slide count and requested output | **No.** New presentation state has a purpose-built native route; CU adds cost without preserving extra state |
| N2 | Continue an existing Manus Slides resource | Attach the resource, then use only the Slides edit, organize, screenshot, and present operations exposed in the current tool schema | Resource attachment or a required operation is unavailable | Export a copy only if an export route is exposed and the user accepts leaving the Slides resource as the canonical source | Reopen the same resource URI, confirm version, order, edited pages, and present gate | **No.** The Slides addon owns this resource state |
| W1 | Work in an authenticated PowerPoint for web deck | My Browser after connector and online-client preflight | Required feature is absent on web, account access fails, or the user requires a local canonical `.pptx` or desktop-only state | Export or obtain a local copy, then route the copy through the presentation-native runtime; keep cloud and local objects distinct | Reopen the same cloud deck and verify the intended objects and save state | **No by default.** Browser state belongs to My Browser, not desktop CU; use CU only after a separately verified desktop-state handoff |
| A1 | Audit an existing `.pptx` or make deterministic whole-deck content changes | Presentation-native imported-deck editing on a copy, after object inventory and capability probe | A required object is unresolved, flattened, protected, or fails the representative round trip | Apply safe edits natively; hand only the unsupported PowerPoint-native residue to a verified app route | Before/after manifest, full renders, intended-match count, preserved-state checks, reopen exported copy | **Conditional.** Show CU only when a named unresolved property must remain editable in PowerPoint and an O1 path exists |
| B1 | Fill an existing template while preserving its structure | Presentation-native template-following on a copy, using inherited source slides and objects | The runtime cannot resolve required placeholders/layouts or preserve the source hierarchy in a representative export | Fill supported inherited elements natively; isolate an unsupported master/layout repair for a verified PowerPoint route | Inspect every source slide, map output slides to source slides, render all outputs, check inherited placeholders and hierarchy | **Conditional.** CU is residual only when exact template state cannot be preserved by the native round trip and O1 exists |
| C1 | Create or repair masters, layouts, theme behavior, or brand inheritance | Presentation-native runtime if master/layout objects are exposed and a representative blast-radius test passes | Exact PowerPoint inheritance or theme behavior cannot be proved after export and reopen | Prepare the brand spec and safe content changes natively; apply only the residual app-state change through verified CU | Layout inventory, representative descendant renders, save-close-reopen result, rollback copy | **Yes, conditional O1.** PowerPoint-native inheritance is the retained state; documentation alone does not authorize execution |
| D1 | Add or repair animations, transitions, timing, triggers, or slideshow behavior | Guidance or a static native alternative until a current PowerPoint operation is O1 | Editable/playable motion state is required and no verified non-CU round trip preserves it | Build static content first; hand the motion-only step to verified PowerPoint CU | Save-close-reopen, inspect effect inventory, replay the slideshow, compare expected sequence and timing | **Highlight only after O1.** The value is editable PowerPoint playback state, not a static approximation |
| D2 | Add or repair embedded or linked audio/video and playback behavior | Guidance or a static/link manifest until a current PowerPoint operation is O1 | Embedded/linked media, poster frame, captions, portability, or playback must survive in PowerPoint | Prepare licensed media and slide content outside the app; hand insertion/playback validation to verified CU | Save-close-reopen on the delivery machine, replay media, verify links or embedded assets and portability | **Highlight only after O1.** The retained state is PowerPoint media playback and packaging behavior |
| E1 | Add, delete, reorder, extract, compare, or merge slides | Slides addon for a Slides resource; presentation-native runtime for a retained `.pptx` copy when structure survives a fixture | Required relationships, sections, source formatting, masters, notes, media, or embedded state fail round-trip verification | Perform supported structural edits natively; isolate only the failing retained state for verified CU | Final count and title order, source-to-output map, notes and master/layout assignments, rendered montage | **Conditional.** CU is justified only by a specific structure-preservation failure plus O1 evidence |
| F1 | Export to PPTX, PDF, images, handouts, notes pages, or motion output | Export from the canonical native object or use a verified local converter for static derivatives | Exact PowerPoint handout/notes layout, app rendering, animation steps, or video output is required | Prepare and validate content natively; use verified PowerPoint CU only for the app-specific export residue | Compare slide/page/image count, inspect high-risk slides, record substitutions, replay motion output when applicable | **Conditional.** CU is for exact PowerPoint rendering or playback-derived output, never generic conversion |
| G1 | Diagnose or recover a damaged `.pptx` | Forensic package inspection and salvage on copies | Candidate repair must be accepted or rendered by real PowerPoint, or the damage concerns app-only state | Diagnose and salvage outside the app; use verified PowerPoint only as an open/render validation gate | Hash original, list repaired and lost parts, render candidate, and record real-PowerPoint open result when available | **No as the repair route.** CU may validate a candidate only; it does not turn an unproved repair recipe into a supported workflow |
| H1 | Teach or demonstrate a PowerPoint feature in the user's installed app | Guidance by default | User explicitly requests an in-app demonstration and the exact operation has current O1 evidence | Explain the goal first; demonstrate only the verified subflow on a disposable fixture or copy | Observe the resulting app state and leave a concise step card based on the user's actual controls | **Yes, conditional O1.** The user's learning outcome depends on seeing the real installed app |

Load the card-specific reference named below only after the route is selected:

| Cards | Reference |
|---|---|
| N1, N2, W1 | `references/native-boundary.md` |
| A1, B1 | `references/batch-and-content.md` |
| C1 | `references/masters-and-brand.md` |
| D1, D2 | `references/animation-and-media.md` |
| E1, F1 | `references/slides-and-export.md` |
| G1, H1 | `references/repair-and-teaching.md` |

## 3. Route discipline

1. Read `formats/pptx_capability_map.md` before assigning an execution route.
2. Read `formats/desktop_runtime.md` before any Computer Use branch.
3. Probe the exact presentation, Slides addon, My Browser, file, conversion, and Computer Use tools exposed in the current session.
4. Preserve the original. Use a dated working copy for retained-file edits, repair, merge, master, animation, and media tasks.
5. For batch or visual changes, inventory the deck first and validate a representative sample before applying the full scope.
6. Verify both intended changes and preserved state. Text correctness is insufficient when the deck contains masters, layouts, animations, media, charts, notes, comments, macros, signatures, or embedded objects.
7. Never present documentation or static source code as a live runtime pass. If an operation lacks current evidence, guide, ask for a compatible output, or mark that branch blocked.

## 4. Delivery contract

Report the route used, canonical output object, output path or resource URI, slides affected, validation performed, and any state that could not be preserved or verified. Never describe a recreated Slides resource or exported copy as an in-place edit of the user's original `.pptx`.
