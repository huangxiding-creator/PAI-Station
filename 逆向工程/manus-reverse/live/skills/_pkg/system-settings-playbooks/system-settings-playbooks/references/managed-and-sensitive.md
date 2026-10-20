# Managed and Sensitive Settings

## Managed-device planning

The durable state for an organization baseline lives in the approved management plane, not in a consumer Settings window.

For a planning task:

1. collect approved policy outcomes, OS versions and editions, ownership, and device scope;
2. map each outcome to a first-party payload or policy concept without assuming Manus can deploy it;
3. record enrollment, authority, applicability, precedence, and removal behavior;
4. define a clean pilot ring, maintenance window, telemetry, and named rollback owner;
5. separate planning from deployment and require explicit live authorization before external mutation.

Do not enroll or unenroll devices, remove profiles, install certificates or credentials, wipe or reset devices, or bypass non-removable management. Security, firewall, antivirus, encryption, update, and network policies need separate risk-specific workflows.

## Sensitive local settings

Use guidance and user takeover for:

- privacy permissions and consent;
- passwords, passkeys, recovery or encryption material;
- account, login, biometric, and administrator state;
- network radios, adapters, Wi-Fi, VPN, firewall, and security controls;
- operating-system updates, startup, reset, erase, and device management.

Manus may explain impact, identify a supported surface, and wait while the user completes the secure step. Do not observe secret entry. After the user returns, verify only a non-secret status when the current runtime and permission model allow it.

## Refusal and handoff

Refuse requests to bypass policy, suppress protections, evade consent, capture credentials, or force secure prompts. Hand off to the device owner, organization administrator, vendor support, or an approved change-management workflow when authority or recovery is missing.

Computer Use is not an exemption from operating-system security boundaries. Visibility of a control does not create authority, and a visible pointer does not make a sensitive mutation safe.
