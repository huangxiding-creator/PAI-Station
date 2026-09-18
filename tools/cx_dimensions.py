# -*- coding: utf-8 -*-
"""六维覆盖度报告：从主时间轴与静态资产实读，产出当前记分卡快照。

用法：python tools/cx_dimensions.py [--out <md路径>]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.dimensions import (  # noqa: E402
    Dimension,
    probe_assets,
    probe_timeline,
    coverage_report,
)

DB = REPO / "data/cx/timeline.db"
STATIC = REPO / "SELF_PROFILE/static_inventory/2026-09-16"
WEREAD = REPO / "SELF_PROFILE/data/weread_notes_20260916/reviews.jsonl"
# 探针快照（自动重算）——手工叙事卡 cx_六维覆盖度_20260916.md 另存，
# 引用本快照的实读数，二者职责分开防覆盖
DEFAULT_OUT = REPO / "SELF_PROFILE/cx_六维探针_自动.md"

CN = {
    Dimension.FACT: "事实（有什么）",
    Dimension.BEHAVIOR: "行为（做什么）",
    Dimension.RELATION: "关系（和谁）",
    Dimension.OPINION: "观点（信什么）",
    Dimension.RHYTHM: "节律（何时）",
    Dimension.EVOLUTION: "演化（怎么变）",
}


def build_markdown(rep: dict) -> str:
    tp, ap = rep["probe_timeline"], rep["probe_assets"]
    lines = ["# CX 六维探针快照（自动重算，算法估级）", "",
             "> 六维 = 事实×行为×关系×观点×节律×演化（用户拍板顶层方法）。",
             "> 本文件=量化探针实读+算法估级（夜刷自动覆盖）；人工判级与证据叙事",
             "> 见 cx_六维覆盖度_20260916.md（叙事卡，不被自动覆盖）。",
             "> 等级：L0无数据 / L1数据在位 / L2管线化 / L3融合可检索 / L4可评测", ""]
    for dim in Dimension:
        d = rep[dim.value]
        lines.append(f"## {CN[dim]} — {d['level_name']}")
        lines.append(f"- 证据：{d['evidence']}")
        lines.append(f"- 登记源：{', '.join(d['feeds'])}")
        lines.append("")
    lines.append("## 量化探针（实读）")
    lines.append("")
    lines.append(f"- 主时间轴：{json.dumps(tp, ensure_ascii=False)}")
    lines.append(f"- 静态资产：{json.dumps(ap, ensure_ascii=False)}")
    lines.append("")
    lines.append("## 升级路径")
    lines.append("")
    lines.append("- 行为→L3：浏览器史/shell史/信号流并入主时间轴")
    lines.append("- 关系→L2→L3：微信/飞书联系人入轴 → graphiti+splink 实体消解")
    lines.append("- 观点→L2：划线/收藏蒸馏为观点事件入轴")
    lines.append("- 节律→L2：作息画像月度自动产出")
    lines.append("- 演化→L2→L3：git/活动纵向主题迁移分析")
    lines.append("- 全维→L4：主人问答金标准月度跑分")
    return "\n".join(lines)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--out", default=str(DEFAULT_OUT))
    args = ap.parse_args()

    rep = coverage_report(
        probe_timeline(DB),
        probe_assets(STATIC, WEREAD),
    )
    out = Path(args.out)
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(build_markdown(rep), encoding="utf-8")
    print(f"written: {out}")
    for dim in Dimension:
        d = rep[dim.value]
        print(f"{dim.value:10s} {d['level_name']}")
    print("probe:", json.dumps(rep["probe_timeline"], ensure_ascii=False))
    print("assets:", json.dumps(rep["probe_assets"], ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
