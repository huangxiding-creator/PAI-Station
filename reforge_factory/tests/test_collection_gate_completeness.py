# -*- coding: utf-8 -*-
"""test_collection_gate_completeness — S1 完备性门+饱和门接线 (T-003 / REQ-015).

REQ-015.AC1 证明 (tmp 合成池+合成账本, 不跑真实采集, 不落真实 state):
  a) 五轴全绿 + 饱和达标 → S1 出门三门串联 PASS
  b) 缺 D 轴 → 完备性门 FAIL (核心断言)
  c) D 轴 waived:true → 该轴豁免 (waived), 全绿则 PASS
  d) 饱和率 79% < 80% → 饱和门 FAIL
  e) 账本不存在 → 完备性 FAIL + 五轴全 unknown
  f) 无 question_tree.json → 饱和门 unknown 计入 FAIL 域 (fail-soft, 不虚报 PASS)
  g) min_pct 热改 80→70 → 同 79% 池重判即时翻转 (决策时现读, 无缓存)

跑法: py -m pytest reforge_factory/tests/test_collection_gate_completeness.py -q
"""
import importlib.util
import json
import sys
from pathlib import Path

CG_PATH = (Path(__file__).resolve().parents[2] / "_proposals"
           / "flagship-paid-report-1007" / "work" / "collection_gate.py")

# KB-COMPLETENESS-SPEC 五轴 schema 最小合成 (axis/sensor/green + 轴负载示意)
GREEN5 = [
    {"axis": "T", "sensor": "entity_timeline", "object": "X公司",
     "year_counts": {"1985": 3, "2026": 210}, "green": True},
    {"axis": "B", "sensor": "coverage_facets",
     "facets": {"资本运作": {"evidence": 12, "lit": True}}, "green": True},
    {"axis": "D", "sensor": "dimension_matrix",
     "dims": ["行业", "政策"], "cells": {"行业": {"depth": "L3", "hits": 45}},
     "green": True},
    {"axis": "P", "sensor": "depth_ladder", "eei_total": 560,
     "l_dist": {"L1": 80, "L3": 180}, "key_eei_ge_l3_pct": 92, "green": True},
    {"axis": "C", "sensor": "channel_matrix", "channels_hit": 34,
     "channels_total": 46, "green": True},
]
COV_OK = {"eei_total": 10, "saturated": 9, "gap": 1, "sat_pct": 90.0,
          "checked": "2026-10-15 10:00"}          # 90% ≥ 80% 饱和达标
COV_79 = {"eei_total": 100, "saturated": 79, "gap": 21, "sat_pct": 79.0,
          "checked": "2026-10-15 10:00"}          # 79% < 80% 不达标


def _load_cg():
    """按文件路径装载 collection_gate 模块 (work 目录非包, 同 T1 套件范式)."""
    spec = importlib.util.spec_from_file_location("collection_gate", CG_PATH)
    mod = importlib.util.module_from_spec(spec)
    sys.modules["collection_gate"] = mod
    spec.loader.exec_module(mod)
    return mod


def _mk_camp(base, ledger_rows=None, coverage="ok", t1_chars=11_000_000):
    """最小合成池: pool_state.json(字数门过) + 五轴账本 + question_tree 覆盖节.

    ledger_rows=None → 不落账本文件 (情形 e); coverage=None → 不落树 (情形 f);
    coverage="ok"/"79" → 落 COV_OK / COV_79.
    """
    d = base / "CAMP"
    d.mkdir(parents=True, exist_ok=True)
    (d / "pool_state.json").write_text(json.dumps({
        "campaign": "CAMP", "total_chars": t1_chars, "items": 2,
        "t1_chars": t1_chars, "t2_chars": 0, "t3_chars": 0, "t0_chars": 0,
    }, ensure_ascii=False), encoding="utf-8")
    if ledger_rows is not None:
        (d / "completeness_ledger.jsonl").write_text(
            "\n".join(json.dumps(r, ensure_ascii=False) for r in ledger_rows),
            encoding="utf-8")
    if coverage is not None:
        cov = COV_OK if coverage == "ok" else coverage
        (d / "question_tree.json").write_text(json.dumps(
            {"topic": "合成战役", "subquestions": [], "coverage": cov},
            ensure_ascii=False), encoding="utf-8")
    return d


def _measure(cg, monkeypatch, camp_dir):
    """对合成池跑 measure (纯内存判定, 不 _save 不落真实 state)."""
    monkeypatch.setattr(cg, "AMMO", camp_dir.parent)
    monkeypatch.setattr(cg, "CID", "CAMP")
    monkeypatch.setattr(cg, "F1_POOL", camp_dir)
    monkeypatch.setattr(cg, "F1_INV", camp_dir / "nope_inventory.json")
    monkeypatch.setattr(cg, "F1_TREE", camp_dir / "nope_tree.json")
    return cg.measure({})


# ---------- a) 五轴全绿+饱和达标 → S1 三门串联 PASS ----------

def test_a_all_green_and_saturated_s1_pass(gates_json, tmp_path, monkeypatch):
    gates_json()                                       # 底=真 gates.json (v3 口径)
    cg = _load_cg()
    st = _measure(cg, monkeypatch, _mk_camp(tmp_path, GREEN5, "ok"))
    assert st["word_gate_pass"] is True                # 字数门 (T1=1100万) 语义不变
    c, s = st["completeness"], st["saturation"]
    assert c["pass"] is True
    assert c["axis_statuses"] == {"T": "green", "B": "green", "D": "green",
                                  "P": "green", "C": "green"}
    assert c["required_axes"] == ["T", "B", "D", "P", "C"]
    assert c["pass_rule"] == "all_green_or_waived"
    assert s["pass"] is True and s["status"] == "pass"
    assert s["sat_pct"] == 90.0 and s["min_pct"] == 80
    assert s["eei_total"] == 10 and s["saturated"] == 9
    assert st["s1_gate_pass"] is True                  # 字数门 ∧ 完备 ∧ 饱和 全过


# ---------- b) 缺 D 轴 → 完备性 FAIL (REQ-015.AC1 核心断言) ----------

def test_b_missing_d_axis_fails_completeness(gates_json, tmp_path, monkeypatch):
    gates_json()
    cg = _load_cg()
    no_d = [r for r in GREEN5 if r["axis"] != "D"]     # 只落 T/B/P/C 四轴
    st = _measure(cg, monkeypatch, _mk_camp(tmp_path, no_d, "ok"))
    c = st["completeness"]
    assert c["axis_statuses"]["D"] == "unknown"        # 缺轴 → 该轴 unknown
    assert c["failing_axes"] == ["D"]                  # 缺任一轴即 FAIL
    assert c["pass"] is False
    assert st["word_gate_pass"] is True                # 字数门独立语义不动
    assert st["s1_gate_pass"] is False                 # 三门串联被完备性门拉闸


# ---------- c) D 轴 waived:true → 豁免制, 全绿(含豁免)则 PASS ----------

def test_c_waived_d_axis_exemption_passes(gates_json, tmp_path, monkeypatch):
    gates_json()
    cg = _load_cg()
    waived_d = {"axis": "D", "sensor": "dimension_matrix", "green": False,
                "waived": True, "reason": "司法风险维公开裁判文书仅2条, 用户豁免"}
    rows = [r for r in GREEN5 if r["axis"] != "D"] + [waived_d]
    st = _measure(cg, monkeypatch, _mk_camp(tmp_path, rows, "ok"))
    c = st["completeness"]
    assert c["axis_statuses"]["D"] == "waived"         # green=False 但豁免
    assert c["waived_axes"] == ["D"]
    assert c["pass"] is True                           # all_green_OR_WAIVED
    assert st["s1_gate_pass"] is True


# ---------- d) 饱和率 79% < 80% → 饱和门 FAIL ----------

def test_d_saturation_79pct_fails(gates_json, tmp_path, monkeypatch):
    gates_json()
    cg = _load_cg()
    st = _measure(cg, monkeypatch, _mk_camp(tmp_path, GREEN5, COV_79))
    s = st["saturation"]
    assert s["status"] == "fail" and s["pass"] is False
    assert s["sat_pct"] == 79.0 and s["min_pct"] == 80
    assert st["completeness"]["pass"] is True          # 完备门仍过 (单门拉闸定位)
    assert st["s1_gate_pass"] is False


# ---------- e) 账本不存在 → 完备性 FAIL + 五轴全 unknown ----------

def test_e_missing_ledger_all_axes_unknown(gates_json, tmp_path, monkeypatch):
    gates_json()
    cg = _load_cg()
    st = _measure(cg, monkeypatch,
                  _mk_camp(tmp_path, ledger_rows=None, coverage="ok"))
    c = st["completeness"]
    assert c["ledger_exists"] is False
    assert c["axis_statuses"] == {"T": "unknown", "B": "unknown",
                                  "D": "unknown", "P": "unknown",
                                  "C": "unknown"}
    assert c["pass"] is False                          # 五轴全 unknown → FAIL
    assert st["s1_gate_pass"] is False


# ---------- f) 无 question_tree.json → 饱和门 unknown 计入 FAIL 域 ----------

def test_f_no_coverage_data_unknown_fails_closed(gates_json, tmp_path,
                                                 monkeypatch):
    gates_json()
    cg = _load_cg()
    st = _measure(cg, monkeypatch, _mk_camp(tmp_path, GREEN5, coverage=None))
    s = st["saturation"]
    assert s["status"] == "unknown" and s["pass"] is False   # fail-soft 不虚报
    assert "coverage" in s["reason"]
    assert st["completeness"]["pass"] is True
    assert st["s1_gate_pass"] is False                 # unknown 计入 FAIL 域


# ---------- g) min_pct 热改 80→70 → 同池重判即时翻转 (无缓存) ----------

def test_g_min_pct_hot_reload_no_cache(gates_json, tmp_path, monkeypatch):
    cg = _load_cg()
    camp = _mk_camp(tmp_path, GREEN5, COV_79)
    gates_json()                                       # 门=80 (真底)
    st = _measure(cg, monkeypatch, camp)
    assert st["saturation"]["pass"] is False           # 79% < 80%
    gates_json(saturation_gate={"min_evidence": 2, "min_hosts": 2,
                                "min_pct": 70})        # 只改 tmp 副本, 不重启进程
    st2 = _measure(cg, monkeypatch, camp)              # 同池不重采重判
    assert st2["saturation"]["min_pct"] == 70
    assert st2["saturation"]["pass"] is True           # 79% ≥ 70% 新门=即时生效
    assert st2["s1_gate_pass"] is True


# ---------- 附) 旁挂函数直测: 坏行跳过 + 同轴滚动更新取最新 ----------

def test_h_ledger_parser_bad_lines_and_rolling_update(gates_json, tmp_path):
    gates_json()
    cg = _load_cg()
    d = tmp_path / "CAMP2"
    d.mkdir(parents=True)
    (d / "completeness_ledger.jsonl").write_text(
        "{bad json 行\n"                                 # 坏行 → 跳过
        + json.dumps({"axis": "T", "green": False})     # 旧行: red
        + "\n"
        + json.dumps({"axis": "T", "green": True}),     # 新行: green (滚动更新)
        encoding="utf-8")
    led = cg.read_completeness_ledger("CAMP2", ammo_root=tmp_path)
    assert led["exists"] is True
    assert cg.completeness_gate_verdict(led)["axis_statuses"]["T"] == "green"
    assert cg.completeness_gate_verdict(led)["pass"] is False  # 其余四轴 unknown
