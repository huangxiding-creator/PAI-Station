"""文件宇宙清单库（P0）+ 提取缓存（P1，行业空白=护城河）。

单 SQLite 库（data/local_index/inventory.db）：
- files 表 = 全盘清单（path 主键，size/mtime/hash/kind/status）
- 提取缓存键 = (content_hash, parser_id, parser_ver)——jdupes hash-db
  快路径（size+mtime 未变直接跳过）+ partial-hash 4096B 初筛 + full
  hash 定案的阶梯；命中即整文件跳过解析（cocoindex 组件级 memoization）。
- 增量 = 代际差分：每轮扫描代 +1，本轮未见即 gone（行保留，ADD-only）。
"""
from __future__ import annotations

import hashlib
import logging
import sqlite3
import time
from dataclasses import dataclass

_log = logging.getLogger("paistation.sense.localfiles.inventory")

SCHEMA = """
CREATE TABLE IF NOT EXISTS files (
    path        TEXT PRIMARY KEY,
    size        INTEGER NOT NULL DEFAULT 0,
    mtime       REAL NOT NULL DEFAULT 0,
    kind        TEXT NOT NULL DEFAULT '',
    hash_full   TEXT NOT NULL DEFAULT '',
    hash_partial TEXT NOT NULL DEFAULT '',
    secret      INTEGER NOT NULL DEFAULT 0,
    seen_gen    INTEGER NOT NULL DEFAULT 0,
    first_seen  REAL NOT NULL DEFAULT 0,
    last_seen   REAL NOT NULL DEFAULT 0,
    extracted_at REAL NOT NULL DEFAULT 0,
    parser_id   TEXT NOT NULL DEFAULT '',
    parser_ver  TEXT NOT NULL DEFAULT '',
    status      TEXT NOT NULL DEFAULT 'pending'
);
CREATE INDEX IF NOT EXISTS idx_files_status ON files(status);
CREATE INDEX IF NOT EXISTS idx_files_kind ON files(kind);
CREATE TABLE IF NOT EXISTS meta (
    key TEXT PRIMARY KEY, value TEXT NOT NULL
);
"""

PARTIAL_BYTES = 4096  # jdupes 式初筛窗口


def file_partial_hash(path: str) -> str:
    """首 4096B 的 sha256——touch 场景 4KB 读即判变没变。"""
    with open(path, "rb") as fh:
        return hashlib.sha256(fh.read(PARTIAL_BYTES)).hexdigest()


def file_hashes(path: str) -> tuple[str, str]:
    """(partial, full) sha256；partial 只读首 4096B 省 IO。"""
    h_part = hashlib.sha256()
    h_full = hashlib.sha256()
    with open(path, "rb") as fh:
        head = fh.read(PARTIAL_BYTES)
        h_part.update(head)
        h_full.update(head)
        while True:
            block = fh.read(1 << 20)
            if not block:
                break
            h_full.update(block)
    return h_part.hexdigest(), h_full.hexdigest()


@dataclass
class ScanDiff:
    """一轮扫描的差分结果（喂给提取层与连接器事件）。"""
    added: list[dict]
    changed: list[dict]
    gone: list[str]

    def __bool__(self) -> bool:
        return bool(self.added or self.changed or self.gone)

    @property
    def total(self) -> int:
        return len(self.added) + len(self.changed) + len(self.gone)


class Inventory:
    """清单+缓存一体库：批量代际差分、待提取队列、统计。"""

    def __init__(self, db_path):
        self._path = str(db_path)
        self._db = sqlite3.connect(self._path)
        self._db.row_factory = sqlite3.Row
        self._db.executescript(SCHEMA)
        self._db.execute("PRAGMA journal_mode=WAL")
        self._db.execute("PRAGMA synchronous=NORMAL")
        self._db.commit()
        self._gen = self._bump_gen()

    # ---------- 代际 ----------

    def _bump_gen(self) -> int:
        self._db.execute(
            "INSERT INTO meta(key, value) VALUES('gen', '1') "
            "ON CONFLICT(key) DO UPDATE SET value = CAST(value AS INTEGER) + 1")
        self._db.commit()
        row = self._db.execute("SELECT value FROM meta WHERE key='gen'").fetchone()
        return int(row["value"])

    @property
    def generation(self) -> int:
        return self._gen

    # ---------- 批量差分（P0 核心） ----------

    def apply_scan(self, records: list[dict], now: float | None = None) -> ScanDiff:
        """整代批量入库：new→added，size/mtime 变→changed，未见→gone。

        records: [{path, size, mtime, secret}]——只读 stat 级信息，
        绝不在此层读文件内容（秘密文件也只登记元数据）。
        """
        ts = time.time() if now is None else now
        # 入口去重（防御任何后端的重复行；冲突留首条，确定性优先）
        uniq: dict[str, dict] = {}
        for rec in records:
            uniq.setdefault(str(rec["path"]), rec)
        known = {
            r["path"]: (r["size"], r["mtime"])
            for r in self._db.execute("SELECT path, size, mtime FROM files")
        }
        added, changed = [], []
        for rec in uniq.values():
            path = str(rec["path"])
            prev = known.pop(path, None)
            row = {
                "path": path,
                "size": int(rec.get("size", 0)),
                "mtime": float(rec.get("mtime", 0)),
                "secret": int(rec.get("secret", 0)),
                "seen_gen": self._gen,
                "ts": ts,
            }
            if prev is None:
                added.append(row)
            elif (int(prev[0]), int(prev[1])) != (row["size"], row["mtime"]):
                changed.append(row)  # 内容键失效 → 重新提取
            else:
                # 未变：推进代际时间戳；顺带回写 size/mtime 自愈
                # （旧库存里的浮点 mtime 归一为整秒，双后端口径一致）
                self._touch(path, row["size"], row["mtime"], ts)
        gone = list(known.keys())
        with self._db:  # 单事务
            self._db.executemany(
                "INSERT INTO files(path, size, mtime, secret, seen_gen,"
                " first_seen, last_seen, status)"
                " VALUES(:path, :size, :mtime, :secret, :seen_gen, :ts, :ts,"
                " CASE :secret WHEN 1 THEN 'secret' ELSE 'pending' END)",
                added)
            for row in changed:
                self._db.execute(
                    "UPDATE files SET size=:size, mtime=:mtime, secret=:secret,"
                    " seen_gen=:seen_gen, last_seen=:ts,"
                    " status=CASE :secret WHEN 1 THEN 'secret' ELSE 'pending' END"
                    " WHERE path=:path", row)
            if gone:
                self._db.executemany(
                    "UPDATE files SET status='gone', seen_gen=0 "
                    "WHERE path=?", [(g,) for g in gone])
        _log.info("代 %d 差分：+%d 变 %d 逝 %d", self._gen,
                  len(added), len(changed), len(gone))
        return ScanDiff(
            added=[{**r, "kind": ""} for r in added],
            changed=[{**r, "kind": ""} for r in changed],
            gone=gone)

    def _touch(self, path: str, size: int, mtime: int, ts: float) -> None:
        with self._db:
            self._db.execute(
                "UPDATE files SET size=?, mtime=?, seen_gen=?, last_seen=?"
                " WHERE path=?", (size, mtime, self._gen, ts, path))

    # ---------- 提取层接口（P1 缓存） ----------

    def pending(self, limit: int = 500) -> list[sqlite3.Row]:
        """待提取队列：pending/failed 且非红线。"""
        return self._db.execute(
            "SELECT * FROM files WHERE status IN ('pending','failed')"
            " AND secret=0 ORDER BY last_seen DESC LIMIT ?", (limit,)).fetchall()

    def cache_hit(self, path: str, size: int, mtime: float,
                  parser_id: str, parser_ver: str) -> bool:
        """快路径：size+mtime+parser 指纹全未变 → 跳过解析。"""
        row = self._db.execute(
            "SELECT size, mtime, parser_id, parser_ver, hash_full, status"
            " FROM files WHERE path=?", (path,)).fetchone()
        return bool(
            row and row["status"] == "ok"
            and row["size"] == size and int(row["mtime"]) == int(mtime)
            and row["parser_id"] == parser_id and row["parser_ver"] == parser_ver
            and row["hash_full"])

    def mark_extracted(self, path: str, parser_id: str, parser_ver: str,
                       hash_full: str, kind: str, now: float | None = None,
                       status: str = "ok", hash_partial: str = "") -> None:
        with self._db:
            self._db.execute(
                "UPDATE files SET parser_id=?, parser_ver=?, hash_full=?,"
                " hash_partial=?, kind=?, extracted_at=?, status=?"
                " WHERE path=?",
                (parser_id, parser_ver, hash_full, hash_partial, kind,
                 time.time() if now is None else now, status, path))

    # ---------- 统计/检索 ----------

    def stats(self) -> dict:
        rows = self._db.execute(
            "SELECT status, COUNT(*) n FROM files GROUP BY status").fetchall()
        by_kind = self._db.execute(
            "SELECT kind, COUNT(*) n FROM files WHERE status!='gone'"
            " GROUP BY kind ORDER BY n DESC").fetchall()
        return {
            "generation": self._gen,
            "by_status": {r["status"]: r["n"] for r in rows},
            "by_kind": [(r["kind"] or "unknown", r["n"]) for r in by_kind],
            "total_alive": sum(r["n"] for r in rows if r["status"] != "gone"),
        }

    def search_paths(self, pattern: str, limit: int = 50) -> list[sqlite3.Row]:
        """文件名 LIKE 秒查（L0 名字级检索，Everything 不在时的兜底）。"""
        return self._db.execute(
            "SELECT path, size, mtime, kind, status FROM files"
            " WHERE path LIKE ? AND status!='gone' LIMIT ?",
            (f"%{pattern}%", limit)).fetchall()

    def close(self) -> None:
        self._db.close()
