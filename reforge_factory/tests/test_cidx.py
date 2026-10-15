# -*- coding: utf-8 -*-
"""CIdx 完备度指数测试 (T-008 / REQ-020.AC1 / KB-COMPLETENESS-SPEC).

覆盖:
  1. 全绿合成五轴 → CIdx 手算对拍 (0.7004)
  2. 缺轴 → 该轴 unknown 计 0 分 + missing_axes, all_green False
  3. 带豁免轴 (green=false 但 waived=true) → all_green True + waived_axes
  4. 五轴 json 齐但字段缺/坏 JSON → fail-soft 计 0 不炸
  5. ledger 追加语义: 重跑加行不覆盖, 每行带 axis, 五轴+CIdx 各就位
  6. 真实池 BID26 只读冒烟 (write=False 不落盘; 池缺席则 skip 不造假)
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from completeness import cidx  # noqa: E402

# ---- 夹具 ---------------------------------------------------------------


def write_axis(root: Path, letter: str, payload: dict) -> None:
    d = root / "completeness"
    d.mkdir(parents=True, exist_ok=True)
    (d / f"{letter}_axis.json").write_text(
        json.dumps(payload, ensure_ascii=False), encoding="utf-8"
    )


def facets_payload(lit_mask, green=True):
    """十面 payload: lit_mask 10 布尔 → lit_count=Σ.

    green 是传感器自己的判定 (阈值口径), 与分数独立 — 汇聚器只读不重判。
    """
    names = [f"面{i}" for i in range(10)]
    facets = {
        n: {"evidence": 2 if m else 0, "lit": bool(m)} for n, m in zip(names, lit_mask)
    }
    return {"axis": "B", "facets": facets, "lit_count": sum(lit_mask),
            "green": green}


def dims_payload(n_ok=9, n_downgraded=0, n_gap=0):
    """九维 payload: n_ok 完整 + n_downgraded 降级 + n_gap 缺格 (L0)."""
    names = [f"维{i}" for i in range(9)]
    cells, open_gaps = {}, []
    for i, n in enumerate(names):
        if i < n_ok:
            cells[n] = {"depth": "L3", "downgraded": False}
        elif i < n_ok + n_downgraded:
            cells[n] = {"depth": "L1", "downgraded": True, "reason": "薄料"}
        else:
            cells[n] = {"depth": "L0", "downgraded": True, "reason": "无命中资料"}
            open_gaps.append(n)
    return {"axis": "D", "dims": names, "cells": cells, "open_gaps": open_gaps,
            "downgraded_count": n_downgraded + n_gap,
            "green": not open_gaps}


def t_payload(year_counts, founded, current, waivers=(), green=True):
    return {"axis": "T", "founded_year": founded, "current_year": current,
            "year_counts": year_counts,
            "gap_waivers": [{"year": y, "reason": "三史+官网+年报均查无"}
                            for y in waivers],
            "green": green}


def all_green_axes() -> dict:
    return {
        # 5 年 (2020-2024), 有证据 {2020,2022,2024}=3 年, 豁免 2021 → 3/(5-1)=0.75
        "T": t_payload({"2020": 1, "2021": 0, "2022": 3, "2023": 0, "2024": 2},
                       2020, 2024, waivers=[2021]),
        # 6/10 点亮 → 0.6
        "B": facets_payload([1, 1, 1, 1, 1, 1, 0, 0, 0, 0]),
        # 8 完整 + 1 降级 → (8+0.5)/9 = 0.9444
        "D": dims_payload(n_ok=8, n_downgraded=1),
        # Σ(L×n)=1×2+2×2+3×2+4×1+5×1=21, 21/(5×10)=0.42
        "P": {"axis": "P", "eei_total": 10,
              "l_dist": {"L0": 2, "L1": 2, "L2": 2, "L3": 2, "L4": 1, "L5": 1},
              "green": True},
        # 4/5 = 0.8
        "C": {"axis": "C", "channels_hit": 4, "channels_total": 5,
              "hit_ratio": 0.8, "green": True},
    }


def seed_campaign(tmp_path, axes: dict, campaign="Camp") -> Path:
    root = tmp_path / "ammo" / campaign
    for letter, payload in axes.items():
        write_axis(root, letter, payload)
    return root


# ---- 1. 全绿手算对拍 ------------------------------------------------------

def test_all_green_known_score(tmp_path):
    root = seed_campaign(tmp_path, all_green_axes())
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    # 手算: 0.25×0.75 + 0.20×0.6 + 0.20×0.9444 + 0.20×0.42 + 0.15×0.8
    #     = 0.1875 + 0.12 + 0.18888 + 0.084 + 0.12 = 0.70038 → 0.7004
    assert res["axis_scores"] == {"T": 0.75, "B": 0.6, "D": 0.9444,
                                  "P": 0.42, "C": 0.8}
    assert res["cidx"] == 0.7004
    assert res["all_green"] is True
    assert res["missing_axes"] == []
    assert res["waived_axes"] == []


# ---- 2. 缺轴 → unknown 计 0 + missing_axes --------------------------------

def test_missing_axis_scores_zero(tmp_path):
    axes = all_green_axes()
    del axes["C"]  # C 轴文件缺席
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    assert res["missing_axes"] == ["C"]
    assert res["axis_scores"]["C"] == 0.0
    assert res["all_green"] is False  # 缺轴不可 green
    # T/B/D/P 用全绿夹具原值, C 计 0: 0.1875+0.12+0.18888+0.084+0 = 0.5804
    assert res["cidx"] == round(0.25 * 0.75 + 0.20 * 0.6 + 0.20 * 0.9444
                                + 0.20 * 0.42 + 0.15 * 0.0, 4)


# ---- 3. 带豁免轴: green=false 但 waived → all_green True -------------------

def test_waived_axis_still_all_green(tmp_path):
    axes = all_green_axes()
    axes["C"] = {"axis": "C", "channels_hit": 1, "channels_total": 5,
                 "green": False, "waived": True,
                 "waiver_reason": "渠道在建 (SOP 四步法 T-015)"}
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    assert res["waived_axes"] == ["C"]
    assert res["all_green"] is True  # green 或 waived
    assert res["axis_scores"]["C"] == 0.2  # 豁免只免 green 门, 分照实算


# ---- 4. 字段缺 / 坏 JSON → fail-soft 计 0 不炸 -----------------------------

def test_field_missing_fail_soft(tmp_path):
    root = tmp_path / "ammo" / "Camp"
    write_axis(root, "T", {"axis": "T"})             # 无 year_counts/founded
    write_axis(root, "B", {"axis": "B"})             # 无 lit_count/facets
    write_axis(root, "D", {"axis": "D"})             # 无 dims/cells
    write_axis(root, "P", {"axis": "P"})             # 无 l_dist/eei_total
    write_axis(root, "C", {"axis": "C"})             # 无 channels_*
    res = cidx.assemble("Camp", pool_root=root.parent,
                        ledger_path=tmp_path / "l.jsonl")
    assert res["axis_scores"] == {"T": 0.0, "B": 0.0, "D": 0.0, "P": 0.0, "C": 0.0}
    assert res["cidx"] == 0.0
    assert res["all_green"] is False
    assert res["missing_axes"] == []  # 文件在, 只是字段缺


def test_broken_json_treated_missing(tmp_path):
    root = tmp_path / "ammo" / "Camp"
    (root / "completeness").mkdir(parents=True)
    (root / "completeness" / "T_axis.json").write_text("{not json", encoding="utf-8")
    axes = all_green_axes()
    for letter, payload in axes.items():
        if letter != "T":
            write_axis(root, letter, payload)
    res = cidx.assemble("Camp", pool_root=root.parent,
                        ledger_path=tmp_path / "l.jsonl")
    assert "T" in res["missing_axes"]
    assert res["axis_scores"]["T"] == 0.0


def test_p_fallback_mean_depth_norm(tmp_path):
    """l_dist 缺席但 mean_depth_norm 在 → 直接采用传感器算好的值."""
    axes = all_green_axes()
    axes["P"] = {"axis": "P", "eei_total": 10, "mean_depth_norm": 0.42,
                 "green": True}
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    assert res["axis_scores"]["P"] == 0.42


def test_d_gap_dim_scores_zero(tmp_path):
    """缺格维 (open_gaps/L0) 计 0 而非 0.5: 7 完整+1降级+1缺格 → 7.5/9."""
    axes = all_green_axes()
    axes["D"] = dims_payload(n_ok=7, n_downgraded=1, n_gap=1)
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    assert res["axis_scores"]["D"] == round(7.5 / 9, 4)


def test_t_waivers_denominator(tmp_path):
    """豁免年出分母: 5 年 2 证据 2 豁免 → 2/(5-2)."""
    axes = all_green_axes()
    axes["T"] = t_payload({"2020": 1, "2021": 0, "2022": 0, "2023": 5, "2024": 0},
                          2020, 2024, waivers=[2021, 2022])
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble("Camp", pool_root=root.parent, ledger_path=tmp_path / "l.jsonl")
    assert res["axis_scores"]["T"] == round(2 / 3, 4)


# ---- 5. ledger 追加语义: 加行不覆盖 ---------------------------------------

def test_ledger_append_semantics(tmp_path):
    root = seed_campaign(tmp_path, all_green_axes())
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(
        json.dumps({"axis": "PRE", "note": "哨兵行, 重跑不得覆盖"},
                   ensure_ascii=False) + "\n", encoding="utf-8")
    r1 = cidx.assemble("Camp", pool_root=root.parent, ledger_path=ledger)
    r2 = cidx.assemble("Camp", pool_root=root.parent, ledger_path=ledger)
    lines = [json.loads(l) for l in ledger.read_text(encoding="utf-8").splitlines()
             if l.strip()]
    assert lines[0]["axis"] == "PRE"            # 原有行保留
    assert len(lines) == 1 + 6 + 6              # 每跑一次追加 5 轴行 + 1 汇总行
    axes = {l["axis"] for l in lines}
    assert {"T", "B", "D", "P", "C", "CIdx"} <= axes
    cidx_rows = [l for l in lines if l["axis"] == "CIdx"]
    assert len(cidx_rows) == 2                  # 重跑各追加一条汇总
    assert cidx_rows[0]["cidx"] == r1["cidx"] == 0.7004
    assert cidx_rows[1]["cidx"] == r2["cidx"] == 0.7004
    t_rows = [l for l in lines if l["axis"] == "T"]
    assert all(r["score"] == 0.75 for r in t_rows)
    assert cidx_rows[0]["all_green"] is True


def test_ledger_default_path(tmp_path):
    """ledger_path 缺省 → ammo_pool/<战役>/completeness_ledger.jsonl."""
    root = seed_campaign(tmp_path, all_green_axes())
    cidx.assemble("Camp", pool_root=root.parent)
    ledger = root / "completeness_ledger.jsonl"
    assert ledger.is_file()
    lines = [json.loads(l) for l in ledger.read_text(encoding="utf-8").splitlines()
             if l.strip()]
    assert len(lines) == 6


# ---- 6. 真实池 BID26 只读冒烟 ---------------------------------------------

REAL_ROOT = Path(__file__).resolve().parents[2] / "ammo_pool"


@pytest.mark.skipif(not (REAL_ROOT / "EPC-BID26" / "completeness").is_dir(),
                    reason="真实池 BID26 completeness/ 缺席")
def test_real_bid26_readonly_smoke():
    res = cidx.assemble("EPC-BID26", write=False)
    assert set(res["axis_scores"]) == {"T", "B", "D", "P", "C"}
    for k, v in res["axis_scores"].items():
        assert 0.0 <= v <= 1.0, k
    assert 0.0 <= res["cidx"] <= 1.0
    assert isinstance(res["all_green"], bool)
