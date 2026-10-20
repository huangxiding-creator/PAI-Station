# Masters, Layouts, and Theme State (Card C1)

This card applies only when the PowerPoint-native master/layout/theme state is the deliverable. A visual redesign that can be reconstructed in a new Slides project is a different route.

## Required inputs

- approved fonts, colors, logo assets, and placement rules;
- required layout inventory and intended use for each layout;
- representative slides that exercise each layout;
- a working-copy deck and a rollback copy.

## Route gate

First probe whether the presentation runtime exposes master and layout objects and can preserve the hierarchy through an import-edit-export-reopen fixture. Use that route when the representative descendant slides pass. Use CU only after that route fails to preserve required PowerPoint-native inheritance and a current operation record proves the path for the installed OS and PowerPoint version. Until then, provide an audit and implementation plan rather than claiming execution.

Microsoft's current desktop guidance establishes an O2 candidate contract: Slide Master view owns master/layout changes, descendant layouts can require reapplication after a layout edit, and a reusable template is built from a master plus layouts. That documentation is not O1. Do not execute or record the path until the exact build proves descendant impact, save/reopen behavior, and rollback.

Any verified native or CU operation must cover:

1. inventory of masters, layouts, and slide assignments;
2. creation or repair of one disposable master/layout change;
3. reassignment or inheritance on representative slides;
4. save, close, reopen, and visual verification;
5. rollback when a change alters more slides than expected.

Never remove a master or reassign slides merely because it appears unused in a superficial scan. Confirm slide and layout references. Never invent brand values.

## Output

Deliver the updated working copy, a layout inventory, representative before/after renders, and a short usage note. Clearly state which slides inherit the intended layouts and which exceptions remain.
