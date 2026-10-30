# -*- coding: utf-8 -*-
"""_framework_diff — 手筑 chapters.json vs NBLM chapters_nblm.json 差异对照表.

规则 (用户升级令): NBLM 版为权威目录; 手筑版仅参照;
缺关键子问域 → 编辑段以补章/补节注入, 不回退手筑框架.
用法: py -X utf8 _framework_diff.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
DIMS = ["政策法规与定额体系", "计价依据与定额测定", "信息价与市场价基准",
        "投标编制实务", "结算核对实务", "合同解除结算", "造价鉴定与争议",
        "清单与定额计价模式", "造价咨询与职业", "数据源与工具生态"]


def ch_dim_map(olds: list[dict]) -> dict[int, list[str]]:
    """手筑章 subqs → question_tree 维度 (实算, 不手猜)."""
    qt = json.loads(Path(r"E:/AI-Station/ammo_pool/EPC-JIAGE/"
                         "question_tree.json").read_text(encoding="utf-8"))
    q2dim = {q["id"]: q["dim"] for q in qt["subquestions"]}
    m: dict[int, list[str]] = {}
    for o in olds:
        ds = []
        for q in o.get("subqs", []):
            d = q2dim.get(q)
            if d and d not in ds:
                ds.append(d)
        m[o["no"]] = ds
    return m


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    olds = json.loads((HERE / "chapters.json").read_text(encoding="utf-8"))
    news = json.loads((HERE / "chapters_nblm.json").read_text(encoding="utf-8"))
    ch_dims = ch_dim_map(olds)
    lines = ["# 框架对照表: 手筑(参照) vs NBLM(权威)", "",
             f"- 手筑: {len(olds)}章 | NBLM: {len(news)}章", ""]

    lines.append("| NBLM章 | NBLM标题(权威) | 场景 | 最贴近手筑章 | 手筑标题(参照) |")
    lines.append("|---|---|---|---|---|")
    for n in news:
        text = n["title"] + " " + n.get("solve", "") + " " + " ".join(n["points"])
        best, bs = "-", -1.0
        for o in olds:
            s = sum(1 for k in o["kws"] if k in text)
            t = o["title"]
            g = {t[i:i+2] for i in range(len(t)-1)}
            s += 0.1 * sum(1 for x in g if x in text)
            if s > bs:
                bs, best = s, o["no"]
        ot = next(o["title"] for o in olds if o["no"] == best)
        lines.append(f"| {n['no']} | {n['title'][:28]} | {n['scenario'][:8]} "
                     f"| ch{best:02d} | {ot[:28]} |")

    # 维度覆盖审计: NBLM 章↔手筑章映射的维度并集 vs 十大维 (缺→编辑段补)
    alltext = " ".join(n["title"] + " " + n.get("solve", "") + " "
                       + " ".join(n["points"]) for n in news)
    covered: set[str] = set()
    for n in news:
        text = n["title"] + " " + n.get("solve", "") + " " + " ".join(n["points"])
        best, bs = None, -1.0
        for o in olds:
            s = sum(1 for k in o["kws"] if k in text)
            t = o["title"]
            g = {t[i:i+2] for i in range(len(t)-1)}
            s += 0.1 * sum(1 for x in g if x in text)
            if s > bs:
                bs, best = s, o["no"]
        covered.update(ch_dims.get(best, []))
    lines += ["", "## 十大维覆盖审计 (经 NBLM章↔手筑章 映射; 缺→编辑段补章/补节注入)", ""]
    missing = []
    for d in DIMS:
        hit = d in covered or d[:4] in alltext
        lines.append(f"- {d}: {'✓覆盖' if hit else '✗未见→编辑段注入'}")
        if not hit:
            missing.append(d)
    (HERE / "framework_diff.md").write_text("\n".join(lines), encoding="utf-8")
    (HERE / "framework_diff.json").write_text(json.dumps(
        {"nblm_chapters": len(news), "manual_chapters": len(olds),
         "dims_missing_in_nblm": missing}, ensure_ascii=False, indent=1),
        encoding="utf-8")
    print("\n".join(lines))
    print("[diff] → framework_diff.md / framework_diff.json")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
