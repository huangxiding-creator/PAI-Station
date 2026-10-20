# Retained Deck Content (Cards A1 and B1)

## A1: audit and whole-deck deterministic changes

Examples include repeated text or terminology updates, speaker-note changes, footer-like content embedded on slides, image replacement, table or chart data updates, and accessibility or content audits.

Procedure:

1. inspect the retained deck and produce a manifest of slide titles, candidate matches, affected objects, and high-risk state;
2. distinguish slide content from master/layout content and app-calculated state;
3. report the affected slide count and ambiguous matches before mutation;
4. work on a copy and use the presentation-native imported-deck route only when the target objects resolve and the representative round trip passes;
5. validate every intended match plus representative slides with masters, notes, charts, media, or embedded objects;
6. compare the before/after manifest and disclose anything not verified.

Escalate only the unsupported state. For example, change resolved ordinary text through the presentation runtime and reserve a failed PowerPoint-native inheritance property for an O1 app route; do not drive every slide through CU merely because one part requires the app.

Do not describe a language rewrite as proof that PowerPoint's language metadata or proofing dictionaries changed unless those properties were specifically edited and verified.

## B1: fill a retained template

First decide whether the user wants:

- a **new presentation inspired by a reference deck**, which belongs to a new presentation-native object; or
- an **edited copy of the same template file**, which belongs to presentation-runtime template-following only when inherited elements and hierarchy survive the round trip.

For retained fill:

1. inspect every source slide and map output slides to actual source slides, placeholder identifiers, and layout roles;
2. identify overflow, missing layouts, and unsupported objects before filling;
3. use a copy and fill only agreed targets;
4. avoid free-floating replacements when a real placeholder is required;
5. render every populated slide, reopen the exported copy, and verify required unchanged hierarchy and objects; animation and media state require separate proof rather than visual inference.

If the template lacks a required layout, present the options: use the closest existing layout, create a new presentation-native object, or invoke a separately verified PowerPoint master workflow. Do not silently invent a layout in the retained file.
