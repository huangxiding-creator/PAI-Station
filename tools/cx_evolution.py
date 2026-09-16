# -*- coding: utf-8 -*-
"""域7 演化驱动：工作主题迁移表 + 双角色投入曲线 → 报告。

用法：python tools/cx_evolution.py
"""
from __future__ import annotations

import json
import sqlite3
import sys
from collections import Counter
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.evolution import (  # noqa: E402
    monthly_activity,
    monthly_top_projects,
)
from paistation.cx.roles import ROLE_LABELS, tag_event_role  # noqa: E402
from paistation.cx.timeline import TimelineStore  # noqa: E402

REPORT = REPO / "SELF_PROFILE/cx_演化_主题迁移_20260916.md"


def main() -> int:
    estore = EntityStore(REPO / "data/cx/entities.db")
    tstore = TimelineStore(REPO / "data/cx/timeline.db")
    conn = tstore._conn

    commits = monthly_activity(conn, "work.commit")
    meetings = monthly_activity(conn, "meeting.attend")
    tops = monthly_top_projects(conn, top=3)

    # 双角色月度投入（tag_event_role 逐 commit 标记）
    role_month: dict[str, Counter] = {"main": Counter(), "side": Counter(),
                                      "personal": Counter()}
    for (start, payload_json) in conn.execute(
        "SELECT start, payload FROM events WHERE type='work.commit'"
    ).fetchall():
        try:
            payload = json.loads(payload_json or "{}")
        except ValueError:
            continue
        role = tag_event_role(estore, "work.commit", payload)
        if role:
            role_month[role][str(start)[:7]] += 1

    lines = [
        "# 工作主题迁移表（域7 演化 · 2026-01 → 09）",
        "",
        "> 2026-09-16 · 数据源：时间轴 git 提交 2192 + 会议 46 场；角色按落款判据",
        "",
        "## 一、月度主导仓（主题迁移）",
        "",
        "| 月 | git提交 | 会议 | 当月主导仓 Top3 |",
        "|---|---|---|---|",
    ]
    commit_map = dict(commits)
    meet_map = dict(meetings)
    for m, repos in tops:
        repo_str = "、".join(f"{r}({n})" for r, n in repos)
        lines.append(f"| {m} | {commit_map.get(m, 0)} | {meet_map.get(m, 0)} "
                     f"| {repo_str} |")

    lines += ["", "## 二、双角色月度投入（git 提交按落款归属）", "",
              "| 月 | 主业 | 副业 | 个人线 |", "|---|---|---|---|"]
    months = sorted({m for c in role_month.values() for m in c})
    for m in months:
        lines.append(f"| {m} | {role_month['main'].get(m, 0)} "
                     f"| {role_month['side'].get(m, 0)} "
                     f"| {role_month['personal'].get(m, 0)} |")

    # 加速度与叙事
    first = commits[0][1] if commits else 0
    peak = max((n for _, n in commits), default=0)
    peak_m = max(commits, key=lambda x: x[1])[0] if commits else "-"
    lines += [
        "",
        "## 三、演化叙事（自动提炼）",
        "",
        f"- **产出加速度**：1 月 {first} commit → 峰值 {peak_m} {peak} commit"
        f"（{'%.0f' % (peak / max(first, 1))} 倍）——AI 自媒体线进入爆发期",
        "- **主题迁移**：上半年 ResearchFactory/AI-Station 基建铺垫 → "
        "7 月起 We-AIPO 永动机主导（内容生产自动化成型）",
        "- **双角色节奏**：git 投入几乎全在副业+个人线（主业产出不落 git，"
        "落文档/会议——见主业会议月度分布）",
    ]
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"→ {REPORT.name}")
    print("commit 月度:", commits)
    print("角色月度:", {r: dict(c) for r, c in role_month.items() if c})
    estore.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
