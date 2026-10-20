# Performance and Capture (Cards B1, B2, and B3)

## Card B1 — Frame-loss and lag triage

**Use when:** the user reports dropped frames, rendering lag, encoding overload, stutter, or unstable output.

**Inputs:** symptom and time window, OBS log, workload, hardware, source graph, output mode, network context, and comparable before/after sample plan.

**Primary channel:** F1 parses logs and measurements first. A read-only P1 query or observed D1 statistics view may add live signals when its gate passes.

**Escalation trigger:** signals conflict, no comparable workload exists, the problem is outside OBS, or a proposed change requires unproved output/capture controls.

**Hybrid handoff:** F1 produces observations and ranked hypotheses; P1/D1 changes one proved variable only after the diagnosis; F1 repeats the same measurements.

**Workflow:**

1. Preserve the current configuration and collect one bounded baseline under a named workload.
2. Separate render-skipped, output-skipped, and congestion signals; add log/context evidence.
3. State hypotheses, not a unique cause, unless corroborated.
4. Choose one relevant, reversible intervention or recommend a network/platform action.
5. Repeat the same workload and measurements.
6. Keep or roll back the change based on evidence.

**Verification:** before/after values share the same workload and time basis; log excerpts and settings are identified; improvement is not inferred from one metric alone; external congestion is not mislabeled an OBS fix.

**Failure and recovery:** revert changes that do not improve the defined measure. Preserve logs and configuration snapshots for the next hypothesis.

**Record as skill:** record data collection only after the current controls are observed. Diagnosis logic remains parameterized and evidence-driven.

**CU display:** conditional for an observed statistics/settings branch; log analysis is not CU.

## Card B2 — Encoder and output quality

**Use when:** the user needs a justified encoder, rate control, bitrate, keyframe, resolution, frame rate, scaling, or recording-quality configuration.

**Inputs:** platform constraints, upload capacity, hardware encoders, canvas/output contract, content motion, recording versus streaming goal, B1 evidence, and rollback point.

**Primary channel:** F1 builds the recommendation. P1 may apply only fields discovered in the live schema; D1 applies a named current-build control when P1 cannot. Do not claim these settings are categorically outside or inside the protocol.

**Escalation trigger:** hardware/platform constraints are unknown, the live object schema is absent, the issue is render/network pressure, or a test output cannot be made safely.

**Hybrid handoff:** F1 computes and documents trade-offs; P1/D1 applies one bounded setting group; a local test recording or separately confirmed private test supplies evidence.

**Workflow:**

1. Freeze the target and baseline settings without exposing service credentials.
2. Explain the proposed change and trade-off in the user's constraints.
3. Prove each target field in the live protocol schema or current Desktop UI.
4. Apply only the proved fields in a disposable Profile or recovery-backed state.
5. Create a bounded test output.
6. Compare technical properties, measurements, and visible quality; retain or roll back.

**Verification:** persisted values, output integrity, expected dimensions/frame rate/streams, comparable metrics, and user visual review. A saved form alone does not prove encoding behavior.

**Failure and recovery:** restore the previous Profile/settings when the test fails or the live schema differs. Do not substitute remembered defaults.

**Record as skill:** one exact output mode/app/OS/version after live replay; hardware and platform values remain parameters.

**CU display:** conditional for a proved D1 output-settings workflow.

## Card B3 — Black or missing capture

**Use when:** a display, window, game, camera, or other capture source is blank, frozen, or wrong.

**Inputs:** OS, OBS version, source type, intended target, display/GPU topology, application mode, permissions, baseline screenshot, and disposable scene.

**Primary channel:** D1 because target selection, permissions, and visible render are OS- and machine-specific. F1 inspects logs; P1 may read source state/screenshots but does not enumerate every capture target.

**Escalation trigger:** protected content, a user-only OS permission prompt, missing hardware/driver/plugin, or no safe disposable target.

**Hybrid handoff:** F1 ranks OS-specific causes; D1 changes one observed cause at a time; screenshots and logs verify; P1 read-back is optional when available.

**Workflow:**

1. Identify OS-specific source family and capture target; do not apply a Windows game-capture recipe to macOS.
2. Record the baseline render and relevant permission/target state.
3. Test one bounded hypothesis at a time through currently observed controls.
4. Stop when a screenshot proves the intended content or when a protected/unavailable target is established.
5. Record the cause, exact system/app change, and rollback.

**Verification:** before/after render, correct target identity, persisted source state, disclosed permission/privilege change, and no unrelated content captured.

**Failure and recovery:** restore each failed experiment before testing the next. Never broaden capture scope to work around privacy/protection limits.

**Record as skill:** separate OS/source-type recordings only after disposable O1. Target identity and permissions remain runtime variables.

**CU display:** yes after one OS-specific source fixture passes live replay.
