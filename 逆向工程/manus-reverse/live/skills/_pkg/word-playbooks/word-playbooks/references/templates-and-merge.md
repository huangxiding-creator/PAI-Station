# Templates and Data-Driven Documents (Cards C1, D1, D2)

## Card C1: Reusable template system

**Primary channel**: Documents runtime for styles, layout, and plain-text content controls.

**Escalation trigger**: the required retained asset contains dropdown, checkbox, date, repeating-section, image, table, or other rich control behavior not covered by the helper.

**Hybrid handoff**: build/test the native tier first; use one independently proved Word operation for one rich-control type at a time.

**Official O2 boundary**: Microsoft documents Word-native checkbox, date-picker, combo-box, and drop-down content controls and their properties. This establishes feature existence and candidate controls, not a reusable Manus procedure. Qualify each rich-control family separately on the exact Word surface before execution or recording.

**Workflow**
1. Define document types, brand system, variable fields, users, and downstream automation expectations.
2. Build styles, theme, sections, headers/footers, static content, and plain-text controls with unique tags/titles.
3. Test short, long, blank, Unicode, and duplicate-tag cases.
4. For a retained DOCX/DOTX, inventory controls and preserve unrelated package state.
5. Deliver a sample and usage contract; do not imply unsupported controls exist.

**Verification**: unique tag/title inventory, fill/reopen tests, full render, output behavior, and explicit unsupported control list.

## Card D1: One document per data row

**Primary channel**: Documents runtime plus spreadsheet tooling.

**Escalation trigger**: the user must retain an existing native Word merge main document, labels/envelopes, or merge-to-email state.

**Hybrid handoff**: `excel-playbooks` cleans/maps data; Documents runtime fills a tested template and creates files; D2 owns only true Word-native merge state.

**Workflow**
1. Confirm combined versus one-file-per-row output, filename rule, DOCX/PDF outputs, and template authority.
2. Validate columns, blanks, Unicode, dates/currency, duplicates, and illegal filename characters.
3. Map fields using stable placeholders or plain-text controls; preserve a retained template's unrelated state.
4. Produce one approved sample, then run the batch.
5. Report counts and skipped rows; sending is a separate Outlook workflow.

**Verification**: input/output counts, unique safe filenames, placeholder completeness, first/middle/last value checks, and full renders for representative edge cases.

## Card D2: Native Word mail merge

**Primary channel**: guidance/HOLD; Word through Computer Use becomes available only after an exact app/OS/version O1 procedure passes.

**Escalation trigger**: none. If one-file-per-row artifacts satisfy the goal, route to D1 instead of escalating to Word.

**Hybrid handoff**: native file/spreadsheet tooling prepares and validates synthetic merge data; an O1-qualified Word route owns the existing main document, label/envelope layout, or merge preview; Outlook owns any send.

**Official O2 boundary**: Microsoft documents the mail-merge model as a main document plus a recipient data source and merge fields, with preview before completion. Use that model to design fixtures and verification. It does not authorize autonomous Word interaction, printing, or email delivery.

**Workflow contract**
1. Detect installed Word, version, existing merge state, data-source reachability, and target letters/labels/envelopes/email output.
2. Use only an O1-qualified procedure; without one, provide a plan and stop.
3. Preview synthetic first/middle/last records and label/envelope alignment before completion.
4. Save results separately and structurally verify them.
5. For merge-to-email, preview recipients/body and require explicit send approval through the Outlook route.

**Verification**: merge-field mapping, preview samples, stock/alignment, separate output, saved/reopened state, and zero unapproved sends.
