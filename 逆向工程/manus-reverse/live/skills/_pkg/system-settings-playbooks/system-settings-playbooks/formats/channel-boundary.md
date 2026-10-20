# Channel Boundary

Choose a channel only after identifying the durable OS state and the current task's real tool surface.

## Guidance

Guidance is the default executable product in this package. It can explain a setting, identify the relevant OS surface, compare choices, prepare a rollback plan, and tell the user what non-secret state to verify. It does not claim that Manus changed the device.

## Sandbox

A sandbox can analyze user-provided reports or build plans. It cannot inspect or mutate the host operating system merely because Manus Desktop is installed. Do not describe sandbox commands as local-device diagnostics.

## Authorized host-local read

Use a host-local diagnostic only when the current task exposes an authorized host execution surface for the target device. Confirm the OS and run the smallest read-only query needed. If the host surface is absent, provide a user-run command or a manual inspection plan and interpret the supplied result.

The checked Mac evidence supports bounded reads of documented user defaults, power state, and profile status. It does not support preference writes, root power mutations, profile removal, or broad state dumps. The Windows command families in the dossier remain documentation-backed and live-blocked; treat them as guidance until reproduced on the target fixture.

## Official operating-system channels

Shortcuts, Apple configuration profiles, Windows Settings URIs, PowerShell command families, and CSP or MDM schemas are upstream OS capabilities. They become Manus execution routes only when the current task exposes a compatible runtime, authority, authentication path, and postcondition.

An official navigation mechanism proves only that a surface can be requested. It does not prove that the expected page appeared or that a setting changed.

## My Browser

My Browser can operate a connected authenticated web session. It may support an approved management portal or first-party documentation, but it does not own local device state. My Browser is not Computer Use.

## Computer Use

Computer Use operates an installed desktop surface. This package has no current-build O1 mutation procedure for either operating system. A future branch may use CU only when all of the following are present:

1. exact OS build, app surface, hardware class, locale, and account type;
2. current helper permission and session preflight;
3. operation-specific O1 control mapping;
4. captured before value and current-state read;
5. task-level postcondition, not click success;
6. tested inverse rollback and stop conditions.

Mac read-only evidence from an earlier build and Windows helper source code do not satisfy these gates. Do not use coordinates, blind search, or repeated clicks to bridge the gap.
