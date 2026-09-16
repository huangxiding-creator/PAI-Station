"""浏览器史解析器：Chromium SQLite（chrome/edge）+ 360 JSON → web.visit 事件。"""

from __future__ import annotations

import json
import re
import sqlite3
from datetime import datetime, timedelta, timezone
from pathlib import Path

from paistation.cx.events import EventEnvelope

_WEBKIT_EPOCH = datetime(1601, 1, 1, tzinfo=timezone.utc)


def _webkit_to_dt(us: int) -> datetime:
    return _WEBKIT_EPOCH + timedelta(microseconds=us)


def parse_chromium_history(db_path: str | Path, source: str) -> list[EventEnvelope]:
    """urls × visits 联查 → 每次访问一条 web.visit 事件。"""
    conn = sqlite3.connect(f"file:{Path(db_path)}?mode=ro", uri=True)
    try:
        rows = conn.execute(
            "SELECT v.id, v.visit_time, u.url, u.title "
            "FROM visits v JOIN urls u ON v.url = u.id "
            "WHERE v.visit_time > 0 ORDER BY v.visit_time"
        ).fetchall()
    finally:
        conn.close()
    events: list[EventEnvelope] = []
    for vid, vt, url, title in rows:
        when = _webkit_to_dt(int(vt))
        events.append(
            EventEnvelope(
                source=source,
                source_id=str(vid),
                start=when,
                type="web.visit",
                payload={"url": (url or "")[:300], "title": (title or "")[:150]},
            )
        )
    return events


_360_DATE = re.compile(r"(\d{4})年(\d{1,2})月(\d{1,2})日")


def parse_360_history(text: str) -> list[EventEnvelope]:
    """360 JSON（天级精度）→ web.visit 事件（无秒级时间，取当日时分）。"""
    rows = json.loads(text)
    if isinstance(rows, dict):
        rows = rows.get("items", [])
    events: list[EventEnvelope] = []
    for i, row in enumerate(rows):
        m = _360_DATE.match(str(row.get("date", "")))
        t = str(row.get("time", ""))
        if not m or ":" not in t:
            continue
        try:
            when = datetime(
                int(m.group(1)), int(m.group(2)), int(m.group(3)),
                int(t.split(":")[0]), int(t.split(":")[1]),
            )
        except ValueError:
            continue
        domain = row.get("domain") or ""
        events.append(
            EventEnvelope(
                source="browser_360",
                source_id=f"{i}|{domain}|{row.get('title', '')[:40]}",
                start=when,
                type="web.visit",
                payload={"domain": domain, "title": (row.get("title") or "")[:150]},
            )
        )
    return events
