# -*- coding: utf-8 -*-
"""BID26 真池热图回测 (T-009 / REQ-025.AC1).

渲染走 tmp 目录 (池只读); 10+ 格对拍: 热图 json 逐格状态 vs 五轴传感器 json
原始字段独立重推 (证据数/lit/open_gaps/l_dist/命中表), 另加:
  - 分数/CIdx 与账本最新 CIdx 行逐键一致 (REQ-025 「json 与账本逐格一致」)
  - T 空窗年清单与传感器 gap_years 字段逐项一致
  - md 末行「呈批件·S1.5」+ 双落盘文件在 tmp
真实池缺席 → skip 不造假。
"""
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from completeness import heatmap_gen as hg  # noqa: E402

CAMPAIGN = "EPC-BID26"
POOL = Path(__file__).resolve().parents[2] / "ammo_pool" / CAMPAIGN
CDIR = POOL / "completeness"

pytestmark = pytest.mark.skipif(
    not (CDIR / "T_axis.json").is_file(),
    reason="真实池 BID26 completeness/ 五轴缺席")


def _axis(letter: str) -> dict:
    return json.loads((CDIR / f"{letter}_axis.json").read_text(encoding="utf-8"))


@pytest.fixture(scope="module")
def rendered(tmp_path_factory):
    out = tmp_path_factory.mktemp("work")
    payload = hg.render(CAMPAIGN, out, pool_root=POOL.parent)
    md = (out / f"heatmap_{CAMPAIGN}.md").read_text(encoding="utf-8")
    js = json.loads((out / f"heatmap_{CAMPAIGN}.json").read_text(encoding="utf-8"))
    return payload, md, js, out


def _cells(js, axis):
    return {c["cell"]: c["state"] for c in js["axes"][axis]["cells"]}


# ---- REQ-025.AC1: 抽 10 格对拍 (热图 vs 轴 json 独立重推) -------------------

def test_bid26_ten_cell_crosscheck(rendered):
    payload, md, js, out = rendered
    t, b, d, p, c = map(_axis, "TBDPC")
    tcells, bcells, dcells, pcells, ccells = (
        _cells(js, a) for a in "TBDPC")
    checks = []  # (格, 期望, 实际)

    # T×3: 证据年/空窗年 (以 year_counts 原始计数独立重推)
    for y in (1953, 1954, 2026):
        n = t["year_counts"].get(str(y), 0)
        expect = "lit" if n > 0 else "gap"
        checks.append((f"T:{y}", expect, tcells[str(y)]))
    # B×2: 首末两面 (lit 字段 → lit; 提及未点亮 → degraded; 否则 gap)
    names = list(b["facets"])
    for name in (names[0], names[-1]):
        f = b["facets"][name]
        mentioned = (f.get("evidence", 0) > 0
                     or str(f.get("best_depth") or "L0") != "L0")
        expect = "lit" if f.get("lit") is True else \
            ("degraded" if mentioned else "gap")
        checks.append((f"B:{name}", expect, bcells[name]))
    # D×2: 首末两维 (open_gaps→gap 优先; downgraded→degraded; 否则 lit)
    gaps = set(d.get("open_gaps") or [])
    for dim in (d["dims"][0], d["dims"][-1]):
        cell = d["cells"][dim]
        expect = "gap" if dim in gaps else \
            ("degraded" if cell.get("downgraded") else "lit")
        checks.append((f"D:{dim}", expect, dcells[dim]))
    # P×1: L3 级 (l_dist 计数>0 → lit 否则 gap)
    n3 = p["l_dist"].get("L3", 0)
    checks.append(("P:L3", "lit" if n3 > 0 else "gap", pcells["L3"]))
    # C×2: 命中渠道首名 → lit; miss_not_in_queue 首名 → gap
    hit_first = c["hit_channels"][0].get("name") or c["hit_channels"][0]["id"]
    checks.append((f"C:{hit_first}", "lit", ccells[hit_first]))
    miss_first = (c.get("miss_not_in_queue") or c["miss_list"])[0]
    in_q = set(c.get("miss_in_queue") or [])
    expect = "degraded" if miss_first in in_q else "gap"
    checks.append((f"C:{miss_first}", expect, ccells[miss_first]))

    assert len(checks) == 10
    bad = [(g, e, a) for g, e, a in checks if e != a]
    assert not bad, f"对拍不一致: {bad}"


# ---- 与账本逐键一致 --------------------------------------------------------

def test_bid26_scores_match_ledger(rendered):
    payload, md, js, _ = rendered
    rows = [json.loads(l) for l in
            (POOL / "completeness_ledger.jsonl").read_text(
                encoding="utf-8").splitlines() if l.strip()]
    row = [r for r in rows if r.get("axis") == "CIdx"][-1]
    assert payload["source"]["ledger_cidx_row"] is True
    assert payload["cidx"] == row["cidx"]
    assert payload["axis_scores"] == row["axis_scores"]
    assert f"{row['cidx']:.4f}" in md


def test_bid26_gap_years_match_sensor(rendered):
    payload, md, js, _ = rendered
    t = _axis("T")
    assert payload["lists"]["gap_years"] == [str(y) for y in t["gap_years"]]


def test_bid26_files_and_footer(rendered):
    payload, md, js, out = rendered
    assert (out / f"heatmap_{CAMPAIGN}.md").is_file()
    assert (out / f"heatmap_{CAMPAIGN}.json").is_file()
    assert [l for l in md.splitlines() if l.strip()][-1] == "呈批件·S1.5"
    assert js["approval"] == "呈批件·S1.5"
    # 五轴行在 md 总览表各占一行
    for a in "TBDPC":
        assert f"| {a} " in md
