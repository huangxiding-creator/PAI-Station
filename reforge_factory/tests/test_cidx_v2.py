# -*- coding: utf-8 -*-
"""CIdx v2 双版本单测 (V-007 / REQ-030 / 百倍V4).

覆盖: ①合成六轴 → v2 六覆手算对拍 (含 D 十二维无缺格口径 + P L6 满分 6
+ BSP 过门比例) 且 v1 五轴口径在同一池上并行可算 (D 封顶 1.0 / P 永续 /5)
②v1 与 v2 并行落盘: 一次 assemble_v2 追加 13 行, 每行带 version, CIdx
汇总双行对账, 追加语义 (哨兵行保留) ③BSP 轴缺失时 v2 仍可算 (BSP=0,
missing_axes 记账) ④v2 纯函数逐件 (缺格/无格维/L6/零候选) ⑤真实池
BID26 双版本只读对照 (write=False; 池缺席 skip 不造假).
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from completeness import cidx  # noqa: E402


# ---- 夹具 -----------------------------------------------------------------

def write_axis(root: Path, letter: str, payload: dict) -> None:
    d = root / "completeness"
    d.mkdir(parents=True, exist_ok=True)
    (d / f"{letter}_axis.json").write_text(
        json.dumps(payload, ensure_ascii=False), encoding="utf-8"
    )


def dims12_payload(n_ok=10, n_downgraded=1, n_gap=1):
    """十二维 payload: n_ok 完整 + n_downgraded 降级(非缺格) + n_gap 缺格."""
    names = [f"维{i}" for i in range(12)]
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
            "green": not open_gaps}


def six_axes() -> dict:
    return {
        # 5 年 (2020-2024), 证据 {2020,2022,2024}=3 年, 豁免 2021 → 3/4 = 0.75
        "T": {"axis": "T", "founded_year": 2020, "current_year": 2024,
              "year_counts": {"2020": 1, "2021": 0, "2022": 3, "2023": 0,
                              "2024": 2},
              "gap_waivers": [{"year": 2021}], "green": True},
        # 6/10 点亮 → 0.6
        "B": {"axis": "B", "facets": {f"面{i}": {"lit": i < 6, "evidence": 1}
                                      for i in range(10)},
              "lit_count": 6, "green": True},
        # 12 维: 10 完整 + 1 降级(非缺格) + 1 缺格 → v2 无缺格 11/12
        # (sensor green 独立于分数, 同 facets_payload 口径显式置 True)
        "D": {**dims12_payload(), "green": True},
        # Σ(L×n)=0+1+2+6+8+10+6=33 → v2 33/60=0.55 (v1 33/50=0.66)
        "P": {"axis": "P", "eei_total": 10,
              "l_dist": {"L0": 1, "L1": 1, "L2": 1, "L3": 2, "L4": 2,
                         "L5": 2, "L6": 1},
              "green": True},
        # 4/5 = 0.8
        "C": {"axis": "C", "channels_hit": 4, "channels_total": 5,
              "green": True},
        # 候选 4 条过门 3 → 0.75
        "BSP": {"axis": "BSP", "sensor": "blindspot", "passed_count": 3,
                "failed_count": 1,
                "candidates": [{"c": i} for i in range(4)], "green": True},
    }


def seed_campaign(tmp_path, axes: dict, campaign="Camp2") -> Path:
    root = tmp_path / "ammo" / campaign
    for letter, payload in axes.items():
        write_axis(root, letter, payload)
    return root


# ---- ① 六轴手算对拍 + v1 并行 ----------------------------------------------

def test_01_v2_six_axis_handcalc(tmp_path):
    root = seed_campaign(tmp_path, six_axes())
    res = cidx.assemble_v2("Camp2", pool_root=root.parent,
                           ledger_path=tmp_path / "l.jsonl")
    v1, v2 = res["v1"], res["v2"]
    # v2 六覆手算: D=11/12=0.9167, P=33/60=0.55, BSP=3/4=0.75
    assert v2["axis_scores"] == {"T": 0.75, "B": 0.6, "D": 0.9167,
                                 "P": 0.55, "C": 0.8, "BSP": 0.75}
    # CIdx(v2) = .20×.75+.15×.6+.20×.9167+.20×.55+.10×.8+.15×.75 = 0.7258
    assert v2["cidx"] == 0.7258
    assert v2["missing_axes"] == [] and v2["all_green"] is True
    assert v2["weights"] == cidx.WEIGHTS_V2
    assert sum(cidx.WEIGHTS_V2.values()) == 1.0
    # v1 同池并行 (口径分道: D 12 维超 9 维分母 → 封顶 1.0; P 永续 /5=0.66)
    assert v1["axis_scores"]["D"] == 1.0
    assert v1["axis_scores"]["P"] == 0.66
    assert v1["cidx"] == 0.7595          # .25×.75+.2×.6+.2×1.0+.2×.66+.15×.8
    assert v1["cidx"] != v2["cidx"]      # 双版本各自成账, 不互相覆写


# ---- ② v1/v2 并行落盘 ------------------------------------------------------

def test_02_dual_version_parallel_ledger(tmp_path):
    root = seed_campaign(tmp_path, six_axes())
    ledger = tmp_path / "ledger.jsonl"
    ledger.write_text(
        json.dumps({"axis": "PRE", "note": "哨兵行, 重跑不得覆盖"},
                   ensure_ascii=False) + "\n", encoding="utf-8")
    res = cidx.assemble_v2("Camp2", pool_root=root.parent, ledger_path=ledger)
    lines = [json.loads(x) for x in
             ledger.read_text(encoding="utf-8").splitlines() if x.strip()]
    assert lines[0]["axis"] == "PRE"                    # 只增不删
    assert len(lines) == 1 + 5 + 1 + 6 + 1              # v1 六行 + v2 七行
    assert all(l.get("version") in ("v1", "v2") for l in lines[1:])
    v1_axis = [l for l in lines[1:] if l["version"] == "v1" and l["axis"] != "CIdx"]
    v2_axis = [l for l in lines[1:] if l["version"] == "v2" and l["axis"] != "CIdx"]
    assert {l["axis"] for l in v1_axis} == set(cidx.AXES)           # 五轴
    assert {l["axis"] for l in v2_axis} == set(cidx.AXES_V2)        # 六轴
    bsp_row = next(l for l in v2_axis if l["axis"] == "BSP")
    assert bsp_row["sensor"] == "blindspot" and bsp_row["score"] == 0.75
    cidx_rows = [l for l in lines[1:] if l["axis"] == "CIdx"]
    assert [l["version"] for l in cidx_rows] == ["v1", "v2"]         # 汇总双行
    assert cidx_rows[0]["cidx"] == res["v1"]["cidx"] == 0.7595
    assert cidx_rows[1]["cidx"] == res["v2"]["cidx"] == 0.7258
    # v1 独立 assemble 的结果与并行落盘的 v1 行同值 (口径未动)
    solo = cidx.assemble("Camp2", pool_root=root.parent, write=False)
    assert solo["cidx"] == cidx_rows[0]["cidx"]
    assert solo["axis_scores"] == cidx_rows[0]["axis_scores"]


# ---- ③ BSP 轴缺失 → v2 仍可算 (BSP=0) -------------------------------------

def test_03_bsp_missing_v2_still_computable(tmp_path):
    axes = six_axes()
    del axes["BSP"]                                     # BSP 轴文件缺席
    root = seed_campaign(tmp_path, axes)
    res = cidx.assemble_v2("Camp2", pool_root=root.parent,
                           ledger_path=tmp_path / "l.jsonl")
    v2 = res["v2"]
    assert v2["missing_axes"] == ["BSP"]
    assert v2["axis_scores"]["BSP"] == 0.0
    # BSP 计 0 仍出数: 0.7258 - 0.15×0.75 = 0.6133
    assert v2["cidx"] == 0.6133
    assert v2["all_green"] is False                     # 缺轴不可 green
    bsp_row = next(l for l in res["v2_axis_rows"] if l["axis"] == "BSP")
    assert bsp_row["missing"] is True and bsp_row["score"] == 0.0


# ---- ④ v2 纯函数逐件 -------------------------------------------------------

def test_04_v2_scorer_units():
    D = cidx.score_d_v2
    # 12 维全有格无缺格 → 1.0; 缺格 2 → 10/12
    assert D(dims12_payload(n_ok=12, n_downgraded=0, n_gap=0)) == 1.0
    assert D(dims12_payload(n_ok=10, n_downgraded=0, n_gap=2)) == \
        round(10 / 12, 4)
    # 无格维 (dims 有名 cells 无格) 不计覆盖; 非 dict payload/无 dims → 0
    p = dims12_payload(n_ok=12, n_downgraded=0, n_gap=0)
    del p["cells"]["维0"]
    assert D(p) == round(11 / 12, 4)
    assert D({"axis": "D"}) == 0.0 and D(None) == 0.0
    # P v2: L6 满分 6 — 同 l_dist v1 (/5) 溢出由 _r4 封顶 1.0, v2 (/6) 归一
    pl = {"eei_total": 2, "l_dist": {"L5": 1, "L6": 1}}
    assert cidx.score_p_v2(pl) == round(11 / 12, 4)
    assert cidx.score_p(pl) == 1.0                  # v1: 11/10>1 → 封顶
    assert cidx.score_p_v2({"eei_total": 3, "mean_depth_norm": 0.5}) == 0.5
    # BSP: 过门比例; 零候选/缺字段 → 0
    B = cidx.score_bsp
    assert B({"passed_count": 3, "candidates": [1, 2, 3, 4]}) == 0.75
    assert B({"passed_count": 0, "candidates": [1, 2]}) == 0.0
    assert B({"passed_count": 2, "failed_count": 2}) == 0.5   # 无 candidates 回退
    assert B({"passed_count": 2}) == 0.0                      # 分母不可得
    assert B({"axis": "BSP"}) == 0.0 and B(None) == 0.0
    # compute_cidx_v2: 缺轴按 0 计
    assert cidx.compute_cidx_v2({"T": 1.0}) == round(0.20, 4)


# ---- ⑤ 真实池 BID26 双版本只读对照 ------------------------------------------

REAL_ROOT = Path(__file__).resolve().parents[2] / "ammo_pool"


@pytest.mark.skipif(not (REAL_ROOT / "EPC-BID26" / "completeness").is_dir(),
                    reason="真实池 BID26 completeness/ 缺席")
def test_05_real_bid26_dual_readonly_smoke():
    res = cidx.assemble_v2("EPC-BID26", write=False)
    assert res["ledger"] is None                          # 只读不落盘
    solo = cidx.assemble("EPC-BID26", write=False)
    assert res["v1"]["cidx"] == solo["cidx"]              # v1 口径未动
    assert res["v1"]["axis_scores"] == solo["axis_scores"]
    for ver, summ in (("v1", res["v1"]), ("v2", res["v2"])):
        for k, v in summ["axis_scores"].items():
            assert 0.0 <= v <= 1.0, (ver, k)
        assert 0.0 <= summ["cidx"] <= 1.0
        assert isinstance(summ["all_green"], bool)
    # BID26 现无 BSP 轴件 → v2 记账缺失且计 0 (不炸不造假)
    if "BSP" in res["v2"]["missing_axes"]:
        assert res["v2"]["axis_scores"]["BSP"] == 0.0
    assert set(res["v2"]["axis_scores"]) == set(cidx.AXES_V2)


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception:
            fail += 1
            import traceback
            traceback.print_exc()
            print(f"  FAIL {fn.__name__}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
