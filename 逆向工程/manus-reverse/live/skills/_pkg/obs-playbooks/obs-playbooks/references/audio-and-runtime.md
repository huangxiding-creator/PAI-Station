# Audio and Runtime Control (Cards C1, C2, D1, and D2)

## Card C1 — Microphone diagnosis and filter chain

**Use when:** speech has background noise, level jumps, clipping, room tone, keyboard noise, or intelligibility problems.

**Inputs:** microphone and interface, room/noise description, current chain, complaint, before sample, target loudness/quality, available built-in or approved plugin filters, and rollback state.

**Primary channel:** F1 analyzes samples and proposes the smallest chain. P1 or D1 applies only filter kinds/settings proved in the live instance. There is no universal filter order or threshold set.

**Escalation trigger:** wrong input/driver, missing plugin, no clean test sample, unstable environment, or subjective result without user listening review.

**Hybrid handoff:** F1 measures and labels the complaint; P1/D1 applies one stage at a time; a short local recording provides the listening and clipping oracle.

**Workflow:**

1. Preserve the original chain and record matched speech/noise samples.
2. Identify the actual defect and choose the minimum candidate stage.
3. Prove the filter kind and setting keys in the live protocol or current UI.
4. Apply one stage, record a matched sample, and compare.
5. Add another stage only for a remaining measured defect.
6. Save the accepted chain and rollback record.

**Verification:** before/after recordings, clipping/noise/level measures where available, user listening approval, exact retained order/settings, and original-chain recovery.

**Failure and recovery:** revert stages that cause pumping, clipping, lost consonants, or unnatural gating. Do not install a plugin without Card F2 approval.

**Record as skill:** record a proved mechanism for one built-in filter/client build, not a universal room preset. Audio judgment remains calibrated by samples.

**CU display:** conditional for a current-build D1 filter workflow.

## Card C2 — Audio synchronization

**Use when:** camera and microphone are offset by a stable amount, or the user needs to distinguish constant offset from drift.

**Inputs:** synchronized clap/slate test, source identities, frame rate/sample rate, measured direction and magnitude, current offset, and rollback value.

**Primary channel:** F1 measures the sample. P1/D1 applies a constant offset only when the live source and control are proved.

**Escalation trigger:** drift changes over time, clocks/sample rates differ, the wrong source is selected, or the measurement is ambiguous.

**Hybrid handoff:** F1 calculates the constant offset; P1/D1 applies it; a second matched recording verifies. Variable drift routes to device/driver guidance instead of a fixed offset.

**Workflow:**

1. Record a short controlled clap/slate fixture.
2. Measure which signal leads and by how much.
3. Determine whether the error is constant or drifting.
4. Apply one measured constant offset through a proved control.
5. Repeat the same test and compare.
6. Save the stable hardware/source-specific value and rollback.

**Verification:** measured before/after alignment, correct input identity, retained offset, and no claim that a constant offset solves drift.

**Failure and recovery:** restore the previous value when alignment worsens; escalate drift to hardware/driver/sample-rate diagnosis.

**Record as skill:** the test-and-apply mechanism can be recorded after O1; the offset itself must never be hard-coded.

**CU display:** conditional for a proved D1 offset control.

## Card D1 — Runtime and output control

**Use when:** the user needs scene switching, source visibility, recording, streaming, replay buffer, virtual camera, or a bounded output routine.

**Inputs:** exact action, target scene/source/output, timing, trigger, final state, privacy scope, confirmation rule, idempotency key, and recovery/query plan.

**Primary channel:** P1 only when the audited client, allowlist, secret, receipt, and timeout gates pass. D1 is a one-off foreground fallback through a currently observed control. R1 applies to consequential output changes.

**Escalation trigger:** unattended public operation, external triggers without a proved scheduler/event runtime, ambiguous current state, missing capability, or absent immediate confirmation.

**Hybrid handoff:** F1 defines a state machine and query-before-retry rule; P1/D1 performs one allowed transition; R1 confirmation gates output starts; read-back reconciles timeouts.

**Workflow:**

1. Read current state and define the exact desired transition and safe duplicate behavior.
2. Confirm the target and consequence at the required moment.
3. Execute one transition through the proved route.
4. Query the resulting state before any retry.
5. Stop outputs when requested and verify stop state plus artifact where applicable.
6. Deliver a routine only if its runtime, credentials, scheduler, idempotency, revocation, and logs are all proved.

**Verification:** current/final scene or output state, request/input receipt, query receipt, no duplicate start, output artifact when applicable, and no public start without confirmation.

**Failure and recovery:** on timeout, query state first. If state remains ambiguous, stop and ask for local inspection; never repeat a consequential start blindly.

**Record as skill:** record only a harmless disposable transition after O1. A recording does not create a secure unattended runtime.

**CU display:** yes for a harmless current-build one-off; public output start is a confirmation-gated test, not an onboarding spectacle.

## Card D2 — Platform authorization and stream destination

**Use when:** the user needs to select a streaming platform, authorize an account, configure a custom destination, or change a stream key.

**Inputs:** target platform/account, direct versus restreaming architecture, authorization method, non-secret destination fields, direct local secret-entry path, test scope, and rollback.

**Primary channel:** My Browser for supported account authorization; F1 for architecture and non-secret settings; the user enters secrets directly in trusted local UI; P1/D1 applies only a proved non-leaking path.

**Escalation trigger:** the workflow would expose a key/token/secret URL, needs unsupported multi-platform fan-out, lacks a private test, or cannot verify/revoke authorization.

**Hybrid handoff:** My Browser completes account authorization without being called CU; the user handles secret entry; P1/D1 updates proved destination state; R1 gates a private test connection.

**Workflow:**

1. Choose direct or authorized restreaming architecture and list non-secret fields.
2. Complete browser authorization in the intended account when supported.
3. Have the user enter secrets directly; do not read them back.
4. Apply the proved destination state with redacted receipts.
5. Run only an explicitly confirmed bounded private test and stop it.
6. Verify destination/account, revoke path, and secret-free report.

**Verification:** intended account/destination, successful authorized test, OBS state without secret echo, test stop, and a documented revoke/rollback route.

**Failure and recovery:** restore the prior destination; revoke failed authorization; never copy secrets into a fallback file or command argument.

**Record as skill:** authorization and destination selection may be taught after O1; secrets are always excluded from recordings and parameters.

**CU display:** conditional for a secret-free D1 branch. My Browser authorization is not CU.
