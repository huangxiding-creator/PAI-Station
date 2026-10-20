# Setup (Cards E1, A1, and A2)

## Card E1 — Connection readiness

**Use when:** the user asks Manus to connect to or control OBS.

**Inputs:** installed OBS build, OS, intended state changes, disposable fixture, terminal permission, approved client provenance, and a direct local secret-entry design.

**Primary channel:** F1 readiness audit first. D1 may enable or inspect the server on the current build. P1 remains blocked until every gate in `formats/websocket_channel.md` passes.

**Escalation trigger:** OBS is absent or too old for the intended protocol; the current server control is not observable; terminal permission is absent; no pinned client exists; no protected secret path exists; authentication or redaction fails.

**Hybrid handoff:** D1 performs only the observed protocol-external enablement step; the user enters the password directly in trusted local UI; a proved P1 client begins with a read-only version/capability probe.

**Workflow:**

1. Inventory the current environment and exact requested objects.
2. Audit the seven P1 gates without collecting a secret.
3. If current-build enablement is needed and a disposable fixture exists, observe and perform the bounded D1 step.
4. Have the user enter any secret directly; never capture it.
5. If all P1 gates pass, run one read-only probe and retain the redacted receipt. Otherwise stop with the failed gate and supported foreground alternative.

**Verification:** server state is intentionally known; authentication remains enabled; no secret appears in any artifact; P1 is called available only with client, capability, redaction, timeout, and recovery receipts.

**Failure and recovery:** restore the prior server state when the connection design cannot be completed. Do not leave an unnecessary listener enabled or weaken authentication.

**Record as skill:** record only one current OBS/OS enablement lesson after live replay. Client authentication and secret transport are code/security artifacts, not pointer recordings.

**CU display:** conditional. Enabling or inspecting a current-build Desktop-only control can be a CU example; protocol mutation cannot be advertised until P1 closes.

## Card A1 — Full setup from scratch

**Use when:** the user needs a complete streaming or recording workspace: scenes, sources, assets, audio, outputs, and an operational runbook.

**Inputs:** show format, hardware, target platforms, canvas/delivery contract, scene sequence, existing assets, interaction needs, privacy scope, and retained-state requirements.

**Primary channel:** F1 for the blueprint and recovery plan; A1/H1 for missing assets and interactive overlays; P1 for retained OBS structure only after its runtime gates pass; D1 for a named protocol-external state through an observed path.

**Escalation trigger:** missing or unlicensed assets, unavailable capture targets, unproved plugins, unsupported platform events, absent P1 runtime, or a production Profile/Collection without a disposable rehearsal path.

**Hybrid handoff:** validate/build every upstream artifact first; create a machine-readable OBS object plan; rehearse one scene in a disposable fixture; apply retained state only through proved P1/D1 routes; verify visible output separately.

**Workflow:**

1. Define the accepted show, scenes, source graph, hardware, output, assets, and live-action boundary.
2. Inventory current state read-only and create separate Profile/Scene Collection recovery plans.
3. Build and verify missing A1/H1 artifacts outside OBS.
4. Produce the exact object blueprint and rollback map.
5. Implement one representative scene through an available proved route and approve it.
6. Scale only the approved object classes; keep blocked classes in the plan.
7. Verify every retained object, visible render, source availability, and recovery point; nothing goes live during setup unless separately confirmed.

**Verification:** blueprint versus actual object inventory; screenshots/render for each scene; upstream asset/page checks; save/reopen or restart persistence; source online status; recovery plan remains usable.

**Failure and recovery:** stop on missing sources, ambiguous target selection, secret leakage risk, or unverified state. Reconcile receipts before retrying; never rebuild blindly over production state.

**Record as skill:** record only a closed app-specific trunk after its fixture passes. Show design, hardware choice, source mapping, and taste remain parameters and decisions.

**CU display:** yes only for a proved D1 branch. Asset/site creation and F1 planning are not CU.

## Card A2 — Wire existing assets and overlays

**Use when:** validated images, media, text, or hosted overlay pages must become visible OBS sources in named scenes.

**Inputs:** asset/page inventory, provenance, dimensions, canvas, scene/layer plan, source settings, retained-state route, and reference render.

**Primary channel:** F1 validates files and URLs; P1 creates/places sources only with an audited live recipe; D1 uses a current observed source-properties path when P1 cannot represent the required state.

**Escalation trigger:** missing/malformed assets, untested or secret-bearing URLs, unsupported source kind, stale media path, required plugin, or absent P1/D1 fixture.

**Hybrid handoff:** A1/H1/F1 fixes upstream artifacts; P1/D1 installs only the verified objects; file/image comparison checks the final render.

**Workflow:**

1. Inventory and independently open each file/page; redact secret query parameters.
2. Freeze the scene, source type, layer order, transform intent, and reference image.
3. Probe the live source kind/defaults or observe current Desktop controls.
4. Install one representative source in a disposable fixture and verify render.
5. Scale the same proved class; keep outliers separate.
6. Reconcile object names, scene membership, transforms, online state, and screenshots.

**Verification:** every upstream artifact works; retained source objects read back or reopen; OBS render matches the approved reference; no secret-bearing URL appears in reports.

**Failure and recovery:** preserve the upstream asset and remove or disable only the failed disposable source through a proved cleanup route. Do not call a collection disposable without an observed teardown.

**Record as skill:** one source type and one client/version path per recording; parameterize scene, source, asset, dimensions, and destination.

**CU display:** conditional for a current-build D1 source-properties workflow.
