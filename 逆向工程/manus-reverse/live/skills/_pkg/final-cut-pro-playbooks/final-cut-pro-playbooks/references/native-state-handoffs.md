# Final Cut-native state handoffs

The cards in this reference require state that lives in Final Cut Pro. Their primary route is Computer Use or an authorized local preflight followed by Computer Use, but every app action is live-blocked in this package revision. Do not provide exact menus or controls. Collect inputs, protect source state, explain the route, and state the missing live qualification.

## C04 — Multicam structure and angle cut

- **Primary:** Computer Use.
- **Escalation:** Missing app or permission, inaccessible native state, ambiguous angle grouping, synchronization drift, or unclear hero audio.
- **Hybrid:** Prepare a read-only media and sync manifest outside the app, then reserve multicam creation and verification for a live-qualified Final Cut run.
- **Fallback:** Deliver the sync map and handoff plan; do not substitute a flattened video for requested multicam state.
- **Verification:** Expected angle set, declared sync tolerance at both ends, and hero-audio continuity.
- **Computer Use reason:** Multicam clips, angle edits, and hero-audio choices are Final Cut-native state.
- **Current status:** Live-blocked; no current-build app or recovery run.

## C05 — Editable native subtitles or closed captions

- **Primary:** Computer Use.
- **Escalation:** Unsupported app version, hardware, language or model availability, inaccessible controls, or transcript ambiguity.
- **Hybrid:** Prepare the transcript and glossary outside the app, then reserve generation, correction, and role or lane verification for a live-qualified run.
- **Fallback:** Route portable timed text to C06 or return a reviewed transcript with no native-state claim.
- **Verification:** Expected text and cue coverage, requested native caption type, and observable editable role or lane state.
- **Computer Use reason:** Editable subtitle clips or caption lanes must remain in Final Cut.
- **Current status:** Live-blocked; portable SRT preflight is the only executable fallback.

## C08 — Media relinking in a copied library

- **Primary:** Authorized local read-only preflight followed by Computer Use.
- **Escalation:** No backup, ambiguous match, incompatible media properties, inaccessible state, or any proposal to edit a library database directly.
- **Hybrid:** Build a candidate manifest only inside a granted file or terminal root; reserve the actual relink and native verification for a live-qualified copied library.
- **Fallback:** Deliver unresolved-media and rejected-candidate reports. Do not mutate the library.
- **Verification:** The expected clip is online and points to the approved root; timeline invariants and source hashes remain unchanged.
- **Computer Use reason:** Media-reference mutation and online state exist in Final Cut.
- **Current status:** Live-blocked; no disposable library or O1 recovery run.

## C09 — Authoritative Final Cut delivery

- **Primary:** Computer Use.
- **Escalation:** Missing media or effects, role mismatch, unsupported batch composition, destination collision, insufficient space, or an unavailable dependent app.
- **Hybrid:** Reserve export configuration and submission for a live-qualified Final Cut run; verify resulting files with an authorized file or media tool. If an already approved flat master is the source of truth, derived copies may use non-Final-Cut routes.
- **Fallback:** Return a delivery matrix and preflight report. Do not claim a render from the authoritative timeline.
- **Verification:** Expected files and names, decodability, duration, codec, dimensions, channels, role isolation, and sampled visual or audio content.
- **Computer Use reason:** Only an actual Final Cut render can prove that delivery reflects the live timeline, effects, roles, and captions.
- **Current status:** Live-blocked; no Final Cut or Compressor render has passed.

## Qualification required before any native card runs

Require all of the following for the selected card: installed app identity and version, current Manus Computer Use exposure, safe observable app state, a disposable fixture or copied destination, an objective oracle, a failure and recovery case, and a current-build live result. Until then, return `native-state handoff blocked pending current-build live qualification`.
