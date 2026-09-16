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
from paistation.cx.roles import (  # noqa: E402
    ROLE_LABELS,
    entity_roles,
    tag_event_role,
)
from paistation.cx.timeline import TimelineStore  # noqa: E402

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

    # 时间轴投入统计（年终总结等"按角色过滤"任务的地基）
    tstore = TimelineStore(REPO / "data/cx/timeline.db")
    stats: dict[str, dict[str, int]] = {"main": {}, "side": {}, "personal": {}}
    unlabeled = 0
    total = 0
    for (etype, payload_json) in tstore._conn.execute(
        "SELECT type, payload FROM events "
        "WHERE type IN ('meeting.attend','work.commit','email.receive')"
    ).fetchall():
        if etype not in ("meeting.attend", "work.commit", "email.receive"):
            continue
        total += 1
        try:
            payload = json.loads(payload_json or "{}")
        except ValueError:
            payload = {}
        role = tag_event_role(estore, str(etype), payload)
        if not role:
            unlabeled += 1
            continue
        stats[role][etype] = stats[role].get(etype, 0) + 1
    lines += ["", "## 时间轴投入（按角色）", "",
              "| 角色 | 会议场次 | git 提交 | 邮件 |", "|---|---|---|---|"]
    for r in ("main", "side", "personal"):
        s = stats[r]
        lines.append(f"| {ROLE_LABELS[r]} | {s.get('meeting.attend', 0)} "
                     f"| {s.get('work.commit', 0)} "
                     f"| {s.get('email.receive', 0)} |")
    lines.append(f"\n> 核心事件 {total} 条中 {unlabeled} 条暂无法定角色"
                 "（快速会议/未映射仓/泛通知）——57 场会议续拉+公众号线实体化后收窄")
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")

    print(f"main: {len(by_role['main'])} 人 | side: {len(by_role['side'])} 人 | "
          f"两栖: {len(amphibians)} 人")
    print("时间轴:", {r: stats[r] for r in stats if stats[r]},
          f"| 未标记 {unlabeled}/{total}")
    print("主业 Top5:", [n for n, _, _ in by_role["main"][:5]])
    print("副业 Top5:", [n for n, _, _ in by_role["side"][:5]])
    print(f"→ {REPORT.name}")
    estore.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
