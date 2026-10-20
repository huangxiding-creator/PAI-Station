# Writer Desktop and Browser Runtime

## 1. File and app availability are separate

- A DOCX is directly reachable only when attached, retrieved through an available storage route, or inside a folder explicitly shared with Manus Desktop.
- Detect which compatible writer is installed and which app owns the relevant extension separately. Word, WPS Writer, LibreOffice Writer, or another app may own the association.
- On macOS, Word commonly identifies as `com.microsoft.Word`; on Windows, inspect the installed app and per-user association rather than assuming.
- Missing Word blocks only a Word-native tail. Missing WPS Writer or LibreOffice Writer likewise blocks only that product's app-native tail, not ordinary artifact creation or file-native edits.

## 2. Native Documents route first

Use the bundled Documents runtime for the file itself. It supports both new authoring and preservation-sensitive retained edits, with render/inspect QA. The Manus Office preview converts to a read-only preview; it is not a DOCX editor. A storage connector can fetch/deliver a file but does not become a Word content connector.

## 3. Resolve the writer family before any UI route

Branch on the exact selected product, not merely on file compatibility:

- **Microsoft Word:** Word semantic Compare/Combine, Word-evaluated layout fields, Word mail-merge state, and rich Word controls remain Word-specific.
- **LibreOffice Writer:** native ODT/OTT styles, page styles, templates, Writer/Base data-source state, and LibreOffice-specific round-trip acceptance remain Writer-specific. A bundled LibreOffice renderer does not prove the user's installed Writer GUI or exact Word compatibility.
- **WPS Writer:** WPS regional distribution, account/plan, WPS Cloud/local state, macro environment, and WPS-specific round-trip acceptance remain WPS-specific.
- **Other or unknown writer:** deliver a standards-based artifact with compatibility notes. Do not infer an app-native route.

The default app is a delivery preference and compatibility signal. It does not by itself authorize Computer Use or prove that the app preserves the requested state.

## 4. When a writer UI route is justified

Use an installed writer through Computer Use only when the required durable state is native to that exact writer and the exact operation has an O1 live record on the selected product/distribution, OS, version, locale, and state. Current Word candidates include:

- Word-evaluated TOC/PAGE/NUMPAGES results when current Microsoft layout is required;
- existing native mail merge, labels, envelopes, or merge-to-email state;
- Word semantic Compare/Combine output;
- one specific rich content-control type not covered by the helper;
- one O1-evidenced Word recovery routine;
- an explicit in-app lesson for a procedure already qualified.

LibreOffice Writer and WPS Writer procedures need their own product-specific O1/O3 records and verifiers; a Word record never transfers to them. These are candidate classes, not a claim that the procedures are live-tested. Without the required record, use a compatible artifact route, guide, or hold.

## 5. Operation contract

1. Record OS, exact writer and distribution, version, locale, app identity, default association, file access, protection/read-only state, and current CU exposure.
2. Work on a synthetic fixture or saved copy.
3. Resolve a semantic procedure for the exact operation; do not invent menus.
4. Capture before state, perform the smallest app-only tail, save separately, reopen, and verify structurally outside the writer and in the recipient ecosystem when compatibility is the outcome.
5. Test wrong app, protected file, stale data source, compatibility mode, modal dialog, and cancellation/recovery paths.

## 6. Web writer surfaces

My Browser can operate the user's connected signed-in browser only when it is available in the task. Autonomous mutation also requires an O1 record for the exact product, web operation, account/plan, and retained state. Never transfer a desktop path to Word for the web, WPS Online, or another web editor; infer retained-package parity; or describe My Browser as CU.
