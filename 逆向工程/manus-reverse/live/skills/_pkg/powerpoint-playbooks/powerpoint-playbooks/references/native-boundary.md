# Native Presentation and Browser Boundaries (Cards N1, N2, and W1)

## N1: create, reconstruct, extend, or style-match

Choose between the presentation artifact runtime and the Slides addon by the canonical output:

- use the presentation runtime for a new local `.pptx` when its authoring and PPTX export surface is exposed;
- use the Slides addon for a new `manus-resource://` deck when its tools are exposed;
- do not describe either route as an in-place modification of a supplied `.pptx`.

Before execution:

1. inspect the current presentation and Slides tool schemas and supported output modes;
2. collect content, data, sources, images, and brand assets before initializing;
3. if a `.pptx` is supplied as a style or content reference, inspect it first and state whether the route will reconstruct a new deck or edit an exported copy;
4. tell the user which new canonical object will be created;
5. read any mode, page-count, plan, and export limits from the current tool schema rather than from remembered product behavior.

If the user explicitly needs a native `.pptx`, use only an exposed PPTX authoring or export route. Otherwise explain the available output object before building.

Validate content, layout, sources, and the requested style. Render every slide and reopen the exported `.pptx` when that is the deliverable.

## N2: continue an existing Manus Slides project

When the user points to a delivered Manus Slides resource, attach it if the current runtime requires attachment. Use only the edit, organize, screenshot, present, or export operations actually exposed by the current Slides tool schema. If speaker-note editing or another requested operation is absent, mark that operation unavailable rather than projecting a legacy tool onto the addon.

These operations are scoped to the active Slides project. Do not claim that they changed a separate `.pptx` file on disk.

## W1: PowerPoint for web

Use My Browser only when the current session reports the connector enabled and an extension client online. Confirm that the target deck is openable and that the requested feature exists in the user's web account before planning mutations.

Keep the browser deck, an exported local `.pptx`, and a Manus Slides resource as separate objects. If web capability is insufficient, obtain a local copy only with the user's intended save semantics, then route that copy through the presentation runtime. Escalate to desktop CU only when the required retained state is desktop-only and a current O1 app operation exists.

Verify by reopening the same cloud deck and observing the changed objects and saved state. A successful browser click is not the postcondition.

## Handoff to retained-file work

Switch out of N1/N2/W1 when the user requires any of the following:

- the supplied `.pptx` itself must remain the canonical artifact;
- existing masters, animations, media, macros, signatures, embedded objects, or relationships must be preserved exactly;
- the user asks to patch a file without recreating it;
- a PowerPoint-specific playback, print, or teaching state is the deliverable.

Name the handoff explicitly and preserve the original.
