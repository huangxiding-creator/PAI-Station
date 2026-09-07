"""画像层（提案 B.1 分层记忆第三层）：两级写入 + 双环确认。

一级（事实流水）：note_fact 直接落库——可纠错、可撤回的观察记录。
二级（画像变更）：propose → pending → 用户 confirm 后才改写画像键。
C.1 红线：double_loop_confirm ≥ 1，构造即校验，画像改动必须过人。
"""
import sqlite3
import time

_SCHEMA = """
CREATE TABLE IF NOT EXISTS facts(
    key TEXT PRIMARY KEY,
    value TEXT NOT NULL,
    source TEXT NOT NULL DEFAULT '',
    confidence REAL NOT NULL DEFAULT 0.5,
    confirmed INTEGER NOT NULL DEFAULT 1,
    ts REAL NOT NULL DEFAULT 0)
"""

_PROPOSAL_SCHEMA = """
CREATE TABLE IF NOT EXISTS proposals(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    key TEXT NOT NULL,
    value TEXT NOT NULL,
    source TEXT NOT NULL DEFAULT '',
    state TEXT NOT NULL DEFAULT 'pending',
    ts REAL NOT NULL DEFAULT 0)
"""


class Profile:
    """facts：画像键值；proposals：双环待批队列。"""

    def __init__(self, db_path: str, double_loop_confirm: int = 1):
        if int(double_loop_confirm) < 1:
            raise ValueError("[learn].double_loop_confirm 不可低于 1（C.1 红线）")
        self._db = sqlite3.connect(db_path)
        self._db.row_factory = sqlite3.Row
        self._db.execute(_SCHEMA)
        self._db.execute(_PROPOSAL_SCHEMA)
        self._db.commit()

    # ---------- 一级：事实流水 ----------

    def note_fact(self, key: str, value: str, source: str = "",
                  confidence: float = 0.5) -> None:
        self._db.execute(
            "INSERT INTO facts(key, value, source, confidence, confirmed, ts)"
            " VALUES(?,?,?,?,1,?) ON CONFLICT(key) DO UPDATE SET"
            " value=excluded.value, source=excluded.source,"
            " confidence=excluded.confidence, ts=excluded.ts",
            (key, value, source, confidence, time.time()))
        self._db.commit()

    def fact(self, key: str) -> dict | None:
        row = self._db.execute("SELECT * FROM facts WHERE key=?", (key,)).fetchone()
        return dict(row) if row else None

    def facts(self) -> list[dict]:
        return [dict(r) for r in
                self._db.execute("SELECT * FROM facts ORDER BY ts DESC")]

    # ---------- 二级：双环确认 ----------

    def propose_profile_change(self, key: str, value: str,
                               source: str = "") -> int:
        cur = self._db.execute(
            "INSERT INTO proposals(key, value, source, state, ts)"
            " VALUES(?,?,?,'pending',?)", (key, value, source, time.time()))
        self._db.commit()
        return int(cur.lastrowid)

    def pending(self) -> list[dict]:
        return [dict(r) for r in self._db.execute(
            "SELECT * FROM proposals WHERE state='pending' ORDER BY ts")]

    def confirm(self, proposal_id: int) -> None:
        row = self._db.execute(
            "SELECT * FROM proposals WHERE id=? AND state='pending'",
            (proposal_id,)).fetchone()
        if row is None:
            if self._db.execute("SELECT 1 FROM proposals WHERE id=?",
                                (proposal_id,)).fetchone():
                return  # 已处理过：幂等
            raise KeyError(f"提案不存在：{proposal_id}")
        self._db.execute("UPDATE proposals SET state='confirmed' WHERE id=?",
                         (proposal_id,))
        self.note_fact(row["key"], row["value"], source=row["source"],
                       confidence=0.9)
        self._db.commit()

    def reject(self, proposal_id: int) -> None:
        cur = self._db.execute(
            "UPDATE proposals SET state='rejected' WHERE id=? AND state='pending'",
            (proposal_id,))
        self._db.commit()
        if cur.rowcount == 0:
            raise KeyError(f"提案不存在或已处理：{proposal_id}")

    def stats(self) -> dict:
        facts = self._db.execute("SELECT COUNT(*) c FROM facts").fetchone()["c"]
        pending = self._db.execute(
            "SELECT COUNT(*) c FROM proposals WHERE state='pending'").fetchone()["c"]
        return {"facts": facts, "pending": pending}

    def close(self) -> None:
        self._db.close()
