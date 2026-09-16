"""chunk 语义库（P2）：FTS5(trigram 中文) + vec0 + 差分重嵌。

增量键制（调研最优解拼合）：chunk_id = sha256(text)，logic_ver =
chunker_ver+embedder_ver——khoj 集合差分只嵌新块 × cocoindex 逻辑
版本键换模型有界失效。per-file 单事务替换（quant 纪律）。
降级：无嵌入器/嵌入失败 → keyword-only + embedding_status 标注
（quant 纪律：检索永不因嵌入缺席而 502）。
"""
from __future__ import annotations

import hashlib
import logging
import sqlite3
import time
from dataclasses import dataclass

_log = logging.getLogger("paistation.sense.localfiles.store")

SCHEMA = """
CREATE TABLE IF NOT EXISTS chunks (
    chunk_id  TEXT NOT NULL,     -- sha256(text)
    path      TEXT NOT NULL,
    seq       INTEGER NOT NULL,
    text      TEXT NOT NULL,
    logic_ver TEXT NOT NULL,
    embedding_status TEXT NOT NULL DEFAULT 'none',  -- none|embedded
    file_gen  INTEGER NOT NULL DEFAULT 0,
    updated_at REAL NOT NULL DEFAULT 0,
    PRIMARY KEY (path, seq)
);
CREATE INDEX IF NOT EXISTS idx_chunks_id ON chunks(chunk_id);
CREATE VIRTUAL TABLE IF NOT EXISTS chunks_fts USING fts5(
    text, path UNINDEXED, seq UNINDEXED, tokenize='trigram');
"""

NONE_EMBEDDER = "none"


def _chunk_id(text: str) -> str:
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


@dataclass
class ChunkHit:
    path: str
    seq: int
    text: str
    score: float = 0.0
    source: str = ""


class ChunkIndex:
    """chunk 存取 + 混合检索（FTS5 + 可选 vec0，RRF 融合）。

    embedder 契约：callable(text) -> list[float]，维度须恒定。
    """

    def __init__(self, db_path, embedder=None, embedder_ver: str = NONE_EMBEDDER):
        self._db = sqlite3.connect(str(db_path))
        self._db.row_factory = sqlite3.Row
        self._db.executescript(SCHEMA)
        self._db.execute("PRAGMA journal_mode=WAL")
        self._db.commit()
        self._embedder = embedder
        self._embedder_ver = (
            embedder_ver if embedder is not None else NONE_EMBEDDER)
        self._vec_dim: int | None = None
        self._vec_ready = False

    # ---------- 写入（差分重嵌，per-file 单事务） ----------

    def upsert_file(self, path: str, texts: list[str], logic_ver: str,
                    file_gen: int = 0) -> dict:
        """整文件替换事务：旧块向量可复用则复用，只嵌真正的新块。"""
        from paistation.sense.localfiles.inventory import _norm_path
        path = _norm_path(path)  # 主键前必经：与 files 表同形态
        old = {
            r["chunk_id"]: r["embedding_status"]
            for r in self._db.execute(
                "SELECT chunk_id, embedding_status FROM chunks WHERE path=?",
                (path,))}
        new = [(seq, _chunk_id(t), t) for seq, t in enumerate(texts)]
        now = time.time()
        embedded = reused = 0
        with self._db:
            self._db.execute("DELETE FROM chunks WHERE path=?", (path,))
            self._db.execute("DELETE FROM chunks_fts WHERE path=?", (path,))
            for seq, cid, text in new:
                status = "none"
                if self._embedder is not None:
                    status = self._embed_chunk(cid, text, old)
                    if status == "embedded":
                        embedded += 1
                    else:
                        reused += 1
                self._db.execute(
                    "INSERT INTO chunks(chunk_id, path, seq, text, logic_ver,"
                    " embedding_status, file_gen, updated_at)"
                    " VALUES(?,?,?,?,?,?,?,?)",
                    (cid, path, seq, text, logic_ver, status, file_gen, now))
                self._db.execute(
                    "INSERT INTO chunks_fts(text, path, seq) VALUES(?,?,?)",
                    (text, path, seq))
        return {"chunks": len(texts), "embedded": embedded, "reused": reused}

    def _embed_chunk(self, cid: str, text: str,
                     old_status: dict[str, str]) -> str:
        """同 chunk_id 且旧向量已在 → 复用；否则真嵌。失败降级 none。"""
        try:
            if old_status.get(cid) == "embedded" and self._vec_has(cid):
                return "reused"
            vec = self._embedder(text)
            self._vec_put(cid, vec)
            return "embedded"
        except Exception as exc:
            _log.warning("嵌入失败降级 keyword-only: %s", exc)
            return "none"

    # ---------- vec0 侧车（惰性建表，缺 sqlite_vec 则纯 keyword） ----------

    def _ensure_vec_table(self, dim: int) -> None:
        if self._vec_ready:
            return
        import sqlite_vec

        self._db.enable_load_extension(True)  # 同 memory.hybrid.VecRoute 纪律
        sqlite_vec.load(self._db)
        self._db.execute(
            f"CREATE VIRTUAL TABLE IF NOT EXISTS chunks_vec USING vec0("
            f"chunk_id TEXT PRIMARY KEY, embedding float[{dim}])")
        self._vec_dim, self._vec_ready = dim, True

    def _vec_put(self, cid: str, vec: list[float]) -> None:
        import sqlite_vec

        if self._vec_dim is None:
            self._ensure_vec_table(len(vec))
        elif len(vec) != self._vec_dim:
            raise ValueError(f"嵌入维度漂移 {len(vec)}!={self._vec_dim}")
        self._db.execute(
            "INSERT OR REPLACE INTO chunks_vec(chunk_id, embedding)"
            " VALUES(?,?)", (cid, sqlite_vec.serialize_float32(vec)))

    def _vec_has(self, cid: str) -> bool:
        if not self._vec_ready:
            return False
        row = self._db.execute(
            "SELECT 1 FROM chunks_vec WHERE chunk_id=?", (cid,)).fetchone()
        return row is not None

    # ---------- 检索（keyword + 语义 → RRF） ----------

    def search(self, query: str, k: int = 8) -> list[ChunkHit]:
        routes: dict[str, list[ChunkHit]] = {}
        kw = self._search_fts(query, k)
        if kw:
            # 路由键取 hit 实际后端（fts/like）：RRF 重建 source 时
            # 不把 LIKE 兜底误标成 fts（溯源失真曾致金标准断言误判）
            routes[kw[0].source or "fts"] = kw
        if self._embedder is not None and self._vec_ready:
            try:
                sem = self._search_vec(self._embedder(query), k)
                if sem:
                    routes["vec"] = sem
            except Exception as exc:
                _log.warning("语义路由缺席，keyword-only: %s", exc)
        return _rrf_fuse(routes, k)

    def _search_fts(self, query: str, k: int) -> list[ChunkHit]:
        """trigram ≥3 字走 FTS；中文双字词（方案/合同类）走 LIKE 兜底。"""
        terms = [t for t in query.replace('"', " ").split() if t]
        if terms and all(len(t) >= 3 for t in terms):
            try:
                rows = self._db.execute(
                    "SELECT c.path, c.seq, c.text FROM chunks_fts f"
                    " JOIN chunks c ON c.path = f.path AND c.seq = f.seq"
                    " WHERE chunks_fts MATCH ? ORDER BY rank LIMIT ?",
                    (_fts_query(query), k)).fetchall()
                if rows:
                    return [ChunkHit(r["path"], r["seq"], r["text"],
                                     source="fts") for r in rows]
            except sqlite3.OperationalError as exc:
                _log.debug("FTS 查询失败: %s", exc)
        # 短词兜底：暴力 LIKE（十万级 chunk 暴力扫描足够，调研共识）
        like = f"%{query.strip()}%"
        rows = self._db.execute(
            "SELECT path, seq, text FROM chunks WHERE text LIKE ?"
            " LIMIT ?", (like, k)).fetchall()
        return [ChunkHit(r["path"], r["seq"], r["text"], source="like")
                for r in rows]

    def _search_vec(self, vec: list[float], k: int) -> list[ChunkHit]:
        import sqlite_vec

        if len(vec) != self._vec_dim:
            return []
        rows = self._db.execute(
            "SELECT c.path, c.seq, c.text, v.distance FROM chunks_vec v"
            " JOIN chunks c ON c.chunk_id = v.chunk_id"
            " WHERE embedding MATCH ? AND k = ? ORDER BY distance",
            (sqlite_vec.serialize_float32(vec), k)).fetchall()
        return [ChunkHit(r["path"], r["seq"], r["text"],
                         score=r["distance"], source="vec") for r in rows]

    # ---------- 状态 ----------

    def stats(self) -> dict:
        row = self._db.execute(
            "SELECT COUNT(*) n, SUM(embedding_status IN"
            " ('embedded','reused')) emb, COUNT(DISTINCT path) files"
            " FROM chunks").fetchone()
        return {"chunks": row["n"] or 0, "embedded": row["emb"] or 0,
                "files": row["files"] or 0, "embedder": self._embedder_ver}

    def close(self) -> None:
        self._db.close()


def _fts_query(query: str) -> str:
    terms = [t for t in query.replace('"', " ").split() if t]
    return " OR ".join(f'"{t}"' for t in terms) or '""'


def _rrf_fuse(routes: dict[str, list[ChunkHit]], k: int) -> list[ChunkHit]:
    """RRF（k=60）：双路共识天然优先，无须跨路由分数归一。"""
    scores: dict[tuple, float] = {}
    first: dict[tuple, ChunkHit] = {}
    sources: dict[tuple, set] = {}
    for name, hits in routes.items():
        for rank, h in enumerate(hits, start=1):
            key = (h.path, h.seq)
            scores[key] = scores.get(key, 0.0) + 1.0 / (60 + rank)
            first.setdefault(key, h)
            sources.setdefault(key, set()).add(name)
    fused = [
        ChunkHit(h.path, h.seq, h.text, score=round(scores[key], 6),
                 source="+".join(sorted(sources[key])))
        for key, h in first.items()]
    fused.sort(key=lambda h: (-h.score, h.path, h.seq))
    return fused[:k]
