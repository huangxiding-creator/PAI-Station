"""实体登记表：统一身份图谱的地基（graphiti/splink 接入前的种子层）。

人/组织/项目/主题四类实体，别名可合并，来源可追溯。
只增不删：合并=别名吸收，不物理删除。
"""

from __future__ import annotations

import json
import re
import sqlite3
from datetime import datetime, timezone
from pathlib import Path

_SCHEMA = """
CREATE TABLE IF NOT EXISTS entities (
    entity_id    TEXT PRIMARY KEY,
    kind         TEXT NOT NULL,
    display_name TEXT NOT NULL,
    aliases      TEXT NOT NULL,
    sources      TEXT NOT NULL,
    first_seen   TEXT,
    last_seen    TEXT,
    created_at   TEXT NOT NULL,
    updated_at   TEXT NOT NULL
);
CREATE INDEX IF NOT EXISTS idx_entities_kind ON entities (kind);
"""

_KINDS = {"person", "org", "project", "topic"}


def _slug(name: str) -> str:
    s = re.sub(r"[^\w一-鿿]+", "-", name.strip()).strip("-")
    return s[:60] or "unnamed"


class EntityStore:
    def __init__(self, db_path: str | Path) -> None:
        self.db_path = Path(db_path)
        self.db_path.parent.mkdir(parents=True, exist_ok=True)
        self._conn = sqlite3.connect(str(self.db_path))
        self._conn.executescript(_SCHEMA)

    def register(
        self,
        kind: str,
        name: str,
        aliases: list[str] | None = None,
        source: str = "",
        seen_at: str | None = None,
    ) -> tuple[str, bool]:
        """登记实体，返回 (entity_id, created)。同名同类合并别名与来源。"""
        if kind not in _KINDS:
            raise ValueError(f"kind 须为 {_KINDS}")
        name = name.strip()
        if not name:
            raise ValueError("name 不能为空")
        eid = f"{kind}/{_slug(name)}"
        now = datetime.now(timezone.utc).isoformat(timespec="seconds")
        row = self._conn.execute(
            "SELECT aliases, sources, first_seen, last_seen FROM entities WHERE entity_id=?",
            (eid,),
        ).fetchone()
        if row is None:
            self._conn.execute(
                "INSERT INTO entities VALUES (?,?,?,?,?,?,?,?,?)",
                (
                    eid, kind, name,
                    json.dumps(sorted(set(aliases or [])), ensure_ascii=False),
                    json.dumps([source] if source else [], ensure_ascii=False),
                    seen_at, seen_at, now, now,
                ),
            )
            self._conn.commit()
            return eid, True
        old_aliases = set(json.loads(row[0]))
        old_sources = set(json.loads(row[1]))
        new_aliases = old_aliases | set(aliases or [])
        new_sources = old_sources | ({source} if source else set())
        first = min((x for x in [row[2], seen_at] if x), default=None)
        last = max((x for x in [row[3], seen_at] if x), default=None)
        self._conn.execute(
            "UPDATE entities SET aliases=?, sources=?, first_seen=?, last_seen=?, updated_at=? "
            "WHERE entity_id=?",
            (
                json.dumps(sorted(new_aliases), ensure_ascii=False),
                json.dumps(sorted(new_sources), ensure_ascii=False),
                first, last, now, eid,
            ),
        )
        self._conn.commit()
        return eid, False

    def merge(self, into_id: str, from_id: str) -> bool:
        """把 from 实体的别名/来源并入 into（别名吸收，不物理删除）。"""
        a = self._conn.execute(
            "SELECT kind, display_name, aliases, sources FROM entities WHERE entity_id=?",
            (into_id,),
        ).fetchone()
        b = self._conn.execute(
            "SELECT display_name, aliases, sources FROM entities WHERE entity_id=?",
            (from_id,),
        ).fetchone()
        if a is None or b is None or into_id == from_id:
            return False
        aliases = sorted(set(json.loads(a[2])) | set(json.loads(b[1])) | {b[0]})
        sources = sorted(set(json.loads(a[3])) | set(json.loads(b[2])))
        now = datetime.now(timezone.utc).isoformat(timespec="seconds")
        self._conn.execute(
            "UPDATE entities SET aliases=?, sources=?, updated_at=? WHERE entity_id=?",
            (json.dumps(aliases, ensure_ascii=False), json.dumps(sources, ensure_ascii=False), now, into_id),
        )
        self._conn.execute(
            "UPDATE entities SET display_name=display_name||'‖'||?, updated_at=? WHERE entity_id=?",
            (b[0], now, from_id),
        )
        self._conn.commit()
        return True

    def count(self, kind: str | None = None) -> int:
        if kind:
            row = self._conn.execute(
                "SELECT COUNT(*) FROM entities WHERE kind=?", (kind,)
            ).fetchone()
        else:
            row = self._conn.execute("SELECT COUNT(*) FROM entities").fetchone()
        return int(row[0])

    def stats(self) -> dict[str, int]:
        rows = self._conn.execute(
            "SELECT kind, COUNT(*) FROM entities GROUP BY kind"
        ).fetchall()
        return {str(k): int(n) for k, n in rows}

    def close(self) -> None:
        self._conn.close()


def collect_git_authors(repos: list[str]) -> list[dict]:
    """每仓库去重作者（姓名+邮箱——后续 splink 消解的强标识符）。"""
    import subprocess

    from paistation.cx.ingest_sources import CREATE_NO_WINDOW

    authors: dict[tuple[str, str], set[str]] = {}
    for repo in repos:
        proc = subprocess.run(
            ["git", "-c", "safe.directory=*", "-C", repo, "log", "--all",
             "--pretty=format:%an%x1f%ae"],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            creationflags=CREATE_NO_WINDOW, timeout=60,
        )
        if proc.returncode != 0:
            continue
        for line in proc.stdout.splitlines():
            parts = line.split("\x1f")
            if len(parts) == 2 and parts[0].strip():
                key = (parts[0].strip(), parts[1].strip().lower())
                authors.setdefault(key, set()).add(repo)
    return [
        {"name": n, "email": e, "repos": sorted(rs)}
        for (n, e), rs in sorted(authors.items())
    ]
