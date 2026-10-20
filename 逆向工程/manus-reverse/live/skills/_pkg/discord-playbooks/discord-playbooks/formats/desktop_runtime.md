# Runtime and channel facts

## Capability versus Manus execution

| Surface | What Discord supports | What Manus must still prove at run time |
|---|---|---|
| My Browser | Technical browser access to the user's normal account | Not an approved automation identity; use manual guidance unless a written policy exception exists |
| Computer Use | Technical access to the installed official client | Not an approved automation identity; official client use and human-like speed do not cure self-bot risk |
| Official app/bot API | Channels, roles, permissions, messages, AutoMod, Welcome Screen, and Onboarding with granted scopes | Actual connector/MCP/local runtime, app identity, scopes, intents, deployment, and error handling |
| Incoming webhook | Channel-scoped posting without a bot user | Secret storage, webhook creation permission, invocation runtime, idempotency, scheduler, revocation, and verification |
| Sandbox/file tools | Organize an already-delivered personal Data Package or other authorized files | File availability, schema detection, privacy scope, counts, and output location |

Electron lineage does not certify that Web and Desktop expose the same feature or control. Detect the chosen surface per workflow.

## Normal-account policy gate

1. Do not execute normal-account reads, posts, server administration, moderation, or settings changes through My Browser or Computer Use under the current package policy.
2. User confirmation, foreground visibility, pacing, and use of Discord's official Web/Desktop client are not documented self-bot exemptions.
3. Provide a manual step card or route the work to a verified official app/bot API or webhook identity.
4. Reintroducing a UI route requires a written product/legal determination plus separate Web/Desktop disposable O1; shared Electron technology never proves parity.
5. Login, 2FA, OAuth authorization, permission grants, webhook creation, and secret entry remain user-controlled security handoffs.

## Reusable automation gate

Before a bot, API, or webhook route is called executable, record:

- current Manus tool or local runtime name and version;
- app/bot/webhook identity and destination;
- granted scopes, permissions, and privileged intents;
- secret-storage mechanism;
- idempotency or deduplication key;
- timeout, retry, revocation, and cleanup behavior;
- one positive and one denied-permission test.

Without these items, the package may recommend or design the official route but must stay in guidance mode.
