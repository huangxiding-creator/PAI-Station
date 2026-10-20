---
name: outlook-playbooks
description: "Use when the user asks what Manus can do with Microsoft Outlook, names Outlook for mail, calendar, client-setting, or archive work, or needs to choose among the checked Outlook connectors, sandbox files, My Browser, Outlook Desktop, and guidance. Routes triage and search, new drafts or sends, bounded calendar operations, preservation, signatures, organization, PDFs, local archives, and version decisions while separating code-shipped handlers from current account availability and operation proof."
---

# Outlook Playbooks (Manus for Outlook)

Route by the exact operation and durable state. The current Manus connector surface is narrower than Microsoft Graph. A schema in source code does not prove that the connector is enabled, authenticated, exposed in this task, or behaviorally verified on the user's account.

## Step 0: Establish the available surface

Before relying on a connector:

1. Confirm the intended Outlook Mail or Microsoft Calendar connector is enabled for this task.
2. Confirm the intended account is authenticated and selected.
3. Inspect the tools exposed in the current task; never infer a missing tool from general Graph documentation.
4. Prefer a minimal read-only smoke test before relying on result semantics.

The checked code currently bounds the surface to:

```text
OUTLOOK MAIL
  Search the default user's messages.
  Read selected message IDs and attempt attachment download.
  Prepare new plain-text messages for save-as-draft or explicit send.

OUTLOOK CALENDAR
  Search the default calendar only.
  Get an event from the default or named calendar.
  Create or delete events with explicit confirmation and item-level checks.
  Do not use connector update: the checked handler can ignore cancellation.

NOT IN THE CHECKED CONNECTOR SURFACE
  Reply-in-thread, HTML composition, folder/category/rule mutation, contacts,
  shared-mailbox selection, exact message export, signatures, Quick Steps,
  free/busy, room discovery, reminders, or client settings.
```

## Step 0.5: Safety and privacy

1. Default to drafts. Sending requires approval of the exact recipients, subject, body, and attachments immediately before the action.
2. Calendar create and delete require an exact preview and explicit approval; connector update is blocked.
3. Do not bulk-delete or silently reorganize mailbox state.
4. Work on copies of local archives and report extraction limits per format.
5. Minimize access to unrelated mail, credentials, verification codes, and security notices.
6. Refuse campaign-style mailbox sending and route to consent-aware campaign infrastructure.

## Step 1: Routing map

| The user wants | Card | Read | Current route |
|---|---|---|---|
| Understand and prioritize the inbox | A1 Inbox triage | `references/mailbox.md` | Mail connector read + sandbox report after current-session exposure, auth, and a scoped invocation receipt |
| Find mail Outlook cannot find | A2 Default-mailbox search | `references/mailbox.md` | Mail connector after current-session exposure, auth, and a scoped invocation receipt; C1 only for file-only mail |
| Prepare or send a new message | A3 New draft or send | `references/mailbox.md` | Mail connector after current-session exposure/auth; draft first and verify every item; UI only after exact O1 proof |
| Search, inspect, create, or delete calendar events | A4 Calendar events | `references/mailbox.md` | Calendar connector after current-session exposure/auth and operation-specific receipt; update blocked |
| Preserve messages or build an evidence package | A5 Preservation package | `references/mailbox.md` | Connector + sandbox after a scoped read receipt for derivatives; exact UI export held |
| Configure signatures | B1 Signatures | `references/client-config.md` | Candidate My Browser/CU route after product-specific O1 proof |
| Configure folders, categories, rules, or Quick Steps | B2 Organization | `references/client-config.md` | Candidate My Browser/CU route after object-specific O1 proof |
| Create message PDFs | B3 Print and PDF | `references/client-config.md` | Connector + sandbox for derivatives; CU only for O1-proven Outlook rendering |
| Read a local PST, OST, or OLM archive | C1 Local archives | `references/archives.md` | Per-format sandbox route after parser fixture passes |
| Compare classic, new, Mac, and web Outlook | D1 Version guidance | `references/guidance.md` | Evidence-dated guidance; live inspection only after exact O1 proof |
| Choose a route across platforms | D2 Platform routing | `references/guidance.md` | Guidance followed by the available bounded channel |
| Send a campaign from Outlook | E1 Bulk-send request | `references/guidance.md` | Refuse and redirect |

Read `formats/route_contract.md` before choosing a card, `formats/channel_boundary.md` before choosing a channel, and `formats/desktop_runtime.md` before using My Browser or Computer Use.

## Step 2: Universal completion gates

1. State which connector, browser, desktop, file, or guidance route was actually used.
2. For connector work, reconcile requested IDs and every item-level result; an outer success is not aggregate success.
3. For UI work, verify the exact Outlook state and reversal on the selected product/version. Dispatch or a visible click is not completion.
4. For file work, verify source hash, counts, date range, attachment handling, and format-specific limits.
5. Label a Manus-created report as a derivative; never call it original MIME, `.eml`, PST, OST, or OLM.
6. Report caps, skipped items, unsupported branches, and unverified operations instead of presenting partial work as complete.
