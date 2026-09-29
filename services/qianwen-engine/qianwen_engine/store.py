# -*- coding: utf-8 -*-
"""总包千问存储——sqlite（用户配额 / 答案 / 点赞 / 批评 / 互动赠次 / 锅圈）。"""
from __future__ import annotations

import json
import secrets as pysecrets
import sqlite3
import threading
import time
from contextlib import contextmanager
from typing import Optional

from . import config

_LOCK = threading.Lock()
_init_done = False


@contextmanager
def _db():
    config.DATA_DIR.mkdir(parents=True, exist_ok=True)
    conn = sqlite3.connect(config.DB_PATH)
    conn.row_factory = sqlite3.Row
    try:
        yield conn
        conn.commit()
    finally:
        conn.close()


def init() -> None:
    global _init_done
    with _LOCK:
        if _init_done:
            return
        with _db() as c:
            c.executescript(
                """
                CREATE TABLE IF NOT EXISTS users (
                    openid TEXT PRIMARY KEY,
                    unionid TEXT DEFAULT '',
                    nickname TEXT DEFAULT '',
                    free_used INTEGER DEFAULT 0,
                    bonus_earned INTEGER DEFAULT 0,
                    bonus_used INTEGER DEFAULT 0,
                    quota_day TEXT DEFAULT '',
                    like_day TEXT DEFAULT '',
                    like_granted INTEGER DEFAULT 0,
                    created_at TEXT DEFAULT (datetime('now','localtime'))
                );
                CREATE TABLE IF NOT EXISTS answers (
                    id TEXT PRIMARY KEY,
                    openid TEXT NOT NULL,
                    question TEXT NOT NULL,
                    answer_full TEXT DEFAULT '',
                    citations TEXT DEFAULT '[]',
                    via TEXT DEFAULT 'kb',
                    status TEXT DEFAULT 'ready',
                    unlocked INTEGER DEFAULT 0,
                    liked INTEGER DEFAULT 0,
                    criticized INTEGER DEFAULT 0,
                    elapsed_sec REAL DEFAULT 0,
                    created_at TEXT DEFAULT (datetime('now','localtime'))
                );
                CREATE INDEX IF NOT EXISTS idx_answers_openid ON answers(openid, created_at DESC);
                CREATE TABLE IF NOT EXISTS mp_session (
                    openid TEXT PRIMARY KEY,
                    session_key TEXT NOT NULL,
                    updated_at TEXT DEFAULT (datetime('now','localtime'))
                );
                CREATE TABLE IF NOT EXISTS rewards (
                    id INTEGER PRIMARY KEY AUTOINCREMENT,
                    openid TEXT NOT NULL,
                    aid TEXT NOT NULL,
                    action TEXT NOT NULL,
                    created_at TEXT DEFAULT (datetime('now','localtime')),
                    UNIQUE(openid, aid, action)
                );
                CREATE TABLE IF NOT EXISTS pot_items (
                    aid TEXT PRIMARY KEY,
                    sort INTEGER DEFAULT 0,
                    created_at TEXT DEFAULT (datetime('now','localtime'))
                );
                """
            )
        _init_done = True
        # 增列（老库平滑升级：已存在则忽略）：v0.2.2 error_text / v0.2.5 支付两列 / v0.5.0 优化计数
        for _col in ("error_text TEXT DEFAULT ''", "out_trade_no TEXT DEFAULT ''", "paid INTEGER DEFAULT 0"):
            try:
                with _db() as c:
                    c.execute(f"ALTER TABLE answers ADD COLUMN {_col}")
            except sqlite3.OperationalError:
                pass
        for _col in ("opt_day TEXT DEFAULT ''", "opt_used INTEGER DEFAULT 0"):
            try:
                with _db() as c:
                    c.execute(f"ALTER TABLE users ADD COLUMN {_col}")
            except sqlite3.OperationalError:
                pass


def _today() -> str:
    """北京日期（UTC+8 固定偏移，无夏令时）——清零时点=北京时间 00:00，与服务器时区无关。"""
    return time.strftime("%Y-%m-%d", time.gmtime(time.time() + 8 * 3600))


def _row_user(c: sqlite3.Connection, openid: str) -> sqlite3.Row:
    row = c.execute("SELECT * FROM users WHERE openid=?", (openid,)).fetchone()
    if row is None:
        c.execute("INSERT INTO users(openid, quota_day) VALUES(?,?)", (openid, _today()))
        row = c.execute("SELECT * FROM users WHERE openid=?", (openid,)).fetchone()
    # 跨日重置
    if row["quota_day"] != _today():
        c.execute(
            "UPDATE users SET free_used=0, bonus_earned=0, bonus_used=0,"
            " like_granted=0, quota_day=? WHERE openid=?",
            (_today(), openid))
        row = _row_user(c, openid)
    return row


def quota_left(openid: str) -> dict:
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        free_left = max(0, config.FREE_PER_DAY - row["free_used"])
        bonus_left = max(0, row["bonus_earned"] - row["bonus_used"])
        return {
            "free_left": free_left,
            "bonus_left": bonus_left,
            "total_left": free_left + bonus_left,
            "free_per_day": config.FREE_PER_DAY,
        }


def consume_one(openid: str) -> bool:
    """扣一次提问配额（先免费后赠次）。返回 False=无配额。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["free_used"] < config.FREE_PER_DAY:
            c.execute("UPDATE users SET free_used=free_used+1 WHERE openid=?", (openid,))
            return True
        if row["bonus_used"] < row["bonus_earned"]:
            c.execute("UPDATE users SET bonus_used=bonus_used+1 WHERE openid=?", (openid,))
            return True
        return False


# ── v0.5.0 互动赠次：有用/导出/分享/纠错，每答案每动作一次，总量上不封顶 ──
def reward_exists(openid: str, aid: str, action: str) -> bool:
    init()
    with _db() as c:
        row = c.execute(
            "SELECT 1 FROM rewards WHERE openid=? AND aid=? AND action=?",
            (openid, aid, action)).fetchone()
        return row is not None


def grant_reward(openid: str, aid: str, action: str) -> bool:
    """互动赠次（+1）。UNIQUE(openid,aid,action)=每答案每动作一次；返回 False=已领过。"""
    if action not in config.REWARD_ACTIONS:
        raise ValueError(f"未知赠次动作: {action}")
    init()
    with _LOCK, _db() as c:
        _row_user(c, openid)  # 确保用户在册且当日计数已重置
        try:
            c.execute(
                "INSERT INTO rewards(openid, aid, action) VALUES(?,?,?)",
                (openid, aid, action))
        except sqlite3.IntegrityError:
            return False
        c.execute("UPDATE users SET bonus_earned=bonus_earned+1 WHERE openid=?", (openid,))
        return True


def new_answer_id() -> str:
    # 短 ID（海报 scene 用，≤32 字符且免中文 urlencode）
    return pysecrets.token_urlsafe(6)


def save_answer(openid: str, question: str, answer_full: str,
                citations: list, via: str = "kb", elapsed: float = 0.0) -> str:
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO answers(id, openid, question, answer_full, citations, via, elapsed_sec)"
            " VALUES(?,?,?,?,?,?,?)",
            (aid, openid, question, answer_full,
             json.dumps(citations, ensure_ascii=False), via, elapsed),
        )
    return aid


def create_pending(openid: str, question: str) -> str:
    """v0.2.2 异步流水线：先落 pending 行，完成后回填。"""
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO answers(id, openid, question, status) VALUES(?,?,?,'pending')",
            (aid, openid, question),
        )
    return aid


def complete_answer(aid: str, answer_full: str, citations: list,
                    elapsed: float = 0.0) -> bool:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE answers SET answer_full=?, citations=?, elapsed_sec=?,"
            " status='ready', unlocked=1, error_text='' WHERE id=? AND status='pending'",
            (answer_full, json.dumps(citations, ensure_ascii=False), elapsed, aid),
        )
        return c.total_changes > 0


def fail_answer(aid: str, err: str) -> bool:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "UPDATE answers SET status='error', error_text=? WHERE id=? AND status='pending'",
            ((err or "")[:300], aid),
        )
        return c.total_changes > 0


def refund_one(openid: str) -> None:
    """失败退次：consume_one 的逆操作（优先退赠次）。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["bonus_used"] > 0:
            c.execute("UPDATE users SET bonus_used=bonus_used-1 WHERE openid=?", (openid,))
        elif row["free_used"] > 0:
            c.execute("UPDATE users SET free_used=free_used-1 WHERE openid=?", (openid,))


def get_answer(aid: str, openid: Optional[str] = None) -> Optional[dict]:
    init()
    with _db() as c:
        row = c.execute("SELECT * FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None:
            return None
        if openid is not None and row["openid"] != openid:
            return None
        d = dict(row)
        d["citations"] = json.loads(d.get("citations") or "[]")
        return d


def get_answer_visible(aid: str, openid: str) -> Optional[dict]:
    """可见性=本人答案 或 锅圈公共答案（v0.5.0）。"""
    row = get_answer(aid)
    if row is None:
        return None
    if row["openid"] == openid or row["openid"] == config.POT_OPENID:
        return row
    return None


def mark_liked(aid: str, openid: str) -> bool:
    """本人答案的行级点赞标记（老语义）。锅圈点赞不走这里——走 grant_reward 的 UNIQUE 去重。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT liked, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid:
            return False
        if row["liked"]:
            return False
        c.execute("UPDATE answers SET liked=1 WHERE id=?", (aid,))
        return True


def save_criticism(aid: str, openid: str, text: str, score: Optional[int] = None,
                   refund_tier: str = "") -> bool:
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT criticized, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None:
            return False
        is_owner = row["openid"] == openid
        is_pot = row["openid"] == config.POT_OPENID
        if not is_owner and not is_pot:
            return False
        if is_owner and row["criticized"]:
            return False
        if is_pot:
            seen = c.execute(
                "SELECT 1 FROM rewards WHERE openid=? AND aid=? AND action='criticize'",
                (openid, aid)).fetchone()
            if seen:
                return False
        if is_owner:
            c.execute("UPDATE answers SET criticized=1 WHERE id=?", (aid,))
        c.execute(
            "CREATE TABLE IF NOT EXISTS criticisms"
            "(id INTEGER PRIMARY KEY AUTOINCREMENT, aid TEXT, openid TEXT, text TEXT,"
            " score INTEGER, refund_tier TEXT, created_at TEXT DEFAULT (datetime('now','localtime')))"
        )
        c.execute("INSERT INTO criticisms(aid, openid, text, score, refund_tier) VALUES(?,?,?,?,?)",
                  (aid, openid, text, score, refund_tier))
        return True


def mark_unlocked(aid: str, openid: str) -> bool:
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT unlocked, openid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid or row["unlocked"]:
            return False
        c.execute("UPDATE answers SET unlocked=1 WHERE id=?", (aid,))
        return True


# ── v0.2.5 虚拟支付：session_key 存取 + 支付解锁 ──────────────
def save_session(openid: str, session_key: str) -> None:
    """登录态留存 session_key（仅服务端使用，绝不下发客户端）。"""
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO mp_session(openid, session_key) VALUES(?,?)"
            " ON CONFLICT(openid) DO UPDATE SET"
            " session_key=excluded.session_key, updated_at=datetime('now','localtime')",
            (openid, session_key or ""),
        )


def get_session(openid: str) -> str:
    init()
    with _db() as c:
        row = c.execute("SELECT session_key FROM mp_session WHERE openid=?", (openid,)).fetchone()
        return (row["session_key"] if row else "") or ""


def mark_paid(aid: str, openid: str, out_trade_no: str = "") -> bool:
    """支付成功解锁：幂等（重复回调恒 True）；首次落 pay_log 供对账。"""
    init()
    with _LOCK, _db() as c:
        row = c.execute("SELECT openid, paid FROM answers WHERE id=?", (aid,)).fetchone()
        if row is None or row["openid"] != openid:
            return False
        otn = (out_trade_no or aid)[:64]
        if not row["paid"]:
            c.execute(
                "UPDATE answers SET unlocked=1, paid=1, out_trade_no=? WHERE id=?", (otn, aid))
            c.execute(
                "CREATE TABLE IF NOT EXISTS pay_log(aid TEXT, openid TEXT, out_trade_no TEXT,"
                " created_at TEXT DEFAULT (datetime('now','localtime')))"
            )
            c.execute("INSERT INTO pay_log(aid, openid, out_trade_no) VALUES(?,?,?)",
                      (aid, openid, otn))
        else:
            c.execute("UPDATE answers SET unlocked=1 WHERE id=?", (aid,))
        return True


def history(openid: str, limit: int = 20) -> list:
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT id, question, substr(answer_full,1,60) AS preview, liked, criticized,"
            " status, unlocked, created_at FROM answers WHERE openid=?"
            " ORDER BY rowid DESC LIMIT ?",
            (openid, limit),
        )
        return [dict(r) for r in cur.fetchall()]


def history_all(openid: str) -> list:
    """全部已完成答案（批量导出用，时间正序）。"""
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT * FROM answers WHERE openid=? AND status='ready'"
            " ORDER BY rowid ASC",
            (openid,),
        )
        out = []
        for r in cur.fetchall():
            d = dict(r)
            d["citations"] = json.loads(d.get("citations") or "[]")
            out.append(d)
        return out


# ── v0.5.0 AI 优化提问：每用户每日计数（护共享 KB 免费池） ──
def consume_optimize(openid: str) -> bool:
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        today = _today()
        if row["opt_day"] != today:
            c.execute("UPDATE users SET opt_day=?, opt_used=0 WHERE openid=?", (today, openid))
            opt_used = 0
        else:
            opt_used = row["opt_used"]
        if opt_used >= config.OPTIMIZE_DAILY_CAP:
            return False
        c.execute("UPDATE users SET opt_used=opt_used+1 WHERE openid=?", (openid,))
        return True


def refund_optimize(openid: str) -> None:
    """优化失败退计数。"""
    init()
    with _LOCK, _db() as c:
        row = _row_user(c, openid)
        if row["opt_day"] == _today() and row["opt_used"] > 0:
            c.execute("UPDATE users SET opt_used=opt_used-1 WHERE openid=?", (openid,))


def opt_used_today(openid: str) -> int:
    init()
    with _db() as c:
        row = _row_user(c, openid)
        return row["opt_used"] if row["opt_day"] == _today() else 0


# ── v0.5.0 锅圈：公共热点问题展区 ──
def pot_add(aid: str, sort: int = 0) -> None:
    init()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO pot_items(aid, sort) VALUES(?,?)"
            " ON CONFLICT(aid) DO UPDATE SET sort=excluded.sort",
            (aid, sort))


def pot_list() -> list:
    """锅圈列表：热点问题 + 答案前 100 字预览 + 按人去重的点赞数。"""
    init()
    with _db() as c:
        cur = c.execute(
            "SELECT a.id AS aid, a.question, a.answer_full, a.created_at,"
            " (SELECT COUNT(*) FROM rewards r"
            "  WHERE r.aid=a.id AND r.action='like') AS likes"
            " FROM pot_items p JOIN answers a ON a.id=p.aid"
            " WHERE a.status='ready' AND a.answer_full != ''"
            " ORDER BY p.sort ASC, p.rowid ASC"
        )
        return [{
            "id": r["aid"],
            "question": r["question"],
            "preview": (r["answer_full"] or "")[:config.POT_PREVIEW_CHARS],
            "likes": r["likes"],
            "full_chars": len(r["answer_full"] or ""),
            "created_at": r["created_at"],
        } for r in cur.fetchall()]


def pot_liked_by(aid: str, openid: str) -> bool:
    return reward_exists(openid, aid, "like")


def pot_exists(question: str) -> bool:
    """播种幂等：同一问题已入锅则跳过（跨日补种用）。"""
    init()
    with _db() as c:
        row = c.execute(
            "SELECT 1 FROM answers WHERE openid=? AND question=? LIMIT 1",
            (config.POT_OPENID, question)).fetchone()
        return row is not None


def save_pot_answer(question: str, answer_full: str, citations: list,
                    sort: int = 0, elapsed: float = 0.0) -> str:
    """锅圈条目落库：answers 行（POT_OPENID · ready · unlocked）+ pot_items 登记。"""
    init()
    aid = new_answer_id()
    with _LOCK, _db() as c:
        c.execute(
            "INSERT INTO answers(id, openid, question, answer_full, citations, via,"
            " status, unlocked, elapsed_sec) VALUES(?,?,?,?,?,'kb','ready',1,?)",
            (aid, config.POT_OPENID, question, answer_full,
             json.dumps(citations, ensure_ascii=False), elapsed),
        )
        c.execute("INSERT INTO pot_items(aid, sort) VALUES(?,?)", (aid, sort))
    return aid


def any_pending() -> bool:
    """是否有引擎在跑的问题（播种器据此让路，两进程经 DB 串行化）。"""
    init()
    with _db() as c:
        row = c.execute("SELECT 1 FROM answers WHERE status='pending' LIMIT 1").fetchone()
        return row is not None
