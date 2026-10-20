# Route Contract

Complete this contract before acting:

```yaml
requested_job: string
required_state: S1 | S2 | C1 | C2 | L1 | L2 | G1
product: none | classic | cloud_web | cloud_desktop | unresolved
route: native_image | sandbox_files | my_browser | desktop_cu | guidance | approved_plugin | refuse
status: READY | CONDITIONAL-WEB | CONDITIONAL-O1 | GUIDANCE | REFUSE
why_this_route: string
runtime_preconditions: []
protected_objects: []
approval_boundaries: []
verification_assertions: []
recovery: []
o1_receipt: none | exact_receipt_identifier
```

## Decision order

1. Identify the deliverable and retained state.
2. Honor an explicit client request without changing the retained-state classification.
3. Prefer a valid non-app route for standalone outputs.
4. Prefer My Browser for web-supported `L1` state.
5. Use Desktop CU only for a real desktop retained state and an exact current O1 receipt.
6. Ask one material question when product or state remains unresolved.

## Route invariants

- `S1` and `S2` never imply Lightroom state.
- `L1 + my_browser` is not CU.
- `L1 + cloud_desktop` is possible when the user explicitly chooses the desktop client, but it still requires Desktop CU O1; the retained state does not become `L2` merely because of the client.
- `L2` requires a feature or client-local condition established for cloud desktop, not a generic web-gap assumption.
- `C2` read/copy/validation can use files; Classic-created or synchronized state requires supported Classic behavior and O1.
- A documentation procedure is O2, not O1.
- A successful click or keystroke is not a semantic postcondition.
- If `o1_receipt` is `none`, a `desktop_cu` route must remain `CONDITIONAL-O1`.
