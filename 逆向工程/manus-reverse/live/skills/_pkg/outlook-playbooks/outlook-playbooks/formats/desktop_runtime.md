# Desktop and Browser Runtime

Computer Use and My Browser are transports. Neither proves that a particular Outlook operation exists or works.

## 1. Choose the actual surface

- My Browser operates the user's connected signed-in Chrome session.
- Computer Use operates an installed desktop client.
- Classic Windows, new Windows, Mac, and web Outlook have different state and controls.
- Record OS, exact product/edition/version, account type, tenant constraints, language, and available tools before operation-specific work.

## 2. Operation gate

Use a UI route only when the connector cannot preserve the required state or the user explicitly requests an in-app demonstration. Autonomous mutation requires an O1 record for the exact product, version, account type, operation, and retained postcondition. Then:

1. Detect the exact Outlook surface and target object.
2. Confirm My Browser or Computer Use is available in this task.
3. Resolve the required O1 procedure for that exact product/version/operation.
4. If no O1 procedure exists, perform only bounded read-only inspection, explain the gap, guide, or stop.
5. Capture before state, perform the smallest mutation, refresh state, verify the semantic postcondition, and preserve a reversal path.

Do not use generic CU capability as proof of signature, rule, Quick Step, print, export, or archive behavior.

## 3. Hybrid handoff

1. Use connector search/read to identify messages when the current schema covers the source.
2. Carry stable message IDs and visible metadata into the next route.
3. Perform only the operation unavailable in the connector.
4. Verify the retained state in the authoritative surface.
5. Use sandbox artifacts for indexes, reports, derivative PDFs, and extracted files when Outlook rendering is unnecessary.

## 4. Privacy and consequential actions

Keep screenshots and reads scoped to the target. Do not expose unrelated messages, codes, credentials, or security notices. Sending, invitations, deletion, and production settings require exact previews and explicit approval. Report every mutation and cleanup result.
