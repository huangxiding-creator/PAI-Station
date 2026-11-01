# -*- coding: utf-8 -*-
"""SQLite Store：领域对象的唯一持久层。单写者原则。"""
from __future__ import annotations

import json
import sqlite3
from pathlib import Path
from typing import Optional

from domain import (
    Assignment, AssignmentState, Decision, Mandate, Report,
    Thread, Ticket, Trigger,
)

DB_PATH = Path(__file__).parent / "state.db"

SCHEMA = """
CREATE TABLE IF NOT EXISTS trigger (
    id TEXT PRIMARY KEY,
    source TEXT NOT NULL,
    actor TEXT,
    thread_id TEXT,
    content TEXT,
    metadata TEXT DEFAULT '{}',
    ts INTEGER NOT NULL,
    is_human INTEGER DEFAULT 1
);
CREATE INDEX IF NOT EXISTS idx_trigger_thread ON trigger(thread_id);

CREATE TABLE IF NOT EXISTS thread (
    id TEXT PRIMARY KEY,
    source TEXT,
    label TEXT,
    subscriptions TEXT DEFAULT '[]',
    queued_triggers TEXT DEFAULT '[]',
    metadata TEXT DEFAULT '{}',
    created_at INTEGER
);

CREATE TABLE IF NOT EXISTS ticket (
    id TEXT PRIMARY KEY,
    title TEXT,
    mandate TEXT,
    origin_trigger_id TEXT,
    assignments TEXT DEFAULT '[]',
    subscriptions TEXT DEFAULT '[]',
    inputs TEXT DEFAULT '[]',
    outcome TEXT,
    created_at INTEGER,
    ended_at INTEGER
);

CREATE TABLE IF NOT EXISTS decision (
    id TEXT PRIMARY KEY,
    trigger_id TEXT,
    thread_id TEXT,
    type TEXT,
    strength TEXT,
    reason TEXT,
    ticket_id TEXT,
    ts INTEGER
);
CREATE INDEX IF NOT EXISTS idx_decision_thread ON decision(thread_id);

CREATE TABLE IF NOT EXISTS effect (
    id TEXT PRIMARY KEY,
    kind TEXT NOT NULL,
    key TEXT NOT NULL,
    payload TEXT DEFAULT '{}',
    status TEXT DEFAULT 'pending',
    attempts INTEGER DEFAULT 0,
    last_error TEXT,
    due_at INTEGER DEFAULT 0,
    created_at INTEGER,
    UNIQUE(kind, key)
);

CREATE TABLE IF NOT EXISTS outbox (
    id TEXT PRIMARY KEY,
    ticket_id TEXT,
    channel TEXT,
    purpose TEXT,
    content TEXT,
    status TEXT DEFAULT 'pending',
    attempts INTEGER DEFAULT 0,
    created_at INTEGER,
    sent_at INTEGER
);

CREATE TABLE IF NOT EXISTS kv (
    key TEXT PRIMARY KEY,
    value TEXT
);
"""


class Store:
    """SQLite 存储，所有领域对象的唯一写入者。"""

    def __init__(self, db_path: Path = None):
        self.db_path = db_path or DB_PATH
        self.conn = sqlite3.connect(str(self.db_path))
        self.conn.row_factory = sqlite3.Row
        self.conn.executescript(SCHEMA)
        self.conn.commit()

    def close(self):
        self.conn.close()

    # ── Trigger ──────────────────────────────────────────────

    def save_trigger(self, t: Trigger) -> bool:
        """幂等：同 id 只存一次。返回是否新存。"""
        cur = self.conn.execute(
            "SELECT 1 FROM trigger WHERE id=?", (t.id,))
        if cur.fetchone():
            return False
        self.conn.execute(
            "INSERT INTO trigger VALUES (?,?,?,?,?,?,?,?)",
            (t.id, t.source, t.actor, t.thread_id, t.content,
             json.dumps(t.metadata, ensure_ascii=False), t.ts,
             1 if t.is_human else 0))
        self.conn.commit()
        return True

    def get_trigger(self, id: str) -> Optional[Trigger]:
        cur = self.conn.execute("SELECT * FROM trigger WHERE id=?", (id,))
        row = cur.fetchone()
        if not row:
            return None
        return Trigger(
            id=row["id"], source=row["source"], actor=row["actor"],
            thread_id=row["thread_id"], content=row["content"],
            metadata=json.loads(row["metadata"] or "{}"),
            ts=row["ts"], is_human=bool(row["is_human"]))

    # ── Thread ───────────────────────────────────────────────

    def save_thread(self, t: Thread):
        self.conn.execute(
            "INSERT OR REPLACE INTO thread VALUES (?,?,?,?,?,?,?)",
            (t.id, t.source, t.label,
             json.dumps(t.subscriptions),
             json.dumps(t.queued_triggers),
             json.dumps(t.metadata, ensure_ascii=False), t.created_at))
        self.conn.commit()

    def get_thread(self, id: str) -> Optional[Thread]:
        cur = self.conn.execute("SELECT * FROM thread WHERE id=?", (id,))
        row = cur.fetchone()
        if not row:
            return None
        return Thread(
            id=row["id"], source=row["source"], label=row["label"],
            subscriptions=json.loads(row["subscriptions"] or "[]"),
            queued_triggers=json.loads(row["queued_triggers"] or "[]"),
            metadata=json.loads(row["metadata"] or "{}"),
            created_at=row["created_at"])

    # ── Ticket ───────────────────────────────────────────────

    def save_ticket(self, t: Ticket):
        self.conn.execute(
            "INSERT OR REPLACE INTO ticket VALUES (?,?,?,?,?,?,?,?,?,?)",
            (t.id, t.title,
             json.dumps(t.mandate.to_dict()) if t.mandate else None,
             t.origin_trigger_id,
             json.dumps([a.to_dict() for a in t.assignments]),
             json.dumps(t.subscriptions),
             json.dumps(t.inputs),
             t.outcome, t.created_at, t.ended_at))
        self.conn.commit()

    def get_ticket(self, id: str) -> Optional[Ticket]:
        cur = self.conn.execute("SELECT * FROM ticket WHERE id=?", (id,))
        row = cur.fetchone()
        if not row:
            return None
        t = Ticket(
            id=row["id"], title=row["title"],
            origin_trigger_id=row["origin_trigger_id"],
            subscriptions=json.loads(row["subscriptions"] or "[]"),
            inputs=json.loads(row["inputs"] or "[]"),
            outcome=row["outcome"],
            created_at=row["created_at"], ended_at=row["ended_at"])
        if row["mandate"]:
            m = json.loads(row["mandate"])
            t.mandate = Mandate(**m)
        t.assignments = [Assignment(**a) for a in json.loads(row["assignments"] or "[]")]
        return t

    def open_tickets(self) -> list[Ticket]:
        cur = self.conn.execute("SELECT id FROM ticket WHERE ended_at IS NULL")
        return [self.get_ticket(r["id"]) for r in cur.fetchall()]

    # ── Decision ─────────────────────────────────────────────

    def save_decision(self, d: Decision):
        self.conn.execute(
            "INSERT OR REPLACE INTO decision VALUES (?,?,?,?,?,?,?,?)",
            (d.id, d.trigger_id, d.thread_id, d.type.value,
             d.strength.value, d.reason, d.ticket_id, d.ts))
        self.conn.commit()

    def decisions_for_thread(self, thread_id: str) -> list[Decision]:
        cur = self.conn.execute(
            "SELECT * FROM decision WHERE thread_id=? ORDER BY ts DESC",
            (thread_id,))
        return [Decision(
            id=r["id"], trigger_id=r["trigger_id"], thread_id=r["thread_id"],
            type=Decision(r["type"]), strength=Strength(r["strength"]),
            reason=r["reason"], ticket_id=r["ticket_id"], ts=r["ts"])
            for r in cur.fetchall()]

    # ── Effect ───────────────────────────────────────────────

    def enqueue_effect(self, kind: str, key: str, payload: dict):
        """同 kind+key 只有一行，重复入队替换 payload 并立即到期。"""
        self.conn.execute(
            "INSERT OR REPLACE INTO effect (id,kind,key,payload,status,attempts,due_at,created_at) "
            "VALUES (?,?,?,?, 'pending',0,?,?) "
            "ON CONFLICT(kind,key) DO UPDATE SET payload=?,status='pending',due_at=0",
            (f"eff_{kind}_{key}", kind, key,
             json.dumps(payload, ensure_ascii=False), 0,
             int(__import__("time").time()*1000),
             json.dumps(payload, ensure_ascii=False)))
        self.conn.commit()

    def pending_effects(self, limit: int = 10) -> list[dict]:
        cur = self.conn.execute(
            "SELECT * FROM effect WHERE status='pending' AND due_at<=? "
            "ORDER BY created_at LIMIT ?",
            (int(__import__("time").time()*1000), limit))
        rows = cur.fetchall()
        return [{"id": r["id"], "kind": r["kind"], "key": r["key"],
                 "payload": json.loads(r["payload"] or "{}"),
                 "attempts": r["attempts"]}
                for r in rows]

    def complete_effect(self, effect_id: str):
        self.conn.execute(
            "UPDATE effect SET status='done' WHERE id=?", (effect_id,))
        self.conn.commit()

    def fail_effect(self, effect_id: str, error: str, backoff_ms: int):
        import time as _t
        self.conn.execute(
            "UPDATE effect SET attempts=attempts+1, last_error=?, due_at=?, "
            "status=CASE WHEN attempts>=3 THEN 'failed' ELSE 'pending' END "
            "WHERE id=?",
            (error, int(_t.time()*1000)+backoff_ms, effect_id))
        self.conn.commit()

    # ── Outbox ───────────────────────────────────────────────

    def queue_message(self, ticket_id: str, channel: str, purpose: str, content: str) -> str:
        import uuid
        mid = f"msg_{uuid.uuid4().hex[:12]}"
        self.conn.execute(
            "INSERT INTO outbox VALUES (?,?,?,?,?,'pending',0,?,NULL)",
            (mid, ticket_id, channel, purpose, content,
             int(__import__("time").time()*1000)))
        self.conn.commit()
        return mid

    def pending_messages(self, limit: int = 5) -> list[dict]:
        cur = self.conn.execute(
            "SELECT * FROM outbox WHERE status='pending' ORDER BY created_at LIMIT ?",
            (limit,))
        return [dict(r) for r in cur.fetchall()]

    def mark_sent(self, msg_id: str):
        self.conn.execute(
            "UPDATE outbox SET status='sent', sent_at=? WHERE id=?",
            (int(__import__("time").time()*1000), msg_id))
        self.conn.commit()

    # ── KV ───────────────────────────────────────────────────

    def kv_set(self, key: str, value: str):
        self.conn.execute("INSERT OR REPLACE INTO kv VALUES (?,?)", (key, value))
        self.conn.commit()

    def kv_get(self, key: str) -> Optional[str]:
        cur = self.conn.execute("SELECT value FROM kv WHERE key=?", (key,))
        row = cur.fetchone()
        return row["value"] if row else None
