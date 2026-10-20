# Conditional OBS Protocol Channel

This is a gate, not a declaration that Manus currently ships an OBS connector.

## Required gates

P1 is available only when all of the following are proved in the current environment:

1. OBS and its protocol version are identified, the server is intentionally enabled, and authentication remains enabled.
2. The chosen shared folder permits host-terminal commands. Shared-file visibility, Sandbox execution, and host-terminal execution are separate permissions.
3. A version-pinned client is present in an authorized location and its dependency/source policy is accepted.
4. The secret enters through a local protected path that ordinary prompts, command arguments, files, screenshots, traces, and reports cannot expose.
5. The client completes authentication, returns a live version/capability receipt, and applies an explicit request allowlist.
6. Every mutation returns a receipt and is followed by semantic read-back. Timeouts have a query-before-retry rule.
7. Redaction, revocation, cleanup, and recovery have executable tests.

If any gate fails, stop at F1 planning or use a current-build D1 route for the supported foreground subset. Never disable authentication as a fallback.

## Capability discipline

- Probe live versions and available requests before choosing a recipe.
- Treat source, filter, output, and plugin setting objects as runtime-specific. Do not hard-code remembered keys.
- A request name in public documentation does not prove that the installed OBS build, source kind, plugin, or client supports the intended object.
- Generic output or profile objects do not prove a stable encoder/bitrate schema.
- Monitor enumeration does not enumerate window, game, or application capture targets.

## Safe request classes

Begin with read-only version, collection, scene, source, filter, output-state, screenshot, and statistics queries. Mutation classes require their own fixtures and allowlist entry. Consequential output requests additionally require R1 confirmation.

## Recovery limits

A protocol can create state that it cannot symmetrically remove. Keep an explicit rollback method for every created object. Do not call a test collection disposable unless its cleanup route has been observed.

## Truth label

Report P1 complete only with the capability receipt, request receipt, semantic read-back, visible/render verification where relevant, and recovery state. Otherwise report the exact failed gate.
