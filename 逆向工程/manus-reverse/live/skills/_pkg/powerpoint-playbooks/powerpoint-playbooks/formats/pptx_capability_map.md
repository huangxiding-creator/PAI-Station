# PPTX Capability Map

Use this map as a probe order. It describes route eligibility, not universal availability.

## 1. Keep the native object families separate

### Presentation artifact runtime

When the current session exposes an imported-deck presentation runtime, it may create a local `.pptx`, import an existing `.pptx`, inspect typed objects, edit supported objects, render previews, and export an edited copy. Treat the exported copy as a new artifact. Do not imply that the user's original file was mutated in place.

### Manus Slides addon

When its skill and MCP tools are exposed, the Slides addon owns a `manus-resource://` deck. It can initialize a deck, attach an existing Slides resource, edit pages, organize page order, capture QA screenshots, and present the resource. Generation modes, including PPTX output, are session-gated. A Slides resource is not an arbitrary `.pptx` file on disk.

### My Browser

PowerPoint for web state belongs to My Browser when the connector is enabled, an extension client is online, and the required feature exists for the user's account. The existence of a web product alone does not prove My Browser is available or that web and desktop states are equivalent.

### PowerPoint desktop

PowerPoint Computer Use is a conditional residual route for tested app-native state. It is never the default merely because one file library lacks a feature.

## 2. Existing `.pptx` eligibility for the presentation runtime

The following are **candidate native edits**, not unconditional promises. Use them only when the current runtime resolves the target object and a representative import-edit-export-render-reopen test passes:

- inspect slide order, text, shapes, images, tables, charts, notes, comments, layouts, and masters;
- edit ordinary text or an identified placeholder;
- replace an image while preserving its resolved placement and crop properties;
- update a table or chart that resolves as an editable native object;
- add or revise speaker notes and comments without clearing unrelated content;
- duplicate, delete, or reorder slides while preserving the required hierarchy and relationships;
- follow an existing template by duplicating source slides and editing inherited elements in place;
- make an intentional layout or master change after measuring its descendant-slide blast radius.

The following must **not** be assigned to the presentation runtime without a dedicated fixture and round-trip proof for every required property:

- animation, transition, trigger, Morph, sequence, or timing state;
- embedded or linked audio/video playback, captions, poster frames, and delivery-machine portability;
- macros, signatures, permissions, protection, add-ins, OLE objects, or live linked-data behavior;
- an object that imports only as an image or otherwise does not resolve as the native type the user needs;
- exact PowerPoint slideshow rendering, handout or notes-page layout, print behavior, or video export;
- encrypted files, corruption recovery, or files that the runtime cannot import and export cleanly;
- browser-only cloud state for which no local canonical file has been obtained.

For any other feature, classify it as unknown until the current runtime and a representative deck prove the round trip. Absence from this list is not permission to assume support.

## 3. Retained-PPTX workflow

Before editing a canonical `.pptx`:

1. copy the file and hash the original;
2. inventory the objects and relationships relevant to the request;
3. classify required state as byte-preserved, logically preserved, visually preserved, or intentionally changed;
4. import and inspect the copy through the current presentation runtime;
5. test the smallest representative edit;
6. export a new copy, render every affected slide, and reopen the exported copy;
7. compare the before/after manifest and disclose unverified state.

If the representative round trip fails, do not expand the native edit to the full deck. Isolate the failing state and choose My Browser, guidance, or an O1 PowerPoint CU branch according to where that state lives.

## 4. Static conversion

Use an exposed converter for PDF or image output when exact PowerPoint rendering is not required. Record the converter and version, compare page or image count with slide count, and inspect high-risk slides. Font substitution, SmartArt, embedded objects, animations, and media require explicit review.

Do not infer that a cloud-drive conversion endpoint is a Manus connector action. Use it only when the current connector tool schema exposes it.

## 5. Computer Use release gate

Every PowerPoint CU branch requires:

- an installed PowerPoint app identified by the helper;
- OS, PowerPoint edition/version, and a disposable fixture or working copy;
- a current O1 operation record using observed semantic controls rather than memorized paths;
- an expected app-native postcondition, save/reopen verification, and rollback behavior;
- separate macOS and Windows status.

Without all five, provide guidance, use a compatible output, or mark the app-state branch blocked.
