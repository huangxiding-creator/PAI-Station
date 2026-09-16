# -*- coding: utf-8 -*-
"""域7 演化：月度活动/主导项目/角色投入曲线。"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.evolution import (  # noqa: E402
    monthly_activity,
    monthly_top_projects,
)


def _timeline(tmp_path: Path) -> sqlite3.Connection:
    conn = sqlite3.connect(tmp_path / "t.db")
    conn.execute("CREATE TABLE events (source TEXT, source_id TEXT, start TEXT, "
                 "type TEXT, payload TEXT)")
    rows = [
        ("g", "1", "2026-01-05T10:00:00+08:00", "work.commit",
         '{"repo": "We-AIPO"}'),
        ("g", "2", "2026-01-20T10:00:00+08:00", "work.commit",
         '{"repo": "IdeaDig"}'),
        ("g", "3", "2026-02-01T10:00:00+08:00", "work.commit",
         '{"repo": "We-AIPO"}'),
        ("g", "4", "2026-02-02T10:00:00+08:00", "work.commit",
         '{"repo": "We-AIPO"}'),
        ("m", "5", "2026-02-03T10:00:00+08:00", "meeting.attend",
         '{"subject": "江巷灌区"}'),
    ]
    conn.executemany("INSERT INTO events VALUES (?,?,?,?,?)", rows)
    conn.commit()
    return conn


class TestMonthly:
    def test_activity_by_type(self, tmp_path):
        conn = _timeline(tmp_path)
        act = monthly_activity(conn, "work.commit")
        assert act == [("2026-01", 2), ("2026-02", 2)]
        meet = monthly_activity(conn, "meeting.attend")
        assert meet == [("2026-02", 1)]

    def test_top_projects_per_month(self, tmp_path):
        conn = _timeline(tmp_path)
        tops = monthly_top_projects(conn, top=1)
        assert dict(tops)["2026-02"][0][0] == "We-AIPO"  # 该月主导仓
        assert dict(tops)["2026-01"][0][0] == "IdeaDig"  # 1:1 并列按字典序
