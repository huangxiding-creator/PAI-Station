# Traceability Matrix

- generated: 2026-10-14T16:47:52+08:00 · require: `tasks`
- MUST coverage — tasks: 100% · tests: 90% (21 MUST requirements)
- verdict: ✅ PASS

| REQ | Priority | EARS | Tasks | Tests |
|---|---|---|---|---|
| REQ-001 | MUST | ✓ | T-001, T-011, T-041 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_001_ac1_router_structure.py, AIUI-Migrate/tests/factory/test_req_001_ac2_route_table_hard_gates.py |
| ↳ REQ-001.AC1 | MUST | ✓ | T-011, T-041 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_001_ac1_router_structure.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py |
| ↳ REQ-001.AC2 | MUST | ✓ | T-011, T-041 | AIUI-Migrate/tests/factory/test_req_001_ac2_route_table_hard_gates.py |
| REQ-002 | MUST | ✓ | T-002, T-013, T-078, T-081 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_002_ac1_junction_single_source.py, AIUI-Migrate/tests/factory/test_req_002_ac2_registration_visibility.py |
| ↳ REQ-002.AC1 | MUST | ✓ | T-013, T-081 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_002_ac1_junction_single_source.py, lingzhu-quant-port/tests/test_g1.py |
| ↳ REQ-002.AC2 | MUST | ✓ | T-013, T-078 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_002_ac2_registration_visibility.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py |
| REQ-003 | MUST | ✓ | T-003, T-004, T-005, T-006, T-016, T-042 | AIUI-Migrate/tests/factory/test_req_003_ac1_proposal_pipeline.py, AIUI-Migrate/tests/factory/test_req_003_ac2_banned_words.py, AIUI-Migrate/tests/test_generator.py |
| ↳ REQ-003.AC1 | MUST | ✓ | T-016, T-042 | AIUI-Migrate/tests/factory/test_req_003_ac1_proposal_pipeline.py, lingzhu-quant-port/tests/test_g2.py |
| REQ-004 | MUST | ✓ | T-007, T-009, T-010, T-044, T-065 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-004.AC1 | MUST | ✓ | T-010, T-044 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-004.AC2 | MUST | ✓ | T-007, T-010, T-065 | .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ada60b0d29c4d4d4c/services/qianwen-engine/tests/test_delete_answer.py |
| REQ-005 | MUST | ✓ | T-008, T-010, T-054, T-075, T-076 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-005.AC1 | MUST | ✓ | T-010, T-076 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-005.AC2 | MUST | ✓ | T-008, T-075 | AIUI-Migrate/tests/factory/test_req_003_ac1_proposal_pipeline.py, AIUI-Migrate/tests/factory/test_req_005_ac2_manifest_home.py, lingzhu-quant-port/tests/test_g4.py |
| ↳ REQ-005.AC3 | MUST | ✓ | T-054 | lingzhu-quant-port/tests/test_g4.py |
| REQ-006 | MUST | ✓ | T-015, T-016, T-045, T-050 | AIUI-Migrate/tests/factory/test_req_006_ac1_render_idempotent.py, AIUI-Migrate/tests/factory/test_req_007_ac1_bind_reconcile.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py |
| ↳ REQ-006.AC1 | MUST | ✓ | T-015, T-016, T-045, T-050 | AIUI-Migrate/tests/factory/test_req_006_ac1_render_idempotent.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py, lingzhu-quant-port/tests/test_g5.py |
| ↳ REQ-006.AC2 | MUST | ✓ | T-015, T-016, T-050 | — |
| REQ-007 | MUST | ✓ | T-014, T-017, T-056 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-007.AC1 | MUST | ✓ | T-014, T-056 | .claude/worktrees/agent-a1176407bc48271a5/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-a52086cd3347105e3/services/qianwen-engine/tests/test_delete_answer.py, .claude/worktrees/agent-ac13086da2181fabb/services/qianwen-engine/tests/test_delete_answer.py |
| ↳ REQ-007.AC2 | MUST | ✓ | T-017, T-056 | lingzhu-quant-port/tests/test_g5.py |
| REQ-008 | MUST | ✓ | T-021, T-057 | .claude/worktrees/agent-a4ed98579baefda64/_t002_staging/tests/test_g1.py, AIUI-Migrate/tests/factory/test_req_008_ac1_three_legs.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py |
| ↳ REQ-008.AC1 | MUST | ✓ | T-057 | AIUI-Migrate/tests/factory/test_req_008_ac1_three_legs.py, lingzhu-quant-port/tests/test_guard.py |
| ↳ REQ-008.AC2 | MUST | ✓ | T-057 | AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py |
| REQ-009 | MUST | ✓ | T-022, T-062 | AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py, AIUI-Migrate/tests/factory/test_req_009_ac1_enum_dual_source.py, AIUI-Migrate/tests/factory/test_req_009_ac1_spec_lint.py |
| ↳ REQ-009.AC1 | MUST | ✓ | T-062 | AIUI-Migrate/tests/factory/test_req_009_ac1_enum_dual_source.py, AIUI-Migrate/tests/factory/test_req_009_ac1_spec_lint.py |
| ↳ REQ-009.AC2 | MUST | ✓ | T-062 | AIUI-Migrate/tests/factory/test_req_009_ac2_cdn_get.py |
| REQ-010 | MUST | ✓ | T-063, T-064 | AIUI-Migrate/tests/factory/test_req_010_ac1_submit_evidence.py, AIUI-Migrate/tests/factory/test_req_010_ac1_usage_envelope_uniform.py, AIUI-Migrate/tests/factory/test_req_010_ac2_verdict_json.py |
| ↳ REQ-010.AC1 | MUST | ✓ | T-063 | AIUI-Migrate/tests/factory/test_req_010_ac1_submit_evidence.py, AIUI-Migrate/tests/factory/test_req_010_ac1_usage_envelope_uniform.py, AIUI-Migrate/tests/factory/test_req_010_ac2_verdict_json.py |
| ↳ REQ-010.AC2 | MUST | ✓ | T-063 | AIUI-Migrate/tests/factory/test_req_010_ac2_verdict_json.py |
| ↳ REQ-010.AC3 | MUST | ✓ | T-064 | AIUI-Migrate/tests/factory/test_req_010_ac3_dryrun.py |
| REQ-011 | MUST | ✓ | T-061 | AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py, AIUI-Migrate/tests/factory/test_req_011_ac1_state_file.py, AIUI-Migrate/tests/factory/test_req_011_ac2_push_payload.py |
| ↳ REQ-011.AC1 | MUST | ✓ | T-061 | AIUI-Migrate/tests/factory/test_req_011_ac1_state_file.py, lingzhu-quant-port/tests/test_req_011_ac1_patrol_compare.py |
| ↳ REQ-011.AC2 | MUST | ✓ | T-061 | AIUI-Migrate/tests/factory/test_req_011_ac2_push_payload.py |
| REQ-012 | MUST | ✓ | T-068 | AIUI-Migrate/tests/factory/test_req_012_ac1_classify_ledger.py, AIUI-Migrate/tests/factory/test_req_012_ac2_second_reject_stop.py, AIUI-Migrate/tests/factory/test_req_014_ac1_wizard_doc.py |
| ↳ REQ-012.AC1 | MUST | ✓ | T-068 | AIUI-Migrate/tests/factory/test_req_012_ac1_classify_ledger.py |
| ↳ REQ-012.AC2 | MUST | ✓ | T-068 | AIUI-Migrate/tests/factory/test_req_012_ac2_second_reject_stop.py |
| REQ-013 | MUST | ✓ | T-058, T-066, T-067 | AIUI-Migrate/tests/factory/test_req_013_ac1_up_flip.py, AIUI-Migrate/tests/factory/test_req_014_ac1_wizard_doc.py, AIUI-Migrate/tests/test_requirements.py |
| ↳ REQ-013.AC1 | MUST | ✓ | T-058 | AIUI-Migrate/tests/factory/test_req_013_ac1_up_flip.py, lingzhu-quant-port/tests/test_writer.py |
| ↳ REQ-013.AC2 | MUST | ✓ | T-066 | — |
| ↳ REQ-013.AC3 | MUST | ✓ | T-067 | — |
| REQ-014 | MUST | ✓ | T-045, T-046 | AIUI-Migrate/tests/factory/test_req_012_ac1_classify_ledger.py, AIUI-Migrate/tests/factory/test_req_014_ac1_cli_exception_face.py, AIUI-Migrate/tests/factory/test_req_014_ac1_wizard_doc.py |
| ↳ REQ-014.AC1 | MUST | ✓ | T-046 | AIUI-Migrate/tests/factory/test_req_012_ac1_classify_ledger.py, AIUI-Migrate/tests/factory/test_req_014_ac1_cli_exception_face.py, AIUI-Migrate/tests/factory/test_req_014_ac1_wizard_doc.py |
| ↳ REQ-014.AC2 | MUST | ✓ | T-045 | — |
| REQ-015 | MUST | ✓ | T-069 | AIUI-Migrate/tests/factory/test_req_012_ac1_classify_ledger.py, AIUI-Migrate/tests/factory/test_req_015_ac1_cli_catchall_envelope.py, AIUI-Migrate/tests/factory/test_req_015_ac1_drift_gate.py |
| ↳ REQ-015.AC1 | MUST | ✓ | T-069 | AIUI-Migrate/tests/factory/test_req_015_ac1_cli_catchall_envelope.py, AIUI-Migrate/tests/factory/test_req_015_ac1_drift_gate.py, AIUI-Migrate/tests/factory/test_req_015_ac1_run_stage_gate_red_evidence_guard.py |
| REQ-016 | SHOULD | ✓ | T-059 | AIUI-Migrate/tests/factory/test_req_016_ac1_write_boundary.py, AIUI-Migrate/tests/factory/test_req_016_ac2_browser_discipline.py, AIUI-Migrate/tests/factory/test_req_017_ac2_throttle.py |
| REQ-017 | MUST | ✓ | T-072 | AIUI-Migrate/tests/factory/test_req_007_ac1_bind_reconcile.py, AIUI-Migrate/tests/factory/test_req_010_ac4_readback.py, AIUI-Migrate/tests/factory/test_req_017_ac1_redaction.py |
| ↳ REQ-017.AC1 | MUST | ✓ | T-072 | AIUI-Migrate/tests/factory/test_req_017_ac1_redaction.py |
| ↳ REQ-017.AC2 | MUST | ✓ | T-072 | AIUI-Migrate/tests/factory/test_req_007_ac1_bind_reconcile.py, AIUI-Migrate/tests/factory/test_req_010_ac4_readback.py, AIUI-Migrate/tests/factory/test_req_017_ac2_throttle.py |
| REQ-018 | MUST | ✓ | T-070 | AIUI-Migrate/tests/factory/test_req_011_ac2_push_payload.py, AIUI-Migrate/tests/factory/test_req_013_ac1_up_flip.py, AIUI-Migrate/tests/factory/test_req_015_ac1_drift_gate.py |
| ↳ REQ-018.AC1 | MUST | ✓ | T-070 | AIUI-Migrate/tests/factory/test_req_018_ac1_changelog_format.py |
| ↳ REQ-018.AC2 | MUST | ✓ | T-070 | AIUI-Migrate/tests/factory/test_req_018_ac2_adversarial_trace.py |
| REQ-019 | MUST | ✓ | T-048 | AIUI-Migrate/tests/factory/test_req_019_ac2_missing_guidance.py |
| ↳ REQ-019.AC1 | MUST | ✓ | T-048 | AIUI-Migrate/tests/factory/test_req_019_ac2_missing_guidance.py |
| REQ-020 | SHOULD | ✓ | T-060 | — |
| ↳ REQ-020.AC1 | SHOULD | ✓ | T-060 | — |
| REQ-021 | MUST | ✓ | T-071 | AIUI-Migrate/tests/factory/test_req_007_ac1_bind_reconcile.py, AIUI-Migrate/tests/factory/test_req_008_ac2_naming.py, AIUI-Migrate/tests/factory/test_req_010_ac1_usage_envelope_uniform.py |
| ↳ REQ-021.AC1 | MUST | ✓ | T-071 | AIUI-Migrate/tests/factory/test_req_021_ac1_breakpoint_report.py, AIUI-Migrate/tests/factory/test_req_021_ac1_f40_entry_wiring.py |
| ↳ REQ-021.AC2 | MUST | ✓ | T-071 | AIUI-Migrate/tests/factory/test_req_007_ac1_bind_reconcile.py, AIUI-Migrate/tests/factory/test_req_021_ac2_create_dedup.py, AIUI-Migrate/tests/factory/test_req_021_ac2_f40_entry_wiring.py |
| REQ-024 | MUST | ✓ | T-040 | — |
| ↳ REQ-024.AC1 | MUST | ✓ | T-040 | — |
| REQ-022 | MUST | ✓ | T-079, T-080 | — |
| ↳ REQ-022.AC1 | MUST | ✓ | T-079 | — |
| ↳ REQ-022.AC2 | MUST | ✓ | T-080 | — |
| REQ-023 | SHOULD | ✓ | T-073 | — |
| ↳ REQ-023.AC1 | SHOULD | ✓ | T-073 | — |
| REQ-025 | SHOULD | ✓ | T-049 | — |
| ↳ REQ-025.AC1 | SHOULD | ✓ | T-049 | — |
