# -*- coding: utf-8 -*-
"""完备性热图生成测试 (T-009 / REQ-025 合成侧).

覆盖:
  1. 全轴合成 → md 含五轴名/CIdx/图例三字符; json 同落且文件名正确
  2. 缺轴 → 该轴 unknown 行 (◌◌◌◌◌ + missing_axes), 不炸
  3. json 与 md 键值一致 (抽 5 键对拍: campaign/CIdx/T格串/空窗年/图例符)
  4. 逐格状态判定: T 豁免年→◐ 空窗→○; B 提及未点亮→◐; D 缺格维→○(优先于降级);
     C 缺口在建渠队列→◐
  5. 末行「呈批件·S1.5」
  6. 账本优先: ledger 有 CIdx 行 → 用账本分不现算; 无账本 → 现算回退且不落池
真实池 BID26 的 10 格对拍在 test_heatmap_bid26.py (REQ-025.AC1)。
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from completeness import cidx, heatmap_gen as hg  # noqa: E402

APPROVAL = "呈批件·S1.5"


# ---- 夹具 ---------------------------------------------------------------


def write_axis(root: Path, letter: str, payload: dict) -> None:
    d = root / "completeness"
    d.mkdir(parents=True, exist_ok=True)
    (d / f"{letter}_axis.json").write_text(
        json.dumps(payload, ensure_ascii=False), encoding="utf-8"
    )


def synth_axes() -> dict:
    """五轴合成: 每轴都有 点亮/降级/缺格 三态可查.

    T: 2020● 2021◐(豁免) 2022○(空窗) 2023● 2024●
    B: 面0-5● 面6◐(L1 提及未点亮) 面7-9○
    D: 维0-6● 维7◐(降级) 维8○(缺格, 同时标降级 → 缺格优先)
    P: L1-L5 全●
    C: 4 渠道● + 渠道E◐(缺口已入建渠队列)
    """
    dims, open_gaps = [], []
    cells = {}
    for i in range(9):
        n = f"维{i}"
        dims.append(n)
        if i <= 6:
            cells[n] = {"depth": "L3", "downgraded": False, "hits": 10 + i}
        elif i == 7:
            cells[n] = {"depth": "L1", "downgraded": True, "reason": "薄料"}
        else:
            cells[n] = {"depth": "L0", "downgraded": True, "reason": "无命中资料"}
            open_gaps.append(n)
    return {
        "T": {"axis": "T", "sensor": "entity_timeline",
              "founded_year": 2020, "current_year": 2024,
              "year_counts": {"2020": 1, "2021": 0, "2022": 0, "2023": 5, "2024": 2},
              "gap_waivers": [{"year": 2021, "reason": "查无此年记录"}],
              "green": False},
        "B": {"axis": "B", "sensor": "coverage_facets",
              "facets": {**{f"面{i}": {"evidence": 2, "evidence_count": 2,
                                       "best_depth": "L3", "lit": True}
                           for i in range(6)},
                         "面6": {"evidence": 1, "evidence_count": 1,
                                 "best_depth": "L1", "lit": False},
                         **{f"面{i}": {"evidence": 0, "evidence_count": 0,
                                       "best_depth": "L0", "lit": False}
                            for i in (7, 8, 9)}},
              "lit_count": 6, "green": False},
        "D": {"axis": "D", "sensor": "dimension_matrix",
              "dims": dims, "cells": cells, "open_gaps": open_gaps,
              "downgraded_count": 2, "green": False},
        "P": {"axis": "P", "sensor": "depth_ladder", "eei_total": 10,
              "l_dist": {"L0": 2, "L1": 2, "L2": 2, "L3": 2, "L4": 1, "L5": 1},
              "green": True},
        "C": {"axis": "C", "sensor": "channel_matrix",
              "channels_hit": 4, "channels_total": 5,
              "hit_channels": [{"id": f"c{i}", "name": f"渠道{i}", "chars": 100}
                               for i in range(4)],
              "miss_list": ["渠道E"],
              "miss_in_queue": ["渠道E"], "miss_not_in_queue": [],
              "new_channel_queue": ["渠道E"],
              "green": False},
    }


def seed(tmp_path: Path, axes: dict, campaign="Camp") -> Path:
    root = tmp_path / "ammo" / campaign
    for letter, payload in axes.items():
        write_axis(root, letter, payload)
    return root


def render_synthetic(tmp_path, axes=None, campaign="Camp"):
    root = seed(tmp_path, axes or synth_axes(), campaign)
    out = tmp_path / "work"
    payload = hg.render(campaign, out, pool_root=root.parent)
    md = (out / f"heatmap_{campaign}.md").read_text(encoding="utf-8")
    js = json.loads((out / f"heatmap_{campaign}.json").read_text(encoding="utf-8"))
    return payload, md, js, root


# ---- 1. 核心内容 ---------------------------------------------------------

def test_md_contains_axes_cidx_legend(tmp_path):
    payload, md, js, _ = render_synthetic(tmp_path)
    for name in ("T 时间轴", "B 广度十面", "D 九维深度", "P EEI深度阶梯",
                 "C 渠道矩阵", "CIdx", "图例"):
        assert name in md, name
    for mark in ("●", "◐", "○"):
        assert mark in md
    # CIdx 与 cidx 汇聚器对拍 (0.25×0.75+0.2×0.6+0.2×0.8333+0.2×0.42+0.15×0.8)
    assert payload["cidx"] == cidx.compute_cidx(payload["axis_scores"])
    assert f"{payload['cidx']:.4f}" in md
    assert js["cidx"] == payload["cidx"]


def test_output_files_and_pool_untouched(tmp_path):
    """双落盘文件名正确; 无账本时现算回退且不在池内落任何账本."""
    root = seed(tmp_path, synth_axes())
    out = tmp_path / "work"
    payload = hg.render("Camp", out, pool_root=root.parent)
    assert (out / "heatmap_Camp.md").is_file()
    assert (out / "heatmap_Camp.json").is_file()
    assert payload["source"]["ledger_cidx_row"] is False  # 现算回退
    assert not (root / "completeness_ledger.jsonl").exists()  # 池只读


# ---- 2. 缺轴 → unknown 行 ------------------------------------------------

def test_missing_axis_unknown_row(tmp_path):
    axes = synth_axes()
    del axes["C"]
    payload, md, js, _ = render_synthetic(tmp_path, axes)
    c = payload["axes"]["C"]
    assert c["missing"] is True
    assert c["marks_strip"] == "◌◌◌◌◌"
    assert c["score"] == 0.0
    assert payload["missing_axes"] == ["C"]
    assert "◌" in md and "unknown" in md
    assert js["axes"]["C"]["missing"] is True


# ---- 3. json 与 md 键值一致 (抽 5 键) -------------------------------------

def test_json_md_consistency_5keys(tmp_path):
    payload, md, js, _ = render_synthetic(tmp_path)
    keys = [
        ("campaign", js["campaign"]),                       # 战役名
        ("cidx", f"{js['cidx']:.4f}"),                      # CIdx 4dp
        ("T 格串", js["axes"]["T"]["marks_strip"]),          # T 逐格字符
        ("空窗年", js["lists"]["gap_years"]),                 # 空窗年清单
        ("图例符", "◐"),                                     # 图例字符
    ]
    assert len(keys) == 5
    assert js["axes"]["T"]["marks_strip"] == "●◐○●●"
    for label, val in keys:
        if isinstance(val, list):
            for item in val:
                assert str(item) in md, (label, item)
        else:
            assert str(val) in md, (label, val)


# ---- 4. 逐格状态判定 ------------------------------------------------------

def test_cell_state_rules(tmp_path):
    payload, _, js, _ = render_synthetic(tmp_path)
    st = {a: {c["cell"]: c["state"] for c in js["axes"][a]["cells"]}
          for a in ("T", "B", "D", "C")}
    assert st["T"]["2021"] == "degraded"   # 豁免年 → ◐
    assert st["T"]["2022"] == "gap"        # 空窗 → ○
    assert st["B"]["面6"] == "degraded"    # L1 提及未点亮 → ◐
    assert st["B"]["面7"] == "gap"         # L0 → ○
    assert st["D"]["维7"] == "degraded"    # 降级维 → ◐
    assert st["D"]["维8"] == "gap"         # 缺格维 (虽标降级) → ○ 缺格优先
    assert st["C"]["渠道E"] == "degraded"  # 缺口已入建渠队列 → ◐
    assert st["C"]["渠道0"] == "lit"
    # 五轴格分布
    assert js["axes"]["T"]["state_counts"] == {"lit": 3, "degraded": 1, "gap": 1,
                                               "unknown": 0}
    assert js["axes"]["B"]["state_counts"] == {"lit": 6, "degraded": 1, "gap": 3,
                                               "unknown": 0}
    assert js["axes"]["D"]["state_counts"] == {"lit": 7, "degraded": 1, "gap": 1,
                                               "unknown": 0}
    assert js["axes"]["P"]["state_counts"] == {"lit": 5, "degraded": 0, "gap": 0,
                                               "unknown": 0}
    assert js["axes"]["C"]["state_counts"] == {"lit": 4, "degraded": 1, "gap": 0,
                                               "unknown": 0}
    assert payload["lists"]["gap_years"] == ["2022"]
    assert payload["lists"]["open_gaps"] == ["维8"]
    assert payload["lists"]["miss_list"] == ["渠道E"]        # 镜像传感器全部未命中
    assert payload["lists"]["miss_in_queue"] == ["渠道E"]    # 其中已入建渠队列
    # 豁免清单: 年豁免 2021 + 无轴级豁免
    assert payload["lists"]["gap_waivers"] == [{"year": 2021,
                                                "reason": "查无此年记录"}]
    assert payload["lists"]["waived_axes"] == []


# ---- 5. 呈批件脚注 --------------------------------------------------------

def test_approval_footer(tmp_path):
    _, md, js, _ = render_synthetic(tmp_path)
    lines = [l for l in md.splitlines() if l.strip()]
    assert lines[-1] == APPROVAL
    assert js["approval"] == APPROVAL


# ---- 6. 账本 CIdx 行优先 --------------------------------------------------

def test_ledger_row_priority(tmp_path):
    root = seed(tmp_path, synth_axes())
    ledger = root / "completeness_ledger.jsonl"
    ledger.parent.mkdir(parents=True, exist_ok=True)
    row = {"ts": "2026-10-15T00:00:00+08:00", "axis": "CIdx", "campaign": "Camp",
           "axis_scores": {"T": 0.1, "B": 0.2, "D": 0.3, "P": 0.4, "C": 0.5},
           "cidx": 0.1234, "all_green": False, "missing_axes": [],
           "waived_axes": [], "weights": dict(cidx.WEIGHTS),
           "formula": cidx.FORMULA}
    ledger.write_text(json.dumps(row, ensure_ascii=False) + "\n", encoding="utf-8")
    payload = hg.render("Camp", tmp_path / "work", pool_root=root.parent)
    assert payload["cidx"] == 0.1234            # 账本权威, 不现算
    assert payload["axis_scores"]["T"] == 0.1
    assert payload["source"]["ledger_cidx_row"] is True
    assert payload["source"]["ledger_cidx_ts"] == row["ts"]
    md = (tmp_path / "work" / "heatmap_Camp.md").read_text(encoding="utf-8")
    assert "0.1234" in md
