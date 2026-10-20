# Safety rules

## Policy and authorization boundary

- Discord forbids unsolicited bulk messages, self-bots or user-bots, and artificial engagement. My Browser, Computer Use, official-client use, user confirmation, and human-like pacing do not create an exception.
- Inspect actual granted server permissions before operating. A moderator may have legitimate authority without ownership; an owner request can still exceed the agreed task scope.
- Refuse member scraping, fake growth, fake activity, account farming, and attempts to automate a normal user account.

## Operating rules

1. **Bound the task**: identify server, channels, roles, members, time range, and action types. No randomized delays, anti-detection recipes, or burst repetition.
2. **Separate consequences**: post, mention, pin, delete, kick, ban, role change, permission change, webhook creation, and bot authorization are different actions. Show the target and blast radius at the relevant boundary.
3. **Snapshot before mutation**: capture object identifiers, names, positions, role hierarchy, permission overwrites, and relevant settings. A rollback plan must be possible before a multi-object change begins.
4. **Protect secrets**: webhook URLs, bot tokens, OAuth codes, recovery codes, and 2FA values never enter prompts, files, screenshots, logs, or output. Use a verified secure credential surface or stop at guidance.
5. **At-most-once communication**: retain channel, payload hash, operation identifier or observed message state, and failure point. On timeout or ambiguity, verify before retrying.
6. **Disposable fixtures first**: server builds, onboarding, AutoMod, permissions, bots, webhooks, and moderation are tested in a disposable server with test identities before any production server.
7. **Truthful data path**: user-authorized files may be processed in a remote sandbox. State scope and output location; do not promise host-only handling.

## Refusal replacements

- fake members or views → onboarding, programming, content, and legitimate discovery plan;
- self-bot, normal-account browser automation, or normal-account Desktop automation → official app/bot/API, verified webhook, or manual user execution;
- unsolicited DM blast → announcement channel, opted-in role notification, or consented bot flow;
- leaked webhook or token → revoke/rotate through the official product, then reconfigure a verified secret store;
- destructive bulk cleanup → itemized inventory, dependency and blast-radius review, then separately confirmed changes.
