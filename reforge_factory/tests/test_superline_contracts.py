# -*- coding: utf-8 -*-
"""superline contracts 单测——P0 地基件 (S0 charter / S1 framework 共享契约).

不碰真池真渠道: 纯 dict 校验器; 门参数同源性用 monkeypatch ammo_pool 验证.
覆盖: 常量值域冻结/charter 必填+设问式+反例≥3+T1 非空/呈批态门/
framework 四路由字段/密度须侦察据/兜底框架自身过门(防悬空件)/
指纹稳定且序无关/校验器零变异(不可变纪律)/门参数动态同源.
"""
import copy
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import ammo_pool as ap  # noqa: E402
from superline import contracts as C  # noqa: E402


def _charter(**over):
    base = {
        "campaign_id": "EPC51-TEST",
        "report_title": "四川电力设计咨询公司研究报告",
        "family": "enterprise",
        "input_level": "L1",
        "reader": "总包企业管理层",
        "volume": {"chapters": 12, "sections": 3, "total_chars": 300000},
        "core_question": "四川电力的EPC转型为什么能持续增长？",
        "tiers": {"T1": ["四川电力"], "T2": ["电力设计院"], "T3": ["工程总承包"]},
        "restatement": "复述: 研究四川电力EPC转型的成长动因与可持续性",
        "counter_questions": [
            "四川电力EPC增长的论断为什么可能是错的？",
            "其区域优势被谁取代？",
            "订单高增是否只是低毛利垫资换量？",
        ],
        "approval": "approved",
    }
    return {**base, **over}


def _fw(**over):
    base = {
        "campaign_id": "EPC51-TEST",
        "family": "enterprise",
        "version": 1,
        "chapters": [
            {"id": "ch01", "title": "企业基本面", "description": "d",
             "tier_map": {"T1": ["四川电力"]},
             "channels": ["stock_harvest", "weread"],
             "budget_band": "outline_wide", "evidence_density": "low"},
            {"id": "ch02", "title": "EPC战略", "description": "d",
             "tier_map": {"T2": ["电力设计院"]},
             "channels": ["current_increment"],
             "budget_band": "section_narrow", "evidence_density": "medium",
             "scout_hits": ["https://example.com/a"]},
        ],
    }
    return {**base, **over}


# ---------- 常量 ----------

def test_constants_frozen_tuples():
    for c in (C.TIERS, C.BUDGET_BANDS, C.CHAPTER_STATES, C.FAMILY_TYPES,
              C.INPUT_LEVELS, C.APPROVAL_STATES, C.DENSITY_LEVELS,
              C.CHANNEL_PLAN_CLASSES):
        assert isinstance(c, tuple)


# ---------- charter ----------

def test_valid_charter_passes():
    assert C.validate_charter(_charter()) == []


@pytest.mark.parametrize("key", [
    "campaign_id", "report_title", "family", "input_level", "reader",
    "volume", "core_question", "tiers", "restatement", "counter_questions",
    "approval",
])
def test_missing_required_field_flagged(key):
    errs = C.validate_charter(_charter(**{key: None}))
    assert errs, f"缺 {key} 必须报错"


def test_core_question_must_be_interrogative():
    errs = C.validate_charter(_charter(core_question="四川电力的EPC转型研究"))
    assert any("设问式" in e for e in errs)


def test_counter_questions_min_three():
    errs = C.validate_charter(_charter(counter_questions=["a？", "b？"]))
    assert any("counter_questions" in e for e in errs)


def test_t1_empty_flagged():
    errs = C.validate_charter(_charter(tiers={"T1": [], "T2": ["x"]}))
    assert any("tiers.T1" in e for e in errs)


def test_campaign_id_rejects_path_sep():
    errs = C.validate_charter(_charter(campaign_id="bad/id"))
    assert any("campaign_id" in e for e in errs)


def test_charter_ready_for_s1_gate():
    assert C.charter_ready_for_s1(_charter()) is True
    assert C.charter_ready_for_s1(_charter(approval="pending")) is False
    assert C.charter_ready_for_s1(_charter(approval="edit")) is False
    assert C.charter_ready_for_s1(_charter(approval="waived")) is False  # S0 章程门只认 approved
    broken = _charter()
    broken["tiers"] = {"T1": []}
    assert C.charter_ready_for_s1(broken) is False   # 有批但校验有错同样不放行


def test_gate_defaults_live_from_ammo_pool(monkeypatch):
    monkeypatch.setattr(ap, "T1_MIN_CHARS", 7)
    assert C.gate_defaults()["t1_min_chars"] == 7   # 动态同源, 不缓存


def test_charter_word_dict_entries_accepted():
    c = _charter(tiers={"T1": [{"word": "四川电力", "slot": "企业名"}]})
    assert C.validate_charter(c) == []
    assert C.tier_words(c["tiers"], "T1") == ["四川电力"]


# ---------- framework ----------

def test_valid_framework_passes():
    assert C.validate_framework(_fw()) == []


@pytest.mark.parametrize("field", ["tier_map", "channels", "budget_band",
                                   "evidence_density"])
def test_missing_route_field_flagged(field):
    ch = copy.deepcopy(_fw()["chapters"][0])
    ch.pop(field)
    errs = C.validate_framework(_fw(chapters=[ch]))
    assert any(field in e for e in errs)


def test_density_high_requires_scout_hits():
    ch = copy.deepcopy(_fw()["chapters"][1])
    ch.pop("scout_hits")
    errs = C.validate_framework(_fw(chapters=[ch]))
    assert any("scout_hits" in e for e in errs)


def test_density_low_without_hits_ok():
    errs = C.validate_framework(_fw())          # ch01 low 无 scout_hits 合法
    assert errs == []


def test_duplicate_chapter_ids_flagged():
    chapters = copy.deepcopy(_fw()["chapters"])
    chapters[1]["id"] = chapters[0]["id"]
    errs = C.validate_framework(_fw(chapters=chapters))
    assert any("重复" in e for e in errs)


def test_bad_budget_band_flagged():
    ch = copy.deepcopy(_fw()["chapters"][0])
    ch["budget_band"] = "wide"                  # 值域外
    errs = C.validate_framework(_fw(chapters=[ch]))
    assert any("budget_band" in e for e in errs)


def test_route_completeness_ratio():
    assert C.route_completeness(_fw()) == (2, 2)
    chapters = copy.deepcopy(_fw()["chapters"])
    chapters[0].pop("channels")
    assert C.route_completeness(_fw(chapters=chapters)) == (1, 2)


# ---------- 兜底框架 (防悬空件) ----------

def test_default_framework_passes_validation():
    fw = C.default_framework("EPC51-TEST", "四川电力研究报告",
                             {"T1": ["四川电力"]})
    assert C.validate_framework(fw) == []
    assert len(fw["chapters"]) == 3
    assert all(ch["evidence_density"] == "low" for ch in fw["chapters"])
    assert fw["generator"] == "default_fallback"


def test_default_framework_without_tiers_uses_title():
    fw = C.default_framework("EPC51-TEST", "某行业报告", None)
    assert C.validate_framework(fw) == []
    assert fw["chapters"][0]["tier_map"]["T1"] == ["某行业报告"]


# ---------- 指纹 ----------

def test_fingerprint_order_insensitive_and_sensitive():
    a = {"b": 1, "a": {"y": 2, "x": 3}}
    b = {"a": {"x": 3, "y": 2}, "b": 1}
    assert C.fingerprint(a) == C.fingerprint(b)
    c = {"a": {"x": 3, "y": 4}, "b": 1}
    assert C.fingerprint(a) != C.fingerprint(c)
    assert len(C.fingerprint(a)) == 12


# ---------- 不可变纪律 ----------

def test_validators_do_not_mutate_input():
    ch = _charter()
    fw = _fw()
    snap_ch = copy.deepcopy(ch)
    snap_fw = copy.deepcopy(fw)
    C.validate_charter(ch)
    C.validate_framework(fw)
    C.route_completeness(fw)
    C.charter_ready_for_s1(ch)
    assert ch == snap_ch and fw == snap_fw
