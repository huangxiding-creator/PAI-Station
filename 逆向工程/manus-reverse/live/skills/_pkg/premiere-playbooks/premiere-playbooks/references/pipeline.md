# Delivery, Proxy, and Lessons (Cards 4, 5, and 8)

## Card 4 — Delivery and export diagnosis

**Use when:** a project must render authoritatively, an approved master needs platform derivatives, or Premiere/encoder export fails.

**Primary channel:** F1 for mechanically equivalent derivatives of an approved master; P1 when effects, plugins, caption tracks, in/out state, sequence color, or the failure itself belongs to Premiere. Do not assume a named companion encoder is installed or integrated until observed.

**Escalation trigger:** use P1 when no approved master exists, project state determines the render, or the failure occurs in a live-proved Premiere export surface.

**Hybrid handoff:** P1 creates the authoritative master when necessary; F1 produces mechanical variants and validates every delivered file.

**Workflow:** build a delivery matrix; separate sequence-authoritative renders from mechanical derivatives; probe runtime/disk/destination; make one controlled diagnostic change at a time; validate every file independently of success toasts.

**Verification:** streams, dimensions, duration, frame rate, codec, audio, captions, names, count, representative playback, and project-state/source preservation.

**Failure and recovery:** preserve logs and the working project; do not clear caches or change several variables at once; reconcile completed jobs before retry.

**Record as skill:** one exact, live-proved export branch per app/version. Troubleshooting remains evidence-driven.

**CU display:** conditional. Authoritative sequence render or app-specific diagnosis qualifies; approved-master derivatives do not.

## Card 5 — Proxy workflow

**Use when:** editing performance needs lower-resolution media while preserving the relationship to full-resolution sources.

**Primary channel:** F1 for standalone lower-resolution copies; P1 when proxies must be created/attached/relinked/toggled and retained as Premiere media state.

**Escalation trigger:** use P1 when proxy metadata, mapping, toggling, relink, or full-resolution export behavior must persist in the project.

**Hybrid handoff:** F1 may create or inspect proxy candidates; P1 attaches and validates the retained mapping; F1 verifies files and storage impact.

**Verification:** candidate files, exact source mapping, online state, toggle behavior, save/reopen persistence, and authoritative full-resolution export rule.

**Inputs:** source IDs/timecode, codec/frame rate, storage, proxy specification, destination, and expected mapping.

**Workflow:** inventory sources and sentinels; preserve project copy; create or validate proxy candidates; attach through a live-proved procedure; compare proxy/full-resolution state; save/reopen; verify authoritative export source.

Do not call unattached low-resolution files a completed Premiere proxy workflow.

**Failure and recovery:** stop on offline media or ambiguous matches; retain relink map and do not rename/move originals during first closure.

**Record as skill:** only after app/OS-specific attachment and reopen tests pass.

**CU display:** yes for attached retained proxy state; no for standalone proxy files.

## Card 8 — Premiere lessons

**Use when:** the user wants to learn or see one Premiere operation in the installed app.

**Primary channel:** Premiere through CU for one live-proved lesson in the installed app; conceptual guidance otherwise.

**Escalation trigger:** use CU only when the user wants app-specific learning or a visible Premiere object/control; reroute a file-only outcome to T0/F1/G1.

**Hybrid handoff:** T0/F1/G1 creates safe demo inputs; Premiere performs the lesson; guidance records variable parameters and recovery.

**Verification:** exact app/OS/version, observable start/end state, saved disposable project, repeat checklist, and missing-control recovery.

Priority lesson candidates are editable captions, recovery candidate validation, proxy attachment, and safe authoritative export. Each lesson ships independently with one disposable fixture, exact app/OS/version, observable start/end state, recovery path, and repeat checklist.

If a lesson lacks live replay, provide conceptual guidance or hold rather than inventing menus. Safe demo media may be prepared through T0/F1/G1; the actual lesson must visibly use Premiere.

**Record as skill:** one lesson per recording; parameterize files, sequence, language, destinations, and app state.

**CU display:** yes only after the specific Desktop lesson passes live replay.
