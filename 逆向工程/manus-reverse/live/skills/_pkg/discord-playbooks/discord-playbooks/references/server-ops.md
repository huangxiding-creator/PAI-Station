# Server operations (Cards 1, 2, 4, and 5)

## Shared change contract

Use a disposable server first. Capture server identifiers, channel tree, role hierarchy, guild permissions, channel overwrites, onboarding state, and AutoMod rules before mutation. A blueprint is approved before execution; each object has a postcondition and rollback note.

## Card 1: Build or restructure a server

**Use when**: create a new community structure or clean up an existing server.

**Route choice**: guidance by default. Execute only through a verified official app/bot API with a disposable server, configured identity, minimum scopes, object receipts, and rollback. Normal-user-account My Browser/CU automation is not a route.

**Procedure**:

1. Define community purpose, expected size, public/private areas, moderation model, events, integrations, and retention needs.
2. Inventory an existing server into a source-completeness-labeled text tree and permission matrix. Do not call it an official export.
3. Produce a blueprint: categories, channels, topics, role hierarchy, effective permission intent, onboarding dependency, and staged migration order.
4. Identify risky operations: moving active channels, changing visibility, role reordering, deletions, webhook/bot dependencies, and permission overwrite changes. Get approval for the blueprint and risk list.
5. If the official runtime gate passes, execute in small checkpoints and verify object identity/effective access after each category or role batch. Otherwise deliver the blueprint and manual checklist.
6. Deliver an actual-change receipt with skipped, failed, and uncertain items. Deletions remain a separately confirmed cleanup phase.

**Verification**: actual tree and permission intent match the approved blueprint; test-owner, moderator, member, and newcomer identities see only the expected areas.

## Card 2: New-member onboarding

**Use when**: configure onboarding prompts, default channels, role choices, rules, or a newcomer journey.

**Procedure**:

1. Define the first-minute outcome, default channels, questions, choices, role bindings, rules, and exit path.
2. Confirm that the disposable test server, configured app identity, permissions, and current onboarding constraints pass. The current API validation expects at least seven default channels and at least five where `@everyone` can send; recheck this live rather than assuming it will remain fixed.
3. Create an expected onboarding object and test-identity journey before changing the UI.
4. Configure one section at a time only through the verified official runtime. Otherwise provide a manual checklist and expected-object oracle.
5. If Discord returns a validation constraint, surface the exact constraint and stop; do not repeatedly click Save or rely on an old bug workaround.
6. Run the journey with a consented test member and compare channels, roles, and prompts to the expected object.

**Recovery**: preserve the prior onboarding snapshot; revert only the objects changed by this run.

## Card 4: AutoMod and moderation configuration

**Use when**: configure keyword, mention, spam, or other detected AutoMod rule types.

**Procedure**:

1. Define risk, languages, trigger, action, alert destination, exempt roles/channels, and acceptable false-positive tolerance.
2. Snapshot existing rules and build a harmless positive/control corpus. Do not test with real abuse or unsuspecting members.
3. Create one new rule only through the verified official AutoMod API runtime. Otherwise provide the rule plan and manual test checklist.
4. Run positive, negative, and exemption samples with a test identity. Report measured results; never claim zero false positives from a tiny corpus.
5. Tune only the new rule. If unexpected blocking occurs, disable or remove that rule and restore the snapshot.

## Card 5: Effective-permission audit

**Use when**: diagnose who can see, post, manage, mention, or moderate in specific server areas.

**Procedure**:

1. Confirm server, roles, channels, threads, and actions in scope. This is read-only.
2. Collect guild roles, hierarchy, base permissions, channel overwrites, and inaccessible objects through a verified official app/bot inventory. Record data-source completeness; a manual screenshot/UI sample remains explicitly partial.
3. Compute or inspect effective permission per role/channel/action. Do not substitute a generic list of common holes for actual state.
4. Rank findings by blast radius and cite exact role, channel, overwrite, and resulting capability.
5. Deliver remediation options separately; mutation requires a new confirmed change plan and test identities.

**Verification**: answer-key identities in the disposable server produce the expected effective access; incomplete or inaccessible state is explicitly marked.
