# Windows Cards

Every Windows branch is live-blocked. Microsoft documentation and helper source establish candidate surfaces and hard limitations; this dossier has no Windows 11 machine, Settings state capture, or O1 procedure.

## SET-W01: Find and explain

**Current route:** guidance.

**What Manus can do now:** clarify the behavior, identify the relevant Windows setting family, account for build, edition, hardware, and policy, and explain what the user should verify. A documented Settings URI proves navigation vocabulary only.

## SET-W02: Safe personalization

**Current route:** guidance.

**What Manus can do now:** reduce the request to one color-mode or taskbar preference, capture the intended value, explain activation or policy dependencies, and prepare inverse rollback.

No URI launch or CU mutation is claimed as executable until the current Windows runtime and control pass O1.

## SET-W03: Readability

**Current route:** guidance and user takeover.

**What Manus can do now:** distinguish text size, pointer visibility, brightness, scale, and resolution; branch for external displays and OEM graphics surfaces; propose the least disruptive option and a recovery check.

Display changes that can require sign-out or remove visual access remain user-owned.

## SET-W04: Notifications, Do Not Disturb, and Focus

**Current route:** guidance and a scoped plan.

**What Manus can do now:** identify the Windows version, critical apps, schedule, priority sources, and test path. Do Not Disturb and Focus are not assumed equivalent across versions.

The documented `ms-settings:notifications` and `ms-settings:quiethours` URIs are O2 navigation vocabulary only. They are not the current primary route and do not prove that Manus can launch the correct page, identify the target control, or change it safely. A future O1 route may use one only after the exact Windows build, page landing, control state, alert oracle, and rollback have been observed on a disposable fixture.

No alert-affecting mutation is executable without isolated test notifications, critical-path verification, and O1.

## SET-W05: Sleep and power

**Current route:** guidance. Read-only command families remain live-blocked on Windows in this dossier.

**What Manus can do now:** prepare a minimal diagnostic plan that distinguishes active scheme, effective timeout, hardware capability, Modern Standby or OEM behavior, policy, and blocker state. Interpret user-provided output without recommending a generic performance plan.

No elevated, plan-wide, hibernation, processor, or `Never` mutation is included.

## SET-W06: Touchpad and mouse

**Current route:** guidance.

**What Manus can do now:** verify that the relevant touchpad or pointer hardware exists, identify possible OEM ownership, specify one intended behavior, and require a backup input and rollback.

A missing page is a hardware, driver, edition, or OEM branch, not permission to search blindly or install software.

## SET-W07: Missing, greyed, or reverting state

**Current route:** guidance.

**What Manus can do now:** prepare a minimum-property read-only diagnostic, classify policy, driver, hardware, activation, account, or probable OS defect, and identify the next responsible owner. The user may supply outputs for interpretation.

Do not use registry edits, policy deletion, driver changes, service changes, app reset, or firmware updates.

## SET-W08: Managed baseline

Read [managed-and-sensitive.md](managed-and-sensitive.md). The package can produce an applicability, pilot, conflict, telemetry, and rollback plan. It cannot deploy policy without an approved runtime and tenant.

## SET-W09: Sensitive settings

Read [managed-and-sensitive.md](managed-and-sensitive.md). Stop at UAC secure desktop, a higher-integrity target, credentials, security, network, account, update, or administrator actions. Never retry around the boundary.
