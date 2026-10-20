# Power BI Desktop runtime boundary

This package contains no current-build Power BI Desktop O1 procedure and no reproduced Desktop Bridge run. Do not infer or execute an exact menu, control, coordinate, dialog, conversion, refresh, capture, model, render, or save sequence from this package.

## Current status

- Product platform: Windows only.
- Installed app identity and version: unresolved for the executing host until runtime discovery.
- Power BI-specific Computer Use event: absent from this package.
- Power BI recording event: absent from this package.
- Concurrent CU: not allowed; the Desktop control lease is serialized.

## Conditional official Desktop Bridge

Microsoft publishes a Windows-local preview bridge that uses a per-process named pipe and a narrow command/method surface. Treat it as unavailable unless the target session proves all of the following:

1. the intended Power BI Desktop process and file are unambiguously identified;
2. the preview bridge is enabled for that exact build;
3. an official bridge client or CLI is installed and callable through an authorized host-local route;
4. the live manifest exposes the exact method needed;
5. the current file path and unsaved-change state are read before open or reload;
6. the operation runs serially and returns an observable receipt;
7. the copied fixture has an independent rollback and postcondition.

The documented bridge can support a bounded status, open, reload, or screenshot handoff. It does not by itself create PBIR/TMDL changes, edit visuals, modify a semantic model, operate Power Query, publish, or prove interaction behavior. Microsoft's separate authoring skills and plug-ins are upstream products, not automatically installed Manus skills.

## Required gate before a future Desktop procedure

A separate validation record must name:

1. Windows host and OS build;
2. installed Power BI Desktop edition and version;
3. canonical app identity returned by runtime discovery;
4. disposable fixture and unmodified original;
5. exact precondition and observed control path;
6. durable postcondition after save, reopen, or refresh;
7. failure, retry, rollback, and user-takeover result;
8. screenshots or event receipts that do not expose secrets.

Until all eight exist for a UI operation, explain that Desktop UI execution is live-blocked and use a bounded file, analysis, cloud, Bridge, or guidance route. A first-party procedure alone does not satisfy this gate. A Bridge operation additionally requires every condition in the Bridge section above and must be reported as a host-local protocol action, not Computer Use.

Stop immediately if the desktop is locked, a UAC secure desktop appears, the app is elevated beyond the helper's integrity level, or the target cannot be distinguished from a production object.
