# -*- coding: utf-8 -*-
"""CX 域7 演化层：工作主题迁移与角色投入曲线（纯派生，只读时间轴）。"""

from __future__ import annotations

import sqlite3


def monthly_activity(conn: sqlite3.Connection, etype: str) -> list[tuple[str, int]]:
    """某类事件的月度计数序列（升序）。"""
    rows = conn.execute(
        "SELECT strftime('%Y-%m', start) m, COUNT(*) FROM events "
        "WHERE type=? AND start IS NOT NULL GROUP BY m ORDER BY m",
        (etype,),
    ).fetchall()
    return [(str(m), int(n)) for m, n in rows]


def monthly_top_projects(
    conn: sqlite3.Connection, top: int = 3
) -> list[tuple[str, list[tuple[str, int]]]]:
    """每月主导 git 仓 Top-N（工作主题迁移的代理指标）。"""
    rows = conn.execute(
        "SELECT strftime('%Y-%m', start) m, "
        "json_extract(payload, '$.repo') repo, COUNT(*) n "
        "FROM events WHERE type='work.commit' AND start IS NOT NULL "
        "GROUP BY m, repo ORDER BY m, n DESC, repo"
    ).fetchall()
    by_month: dict[str, list[tuple[str, int]]] = {}
    for m, repo, n in rows:
        by_month.setdefault(str(m), []).append((str(repo), int(n)))
    return [(m, repos[:top]) for m, repos in sorted(by_month.items())]
