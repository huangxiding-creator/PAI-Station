"""M12 进化提案机制 TDD（PROPOSAL_V2.md 第 9 章，用户裁决：每周提 PR）。

- 每周闸：ISO 周变更才生成（用户 2026-09-11 由月度提频）
- 变异类型：method_evolve / skill_rebirth / profile_fix / rule_update /
  new_channel / retire
- 每案必附 before→after 证据 + 风险 + 回滚（C11）
- 裁撤红线：安全件（深读参数/只读守卫/账号节流）永不入裁撤候选
- R15：系统永不自批——status 恒 pending_user，land() 须用户显式批准
"""
import json
from datetime import datetime

import pytest

from paistation.evolve.proposer import (
    NON_RETIREABLE,
    EvolutionEngine,
    land,
    render_card,
)


def snap(tmp_path, domain, u, week):
    p = tmp_path / "11 进化" / "pdca" / f"unity_{week}_{domain}.json"
    p.parent.mkdir(parents=True, exist_ok=True)
    p.write_text(json.dumps({"domain": domain, "u": u, "iso_week": week,
                             "components": {}, "date": week},
                            ensure_ascii=False), encoding="utf-8")
    return p


def engine(tmp_path):
    class Chan:
        def __init__(self):
            self.sent = []

        def send(self, title, body):
            self.sent.append((title, body))
            return {"ok": True}

    ch = Chan()
    eng = EvolutionEngine(station_root=tmp_path, channel=ch,
                          now_fn=lambda: datetime(2026, 9, 11, 9, 0))
    return eng, ch


# ---------------------------------------------------------------- 每周闸

def test_weekly_gate_iso_week(tmp_path):
    eng, ch = engine(tmp_path)
    assert eng.due(last_week="2026-W36", now=datetime(2026, 9, 11)) is True
    assert eng.due(last_week="2026-W37", now=datetime(2026, 9, 11)) is False


def test_maybe_weekly_runs_once_per_week(tmp_path):
    eng, ch = engine(tmp_path)
    eng.maybe_weekly()                       # W37 首跑
    assert ch.sent and "进化提案" in ch.sent[0][0]
    count = len(ch.sent)
    eng.maybe_weekly()                       # 同周再跑 → 静默
    assert len(ch.sent) == count


# ---------------------------------------------------------------- 信号→提案

def test_u_crossing_singularity_proposes_method_evolve(tmp_path):
    eng, _ = engine(tmp_path)
    snap(tmp_path, "调研报告", 63, "2026-W37")
    snap(tmp_path, "调研报告", 41, "2026-W36")
    props = eng.generate()
    kinds = [(p["kind"], p["domain"]) for p in props]
    assert ("method_evolve", "调研报告") in kinds
    prop = next(p for p in props if p["kind"] == "method_evolve")
    assert prop["evidence"]["before"] == 41 and prop["evidence"]["after"] == 63
    assert "60" in json.dumps(prop)          # 奇点证据入案


def test_c_rate_rising_proposes_profile_fix(tmp_path):
    eng, _ = engine(tmp_path)
    snap2 = {"domain": "公众号写作", "u": 41, "iso_week": "2026-W37",
             "components": {"c_rate": 0.6}, "date": "2026-W37"}
    snap1 = {"domain": "公众号写作", "u": 52, "iso_week": "2026-W36",
             "components": {"c_rate": 0.2}, "date": "2026-W36"}
    for row, wk in ((snap1, "2026-W36"), (snap2, "2026-W37")):
        p = tmp_path / "11 进化" / "pdca" / f"unity_{wk}_公众号写作.json"
        p.parent.mkdir(parents=True, exist_ok=True)
        p.write_text(json.dumps(row, ensure_ascii=False), encoding="utf-8")
    props = eng.generate()
    assert any(p["kind"] == "profile_fix" and p["domain"] == "公众号写作"
               for p in props)


def test_retire_scans_idle_but_never_safety(tmp_path):
    eng, _ = engine(tmp_path)
    usage = {"书城旧版入口": {"days_idle": 120, "uses_90d": 0},
             "深读安全参数": {"days_idle": 400, "uses_90d": 0},
             "账号节流器": {"days_idle": 365, "uses_90d": 0}}
    props = eng.generate(usage=usage)
    retires = [p for p in props if p["kind"] == "retire"]
    names = [p["target"] for p in retires]
    assert names == ["书城旧版入口"]          # 安全件永不出现在裁撤候选
    assert not any(k in n for n in names for k in NON_RETIREABLE)


def test_proposal_contract_fields(tmp_path):
    """每案必附：变异类型/证据 before→after/风险/回滚（C11）。"""
    eng, _ = engine(tmp_path)
    snap(tmp_path, "调研报告", 63, "2026-W37")
    snap(tmp_path, "调研报告", 41, "2026-W36")
    props = eng.generate()
    assert props
    for p in props:
        assert p["kind"] and p["id"]
        assert "before" in p["evidence"] and "after" in p["evidence"]
        assert p["risk"] and p["rollback"]


def test_empty_signals_no_fabrication(tmp_path):
    eng, _ = engine(tmp_path)
    assert eng.generate() == []              # 零信号零提案，不编造


# ---------------------------------------------------------------- 卡片+落地

def test_render_card_contains_approval_options(tmp_path):
    eng, _ = engine(tmp_path)
    snap(tmp_path, "调研报告", 63, "2026-W37")
    snap(tmp_path, "调研报告", 41, "2026-W36")
    text = render_card(eng.generate())
    assert "批准" in text and "驳回" in text


def test_land_requires_user_approval_r15(tmp_path):
    eng, _ = engine(tmp_path)
    snap(tmp_path, "调研报告", 63, "2026-W37")
    snap(tmp_path, "调研报告", 41, "2026-W36")
    props = eng.generate()
    prop = eng.persist(props)[0]
    with pytest.raises(PermissionError):
        land(tmp_path, prop)                 # 系统永不自批（R15）
    landed = land(tmp_path, prop, approved_by="用户")
    assert landed["status"] == "approved"
    assert landed["approved_by"] == "用户"
    # 落地凭证进 11 进化 链（R14）
    from paistation.organ.credential import read_chain
    chain = read_chain(tmp_path, "进化")
    assert any(c.kind == "evolution_proposal" for c in chain)
