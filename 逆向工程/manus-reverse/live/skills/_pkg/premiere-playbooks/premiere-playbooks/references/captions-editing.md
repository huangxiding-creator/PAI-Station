# Captions, Editing, and Color (Cards 1, 3, and 6)

## Card 1 — Transcript and captions

**Use when:** the user needs transcript text, translated/reformatted subtitles, burned-in captions, or an editable Premiere caption track. Typical cases include interviews, courses, podcasts, social clips, multilingual campaigns, and accessibility delivery.

**Demand basis:** caption workflows converge across creator tutorials, paid service listings, first-party help, and user pain. This supports the outcome family, not a default Premiere route.

**Primary channel:**

- T0 for standalone transcript text when runtime probe succeeds.
- F1 for existing SRT/VTT normalization, translation with preserved cues, conversion, validation, or deterministic burn-in.
- P1 when captions must be created, timed, styled, and retained as editable Premiere sequence objects or the user explicitly requests app-native transcription.

**Escalation trigger:** move to P1 only for retained Premiere caption state, sequence-aware correction/styling, or explicit app-native teaching; missing timing in T0 is not permission to fabricate it.

**Hybrid handoff:** T0/F1 prepares and validates transcript/subtitle assets; P1 imports or creates the editable caption track and may export a file for independent cue validation.

**Verification:** sample text accuracy, cue order/timing and encoding where present, coverage, independent subtitle-file opening, and save/reopen proof for editable Premiere captions.

**Inputs:** source media or project copy, sequence, language, glossary/proper nouns, speaker requirement, style, and exact deliverable.

**Workflow:** classify the product; probe the selected route; approve a transcript excerpt or five cues; correct names/numbers/line breaks; complete the requested output; verify file or retained project state.

Do not invent timestamps or speaker labels when the transcript route does not provide them. Do not freeze a panel/menu path until the current app/OS/version procedure passes live replay.

**Failure and recovery:** keep partial transcript/caption output; report unsupported timing/speakers; reconcile cue IDs before retrying; never submit a running transcription twice.

**Record as skill:** strong only for the P1 branch after live replay. Parameterize sequence, language, glossary, style, and output.

**CU display:** yes only for editable Premiere caption state or explicit app-native teaching. Transcript text and subtitle-file transforms are not CU.

## Card 3 — Sequence edit

**Use when:** multiple shots, audio, captions, graphics, effects, and exact editorial choices must form a coherent edit. Typical cases include interviews, branded social video, product stories, training videos, event recaps, and creator content.

**Primary channel:** F1 for a fully specified deterministic assembly when no project must remain; G1 only for a new short generative shot within runtime limits; M1 as a user-editable Manus scene handoff when accepted; P1 for an editable Premiere sequence, track relationships, exact frame decisions, effects, plugins, or continued collaboration in Premiere.

**Escalation trigger:** use P1 when exact editable sequence state or Premiere-specific effects/plugins are acceptance criteria, not merely because the source has several clips.

**Hybrid handoff:** T0/F1/G1 prepares transcripts, normalized media, and source shots; P1 integrates only when Premiere state is required; M1 remains a separate optional user handoff.

**Verification:** source order/cut plan, synchronization, sample approval, duration, beginning/middle/end playback, media-online state, project reopen, and output specs.

**Workflow:** inventory and normalize sources; freeze cut list/references; preserve a project copy for P1; build and approve a fifteen-second sample; complete the edit; verify beginning/middle/end, synchronization, media links, and output state.

**Failure and recovery:** keep source manifests and checkpoints. Offline media, ambiguous references, or missing plugins stop the affected branch rather than triggering blind relink or substitution.

**Record as skill:** record only a proved ingest-to-delivery trunk. Culling, pacing, music, and taste remain explicit decisions with sample approval.

**CU display:** conditional. A reusable Premiere sequence is a valid CU story; deterministic assembly or a generated clip is not.

## Card 6 — Color consistency

**Use when:** clips need technical normalization, a deterministic LUT transform, or editable shot-by-shot color state in Premiere.

**Primary channel:** F1 for a verified deterministic transform on standalone files; G1 only for short semantic visual variation, never exact grading; P1 for editable Lumetri/effect state, scope-guided sequence matching, adjustment layers, plugins, or authoritative sequence rendering.

**Escalation trigger:** move to P1 for editable sequence color state, scope-guided shot matching, named plugins, or authoritative sequence rendering.

**Hybrid handoff:** F1 may normalize or apply a proved deterministic transform; P1 preserves reversible project color state; G1 may provide a look reference but not an exact grade.

**Verification:** sampled frames against reference, protected color/skin review, duration/audio preservation, requested technical metadata, and Lumetri/effect persistence after reopen when promised.

**Inputs:** source color information, technical/creative goal, reference frames, protected skin/product colors, delivery color requirement, and retained-state need.

**Workflow:** identify technical versus creative goal; probe the route; approve representative frames; apply the bounded transform or P1 state; compare outliers; verify duration/audio and retained state.

**Failure and recovery:** preserve source and reversible project copy. Report missing color metadata, unsupported plugins, and uncalibrated visual-review limits.

**Record as skill:** mechanics may be recorded after live closure; reference selection and shot-specific grading do not become fixed automation.

**CU display:** conditional for retained Premiere color state only.
