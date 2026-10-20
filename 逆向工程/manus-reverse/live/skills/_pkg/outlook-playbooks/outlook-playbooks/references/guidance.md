# Guidance and Refusals (Cards D1, D2, E1)

## Card D1: Classic, new, Mac, and web Outlook

Give evidence-dated guidance tailored to the user's actual workflows. Do not construct a timeless feature matrix from memory.

Microsoft's new-versus-classic Windows feature matrix is explicitly date-stamped and changes over time. Record its update date and distinguish `Available`, `Partially available`, `Not supported`, `Under investigation`, and `Upcoming`; never collapse those states into a binary answer.

**Primary channel**: evidence-dated guidance.

**Escalation trigger**: the answer depends on a live build, tenant policy, or feature flag not established by current evidence.

**Hybrid handoff**: an O1-proved read-only My Browser/CU inspection can supply current state; connector routes may replace only operations in their checked surface.

1. Identify exact product/build, account/tenant, OS, and critical workflows.
2. Classify each workflow as observed available, documented available, changed, missing, replaced by a Manus route, or unknown.
3. Use live inspection only when the selected product/version operation has an O1 read-only procedure.
4. Recommend stay, move, or hybrid use with explicit reasons and uncertainty.

**Verification**: every named workflow gets an evidence level, current status, route, and explicit unknown where applicable.

## Card D2: Platform routing

**Primary channel**: guidance followed by the available bounded connector, browser, desktop, or file route.

**Escalation trigger**: required state belongs to an unavailable connector/account/product, or the operation lacks product-specific proof.

**Hybrid handoff**: use stable IDs/files between channels; each channel owns only its authoritative state and verifies its own result.

1. Identify desired durable state before asking whether Outlook is installed.
2. Check Mail/Calendar connector availability and exact tool surface.
3. Use My Browser only for O1-proved web state; use CU only for O1-proved installed-client state; use sandbox files for local archives and portable outputs.
4. Explain route limits and verify the result in its authoritative channel.

**Verification**: current tool/account/product availability and retained postcondition match the selected route; no capability is inferred from app name alone.

## Card E1: Campaign-style bulk send

**Primary channel**: refusal plus consent-aware campaign guidance.

**Escalation trigger**: the request is actually a small, expected, individualized set rather than a campaign.

**Hybrid handoff**: sandbox work may prepare consented content/list artifacts; proper campaign infrastructure distributes; Card A3 may create individually reviewed drafts for a small legitimate set.

Refuse campaign delivery through Outlook. Offer consent-aware campaign infrastructure with unsubscribe, bounce, suppression, and delivery controls.

For a genuinely small set of expected individualized messages, Card A3 may prepare reviewed drafts. Schema batch limits are technical limits, not permission to run a campaign.

**Verification**: no campaign was sent from Outlook; the alternative is concrete; any small-set messages remain drafts unless each exact send was explicitly approved.
