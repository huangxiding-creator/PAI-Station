---
name: discord-playbooks
description: "Use when the user asks what Manus can do with Discord or needs workflows for server structure, roles and permissions, onboarding, moderation, bots, announcements, activity summaries, personal data packages, or Discord guidance. Routes each workflow by identity, authority, durable state, runtime availability, and policy among verified official app or bot APIs, webhooks, file tools, and manual guidance; normal-user-account automation through My Browser or Computer Use is not an execution route."
---

# Discord Playbooks (Manus for Discord)

Route Discord work by server authority, durable state, frequency, and execution availability. Official APIs cover many server-management objects, but documented capability is not proof that the current Manus session exposes a configured Discord app.

## Step 0: Safety and authority

1. Refuse self-bots, normal-user-account scripting, unsolicited bulk messaging, fake members, fake views, and artificial engagement.
2. Inspect the user's actual server role and effective permissions. Server ownership is not the only valid authority, and membership alone is not permission to administer.
3. Read-only work stays read-only. A draft is not a post; sending, publishing, pinning, deleting, kicking, banning, changing roles, and changing permissions are distinct consequential actions.
4. Keep bot tokens and webhook URLs out of prompts, files, logs, screenshots, and chat output. Use a verified secret surface or remain in guidance mode.
5. Do not treat My Browser, Computer Use, user confirmation, official-client use, or human-like pacing as an exception to Discord's self-bot/user-bot policy. Normal-user-account automation is not a production route in this package.

Read `formats/safety_rules.md` before any write, authorization, moderation, permission, webhook, bot, or data-package workflow.

## Step 0.5: Runtime routing

```
R0 Assign one status: EXECUTABLE, CONDITIONAL-RUNTIME, GUIDANCE, or REFUSE.
R1 Confirm the identity and authority required by the job:
   - official app/bot identity -> conditional API execution after runtime/scopes/tests;
   - channel-scoped webhook -> conditional posting after secret/runtime/idempotency tests;
   - normal user identity -> manual guidance only pending a written policy exception;
   - no Discord identity -> sandbox/file processing.
R2 Snapshot state, prove source completeness, and define rollback before any server mutation.
R3 Verify every post, permission, rule, or object through the official runtime; query before retry.
```

The checked Manus builtin connector enum has no Discord identifier. This does not prove that the live server catalog has no Discord MCP. Inspect the actual session tool list before claiming either API execution or absence.

## Step 1: Routing and completion contracts

| User outcome | Card / read | Primary route | Escalation route | Hybrid contract | Verification contract | CU display and reason |
|---|---|---|---|---|---|---|
| Build or restructure a server | 1 / `references/server-ops.md` | GUIDANCE; CONDITIONAL-RUNTIME through a verified official app/bot API | Deliver the blueprint and manual checklist when runtime, authority, snapshot, or rollback is incomplete | Planning produces an approved object model; the official runtime creates only the approved objects | Created/changed/skipped/failed IDs reconcile to the blueprint; test identities see expected areas | **No**: normal-account CU is not an approved route |
| Configure new-member onboarding | 2 / `references/server-ops.md` | GUIDANCE; CONDITIONAL-RUNTIME through the official onboarding API in a disposable server | Stop on current validation constraints and return the expected-object checklist | Manus designs prompts/roles/channels; verified API runtime stores them; test identity completes the journey | Observed prompts, roles, and default channels match the expected object | **No**: use official app identity or manual guidance |
| Select or configure a bot | 3 / `references/engagement.md` | Current vendor research and GUIDANCE; conditional official runtime after authorization | Custom app design or manual setup when no candidate passes minimum-permission review | Manus compares/configures non-secret settings; the user performs OAuth/permission grants | Positive, denied-permission, and uninstall/revoke tests pass without orphaned state | **No**: authorization and bot identity are not normal-account CU jobs |
| Configure AutoMod | 4 / `references/server-ops.md` | GUIDANCE; CONDITIONAL-RUNTIME through the official AutoMod API | Deliver the rule plan and manual test corpus when runtime is unavailable | Manus builds the rule/test oracle; official API creates one bounded rule | Positive, negative, and exemption cases are measured; only the new rule changes | **No**: official API owns the executable route |
| Audit role and channel permissions | 5 / `references/server-ops.md` | Verified official app/bot inventory with sufficient permissions | Explicitly partial manual evidence or supplied export when the complete object graph is unavailable | Official inventory supplies objects; Manus computes and reports effective access | Findings cite role, channel, overwrite, and resulting capability; inaccessible state is labeled | **No**: a partial normal-account UI view cannot certify completeness |
| Publish an announcement or reusable notification | 6 / `references/engagement.md` | Verified webhook or official bot/app; one-off normal-account post remains manual | Return a copy-ready preview when secret storage, scheduler, permissions, or idempotency is not proved | Manus prepares payload/allowed mentions; verified runtime posts; user controls authorization | Resulting message ID/body/channel/mentions and payload hash match; query before retry | **No**: supported identities are webhook/bot, not normal-account CU |
| Summarize server activity | 7 / `references/engagement.md` | Permissioned official bot/app read | Supplied authorized files or manual source selection | Official runtime or files supply bounded source items; Manus creates the digest and cursor | Every conclusion traces to channel/thread/timestamp; excluded areas stay unread; write count is zero | **No**: normal-account automated reading is not approved |
| Request and organize personal account data | 8 / `references/data-guidance.md` | Manual package-request guidance after verified-email and active-request checks, then file processing after delivery | Preserve original files and report unsupported or incomplete sections | User chooses the available category scope and requests/downloads the package; Manus inventories, indexes, and validates it | Request state, original hash, object counts, package scope, and parse exceptions are reported | **No**: normal-account request flow is manual; post-delivery work is file-based |
| Find or explain a setting | 9 / `references/data-guidance.md` | Evidence-gated manual GUIDANCE | High-level guidance plus current first-party lookup when an exact path is unproved | Manus provides a versioned step card; the user performs the account action | User verifies the named state; no coordinates, credentials, or unrelated settings are captured | **No**: normal-account UI automation is not an approved route |

**Channel vocabulary**: *Official API/bot* is Discord's supported app identity; execution requires a configured runtime, scopes, intents, and tests. *Webhook* is a channel-scoped credential and is not automatically connected to Manus or a scheduler. *Sandbox/file tools* process user-authorized files and may run remotely. *Manual guidance* lets the user operate their normal account without Manus automating it. My Browser and Computer Use remain technical capabilities, but they are not approved normal-account Discord execution routes here.

**Computer Use display markers**: none for normal-account Discord work under the current policy evidence. A future written product/legal exception would require a new route review and disposable O1 before any CU card could be marked.

Read `formats/desktop_runtime.md` for runtime boundaries, `formats/route-contract.md` for status and precedence, and `formats/verification-manifest.md` before declaring completion. The table above is the canonical per-card route and completion contract.

## Step 2: Output and verification gates

1. Structural work starts with a snapshot and a confirmed blueprint: channel tree, role hierarchy, permission intent, and object-level change plan. The receipt records created, changed, skipped, and failed objects.
2. Permission work distinguishes guild roles, role hierarchy, channel overwrites, inaccessible state, and uncertainty. Never claim completeness from a partial view.
3. A recurring webhook or bot workflow is executable only after secure secret storage, runtime exposure, permissions, idempotency, timeout handling, revocation, and one test event are proven.
4. Long reads use a channel/thread/message cursor and report inaccessible or partial history. No reaction, mark, post, or moderation action is allowed in a read-only digest.
5. Data Package workflows preserve the original archive, minimize exposure, and record source counts and parse exceptions. Do not use the personal package as a pretext for scraping other members or arbitrary server history.
