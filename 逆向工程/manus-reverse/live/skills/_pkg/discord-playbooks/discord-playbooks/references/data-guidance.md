# Data and settings guidance (Cards 8 and 9)

## Card 8: Personal Data Package and archive organization

**Use when**: request a copy of the user's own Discord account data and organize it after delivery.

**Route boundary**: requesting the package is an asynchronous normal-account flow and therefore manual guidance. Current first-party guidance says the account needs a verified email address, delivery can take up to 30 days, and a new request cannot be submitted until the current one finishes. Desktop/browser lets the user choose requested data; mobile requests all data. File processing starts only after delivery.

**Procedure**:

1. Explain that this is the requesting account's personal package, not a complete export of every server or other people's content.
2. Confirm the account has a verified email, choose requested categories on desktop/browser or explain the all-data mobile scope, define sensitive-data handling, and choose the intended output location.
3. Give the user the current manual request checklist and explain the final submission boundary; do not automate the normal account.
4. Have the user report the observed request state. If a request is already active, wait for it to finish; do not submit a duplicate. Warn that disabling or deleting the account before delivery cancels the request and that the link goes to the email attached when the request was made.
5. When the package arrives, preserve the original archive, inventory files and counts, detect schemas, build a searchable index, and report parse exceptions.

**Privacy**: the package can contain sensitive account, session, payment, and communication data. Minimize scope and avoid broad sharing or unnecessary copies.

**Verification**: verified-email and request state are recorded; the selected category scope is preserved; original package hash is preserved; indexed object counts reconcile to detected source files.

## Card 9: Evidence-gated settings walkthrough

**Use when**: the user asks where a Discord setting is or wants a short demonstration.

This is a routing shell, not a promise that every setting has one stable path. Security, account, server, channel, event, notification, template, Stage, invite, streaming, and subscription settings have different authority and consequence models.

**Procedure**:

1. Name the exact setting, account/server scope, intended outcome, authority, OS, selected Web/Desktop surface, and current version.
2. Look up or inspect a current first-party procedure. If no current O2 procedure or O1 event exists, give high-level guidance and detect the control live; do not invent a path.
3. Classify the final action: read-only navigation, personal preference, security/2FA, server mutation, public event, or purchase. Apply the matching confirmation and credential boundary.
4. Provide a manual one-setting checklist. The user verifies the resulting state; capture a versioned non-secret step card without coordinates or account identifiers.

**Recordability**: normal-account Discord UI automation is not recordable under the current policy evidence. A future written exception would still require one current Mac or Windows O1, postcondition, and recovery path.
