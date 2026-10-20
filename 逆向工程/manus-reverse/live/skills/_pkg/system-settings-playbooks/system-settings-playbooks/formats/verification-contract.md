# Verification Contract

## Guidance result

Report:

- operating system, build or edition when known, and personal or managed scope;
- selected card and route status;
- what the setting affects and the relevant risk class;
- the user-owned action or missing runtime gate;
- a non-secret state the user can check afterward.

Do not say the setting was changed.

## Read-only diagnosis

Before a diagnostic query, confirm that the execution surface is host-local and authorized. Minimize requested properties and redact user, organization, device, network, and account identifiers. Record the source of state, observed value, interpretation, uncertainty, and zero-write result.

If the output cannot distinguish policy, hardware, process, and OS behavior, report the unresolved branches rather than recommending a mutation.

## Future reversible mutation

A mutation can pass only with all of these receipts:

1. exact current value captured from the authoritative OS surface;
2. exact target and scope confirmed immediately before action;
3. one smallest supported change;
4. fresh app-native state after the change;
5. a task-level behavior oracle;
6. no unrelated setting delta;
7. inverse rollback using the captured value;
8. rollback state and behavior verified.

Never use a presumed factory default as rollback.

## Risk-specific oracles

- Appearance: selected state and visible shell chrome agree.
- Readability: Settings and one representative app remain readable and controllable.
- Notifications or Focus: a benign test follows the requested rule and a named critical path still alerts.
- Power: effective state and a bounded behavior check agree.
- Input: physical click, scroll, or gesture behavior agrees and alternate input remains available.
- Managed policy: management telemetry and a clean pilot's effective state agree.

## Terminal stop conditions

Stop rather than retry when the desktop locks, helper permission is missing, a secure or higher-integrity surface appears, the control is absent or managed, state becomes stale, visual or input access is degraded, secrets are visible, or the postcondition cannot be read.
