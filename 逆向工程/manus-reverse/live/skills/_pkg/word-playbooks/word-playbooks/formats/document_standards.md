# Document Standards

## 1. New versus retained files

- For a new document, use real styles, list numbering, sections, tables, captions, and links rather than visual lookalikes.
- For an existing document, treat the source as design and state authority. Make minimal local changes after inventorying package features that must survive.
- Work on a separate output unless the user explicitly approves replacement.

## 2. Structure

- Headings use Heading styles; numbering is defined at list level.
- Sections carry page geometry, margins, headers/footers, orientation, and page-number behavior.
- Paragraph spacing replaces empty-paragraph layout hacks.
- Distinguish static clickable navigation from a true TOC field.
- A true TOC field can be inserted natively, but current TOC/PAGE/NUMPAGES cached results need a compatible evaluator. SEQ/REF display values have bounded native materialization support.

## 3. Preservation contract

Do not promise blanket byte identity after transforming a DOCX package. Instead record and test the relevant state:

- source/output hashes and package integrity;
- text and heading/list structure;
- styles/direct formatting within and outside scope;
- sections and header/footer linkage;
- relationships and media hashes;
- fields, bookmarks, controls, comments, revisions, notes, protection, and metadata;
- page count and every rendered page.

Broad style normalization can remove intentional emphasis. Template-style application can change pagination or overwrite colliding style IDs. Require scope approval and report measured deltas.

## 4. Format boundaries

- Legacy `.doc` needs a compatible conversion before DOCX-native editing.
- The bundled PDF/render route uses headless LibreOffice. Exact Microsoft Word layout requires a Word-produced comparison when that is the acceptance target.
- Plain-text content controls are supported; richer control families require separate evidence.
- Multi-document body append is safe only for compatible sources whose unsupported package state is absent or deliberately rebuilt.

## 5. Delivery verification

1. Validate DOCX ZIP, content types, and internal relationships.
2. Reconcile card-specific semantic assertions.
3. Render and inspect every page, or disclose why no render is available.
4. Report field types and actual evaluation/materialization status.
5. Deliver the change/loss report, output count, and skipped items.
