# macOS Cards

These cards describe current routing, not current-build UI procedures. The retained Mac observation covers read-only navigation on an earlier build; it does not qualify interior controls or mutation.

## SET-M01: Find and explain

**Current route:** guidance. Use current first-party naming for the detected macOS build. If the user asks Manus to show the surface, Computer Use remains live-gated.

**What Manus can do now:** clarify the intended behavior, identify the likely setting family, explain impact, and interpret a non-secret value supplied by the user.

**Verification:** correct setting family, no mutation, and explicit uncertainty when the control moved or is hardware- or policy-dependent.

## SET-M02: Safe personalization

**Current route:** guidance. Appearance and Dock preferences are app-native state. A documented Shortcut action or visible control does not prove a Manus execution route.

**What Manus can do now:** turn the request into one exact preference and target value, explain the supported choices, and prepare an inverse rollback.

**Future CU gate:** current-build control mapping, unseen starting values, exact before and after state, shell-level visual oracle, and rollback. Do not bundle several new-device choices.

## SET-M03: Readability

**Current route:** guidance and user takeover.

**What Manus can do now:** distinguish system text, application text, pointer visibility, icon size, and display scaling; recommend the least disruptive setting family; prepare a recovery plan.

Display resolution, contrast, and multi-display changes stay user-owned until a safe timed recovery path is live-tested.

## SET-M04: Notifications and Focus

**Current route:** guidance and a scoped plan.

**What Manus can do now:** inventory the exact apps, people, time window, critical alert sources, and cross-device scope; explain tradeoffs; define a benign test and rollback.

No notification disable, Focus schedule, allowed-list edit, or sync change is executable from this package.

## SET-M05: Sleep, wake, and battery

**Current route:** conditional host-local read, otherwise guidance.

**What Manus can do now:** if an authorized Mac host runtime is exposed, use only bounded read-only power queries already qualified by the dossier; otherwise interpret user-supplied output. Distinguish timeout, process assertion, hardware capability, power source, and managed policy before proposing a setting.

Do not run root power mutations. `Never`, wake, hibernation, charging-health, and plan-wide changes remain guidance-only.

## SET-M06: Trackpad and mouse

**Current route:** guidance.

**What Manus can do now:** identify the exact click, tracking, scroll, or gesture preference; verify that the relevant hardware and a backup input exist; prepare a one-change rollback test.

No input mutation is executable until the target hardware's controls and physical behavior oracle pass current-build O1.

## SET-M07: Missing, greyed, or reverting state

**Current route:** conditional host-local read, otherwise guidance.

**What Manus can do now:** collect build, hardware, symptom, and managed-device context; use only a minimal qualified read when available; classify version drift, hardware absence, policy ownership, process interference, or probable defect.

Never delete preference files, remove profiles, reset settings, or turn a symptom into an undocumented write.

## SET-M08: Managed baseline

Read [managed-and-sensitive.md](managed-and-sensitive.md). The package can produce a requirement-to-payload review, pilot plan, verification plan, and rollback design. It cannot enroll, deploy, remove, or bypass management.

## SET-M09: Sensitive settings

Read [managed-and-sensitive.md](managed-and-sensitive.md). Privacy, security, accounts, credentials, network, updates, startup, reset, and administrator actions are user-owned. A helper permission guide may direct the user, but Manus never grants itself consent.
