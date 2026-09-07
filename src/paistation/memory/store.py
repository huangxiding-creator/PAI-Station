"""分层记忆存储（提案 4.2 memory / 附录 B.1）：SQLite FTS5 文档摘要库。

trigram 分词器支持中文子串检索（SQLite ≥3.34）；旧版本自动回退 LIKE。
upsert 以 path 为键幂等；stats 供首扫镜像报告聚合。
"""
import os
import sqlite3
import threading

_SCHEMA = """
CREATE TABLE IF NOT EXISTS docs(
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    path TEXT NOT NULL UNIQUE,
    title TEXT NOT NULL DEFAULT '',
    summary TEXT NOT NULL DEFAULT '',
    score REAL NOT NULL DEFAULT 0.5,
    size INTEGER NOT NULL DEFAULT 0,
    mtime REAL NOT NULL DEFAULT 0,
    ingested_at REAL NOT NULL DEFAULT 0)
"""


class MemoryStore:
    """文档摘要库：upsert / search / stats。"""

    def __init__(self, db_path: str):
        parent = os.path.dirname(os.path.abspath(db_path))
        os.makedirs(parent, exist_ok=True)
        # watchdog 回调线程与主线程共用（实机 2026-09-07 日志教训：
        # 默认 check_same_thread=True → 实时入库全败）；串行锁保安全
        self._lock = threading.Lock()
        self._db = sqlite3.connect(db_path, check_same_thread=False)
        self._db.row_factory = sqlite3.Row
        self._db.execute(_SCHEMA)
        self._fts = self._init_fts()
        self._db.commit()

    def _init_fts(self) -> bool:
        try:
            self._db.execute(
                "CREATE VIRTUAL TABLE IF NOT EXISTS docs_fts USING fts5("
                "path, title, summary, tokenize='trigram')")
            return True
        except sqlite3.OperationalError:
            return False  # 旧 SQLite：回退 LIKE

    def upsert(self, path: str, title: str, summary: str, score: float,
               size: int = 0, mtime: float = 0.0) -> None:
        import time
        now = time.time()
        norm = path.replace("\\", "/")  # 两表同键归一，JOIN 才能对上
        with self._lock:
            self._db.execute(
                "INSERT INTO docs(path, title, summary, score, size, mtime, ingested_at)"
                " VALUES(?,?,?,?,?,?,?)"
                " ON CONFLICT(path) DO UPDATE SET title=excluded.title,"
                " summary=excluded.summary, score=excluded.score, size=excluded.size,"
                " mtime=excluded.mtime, ingested_at=excluded.ingested_at",
                (norm, title, summary, score, size, mtime, now))
            if self._fts:
                self._db.execute("DELETE FROM docs_fts WHERE path=?", (norm,))
                self._db.execute(
                    "INSERT INTO docs_fts(path, title, summary) VALUES(?,?,?)",
                    (norm, title, summary))
            self._db.commit()

    def search(self, query: str, limit: int = 10) -> list[dict]:
        if not query.strip():
            return []
        with self._lock:
            if self._fts:
                rows = self._db.execute(
                    "SELECT d.* FROM docs_fts f JOIN docs d ON d.path = f.path "
                    "WHERE docs_fts MATCH ? LIMIT ?",
                    (self._fts_query(query), limit)).fetchall()
            else:
                like = f"%{query}%"
                rows = self._db.execute(
                    "SELECT * FROM docs WHERE summary LIKE ? OR title LIKE ? "
                    "LIMIT ?", (like, like, limit)).fetchall()
        return [dict(r) for r in rows]

    @staticmethod
    def _fts_query(query: str) -> str:
        """trigram MATCH 需要引号包裹防语法注入。"""
        safe = query.replace('"', " ").strip()
        return f'"{safe}"'

    def stats(self) -> dict:
        with self._lock:
            rows = self._db.execute(
                "SELECT path, score FROM docs").fetchall()
        by_suffix: dict[str, int] = {}
        by_dir: dict[str, int] = {}
        for row in rows:
            path = row["path"]
            suffix = os.path.splitext(path)[1].lower() or "(无)"
            by_suffix[suffix] = by_suffix.get(suffix, 0) + 1
            directory = path.rsplit("/", 1)[0].lower() if "/" in path else "(根)"
            by_dir[directory] = by_dir.get(directory, 0) + 1
        top_dirs = dict(sorted(by_dir.items(), key=lambda kv: -kv[1])[:10])
        return {"total": len(rows), "by_suffix": by_suffix,
                "by_dir": top_dirs}

    def close(self) -> None:
        self._db.close()
