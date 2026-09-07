"""全动作审计日志（audit.db 只追加，提案 4.6 安全层）。

线程安全；中文 detail 不转义；提供 audited 装饰器（成败两态落库）。
"""
import functools
import json
import os
import sqlite3
import threading
import time

_SCHEMA = """CREATE TABLE IF NOT EXISTS audit_log(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ts REAL NOT NULL,
    module TEXT NOT NULL,
    action TEXT NOT NULL,
    detail TEXT NOT NULL DEFAULT '{}')"""


class AuditLog:
    """只追加审计账本：record() 写入，query() 倒序查询，无 update/delete API。"""

    def __init__(self, db_path: str):
        parent = os.path.dirname(os.path.abspath(db_path))
        os.makedirs(parent, exist_ok=True)
        self._lock = threading.Lock()
        self._db = sqlite3.connect(db_path, check_same_thread=False)
        self._db.execute(_SCHEMA)
        self._db.commit()

    def record(self, action: str, module: str = "core", **detail) -> None:
        payload = json.dumps(detail, ensure_ascii=False)
        with self._lock:
            self._db.execute(
                "INSERT INTO audit_log(ts, module, action, detail) VALUES(?,?,?,?)",
                (time.time(), module, action, payload))
            self._db.commit()

    def query(self, action: str | None = None, module: str | None = None,
              limit: int = 100) -> list[dict]:
        sql, args = "SELECT id, ts, module, action, detail FROM audit_log", []
        conds = []
        if action:
            conds.append("action=?")
            args.append(action)
        if module:
            conds.append("module=?")
            args.append(module)
        if conds:
            sql += " WHERE " + " AND ".join(conds)
        sql += " ORDER BY id DESC LIMIT ?"
        args.append(limit)
        rows = self._db.execute(sql, args).fetchall()
        return [{"id": r[0], "ts": r[1], "module": r[2], "action": r[3],
                 "detail": json.loads(r[4])} for r in rows]

    def close(self) -> None:
        self._db.close()


def audited(action: str, module: str = "core", audit: AuditLog | None = None):
    """装饰器：成功记 ok=True；异常记 ok=False+error 并重抛；audit=None 时 no-op。"""
    def deco(fn):
        @functools.wraps(fn)
        def wrap(*args, **kwargs):
            if audit is None:
                return fn(*args, **kwargs)
            try:
                result = fn(*args, **kwargs)
                audit.record(action, module=module, ok=True)
                return result
            except Exception as exc:
                audit.record(action, module=module, ok=False,
                             error=str(exc)[:300])
                raise
        return wrap
    return deco
