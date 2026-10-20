---
name: system-settings-playbooks
description: "Use when the user asks what Manus can do with macOS System Settings or Windows Settings; wants help finding, understanding, diagnosing, changing, or planning an operating-system setting; or needs to choose among read-only diagnostics, official navigation and management channels, user guidance, and conditional Computer Use. Routes personalization, readability, notifications and focus, power, input, managed policy, and sensitive settings while keeping Mac and Windows evidence and mutation gates separate."
---

# System Settings Playbooks (Manus for System Settings)

Treat macOS System Settings and Windows Settings as two implementations of shared user goals. Never transfer a control name, procedure, live result, or readiness claim from one operating system to the other.

This package is a bounded router and guidance layer. It contains no current-build O1 procedure for changing a setting. Do not drive a settings mutation through Computer Use unless a later operation-specific receipt proves the exact OS build, app surface, control, before state, postcondition, and rollback.

## 1. Establish the real surface

Before selecting a card, determine:

1. macOS or Windows, including exact build and edition when available.
2. Personal or organization-managed device.
3. Relevant hardware, such as display topology, portable power, touchpad, mouse, or alternate input.
4. The exact user outcome and the durable OS state that would change.
5. Which execution surfaces are actually exposed in the current task.

Do not infer Manus execution from an Apple or Microsoft feature. A documented Shortcut, command, URI, policy schema, or Settings page is an operating-system capability until the current task proves a usable Manus route.

Read [channel-boundary.md](formats/channel-boundary.md) before selecting an execution channel.

## 2. Assign a route status

Use one status before acting:

- `GUIDANCE`: explain impact, identify the supported surface, and let the user act.
- `CONDITIONAL-LOCAL-READ`: use a minimal read-only host diagnostic only when an authorized host-local runtime is actually exposed; otherwise ask the user to run it and interpret the result.
- `CONDITIONAL-O1`: the requested app-native state may justify Computer Use, but this package has no current live pass for the mutation.
- `USER-OWNED`: stop before consent, credentials, administrator approval, secure desktop, or another consequential boundary.
- `REFUSE`: decline destructive, evasive, secret-capturing, or policy-bypassing behavior.

Sandbox execution is not host execution. My Browser may help with documentation or an approved management portal, but it does not read or change the local OS and it is not Computer Use.

## 3. Route by user outcome

| User outcome | Cards | Load | Current route |
|---|---|---|---|
| Find and understand a setting without changing it | SET-M01 / SET-W01 | OS reference | Guidance; read-only inspection remains operation-specific and live-gated |
| Personalize appearance, Dock, or taskbar behavior | SET-M02 / SET-W02 | OS reference | Guidance; a mutation is `CONDITIONAL-O1` |
| Improve text, pointer, icon, or display readability | SET-M03 / SET-W03 | OS reference | Guidance; disruptive display changes require user takeover |
| Reduce interruptions with notifications, Do Not Disturb, or Focus | SET-M04 / SET-W04 | OS reference | Guidance and a risk-specific plan; no autonomous mutation |
| Diagnose sleep, wake, battery, or power behavior | SET-M05 / SET-W05 | OS reference | Mac: conditional host-local read; Windows: guidance from minimized user-supplied state; changes remain live-blocked |
| Tune trackpad or mouse behavior | SET-M06 / SET-W06 | OS reference | Guidance; a mutation requires hardware-specific O1 and rollback |
| Explain a missing, greyed, or reverting setting | SET-M07 / SET-W07 | OS reference | Mac: conditional host-local read; Windows: guidance from minimized user-supplied state; never use registry or preference-reset folklore |
| Plan an organization-managed baseline | SET-M08 / SET-W08 | [managed-and-sensitive.md](references/managed-and-sensitive.md) | Planning only unless an approved management runtime, pilot, and rollback are proved |
| Handle privacy, security, network, account, or administrator settings | SET-M09 / SET-W09 | [managed-and-sensitive.md](references/managed-and-sensitive.md) | `USER-OWNED` guidance and non-secret status only |

For Mac cards read [macos.md](references/macos.md). For Windows cards read [windows.md](references/windows.md). The canonical route and verification summary is in [route-contract.md](formats/route-contract.md).

## 4. Global boundaries

1. Diagnose before changing. A missing or reverting control may be owned by hardware, an organization policy, a process, an OS defect, or a different product surface.
2. A future qualified mutation may change at most one clearly named preference after an immediate confirmation. Do not apply generic optimization or new-device presets.
3. Never enter, read, store, or capture passwords, recovery keys, certificates, tokens, network secrets, or administrator credentials.
4. Never self-grant privacy permissions, accept UAC, bypass device management, or work around a secure or higher-integrity desktop.
5. Do not change network connectivity, security software, encryption, accounts, updates, device management, startup or reset controls from this package.
6. Notification, Focus, display, power, and input changes need their own risk oracle. A visible toggle is not permission to change it.
7. A successful launch, click, command dispatch, or page landing is not a setting postcondition.

## 5. Completion contract

Read [verification-contract.md](formats/verification-contract.md) before reporting completion.

For guidance, report the selected OS branch, expected effect, risk class, user-owned step, and observable non-secret check. For read-only diagnosis, report the exact source of state, minimized output, cause category, uncertainty, and zero writes. For a future mutation, require a captured before value, exact confirmed delta, fresh app-native read, task-level behavior check, inverse rollback, and rollback verification.

If the current build, control, permission, hardware, policy ownership, or postcondition is unknown, stop at guidance. Never convert missing evidence into a plausible procedure.
