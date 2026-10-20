# Channel Boundary

Use this reference to choose a route. Keep code capability, runtime connection, and operation proof separate.

## 1. Code-bounded connector surface

| Surface | Checked operations | Important limits |
|---|---|---|
| Outlook Mail | Search default-user messages; read selected IDs; prepare new plain-text messages for draft or send | No reply/thread ID, HTML body, folder/category/shared-mailbox selector, pagination, mailbox mutation, exact export, or draft CRUD |
| Microsoft Calendar | Default-calendar search; get; create; delete | Search ignores `calendar_id`; no free/busy, rooms, calendar listing, responses, reminders, categories, or sharing; update is blocked because cancellation may be ignored |

The send flow can save a new message as a draft. It is not a general draft-management API. Runtime code may support auto-confirm behavior, so this playbook independently requires exact user approval before sending.

## 2. Three-layer execution gate

```text
L1 CODE
  The exact operation exists in the checked Manus schema and handler.

L2 RUNTIME
  The required connector, addon, or browser is enabled, authenticated, exposed,
  and bound to the intended account or device in this task.

L3 OPERATION
  For a connector, the exact tool is exposed now and a scoped invocation receipt
  proves only the operation that was called. For app or web UI, the selected
  product/version route has exact O1 evidence and an observable postcondition.
  Generic transport and code-shipped schema are not operation proof.
```

If L1 fails, choose another route. If L2 fails, connect or stop. If L3 fails, inspect safely, guide, or stop; do not invent controls.

## 3. Retained-state decision table

| Required surviving state | Primary route |
|---|---|
| Search/read result or new plain-text draft/send | Mail connector after L1-L2 checks |
| Default-calendar search, event get/create/delete | Calendar connector after L1-L2 checks and explicit mutation approval |
| Triage report, index, derivative PDF, or extracted attachment set | Connector reads + sandbox artifact creation |
| Server-visible web setting not exposed by the connector | My Browser only after a product-specific O1 procedure |
| Desktop profile, Quick Step, local client state, or authoritative Outlook rendering | Computer Use only after a product/version-specific O1 procedure |
| PST/OST/OLM content | Sandbox on a copy, after a per-format parser fixture passes |
| Product/version explanation | Evidence-dated guidance |

## 4. Search, batch, and completeness limits

- Mail search defaults to 50 and is capped at 500 in one non-paginated request.
- Mail read accepts up to 100 IDs, batches internally, and can omit failed items from the returned array.
- Attachment download is best effort and can fail independently of message read.
- Calendar create/delete and Mail send can report outer success while individual items contain errors.
- Reconcile every requested ID and item result. Partition capped searches into disjoint user-approved ranges and deduplicate by message ID. Never claim mailbox absence beyond the tested partitions.

## 5. Platform and file boundaries

Classic Outlook for Windows, new Outlook for Windows, Outlook for macOS, and Outlook on the web are separate execution surfaces. Do not transfer a path or feature claim between them without its own evidence.

Local archives must be inside the shared folder. Preserve the original hash and process a copy. A connector-derived report is not an exact message file or Outlook archive.
