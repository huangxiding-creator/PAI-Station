# Mail and Calendar Work (Cards A1-A5)

Apply the three-layer gate in `formats/channel_boundary.md` before execution.

For connector cards, source-reviewed schemas define the eligible operation and parameters; the current session must still expose and authenticate that connector, and an invocation receipt closes only the exact call tested. Reserve O1 terminology for Outlook web or desktop UI procedures.

## Card A1: Inbox triage

**Outcome**: a scoped read-only action report, not mailbox mutation.

**Primary channel**: Outlook Mail connector search/read plus a sandbox report.

**Escalation trigger**: the user asks for mailbox mutation, the intended account is unavailable, or the requested scope is outside the default user's mailbox.

**Hybrid handoff**: the connector identifies messages and the sandbox creates the report; any later UI mutation becomes a separate O1-proved B2 workflow.

**Workflow**
1. Define the intended account and scope using a time range, sender, subject, unread state, or KQL query. Do not imply shared-mailbox or folder/category selection.
2. Run a bounded search and record the exact query and returned cap state.
3. Read only selected IDs. Reconcile requested IDs against returned IDs because failed reads can be omitted.
4. Treat attachment download as best effort; record missing or failed attachment details separately.
5. Classify urgency, action, deadline, and topic in a portable report. Keep mailbox writes at zero.
6. If the user asks for organization changes, open a separate B2 route and require its own operation proof and confirmation.

**Verification**: query, returned count, requested IDs, returned IDs, missing IDs, attachment results, and report rows reconcile; unrelated messages were not read.

## Card A2: Default-mailbox server search

**Outcome**: a re-identifiable index of matching messages when client search is unreliable.

**Primary channel**: Mail connector search against the default user's messages, followed by selected reads.

**Escalation trigger**: use a local-file route when the only copy is in a local archive. Shared/delegated-mailbox selection is not supported by the checked connector.

**Hybrid handoff**: connector results become a sandbox index; a UI is used only for a separately O1-proved operation on selected hits.

**Workflow**
1. Capture sender, recipient, subject, date, keyword, attachment, and unread clues.
2. Run the narrowest query and record it verbatim.
3. If capped, partition into disjoint user-approved date windows or another non-overlapping KQL dimension. Deduplicate by message ID.
4. Read only the strongest hits and return stable metadata.
5. State the tested partitions and never claim absence beyond them.

**Verification**: each delivered hit can be found again by ID and metadata; cap/refinement status and any missing reads are explicit.

## Card A3: New plain-text draft or send

**Outcome**: a new Outlook message saved as a draft by default or explicitly sent.

**Primary channel**: Mail connector send flow. The checked schema supports new plain-text messages, recipients, and sandbox/Slides attachments. It does not preserve reply threading or HTML.

**Escalation trigger**: the request requires a preserved thread, rich HTML, an existing draft, a client template/add-in, or campaign delivery.

**Hybrid handoff**: connector read gathers context and sandbox files prepare attachments; an O1-proved UI route owns only the unsupported compose state.

**Workflow**
1. Search/read source context only when needed.
2. Draft in the requested tone and flag commitments, money, deadlines, and legal positions.
3. Preview exact recipients, subject, plain-text body, and attachment paths.
4. Save as draft by default. Send only after explicit approval immediately before the exact action, even if the runtime can auto-confirm.
5. Inspect every item result for draft flag, message ID, or error; do not trust outer success.

Rich formatting, in-thread replies, desktop templates, and add-ins need a separately proved web/client route. If no such proof exists, stop or provide guidance.

**Verification**: preview and item-level outcomes match one-to-one; cancellation causes zero sends; accurately label the result as a new plain-text message.

## Card A4: Calendar operations

Treat each operation separately.

**Primary channel**: Microsoft Calendar connector for default-calendar search, get, create, and delete after current-session exposure/auth and an operation-specific invocation receipt; update is blocked.

**Escalation trigger**: the task needs secondary-calendar search, update, free/busy, rooms, responses, reminders, sharing, or another absent operation.

**Hybrid handoff**: connector reads establish known event state; a separately O1-proved My Browser/CU route may own an unsupported operation, otherwise guide or stop.

### Search

- Search the default calendar only; the checked implementation ignores `calendar_id`.
- Record range, query, cap, and returned IDs.

### Get

- Get a known event by ID from the default or named calendar.
- Re-read critical time, location, attendee, and recurrence fields before a consequential action.

### Create

- Preview summary, start/end, effective time zone, location, attendees, text description, calendar, and recurrence.
- Attendees are invitation-impacting. Obtain explicit approval.
- Only the first recurrence entry is used by the checked implementation.
- Inspect every item result and re-read each created event.

### Update

- **Blocked.** The checked execution handler can ignore a cancelled confirmation.
- Do not call connector update until the handler is fixed and both cancel-with-zero-patch and explicit-update regressions pass.
- Offer an O1-proved UI route or guidance; otherwise stop.

### Delete

- Fetch and preview the exact original event.
- Require explicit approval; inspect every item result and confirm absence afterward.

**Not available in the checked surface**: free/busy, room discovery, calendar listing, response status, sharing, reminders, and categories.

**Verification**: record event IDs and item-level results; re-read after create and confirm absence after delete; never use outer success as aggregate proof.

## Card A5: Preservation package

Choose the required fidelity first.

**Primary channel**: connector search/read plus sandbox artifacts for a derivative package.

**Escalation trigger**: the user requires original MIME, exact message files, Outlook archives, or authoritative Outlook rendering.

**Hybrid handoff**: connector IDs and metadata seed the artifact index; a product-specific UI route owns exact export only after its O1 procedure is proved.

### Derivative package

Use connector search/read plus sandbox files. Include an index, returned metadata/body, downloaded attachments, source message IDs, and attachment failures. Label it as Manus-created and not original MIME or `.eml`.

### Exact Outlook export

This requires an O1 product/version-specific web or client procedure that produces and reopens the requested files. Generic My Browser/CU availability is not enough. Until that procedure exists, explain the gap and do not promise execution.

**Verification**: source IDs reconcile with outputs; every file opens; format and omissions are explicit; derivative and exact artifacts are never conflated.
