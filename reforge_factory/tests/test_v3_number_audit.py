# -*- coding: utf-8 -*-
"""test_v3_number_audit — 数字零造假复算抽检单测 (T-027 / REQ-001.AC1).

五大类各抽 N 处的只读复算审计件:
  ①完备性  ②漏斗  ③字数  ④决策账本  ⑤冲刺账本
合成数据全一致 → exit 0; 故意植入错数 → exit 2 且定位到具体条目。

跑法: py -m pytest reforge_factory/tests/test_v3_number_audit.py -q
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import v3_number_audit as NA                                    # noqa: E402

REPO_ROOT = Path(__file__).resolve().parents[2]
REAL_FUNNEL_QUERY = REPO_ROOT / "report_platform" / "funnel_query.py"
REAL_SPRINT_LEDGER = REPO_ROOT / "reforge_factory" / "sprint_ledger.py"

FUNNEL_LEVELS = ("visit", "sample_read", "click_buy", "pay")


# ---------------------------------------------------------- 夹具构造 ----------
def _wl(path: Path, rows: list[dict]) -> None:
    path.parent.mkdir(parents=True, exist_ok=True)
    with path.open("w", encoding="utf-8") as fh:
        for r in rows:
            fh.write(json.dumps(r, ensure_ascii=False) + "\n")


def _mk_completeness_pool(root: Path, campaign: str = "SYN-CMP") -> Path:
    """五轴 json 原始字段 → 期望分 T=0.6667 B=0.3 D=0.9444 P=0.4 C=0.25, CIdx=0.5331."""
    d = root / campaign
    cdir = d / "completeness"
    cdir.mkdir(parents=True, exist_ok=True)
    (cdir / "T_axis.json").write_text(json.dumps({
        "axis": "T", "sensor": "entity_timeline",
        "year_counts": {"2020": 5, "2021": 0, "2022": 3},
        "founded_year": 2020, "current_year": 2022, "gap_waivers": [],
    }, ensure_ascii=False), encoding="utf-8")
    facets = {f"面{i}": {"lit": i < 3} for i in range(10)}
    (cdir / "B_axis.json").write_text(json.dumps({
        "axis": "B", "sensor": "coverage_facets",
        "lit_count": 3, "facets": facets,
    }, ensure_ascii=False), encoding="utf-8")
    dims = [f"维{i}" for i in range(9)]
    cells = {dm: {"downgraded": i == 8} for i, dm in enumerate(dims)}
    (cdir / "D_axis.json").write_text(json.dumps({
        "axis": "D", "sensor": "dimension_matrix",
        "dims": dims, "cells": cells, "open_gaps": [],
    }, ensure_ascii=False), encoding="utf-8")
    (cdir / "P_axis.json").write_text(json.dumps({
        "axis": "P", "sensor": "depth_ladder",
        "l_dist": {"L0": 2, "L3": 4}, "eei_total": 6,
    }, ensure_ascii=False), encoding="utf-8")
    (cdir / "C_axis.json").write_text(json.dumps({
        "axis": "C", "sensor": "channel_matrix",
        "channels_hit": 5, "channels_total": 20,
    }, ensure_ascii=False), encoding="utf-8")
    return d


_CMP_SUMMARY = {
    "ts": "2026-10-15T00:00:00", "axis": "CIdx", "campaign": "SYN-CMP",
    "axis_scores": {"T": 0.6667, "B": 0.3, "D": 0.9444, "P": 0.4, "C": 0.25},
    "cidx": 0.5331, "all_green": False, "missing_axes": [], "waived_axes": [],
    "weights": {"T": 0.25, "B": 0.2, "D": 0.2, "P": 0.2, "C": 0.15},
}


def _mk_chars_pool(root: Path, name: str, t1_chars: int) -> Path:
    """manifest 行级: 招标标题 100 计 T1; 其他 50 不计; 重复 dedup 不计;
    reject 不计; 坏行不计 → 标题级重算 t1=100, n1=1."""
    d = root / name
    d.mkdir(parents=True, exist_ok=True)
    (d / "tiers.json").write_text(json.dumps(
        {"T1": ["招标"], "T2": ["合同"]}, ensure_ascii=False), encoding="utf-8")
    rows = [
        {"judge": "valid", "dedup_key": "c:1", "source_path": "x/招标公告.md",
         "url_norm": "", "chars": 100},
        {"judge": "valid", "dedup_key": "c:2", "source_path": "x/其他资料.md",
         "url_norm": "", "chars": 50},
        {"judge": "valid", "dedup_key": "c:1", "source_path": "x/招标公告.md",
         "url_norm": "", "chars": 999},                      # 重复 dedup → 不计
        {"judge": "reject", "dedup_key": "c:3", "source_path": "x/招标废件.md",
         "url_norm": "", "chars": 700},                      # reject → 不计
        {"judge": "valid", "dedup_key": "c:4", "source_path": "x/合同范本.md",
         "url_norm": "", "chars": 60},                       # T2 → 不入 t1
    ]
    _wl(d / "manifest.jsonl", rows)
    with (d / "manifest.jsonl").open("a", encoding="utf-8") as fh:
        fh.write("{bad json line\n")                          # 坏行 → 不计
    (d / "pool_state.json").write_text(json.dumps(
        {"campaign": name, "t1_chars": t1_chars, "t1_items": 1,
         "t2_chars": 60}, ensure_ascii=False), encoding="utf-8")
    return d


def _mk_decision_ledger(root: Path, campaign: str = "SYN-DEC") -> Path:
    d = root / campaign
    d.mkdir(parents=True, exist_ok=True)
    rows = []
    for i in (1, 2, 3):
        rows.append({
            "id": f"D-{i:04d}", "ts": "2026-10-15T00:00:00",
            "decision_type": "research_rounds", "context": {"k": 1},
            "options": [{"k": "a", "v": 1}, {"k": "b", "v": 2}], "chosen": "a",
            "rationale": "理由", "budget_used": None,
            "outcome": None, "outcome_ts": None, "score": None,
        })
    p = d / "decision_ledger.jsonl"
    _wl(p, rows)
    return p


def _mk_sprint_ledger(path: Path, *, double_w1: bool = True) -> None:
    """W1 两行 (修正语义: 末行 actual=100.0 生效), W2 一行."""
    rows = [
        {"week": "W1", "span": "2026-10-15~2026-10-21", "target": 5000,
         "actual": 0.0, "note": "首行", "ts": "2026-10-15T10:00:00+08:00"},
        {"week": "W1", "span": "2026-10-15~2026-10-21", "target": 5000,
         "actual": 100.0, "note": "修正行", "ts": "2026-10-15T11:00:00+08:00"},
        {"week": "W2", "span": "2026-10-22~2026-10-28", "target": 25000,
         "actual": 120.5, "note": "", "ts": "2026-10-22T10:00:00+08:00"},
    ]
    if not double_w1:
        rows = rows[1:]
    _wl(path, rows)


# ---------------------------------------------------------- ① 完备性 ----------
class TestCompleteness:
    def test_consistent(self, tmp_path):
        d = _mk_completeness_pool(tmp_path)
        _wl(d / "completeness_ledger.jsonl",
            [dict(_CMP_SUMMARY, ts="2026-10-14T00:00:00", cidx=0.5),
             _CMP_SUMMARY])                     # 最新 CIdx 行生效
        items, notes = NA.audit_completeness(d)
        assert len(items) == 6                  # 五轴 + CIdx 合成
        assert all(it["match"] for it in items), items
        assert items[0]["item"] == "completeness/T覆"
        assert items[5]["item"] == "completeness/CIdx加权"
        assert items[5]["recomputed_value"] == pytest.approx(0.5331, abs=1e-6)

    def test_tampered_axis_and_cidx_pinpointed(self, tmp_path):
        d = _mk_completeness_pool(tmp_path)
        bad = dict(_CMP_SUMMARY)
        bad["axis_scores"] = dict(bad["axis_scores"], B=0.9)   # 植入错轴分
        bad["cidx"] = 0.6                                      # 植入错合成
        _wl(d / "completeness_ledger.jsonl", [bad])
        items, _ = NA.audit_completeness(d)
        mism = {it["item"] for it in items if not it["match"]}
        assert "completeness/B覆" in mism
        assert "completeness/CIdx加权" in mism
        b = next(it for it in items if it["item"] == "completeness/B覆")
        assert b["recomputed_value"] == pytest.approx(0.3, abs=1e-9)

    def test_missing_axis_file_failsoft_zero(self, tmp_path):
        d = _mk_completeness_pool(tmp_path)
        (d / "completeness" / "C_axis.json").unlink()
        _wl(d / "completeness_ledger.jsonl", [_CMP_SUMMARY])
        items, notes = NA.audit_completeness(d)
        c = next(it for it in items if it["item"] == "completeness/C覆")
        assert c["match"] is False and c["recomputed_value"] == 0.0
        assert any("轴文件缺" in n for n in notes)

    def test_no_cidx_row_noted(self, tmp_path):
        d = _mk_completeness_pool(tmp_path)
        _wl(d / "completeness_ledger.jsonl",                  # 只有轴行, 无汇总行
            [{"ts": "t", "axis": "T", "sensor": "entity_timeline",
              "score": 0.1, "green": True, "waived": False,
              "missing": False, "note": ""}])
        items, notes = NA.audit_completeness(d)
        assert items == []
        assert any("CIdx" in n for n in notes)

    def test_ledger_missing_noted(self, tmp_path):
        d = _mk_completeness_pool(tmp_path)
        items, notes = NA.audit_completeness(d)
        assert items == []
        assert any("不存在" in n for n in notes)


# ---------------------------------------------------------- ② 漏斗 ----------
class TestFunnel:
    def test_consistent_against_real_tool(self, tmp_path):
        ledger = tmp_path / "funnel_events.jsonl"
        rows = [
            {"sku": "SKU-A", "channel": "gzh", "level": "visit", "ts":
             "2026-10-15T10:00:00+08:00", "ref": ""},
        ] * 3 + [
            {"sku": "SKU-A", "channel": "gzh", "level": "sample_read", "ts":
             "2026-10-15T10:01:00+08:00", "ref": ""},
            {"sku": "SKU-B", "channel": "site", "level": "visit", "ts":
             "2026-10-15T10:02:00+08:00", "ref": ""},
        ]
        _wl(ledger, rows)
        with ledger.open("a", encoding="utf-8") as fh:
            fh.write("{broken\n")                                # 坏行两侧同跳过
            fh.write(json.dumps({"sku": "SKU-A", "channel": "gzh",
                                 "level": "visitx"}) + "\n")     # 非法级同跳过
        db = tmp_path / "absent.db"                              # 不存在 → sqlite 恒 0
        items, notes = NA.audit_funnel(
            ledger, REAL_FUNNEL_QUERY, db, n=5)
        assert all(it["match"] for it in items), items
        total = next(it for it in items if it["item"] == "funnel/total_events")
        assert total["source_value"] == 5 and total["recomputed_value"] == 5
        a_visit = next(it for it in items
                       if it["item"] == "funnel/SKU-A/visit")
        assert a_visit["source_value"] == 3

    def test_detects_tool_divergence(self, tmp_path):
        """植入: 工具侧计数漂移 (模拟上报数字与账本不符) → 定位到 (sku,level)."""
        ledger = tmp_path / "funnel_events.jsonl"
        _wl(ledger, [{"sku": "SKU-A", "channel": "gzh", "level": "visit",
                      "ts": "t", "ref": ""}] * 2)

        def lying_runner(sku, ledger, db):
            return {"sources": {"jsonl": 2},
                    "per_sku": {"SKU-A": {"visit": 5, "sample_read": 0,
                                          "click_buy": 0, "pay": 0}}}
        items, _ = NA.audit_funnel(ledger, REAL_FUNNEL_QUERY,
                                   tmp_path / "absent.db",
                                   query_runner=lying_runner)
        v = next(it for it in items if it["item"] == "funnel/SKU-A/visit")
        assert v["match"] is False
        assert v["source_value"] == 2 and v["recomputed_value"] == 5

    def test_empty_ledger_only_total_item(self, tmp_path):
        ledger = tmp_path / "funnel_events.jsonl"
        ledger.write_text("", encoding="utf-8")
        items, notes = NA.audit_funnel(
            ledger, REAL_FUNNEL_QUERY, tmp_path / "absent.db")
        assert [it["item"] for it in items] == ["funnel/total_events"]
        assert items[0]["match"] and items[0]["source_value"] == 0
        assert any("无合法事件" in n for n in notes)


# ---------------------------------------------------------- ③ 字数 ----------
class TestChars:
    def test_consistent(self, tmp_path):
        _mk_chars_pool(tmp_path, "POOL-OK", t1_chars=100)
        items, notes = NA.audit_chars(tmp_path, n=5)
        assert len(items) == 1
        it = items[0]
        assert it["item"] == "chars/POOL-OK/t1_chars"
        assert it["match"] and it["recomputed_value"] == 100

    def test_tampered_pool_state_pinpointed(self, tmp_path):
        _mk_chars_pool(tmp_path, "POOL-BAD", t1_chars=101)      # 植入错数
        items, _ = NA.audit_chars(tmp_path, n=5)
        assert items[0]["match"] is False
        assert items[0]["diff"] == 1
        assert items[0]["source_value"] == 101
        assert items[0]["recomputed_value"] == 100

    def test_tier_gate_v3_source_and_no_t1_pool(self, tmp_path):
        d = _mk_chars_pool(tmp_path, "POOL-V3", t1_chars=100)
        st = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        del st["t1_chars"]                                        # 只剩 v3 口径
        st["tier_gate_v3"] = {"t1_chars": 100, "t2_chars": 60,
                              "t1_t2_source": "manifest重算(测试)"}
        (d / "pool_state.json").write_text(
            json.dumps(st, ensure_ascii=False), encoding="utf-8")
        _mk_chars_pool(tmp_path, "POOL-NOT1", t1_chars=100)
        st2 = json.loads((tmp_path / "POOL-NOT1" / "pool_state.json")
                         .read_text(encoding="utf-8"))
        del st2["t1_chars"]
        (tmp_path / "POOL-NOT1" / "pool_state.json").write_text(
            json.dumps(st2, ensure_ascii=False), encoding="utf-8")
        items, notes = NA.audit_chars(tmp_path, n=5)
        got = {it["item"]: it for it in items}
        assert set(got) == {"chars/POOL-V3/t1_chars"}
        assert got["chars/POOL-V3/t1_chars"]["match"]
        assert any("POOL-NOT1" in n and "无 t1" in n for n in notes)


# ---------------------------------------------------------- ④ 决策账本 ----------
class TestDecision:
    def test_consistent(self, tmp_path):
        _mk_decision_ledger(tmp_path)
        items, notes = NA.audit_decisions(tmp_path, n=5)
        schema = [it for it in items if it["item"].endswith(":schema")]
        cont = [it for it in items if it["item"].endswith("/id连续性")]
        assert len(schema) == 3 and all(it["match"] for it in schema)
        assert len(cont) == 1 and cont[0]["match"]

    def test_schema_hole_and_id_gap_pinpointed(self, tmp_path):
        p = _mk_decision_ledger(tmp_path)
        lines = [json.loads(x) for x in
                 p.read_text(encoding="utf-8").splitlines() if x.strip()]
        del lines[1]["rationale"]                                 # 植入: 缺键
        lines[2]["id"] = "D-0009"                                 # 植入: 跳号
        _wl(p, lines)
        items, _ = NA.audit_decisions(tmp_path, n=5)
        mism = {it["item"] for it in items if not it["match"]}
        assert "decision/SYN-DEC/D-0002:schema" in mism
        assert "decision/SYN-DEC/id连续性" in mism

    def test_no_ledger_noted_not_failed(self, tmp_path):
        items, notes = NA.audit_decisions(tmp_path, n=5)
        assert items == []
        assert any("decision_ledger" in n for n in notes)


# ---------------------------------------------------------- ⑤ 冲刺账本 ----------
class TestSprint:
    def test_consistent_against_real_tool(self, tmp_path):
        ledger = tmp_path / "sprint_ledger.jsonl"
        mirror = tmp_path / "mirror.jsonl"
        _mk_sprint_ledger(ledger)
        _mk_sprint_ledger(mirror)
        items, notes = NA.audit_sprint(
            ledger, REAL_SPRINT_LEDGER, mirror=mirror,
            status_runner=None)                    # 默认子进程跑真工具
        assert all(it["match"] for it in items), items
        got = {it["item"]: it for it in items}
        assert got["sprint/W1/actual"]["source_value"] == pytest.approx(100.0)
        assert got["sprint/W2/target"]["source_value"] == 25000
        assert got["sprint/cum/actual"]["recomputed_value"] == \
            pytest.approx(220.5)
        assert got["sprint/cum/plan_target"]["recomputed_value"] == 30000
        assert got["sprint/mirror_parity"]["match"]

    def test_mirror_drift_detected(self, tmp_path):
        ledger = tmp_path / "sprint_ledger.jsonl"
        mirror = tmp_path / "mirror.jsonl"
        _mk_sprint_ledger(ledger)
        _mk_sprint_ledger(mirror, double_w1=True)
        with mirror.open("w", encoding="utf-8") as fh:           # 镜像少一行
            fh.write(json.dumps({"week": "W1", "span": "s", "target": 5000,
                                 "actual": 0.0, "note": "", "ts": "t"},
                                ensure_ascii=False) + "\n")
        items, _ = NA.audit_sprint(
            ledger, REAL_SPRINT_LEDGER, mirror=mirror)
        par = next(it for it in items if it["item"] == "sprint/mirror_parity")
        assert par["match"] is False

    def test_status_divergence_detected(self, tmp_path):
        ledger = tmp_path / "sprint_ledger.jsonl"
        _mk_sprint_ledger(ledger, double_w1=False)
        ledger / "nonexist"                        # noqa: B018 (占位防误删)
        rows = [json.loads(x) for x in
                ledger.read_text(encoding="utf-8").splitlines() if x.strip()]

        def lying_runner(path):
            weeks = []
            for r in rows:
                weeks.append({"week": r["week"], "settled": True,
                              "target": r["target"],
                              "actual": r["actual"] + 999})       # 植入漂移
            return {"weeks": weeks, "actual_cum": 9999,
                    "plan_cum_of_settled": 1}
        items, _ = NA.audit_sprint(
            ledger, REAL_SPRINT_LEDGER, mirror=None,
            status_runner=lying_runner)
        mism = {it["item"] for it in items if not it["match"]}
        assert "sprint/W2/actual" in mism
        assert "sprint/cum/actual" in mism
        assert "sprint/cum/plan_target" in mism

    def test_no_ledger_noted(self, tmp_path):
        items, notes = NA.audit_sprint(
            tmp_path / "none.jsonl", REAL_SPRINT_LEDGER, mirror=None)
        assert items == []
        assert any("账本不存在" in n for n in notes)


# ---------------------------------------------------------- main 出口 ----------
class TestMain:
    def _world(self, tmp_path):
        ammo = tmp_path / "ammo"
        d = _mk_completeness_pool(ammo, "SYN-CMP")
        _wl(d / "completeness_ledger.jsonl", [_CMP_SUMMARY])
        _mk_chars_pool(ammo, "POOL-OK", t1_chars=100)
        _mk_decision_ledger(ammo)
        funnel = tmp_path / "funnel_events.jsonl"
        _wl(funnel, [{"sku": "SKU-A", "channel": "gzh", "level": "visit",
                      "ts": "t", "ref": ""}])
        sprint = tmp_path / "sprint.jsonl"
        mirror = tmp_path / "mirror.jsonl"
        _mk_sprint_ledger(sprint, double_w1=False)
        _mk_sprint_ledger(mirror, double_w1=False)
        return ["--n", "5", "--campaign", "SYN-CMP",
                "--ammo-root", str(ammo),
                "--funnel-ledger", str(funnel),
                "--funnel-query", str(REAL_FUNNEL_QUERY),
                "--funnel-db", str(tmp_path / "absent.db"),
                "--sprint-ledger", str(sprint),
                "--sprint-mirror", str(mirror),
                "--sprint-script", str(REAL_SPRINT_LEDGER),
                "--json"]

    def test_exit0_on_consistent_synthetic(self, tmp_path, capsys):
        rc = NA.main(self._world(tmp_path))
        assert rc == 0
        out = json.loads(capsys.readouterr().out)
        assert out["exit_code"] == 0
        assert out["totals"]["mismatch"] == 0
        assert out["totals"]["checked"] >= 13

    def test_exit2_on_planted_wrong_number(self, tmp_path, capsys):
        args = self._world(tmp_path)
        d = tmp_path / "ammo" / "POOL-OK"
        st = json.loads((d / "pool_state.json").read_text(encoding="utf-8"))
        st["t1_chars"] = 888                                      # 植入错数
        (d / "pool_state.json").write_text(
            json.dumps(st, ensure_ascii=False), encoding="utf-8")
        rc = NA.main(args)
        assert rc == 2
        out = json.loads(capsys.readouterr().out)
        assert out["exit_code"] == 2
        bad = [it for it in out["items"] if not it["match"]]
        assert any(it["item"] == "chars/POOL-OK/t1_chars" for it in bad)
        assert out["totals"]["mismatch"] >= 1
