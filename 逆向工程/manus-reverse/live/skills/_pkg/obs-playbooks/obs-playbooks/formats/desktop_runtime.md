# OBS Desktop Runtime

Use this preflight for D1 and R1 only.

## Environment and fixture

- Resolve OBS installation, version, OS, architecture, locale, active Profile, and active Scene Collection from current state.
- Record whether the work uses a disposable Windows portable instance or a dedicated macOS test Profile/Collection. Portable mode is not a cross-platform assumption.
- Confirm Computer Use readiness and the single desktop-control lease.
- Preserve source assets and two distinct recovery artifacts: the active Profile for output-related settings and the active Scene Collection for scenes, sources, and global audio state. A copy of one is not proof that the other can be restored.
- Treat Profile exports as sensitive. Inventory and redact connected-account or stream-service state before any transfer, fixture reuse, screenshot, or report.

## Observe, do not remember

- Inspect the current window and controls. Do not freeze a menu path from documentation, another OS, or another version.
- Use coherent state, fresh element discovery, and bounded state-based waits. Do not replay absolute coordinates or stale handles.
- Re-observe the exact target object, value, visible render, and saved state after each meaningful mutation.
- If the required control cannot be identified or verified, stop with the fixture and recovery state intact.

## Appropriate Desktop work

D1 is justified for a currently observed protocol-external control, plugin installation, operating-system permission, capture target, properties dialog, or visual diagnosis. It is not justified for asset creation, page deployment, log parsing, or a protocol mutation whose audited P1 route has already passed.

## Consequential output

- Require immediate confirmation before starting a public stream, recording, replay buffer, or virtual camera when the action changes live output or captures private content.
- Confirm the selected Profile, Scene Collection, scene, destination, and privacy scope.
- Verify the resulting state independently; input dispatch or a changed button label is insufficient.
- Stop and reconcile ambiguous state before retrying. Never double-submit a start action.

## Secrets

The user must enter secrets directly into the intended trusted UI. Do not read, repeat, record, screenshot, or report them. Do not pass an OBS WebSocket password or stream key on a command line: process listings, shell history, and receipts can expose command arguments. If no direct secret-entry or approved secret-broker handoff is available, the secret-bearing workflow is blocked.

Finish the CU session exactly once after final verification.
