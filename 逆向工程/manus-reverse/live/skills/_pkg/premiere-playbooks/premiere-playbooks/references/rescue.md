# Recovery and Project Hygiene (Cards 2 and 7)

## Card 2 — Crash and project recovery

**Use when:** Premiere crashed, a project will not open, or the user needs the semantically correct last-known-good version.

**Primary channel:** file handling first preserves the project and recovery tree and inventories candidates. P1 is used only to open and semantically validate candidate project state through a live-proved workflow.

**Escalation trigger:** enter P1 only after preservation and when a candidate must be evaluated as Premiere sequence/media state; deeper salvage remains a separate guarded problem.

**Hybrid handoff:** file tooling hashes/copies/ranks candidates; P1 opens only copies and validates semantic sentinels; file tooling stores the selected recovered copy and report.

**Verification:** preservation-before-open, candidate table, user selection, expected semantic sentinel, media-online state, save/reopen under a distinct name, and original hash unchanged.

**Inputs:** project path, symptom, crash time, last-known-good edit or sentinel, media roots, and recovery destination.

**Workflow:**

1. Hash/copy the project and all candidate recovery files before launching Premiere.
2. Build a candidate table with timestamps, sizes, hashes, and known semantic sentinels.
3. Open only copies through the current observed app path.
4. Present plausible candidates for user choice; never pick “newest” as a universal rule.
5. Save the selected candidate under a distinct recovered name, reopen it, and inspect expected sequence/media state.

**Failure and recovery:** preserve every candidate and logs. If ordinary candidates fail, stop with a loss/next-step report rather than claiming generic repair.

**Record as skill:** record preservation and candidate comparison; app-opening steps require per-version live evidence.

**CU display:** yes after file preservation when Premiere is necessary to validate retained project state.

## Card 7 — Project and cache hygiene

**Use when:** the user wants a read-only bloat diagnosis, archive plan, media consolidation, or cache cleanup.

**Primary channel:** file tooling for read-only inventory, sizes, duplicates, and proposed manifests; P1 for project-aware dependency review, consolidation, relink, or in-app cache state after a disposable fixture proves rollback.

**Escalation trigger:** use P1 only when the decision depends on project references or must mutate retained Premiere dependency/cache state.

**Hybrid handoff:** file tooling inventories and proposes actions; P1 performs only approved project-aware changes; file tooling reconciles the final filesystem and rollback manifest.

**Verification:** itemized before/after counts, no unapproved deletion, project reopen, media-online state, relink integrity, and successful rollback rehearsal where destructive behavior is involved.

**Workflow:** inventory project/media/cache without mutation; classify regenerated cache versus source/project dependencies; propose itemized actions and rollback; obtain separate approval; execute one bounded class; reopen the project and verify media online.

**Failure and recovery:** no deletion by default. Keep backup, move/relink manifest, and source hashes. Stop when project dependency is ambiguous.

**Record as skill:** inventory is parameterized; destructive/consolidation branches wait for backup, relink, reopen, and rollback fixtures.

**CU display:** conditional for project-aware Premiere state, not disk-size inventory.
