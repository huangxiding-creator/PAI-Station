# Native and Desktop Handoffs (Cards F1, F2, and F3)

## Card F1 — Interactive overlay

**Use when:** the user needs alerts, goals, chat displays, scoreboards, timers, lower thirds, or another interactive browser-rendered surface.

**Inputs:** event source and permitted access, state/rules, visual reference, canvas/safe areas, privacy scope, local simulation cases, deployment authorization, and target OBS scene.

**Primary channel:** H1 through Manus site building and deployment. P1/D1 installs the resulting Browser Source only after its route gate passes.

**Escalation trigger:** no permitted event source, browser-exposed secrets, unapproved publication, inaccessible account, or no proved downstream OBS source route.

**Hybrid handoff:** build and test the overlay independently with simulated events; deploy only after approval; then install the public or local URL in a disposable OBS scene and test the full path.

**Workflow:**

1. Define event schema, allowed access, visual behavior, failure/empty states, and target scenes.
2. Build deterministic simulated events before connecting real data.
3. Verify local behavior, responsiveness, accessibility, and secret boundary.
4. Obtain publication approval and deploy.
5. Verify the deployed URL independently.
6. Install through a proved P1/D1 route and trigger the same simulation in OBS.

**Verification:** local and deployed event cases pass; URL loads; no secret is client-exposed; OBS visibly renders the correct state; upstream page and downstream source are reported separately.

**Failure and recovery:** keep a static fallback asset; remove or disable the disposable source through a proved route; revoke any failed authorization.

**Record as skill:** OBS installation may be recorded after O1; event design/site implementation remains a parameterized build workflow.

**CU display:** only the proved downstream D1 Browser Source step is CU.

## Card F2 — Plugin installation

**Use when:** a specific maintained plugin is required for a named source, filter, output, or integration unavailable in the current OBS build.

**Inputs:** exact plugin, publisher/source, version, OBS version, OS, architecture, package type, permissions/signing, install and uninstall instructions, test fixture, and rollback.

**Primary channel:** F1 compatibility and integrity review first. User-approved system/file handoff plus D1 performs only a version-pinned procedure observed for the exact matrix.

**Escalation trigger:** built-in alternative exists, source or package cannot be verified, compatibility is uncertain, plugin is unmaintained/unsigned, privileged change is unapproved, or uninstall/recovery is absent.

**Hybrid handoff:** inspect the package and documentation outside OBS; the user handles trust/privilege prompts; D1 installs/restarts; P1/D1 verifies the named capability in a disposable scene.

**Workflow:**

1. Confirm the user outcome and check a built-in alternative.
2. Verify the exact compatibility matrix, integrity/provenance, permissions, install, and uninstall route.
3. Export and protect the current Profile and Scene Collection as separate recovery artifacts, review the Profile export for sensitive connected-account state, and obtain installation approval.
4. Follow only the exact current matrix; restart OBS as required.
5. Verify the plugin/version and one disposable capability.
6. Document removal and rollback.

**Verification:** expected plugin/capability appears after restart, works in a disposable fixture, survives another restart when required, and has an executable uninstall record.

**Failure and recovery:** remove or disable the exact plugin through its verified method; use safe-mode diagnosis only as a separate run, not as proof that WebSocket/plugin behavior works simultaneously.

**Record as skill:** one exact plugin/OS/architecture/OBS-version procedure per recording. Never generalize a generic installer flow.

**CU display:** yes only after a maintained test plugin passes the full matrix and rollback.

## Card F3 — Stream asset creation

**Use when:** the user needs starting/ending screens, overlays, stingers, alert sounds, lower thirds, backgrounds, or other source media.

**Inputs:** brand/reference, canvas/safe areas, format, transparency, duration/loop, audio, editable-source requirement, licensing, naming, and delivery matrix.

**Primary channel:** A1 through the appropriate Manus image/video/audio capability or deterministic file route. OBS is not the creation tool unless the user explicitly needs retained OBS composition state.

**Escalation trigger:** layered/editable specialist-app state, exact brand text/geometry, long/multitrack production, unavailable runtime, or unlicensed third-party material.

**Hybrid handoff:** create and verify a small asset set; specialist app skills own named editable project state; F1 normalizes delivery; Card A2 installs only approved files.

**Workflow:**

1. Freeze technical contract, visual direction, provenance, and retained-source requirement.
2. Generate one representative asset per type.
3. Verify file properties and user direction before scaling.
4. Produce the delivery matrix and manifest.
5. Hand approved assets to A2; do not open OBS merely to create them.

**Verification:** signatures, dimensions, duration, streams, transparency, loop/audio behavior, exact text where required, provenance, user approval, and source hashes.

**Failure and recovery:** quarantine uncertain outputs; retain original sources and regeneration parameters; do not install rejected assets.

**Record as skill:** asset-generation parameters may become reusable; OBS-specific placement is a separate recorded workflow.

**CU display:** no for asset creation; only downstream D1 placement can qualify.
