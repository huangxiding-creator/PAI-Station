# Card 1: Culling and Selection

- **Primary channel:** Use semantic review plus Sandbox reporting for a standalone pick list, My Browser for web-supported cloud-library flags and ratings, and Desktop CU only for retained Classic or verified cloud-desktop state under exact O1.
- **Escalation trigger:** Escalate from files or web only when the user requires Classic catalog state, a verified desktop-only feature, or an explicit desktop-client lesson.
- **Hybrid handoff:** Calibrate the judgment rubric and prepare a review list outside Lightroom, then apply only approved state changes through the selected Lightroom surface.
- **Verification:** Reconcile the full scope into keep, reject, borderline, and unprocessed counts; prove persistence in the selected state and zero unapproved deletions.

## Resolve the deliverable

| Requested outcome | State | Route | Status in this package |
|---|---|---|---|
| Pick list, contact sheet, or review report from files | `S2` | Semantic review plus Sandbox report | `READY` after file/runtime preflight |
| Flags, ratings, labels, or collections in Classic | `C1` | Lightroom Classic through Desktop CU | `CONDITIONAL-O1` |
| Flags, ratings, filtering, or albums in cloud Lightroom Web | `L1` | My Browser | `CONDITIONAL-WEB` |
| Named Assisted Culling in Classic | `C1` | Lightroom Classic through Desktop CU | `CONDITIONAL-O1` |
| Named Assisted Culling in cloud Lightroom desktop | `L2` | Cloud Lightroom desktop through Desktop CU | `CONDITIONAL-O1` |
| Named Assisted Culling in Lightroom Web | unresolved | Stop and preflight | Feature presence is unproven; do not infer it from desktop evidence |

## Judgment contract

Culling mechanics and culling taste are different inputs. A recording may teach navigation, comparison, flagging, rating, and review-set mechanics. It does not capture what the user considers sharp, flattering, expressive, unique, diverse, or on-brand.

Before scale, obtain:

- scope and target range;
- product/client and desired state vocabulary;
- written keep, reject, borderline, tie-break, and diversity rules;
- reference picks and any identity-sensitive constraints;
- a stratified calibration sample covering lighting, scene, subject, camera, burst, and failure modes;
- reviewer acceptance of the calibration.

Sample size is risk-based, not a fixed number. Keep uncertainty in a reviewable borderline state rather than forcing a binary decision.

## Workflow

1. Complete the route contract.
2. Calibrate against the supplied rubric and reference picks.
3. Reconcile the in-scope item count before mutation.
4. Execute only the route whose preconditions are met.
5. Reconcile keep, reject, borderline, and unprocessed counts.
6. Prove zero unapproved deletions and preserve a review path.

Assisted Culling may supply candidates; it does not replace the user's taste contract. Do not claim that a recorded workflow has learned taste automatically.
