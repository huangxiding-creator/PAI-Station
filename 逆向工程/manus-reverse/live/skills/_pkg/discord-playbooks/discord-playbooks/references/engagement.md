# Engagement (Cards 3, 6, and 7)

## Card 3: Bot selection and configuration

**Use when**: choose an existing bot or design a custom app for moderation, tickets, welcome, commands, or another reusable job.

**Procedure**:

1. Define required events, actions, channels, users, data retention, volume, budget, and failure behavior.
2. Research current candidates at execution time. Compare publisher identity, maintenance, pricing, permissions, privileged intents, data policy, uninstall path, and feature fit. Do not reuse stale free-tier or dashboard claims.
3. Preview the exact authorization scopes and server. Reject overbroad permissions or unexplained administrator access.
4. The user performs OAuth authorization and permission grants after preview. Configure only through a verified vendor/runtime or build a custom app only after runtime, deployment, secret, and test contracts are complete.
5. Trigger a minimum-permission test, denied-permission test, and uninstall/revoke test in the disposable server.

**Verification**: required tests pass, permissions match the approved minimum, and removal leaves no unintended role, webhook, command, or secret.

## Card 6: Announcements and reusable notifications

**Use when**: publish once in a channel or create a reusable, channel-scoped notification path.

**Route choice**:

- one-off normal-account post: manual guidance only;
- simple reusable channel posting: incoming webhook only after the full runtime gate passes;
- event listening, interaction, or richer permission logic: official app/bot.

**Procedure**:

1. Confirm exact channel, webhook or bot identity, content/template, embeds, mentions, audience, and timing. `@everyone` and `@here` have a separate blast-radius gate.
2. For a manual one-off post, deliver the exact preview, target, and mention policy for the user to publish.
3. For a webhook, verify creation authority, create it through an approved user handoff in a disposable channel, place the URL into an approved secret store, and retain only a non-secret identifier.
4. Verify invocation runtime and scheduler when needed. Discord's webhook endpoint does not provide a generic idempotency-key field, so implement application-level dedupe over destination and payload hash.
5. Send one test with a response mode that returns the saved message. Verify resulting message ID, body, target, allowed mentions, and payload hash. On timeout, inspect before retrying.

**Fallback**: if secure secret storage, scheduler, or invocation is not proved, provide setup guidance or a manual one-off post; do not claim autonomous recurrence.

## Card 7: Activity digest

**Use when**: summarize selected channels, threads, forums, or moderation activity over a bounded period.

**Route choice**: a verified official bot/app for scoped reads when installed, permissioned, deployed, and able to access the required message content. Otherwise use supplied authorized files or give the user a manual selection/export workflow; do not automate the normal account.

**Procedure**:

1. Confirm channel/thread set, time range, focus, excluded private areas, and expected output.
2. Read only through the approved identity/runtime without reacting, posting, marking, or moderating. Keep a per-channel/thread/message cursor.
3. Separate decisions, unanswered questions, incidents, member requests, and moderator actions. Cite channel and timestamp.
4. Report inaccessible channels, partial history, edits, thread/forum gaps, and privileged-intent limits.
5. Reconcile sampled source items and store a resumable cursor.

**Verification**: source traceability passes; excluded areas remain unread; Discord write count is zero; inaccessible channels and message-content/intent limitations are explicit.
