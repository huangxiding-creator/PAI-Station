"""全源主时间轴存储：SQLite 追加式、幂等、双时态。"""

from __future__ import annotations

import json
import sqlite3
from datetime import datetime, timezone
from pathlib import Path
from typing import Iterable

from paistation.cx.events import EventEnvelope

_SCHEMA = """
CREATE TABLE IF NOT EXISTS events (
    source      TEXT NOT NULL,
    source_id   TEXT NOT NULL,
    start       TEXT NOT NULL,
    end         TEXT,
    type        TEXT NOT NULL,
    payload     TEXT NOT NULL,
    ingested_at TEXT NOT NULL,
    PRIMARY KEY (source, source_id)
);
CREATE INDEX IF NOT EXISTS idx_events_start ON events (start);
CREATE INDEX IF NOT EXISTS idx_events_type  ON events (type);
"""


class TimelineStore:
    """主时间轴。首写优先（INSERT OR IGNORE），重跑零重复；只增不删。"""

    def __init__(self, db_path: str | Path) -> None:
        self.db_path = Path(db_path)
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self._conn = sqlite3.connect(str(self.db_path))
        self._conn.executescript(_SCHEMA)

    # -- 写入 -------------------------------------------------------
    def ingest(self, events: Iterable[EventEnvelope]) -> tuple[int, int]:
        """批量入库，返回 (inserted, skipped)。同 (source, source_id) 跳过。"""
        now = datetime.now(timezone.utc).isoformat(timespec="seconds")
        inserted = skipped = 0
        for ev in events:
            cur = self._conn.execute(
                "INSERT OR IGNORE INTO events VALUES (?,?,?,?,?,?,?)",
                (
                    ev.source,
                    ev.source_id,
                    ev.start.isoformat(),
                    ev.end.isoformat() if ev.end else None,
                    ev.type,
                    json.dumps(ev.payload, ensure_ascii=False),
                    now,
                ),
            )
            if cur.rowcount:
                inserted += 1
            else:
                skipped += 1
        self._conn.commit()
        return inserted, skipped

    # -- 查询 -------------------------------------------------------
    def count(self, source: str | None = None) -> int:
        if source:
            row = self._conn.execute(
                "SELECT COUNT(*) FROM events WHERE source=?", (source,)
            ).fetchone()
        else:
            row = self._conn.execute("SELECT COUNT(*) FROM events").fetchone()
        return int(row[0])

    def span(self) -> tuple[str | None, str | None]:
        row = self._conn.execute(
            "SELECT MIN(start), MAX(start) FROM events"
        ).fetchone()
        return row[0], row[1]

    def stats(self) -> dict[str, int]:
        rows = self._conn.execute(
            "SELECT source, COUNT(*) FROM events GROUP BY source ORDER BY 2 DESC"
        ).fetchall()
        return {str(s): int(n) for s, n in rows}

    def query(
        self,
        source: str | None = None,
        since: str | None = None,
        until: str | None = None,
        limit: int = 100,
    ) -> list[dict]:
        sql = "SELECT source, source_id, start, end, type, payload FROM events WHERE 1=1"
        args: list = []
        if source:
            sql += " AND source=?"
            args.append(source)
        if since:
            sql += " AND start>=?"
            args.append(since)
        if until:
            sql += " AND start<=?"
            args.append(until)
        sql += " ORDER BY start DESC LIMIT ?"
        args.append(limit)
        return [
            {
                "source": r[0],
                "source_id": r[1],
                "start": r[2],
                "end": r[3],
                "type": r[4],
                "payload": json.loads(r[5]),
            }
            for r in self._conn.execute(sql, args).fetchall()
        ]

    def close(self) -> None:
        self._conn.close()
