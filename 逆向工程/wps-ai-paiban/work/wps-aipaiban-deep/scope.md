# Case Scope

## meta
- case_id: wps-aipaiban-deep
- created: 2026-10-21T22:42:52.5237610+08:00
- operator: local
- project_root: E:\AI-Station\逆向工程\wps-ai-paiban
- primary_skill: reverse-engineering/SKILL.md
- primary_id: R0
- lead_role: lead
- specialist_roles: []
- hint: WPS AI排版 深挖：本地引擎/工具桥/安全面
- preset: offline-sample

## auth
- status: granted
- basis: own_system
- evidence_of_auth: preset:offline-sample (owner-operated local file)
- MUST NOT proceed if status != granted

## in_scope
- assets:
  - C:\Users\91216\AppData\Local\Kingsoft\WPS Office\12.1.0.28802\office6\wps.exe
- surfaces: []
- activities: []

## out_of_scope
- assets: []
- activities: [dos, phishing_real_users, unrestricted_exfil]

## network_profile
- mode: offline
- notes: |
    offline | lab_only | authorized_target_only | unrestricted_lab
    Change mode only after auth.status = granted.

## deliverables
- report: true
- field_journal: true
- diagrams: true
- timeline: true

## constraints
- timebox: {}
- stealth: low
- data_handling: anonymize

## signoff
- ready_for_act: true
- checklist:
  - [x] auth.status = granted
  - [x] in_scope.assets non-empty OR offline sample path set
  - [x] network_profile.mode chosen
  - [ ] out_of_scope reviewed
  - [ ] roles assigned (see skills/ops/role-map.md)

## ops_refs
- skills/ops/scope-contract.md
- skills/ops/evidence-finding-path.md
- skills/ops/role-map.md
- skills/ops/timeline-workitem.md
- skills/ops/IDENTITY.md