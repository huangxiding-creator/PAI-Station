---
name: word-playbooks
description: "Use when the user asks what Manus can do with Microsoft Word, WPS Writer, or LibreOffice Writer, or needs a word-processing workflow routed by the document state that must survive. Covers creation and editing, structure and formatting, templates and data-driven documents, revisions and comparison, conversion and extraction, diagnosis, and qualified app-native workflows; routes generic artifacts to Documents and app-specific state to the exact installed or web writer only after capability and runtime checks."
---

# Word Playbooks (Manus for Word)

Route by the state that must survive, not by the fact that the user named Word or installed an Office-compatible suite. Manus has a bundled Documents runtime for DOCX creation, retained-file edits, structure inspection, comments/revisions, rendering, and bounded helpers. The Office preview is read-only, storage is file transport rather than a document editor, and generic Computer Use does not prove a procedure in Word, WPS Writer, or LibreOffice Writer.

## Step 0: Classify the durable state

```text
NEW DOCX
  Manus owns the package. Use the Documents runtime and render every page.

RETAINED DOCX
  The source's sections, relationships, media, fields, controls, comments,
  revisions, styles, protection, and unknown OOXML may matter. Inventory first,
  make surgical changes to a copy, and verify the declared preservation scope.

WRITER-NATIVE STATE
  Examples: Word semantic Compare/Combine, native mail-merge state, a rich
  control not covered by the bundled helpers, Word-evaluated layout fields,
  native ODT/OTT styles or templates, or WPS-specific cloud/macro state.
  Use the exact requested writer only after that operation has O1 evidence for
  the product/distribution/OS/version and an observable saved postcondition.
  Otherwise use a compatible artifact route, guide, or hold.

BROWSER STATE
  Use My Browser only for an O1-proved Word-on-the-web operation in the user's
  connected browser. It is not Computer Use, and web access does not prove
  parity with the retained package or the installed Word client.

LESSON
  Teach only an independently closed procedure on a synthetic or copied file.
```

Files are directly available only when attached, retrieved through a storage route, or inside a folder explicitly shared with Manus Desktop. Do not promise universal access to all local files.

## Step 0.25: Resolve the office-suite component

WPS Office and LibreOffice are suites, not single word processors. Route the named component before selecting a card:

| Detected or requested surface | Owning playbook | Default behavior |
|---|---|---|
| Microsoft Word, WPS Writer, LibreOffice Writer | This playbook | Use Documents for ordinary artifacts; preserve app-specific state only through a qualified exact-app route |
| WPS Spreadsheets or LibreOffice Calc | `excel-playbooks` | Follow the spreadsheet-family execution matrix |
| WPS Presentation or LibreOffice Impress | `powerpoint-playbooks` | Follow the presentation-family execution matrix |
| WPS PDF or an ordinary PDF derivative | PDF capability | Use PDF-native creation, inspection, filling, rendering, and verification |
| LibreOffice Base, WPS Cloud/local reconciliation, or suite-specific macro state | Conditional residual research | Do not pretend the Word route owns it; require its own evidence, runtime, and verifier gates |

An installed suite or default file association is an onboarding and delivery signal, not proof that its GUI is the best execution route. Generic DOCX/ODT/RTF work remains artifact-first unless the user explicitly requires app-native state that survives save, close, and reopen.

## Step 0.5: Code-bounded native surface

The checked Documents runtime supports new DOCX authoring; minimal retained edits; text/page-image review; full-page render QA; headings, numbering, sections, captions, bookmarks, and SEQ/REF fields; static clickable navigation; true TOC field insertion without local TOC/PAGE/NUMPAGES evaluation; plain-text content controls; comments; pragmatic tracked-change handling; style lint; bounded template-style application; simple table bridges; and LibreOffice-based PDF rendering.

Important limits:

- Multi-document append is body-only and does not generally merge append-source media, relationships, headers/footers, footnotes, or section state.
- Plain-text content controls are native; dropdown, checkbox, date, repeating, image, and table controls are not covered by the bundled helper.
- Native text/render diff is not Word semantic Compare/Combine.
- Generic retained-document find/replace, damaged-file recovery, and large-document optimization are not closure-grade capabilities yet.
- LibreOffice rendering is not proof of exact Microsoft Word pagination.

## Step 1: Routing map

| User outcome | Card | Read | Current route |
|---|---|---|---|
| Build or repair headings, numbering, sections, TOC, captions, or cross-references | A1 Structure | `references/structure-and-format.md` | Documents runtime; conditional Word field-evaluation tail |
| Merge several documents | A2 Multi-source merge | `references/structure-and-format.md` | Rebuild/compatible native append; complex retained merge held |
| Repair inconsistent formatting | B1 Formatting rescue | `references/structure-and-format.md` | Documents runtime with scoped diff |
| Apply a brand system | B2 Brand restyle | `references/structure-and-format.md` | Documents runtime; rich-control tail conditional |
| Build a reusable template | C1 Template system | `references/templates-and-merge.md` | Native styles + plain-text controls; rich controls conditional |
| Generate one document per data row | D1 Data-driven documents | `references/templates-and-merge.md` | Documents runtime + spreadsheet data prep |
| Use native Word mail merge, labels, or envelopes | D2 Native mail merge | `references/templates-and-merge.md` | Word CU candidate; held until exact O1 proof |
| Report comments or tracked changes | E1 Revision report | `references/revisions.md` | Documents runtime |
| Explain differences or produce Word semantic comparison state | E2 Compare | `references/revisions.md` | Native analysis; Word semantic Compare/Combine conditional |
| Convert PDF, scans, or images into editable DOCX | F1 Convert | `references/conversion.md` | Documents runtime + PDF/OCR tooling |
| Replace text across many retained documents | F2 Batch replacement | `references/conversion.md` | Hold arbitrary scope; tested simple/generated scope only |
| Extract document facts into a table | F3 Extract | `references/conversion.md` | File read/Documents runtime; output follows `excel-playbooks` |
| Diagnose an unreadable or damaged file | G1 Recovery diagnosis | `references/rescue-and-teaching.md` | Forensic copy and diagnosis; recovery route held |
| Diagnose a slow large document | G2 Performance diagnosis | `references/rescue-and-teaching.md` | File-native audits; no generic optimizer promise |
| Show the user how to perform a Word task | H1 In-app lesson | `references/rescue-and-teaching.md` | Only a previously O1-proved Word procedure |

Read `formats/route_contract.md` before choosing a card, `formats/document_standards.md` for every document artifact, and `formats/desktop_runtime.md` before My Browser or Computer Use.

## Step 2: Universal completion gates

1. Record the source hash and never overwrite the source by default.
2. For retained files, name the preservation contract: text, styles, sections, media/relationships, fields, controls, comments/revisions, metadata, and rendered pages as applicable.
3. Verify ZIP/content-type/relationship integrity, semantic assertions, and every rendered page. Disclose when the renderer is unavailable or Word-exact layout remains unverified.
4. Report field state by type; never say all fields are current when only insertion or SEQ/REF materialization was proved.
5. Report file/record counts, skipped items, and loss or unsupported-state reports.
6. Accept/reject revisions, strip metadata, send merged mail, perform lossy recovery, or recompress media only after separate explicit approval.
