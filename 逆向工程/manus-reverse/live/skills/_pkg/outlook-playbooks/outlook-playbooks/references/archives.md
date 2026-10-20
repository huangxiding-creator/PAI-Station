# Local Archives (Card C1 and damage guardrail)

Archive execution is qualified per format. Parser availability is not parser success.

**Primary channel**: prefer the authenticated Mail connector when the mail is still available there; otherwise HOLD until a parser passes an O3 fixture for the exact archive format/version, then use the sandbox on a verified copy.

**Escalation trigger**: damage, encryption, unsupported format/version, parser mismatch, or a need to import or authoritatively open the result in Outlook.

**Hybrid handoff**: copy and hash first, use only the fixture-qualified parser, and reserve any client export/import/open tail for a separate exact O1 procedure.

**Fallback**: OLM and any unsupported PST/OST branch stop with export/import guidance or a user-approved specialist handoff.

**CU display**: no. Computer Use is not a parser and no archive workflow has Outlook O1 evidence.

## Common preflight

1. Confirm the mail is not more safely available through the authenticated mailbox connector.
2. Put the archive inside the shared folder and create a verified copy.
3. Record original and copy hashes, size, format, and expected provenance.
4. Run only a parser that has passed an O3 synthetic fixture for the selected format/version.
5. Reconcile folders, messages, dates, Unicode, HTML normalization, and attachment hashes against an answer key.

## PST

PST is a candidate sandbox route only after the available parser passes a generated PST fixture. Do not infer completeness from tool installation. Preserve source identifiers and report unsupported fields.

Microsoft currently documents mailbox export to PST in new Outlook for Windows and classic Outlook, while import and some PST object types remain product-dependent. Treat this as O2 guidance for selecting a product/version test. It does not qualify parser completeness, autonomous export, or import through Manus.

## OST

Treat OST separately from PST. Run only on a legally created disposable fixture and only when the selected parser explicitly supports it. Do not claim the extracted result can be imported back into Outlook.

## OLM

OLM is unsupported until an actual parser and current synthetic fixture pass. Provide export/import guidance or a user-approved specialist handoff instead of claiming generic extraction.

## Damaged archive guardrail

Damage handling is not an advertised Manus repair capability.

1. Check mailbox/backups first.
2. Never run repair against the only copy or the original.
3. Explain that recovery can be incomplete and obtain explicit approval before a first-party utility.
4. Preserve original, safety copy, recovered output, and separate hashes.
5. Inventory whatever survives; do not promise restoration.

**Completion**: original hash remains unchanged; output counts and attachments reconcile or gaps are explicit; unsupported formats stop safely.
