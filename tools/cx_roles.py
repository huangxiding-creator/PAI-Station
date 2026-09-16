# -*- coding: utf-8 -*-
"""双角色榜单：interaction_scores × 角色传导 → 主业/副业两张协作人榜。

用法：python tools/cx_roles.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.roles import ROLE_LABELS, entity_roles  # noqa: E402

REPORT = REPO / "SELF_PROFILE/cx_双角色协作人_20260916.md"


def main() -> int:
    estore = EntityStore(REPO / "data/cx/entities.db")
    sconn = sqlite3.connect(str(REPO / "data/cx/scores.db"))
    rows = sconn.execute(
        "SELECT entity_id, name, score FROM interaction_scores "
        "WHERE entity_id LIKE 'person/%' ORDER BY score DESC"
    ).fetchall()
    sconn.close()

    # 群角色预计算避免逐人递归
    _org_cache: dict[str, str | None] = {}
    from paistation.cx.roles import role_of_org
    orig = estore.__class__.__dict__  # noqa: F841

    def cached_roles(eid: str) -> set[str]:
        return entity_roles(estore, eid)

    # 逐人算角色（成员→群→part_of→project→operated_by，27k 人秒级可接受）
    by_role: dict[str, list[tuple[str, int, set[str]]]] = {"main": [], "side": []}
    amphibians: list[tuple[str, int]] = []
    for eid, name, score in rows:
        roles = cached_roles(eid)
        if not roles:
            continue
        if "main" in roles and "side" in roles:
            amphibians.append((name, score))
        for r in ("main", "side"):
            if r in roles:
                by_role[r].append((name, score, roles))

    lines = [
        "# 双角色协作人榜（按落款归属分视角）",
        "",
        "> 2026-09-16 · 角色判据：项目 operated_by（黄河设计院=主业 / 总包说=副业），"
        "沿群 part_of→member_of 传导到人；两栖者=双角色群都在",
        "",
    ]
    for r in ("main", "side"):
        lst = by_role[r][:20]
        lines += [f"## {ROLE_LABELS[r]}（记分 {len(by_role[r])} 人）", "",
                  "| # | 人物 | 互动分 | 角色面 |", "|---|---|---|---|"]
        for i, (name, score, roles) in enumerate(lst, 1):
            tag = "两栖" if len(roles) > 1 else ""
            lines.append(f"| {i} | {name} | {score} | {tag} |")
        lines.append("")
    amphibians.sort(key=lambda x: -x[1])
    lines += ["## 两栖协作者（主业×副业跨线，前 20）", "",
              "| 人物 | 互动分 |", "|---|---|"]
    for name, score in amphibians[:20]:
        lines.append(f"| {name} | {score} |")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"main: {len(by_role['main'])} 人 | side: {len(by_role['side'])} 人 | "
          f"两栖: {len(amphibians)} 人")
    print("主业 Top5:", [n for n, _, _ in by_role["main"][:5]])
    print("副业 Top5:", [n for n, _, _ in by_role["side"][:5]])
    print(f"→ {REPORT.name}")
    estore.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
