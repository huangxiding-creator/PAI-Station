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
CREATE TABLE IF NOT EXISTS meta (
    key TEXT PRIMARY KEY, value TEXT NOT NULL
);
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

    def __init__(self, db_path, embedder=None, embedder_ver: str = NONE_EMBEDDER,
                 batch_embedder=None):
        self._db = sqlite3.connect(str(db_path))
        self._db.row_factory = sqlite3.Row
        self._db.executescript(SCHEMA)
        self._db.execute("PRAGMA journal_mode=WAL")
        self._db.commit()
        self._embedder = embedder
        self._embedder_ver = (
            embedder_ver if embedder is not None else NONE_EMBEDDER)
        # 批量嵌入器（回填专用）：callable(texts)->list[vec]，一次推理
        # 摊薄 GPU 启动开销——实测单条 1 块/s vs 批量 30 块/s
        self._batch_embedder = batch_embedder
        self._vec_dim: int | None = None
        self._vec_ready = False

    # ---------- 写入（差分重嵌，per-file 单事务） ----------

    def upsert_file(self, path: str, texts: list[str], logic_ver: str,
                    file_gen: int = 0) -> dict:
        """整文件替换事务：旧块向量可复用则复用，只嵌真正的新块。

        rowid 配对（2026-09-17 根治入库瓶颈）：chunks 与 chunks_fts
        同 rowid 双写，删除走 rowid B 树直击。FTS5 虚表列无索引——
        旧版 `DELETE FROM chunks_fts WHERE path=?` 是 86 万行全表扫
        （真机实测 73 块文件 2.12s，29ms/块全烧在删旧行），rowid
        直击后整文件替换回到毫秒级。存量两表 rowid 失配由
        rebuild_fts_prefix(v2) 一次性同步。
        """
        from paistation.sense.localfiles.inventory import _norm_path
        path = _norm_path(path)  # 主键前必经：与 files 表同形态
        old = {
            r["chunk_id"]: r["embedding_status"]
            for r in self._db.execute(
                "SELECT chunk_id, embedding_status FROM chunks WHERE path=?",
                (path,))}
        old_rids = [r[0] for r in self._db.execute(
            "SELECT rowid FROM chunks WHERE path=?", (path,))]
        new = [(seq, _chunk_id(t), t) for seq, t in enumerate(texts)]
        now = time.time()
        embedded = reused = 0
        with self._db:
            if old_rids:
                self._db.executemany(
                    "DELETE FROM chunks_fts WHERE rowid=?",
                    [(r,) for r in old_rids])
            self._db.execute("DELETE FROM chunks WHERE path=?", (path,))
            rid = self._db.execute(
                "SELECT COALESCE(MAX(rowid), 0) FROM chunks").fetchone()[0]
            for seq, cid, text in new:
                status = "none"
                if self._embedder is not None:
                    status = self._embed_chunk(cid, text, old)
                    if status == "embedded":
                        embedded += 1
                    else:
                        reused += 1
                rid += 1
                self._db.execute(
                    "INSERT INTO chunks(rowid, chunk_id, path, seq, text,"
                    " logic_ver, embedding_status, file_gen, updated_at)"
                    " VALUES(?,?,?,?,?,?,?,?,?)",
                    (rid, cid, path, seq, text, logic_ver, status,
                     file_gen, now))
                self._db.execute(
                    "INSERT INTO chunks_fts(rowid, text, path, seq)"
                    " VALUES(?,?,?,?)",
                    (rid, f"[{path}] {text}", path, seq))  # Contextual 元前缀
        return {"chunks": len(texts), "embedded": embedded, "reused": reused}

    def rename_path(self, old: str, dest: str) -> int:
        """USN rename 伴生换路径：chunks 主键 + fts 行同步改写。

        chunk_id=内容哈希与向量不参与——移动文件零重嵌零重建，
        向量经 chunk_id join 天然跟到新路径。返回改写行数。
        """
        from paistation.sense.localfiles.inventory import _norm_path

        old, dest = _norm_path(old), _norm_path(dest)
        with self._db:
            if self._db.execute(
                    "SELECT 1 FROM chunks WHERE path=?", (old,)).fetchone():
                # dest 残留重复块（老环轮/竞态）让位：rowid 直击删 fts
                rids = [r[0] for r in self._db.execute(
                    "SELECT rowid FROM chunks WHERE path=?", (dest,))]
                if rids:
                    self._db.executemany(
                        "DELETE FROM chunks_fts WHERE rowid=?",
                        [(r,) for r in rids])
                self._db.execute("DELETE FROM chunks WHERE path=?", (dest,))
            cur = self._db.execute(
                "UPDATE chunks SET path=? WHERE path=?", (dest, old))
            n = cur.rowcount
            if n:
                self._db.execute(
                    "UPDATE chunks_fts SET path=? WHERE path=?", (dest, old))
                # fts text 带 [路径] 元前缀（Contextual 检索），需重建该组行
                rids = [r[0] for r in self._db.execute(
                    "SELECT f.rowid FROM chunks_fts f JOIN chunks c"
                    " ON c.rowid=f.rowid WHERE c.path=?", (dest,))]
                for rid in rids:
                    row = self._db.execute(
                        "SELECT c.path, c.text FROM chunks c"
                        " WHERE c.rowid=?", (rid,)).fetchone()
                    self._db.execute(
                        "UPDATE chunks_fts SET text=? WHERE rowid=?",
                        (f"[{row['path']}] {row['text']}", rid))
        return n

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

    def backfill(self, batch: int = 256) -> dict:
        """存量 none 块批量补嵌（--no-embed 时代入库的欠账）。

        同 chunk_id 跨文件多行只嵌一次、全部点亮（chunks_vec 主键即
        去重键）；断点 = embedding_status，重跑零产出。毒文本单块
        失败跳过不阻塞批次（Calibre 纪律）。批间 yield 事务，随时可停。
        """
        if self._embedder is None and self._batch_embedder is None:
            return {"error": "no embedder"}
        rows = self._db.execute(
            "SELECT DISTINCT chunk_id, text FROM chunks"
            " WHERE embedding_status='none' LIMIT ?", (batch,)).fetchall()
        # 预检分流：并发重注册的"假 none"块（vec 已在、状态翻回）直接
        # 点亮跳过——不预检会撞 chunks_vec 主键 UNIQUE（sqlite_vec 虚拟
        # 表不支持 OR REPLACE 冲突解决，延迟到 commit 才炸），计成失败
        # 后夜夜重试已嵌块（2026-09-18 夜 11,329 次白磨实证）。
        lit_pre = 0
        todo = []
        for r in rows:
            if self._vec_ready and self._vec_has(r["chunk_id"]):
                with self._db:
                    cur = self._db.execute(
                        "UPDATE chunks SET embedding_status='embedded'"
                        " WHERE chunk_id=?", (r["chunk_id"],))
                    lit_pre += cur.rowcount
            else:
                todo.append(r)
        rows = todo
        embedded = rows_lit = failed = 0
        if self._batch_embedder is not None:
            embedded, rows_lit, failed = self._backfill_batched(rows)
        else:
            for r in rows:
                try:
                    self._vec_put(r["chunk_id"], self._embedder(r["text"]))
                    with self._db:
                        cur = self._db.execute(
                            "UPDATE chunks SET embedding_status='embedded'"
                            " WHERE chunk_id=?", (r["chunk_id"],))
                        rows_lit += cur.rowcount
                    embedded += 1
                except Exception as exc:
                    failed += 1
                    _log.warning("补嵌失败跳过 chunk %s: %s",
                                 r["chunk_id"][:12], exc)
        return {"embedded": embedded, "rows_lit": rows_lit + lit_pre,
                "failed": failed, "remaining": self._pending_count()}

    def _backfill_batched(self, rows) -> tuple[int, int, int]:
        """批嵌 128/片一次推理；毒片降级逐条救回好块。"""
        SLICE = 128
        embedded = rows_lit = failed = 0
        for i in range(0, len(rows), SLICE):
            sl = rows[i:i + SLICE]
            try:
                vecs = self._batch_embedder([r["text"] for r in sl])
                if len(vecs) != len(sl):
                    raise ValueError(f"批量返回数不符 {len(vecs)}!={len(sl)}")
                for r, vec in zip(sl, vecs):
                    self._vec_put(r["chunk_id"], vec)
                    with self._db:
                        cur = self._db.execute(
                            "UPDATE chunks SET embedding_status='embedded'"
                            " WHERE chunk_id=?", (r["chunk_id"],))
                        rows_lit += cur.rowcount
                    embedded += 1
            except Exception as exc:
                _log.warning("批嵌片失败降级逐条（%d 块）: %s", len(sl), exc)
                for r in sl:  # 逐条救：定位毒块，好块不陪葬
                    try:
                        vec = self._batch_embedder([r["text"]])[0]
                        self._vec_put(r["chunk_id"], vec)
                        with self._db:
                            cur = self._db.execute(
                                "UPDATE chunks SET embedding_status='embedded'"
                                " WHERE chunk_id=?", (r["chunk_id"],))
                            rows_lit += cur.rowcount
                        embedded += 1
                    except Exception as exc1:
                        failed += 1
                        _log.warning("补嵌失败跳过 chunk %s: %s",
                                     r["chunk_id"][:12], exc1)
        return embedded, rows_lit, failed

    def _pending_count(self) -> int:
        row = self._db.execute(
            "SELECT COUNT(DISTINCT chunk_id) FROM chunks"
            " WHERE embedding_status='none'").fetchone()
        return row[0]

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
        """分级路由（09-17 实战重构，白龟湖诉讼检索暴露的整串 LIKE bug）：

        - 长词(≥3字) FTS 取候选（OR + bm25 rank，向后兼容）
        - 短词(<3字，中文双字词常态) 在候选内 AND 过滤——毫秒级精确，
          不落全表扫；过滤后空则退回纯长词命中保召回
        - 纯短词查询才落 LIKE：AND 一次扫完（87 万行 ~8s），空则
          OR 兜底按命中词数排序
        旧版混合查询（『尾款 划抵 244』）整串 `LIKE '%尾款 划抵 244%'`
        连空格都要求匹配——永远零命中，OCR 入库的核心证据查不出来。
        """
        terms: list[str] = []
        for t in query.replace('"', " ").split():
            for w in _segment_cjk(t):
                if w and w not in terms:
                    terms.append(w)
        if not terms:
            return []
        longs = [t for t in terms if len(t) >= 3]
        shorts = [t for t in terms if len(t) < 3]
        if longs:
            # 有短词时候选放大 32 倍：短词过滤的空间基础（『244』这类
            # 弱区分度长词 bm25 前排全是噪声，真目标在几十名开外）
            hits = self._fts_match(_fts_query(" ".join(longs)),
                                   k * (32 if shorts else 1))
            if hits and shorts:
                filtered = [h for h in hits
                            if all(s in h.text for s in shorts)]
                if filtered:  # AND 命中
                    return filtered[:k]
                # 快路径空 → 慢路径：path 级全词 AND-LIKE（数字弱区分
                # 词 bm25 前排全是噪声，真目标在候选窗外；~8s 换精确）
                slow = self._like_graduated(longs + shorts, k)
                if slow:
                    return slow
                # AND 空：含短词数作相关性信号重排（稳定排序保 bm25 序）
                hits.sort(key=lambda h: (0 - sum(
                    s in h.text for s in shorts)))
            if hits:  # 退回长词命中保召回（重排后）
                return hits[:k]
        if shorts:
            return self._like_graduated(shorts, k)
        return []

    def _fts_match(self, match_expr: str, k: int) -> list[ChunkHit]:
        try:
            rows = self._db.execute(
                "SELECT c.path, c.seq, c.text FROM chunks_fts f"
                " JOIN chunks c ON c.rowid = f.rowid"
                " WHERE chunks_fts MATCH ? ORDER BY rank LIMIT ?",
                (match_expr, k)).fetchall()
            return [ChunkHit(r["path"], r["seq"], r["text"],
                             source="fts") for r in rows]
        except sqlite3.OperationalError as exc:
            _log.debug("FTS 查询失败: %s", exc)
            return []

    def _like_graduated(self, terms: list[str], k: int) -> list[ChunkHit]:
        """path 级 AND-LIKE 聚合 → 空 OR 兜底。

        块级 AND 过苛（『尾款』在标题块、『划抵 244』在正文块——
        用户心智是文档级）：先 DISTINCT path 找全词文档（一次全表
        扫，~8s@87 万块），再取回该文档的块按命中词数排。
        """
        pats = [f"%{_like_escape(t)}%" for t in terms]
        cond = 'text LIKE ? ESCAPE "\\"'
        paths = [r[0] for r in self._db.execute(
            f"SELECT DISTINCT path FROM chunks WHERE "
            f"{' AND '.join([cond] * len(pats))} LIMIT ?",
            (*pats, k * 4)).fetchall()]
        if paths:
            qmarks = ",".join("?" * len(paths))
            rows = self._db.execute(
                f"SELECT path, seq, text FROM chunks WHERE path IN ({qmarks})",
                paths).fetchall()
            hits = [ChunkHit(r["path"], r["seq"], r["text"],
                             score=float(sum(t in r["text"]
                                             for t in terms)),
                             source="like") for r in rows]
            hits.sort(key=lambda h: (-h.score, h.path, h.seq))
            return hits[:k]
        or_rows = self._db.execute(
            f"SELECT path, seq, text FROM chunks WHERE "
            f"{' OR '.join([cond] * len(pats))} LIMIT ?",
            (*pats, k * 3)).fetchall()
        hits = [ChunkHit(r["path"], r["seq"], r["text"],
                         score=float(sum(t in r["text"] for t in terms)),
                         source="like") for r in or_rows]
        hits.sort(key=lambda h: (-h.score, h.path, h.seq))
        return hits[:k]

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


# jieba 查询侧分词（惰性加载：词典 ~1s，不拖累进程启动）
_jieba_cut = None
_jieba_tried = False


def _segment_cjk(term: str) -> list[str]:
    """CJK 词项 jieba 切分 + 邻接词对重建 ≥3 字短语。

    无空格中文整串（『尾款划抵244』——用户最常态的粘贴行为）按
    短语走 trigram 匹配必然零命中：要求 7 字连续共现。切词后：
    原短语保留（精确命中 bm25 天然前排）+ 单词（≥3 字进 FTS OR，
    2 字进 shorts AND 过滤）+ 邻接拼接（全 2 字词时『尾款+划抵』
    →『尾款划抵』重建快路径，不落 8s LIKE 全表扫）。
    jieba 缺席 → 原词返回（嵌入器同款降级哲学，检索永不 502）。
    """
    global _jieba_cut, _jieba_tried
    if not any("一" <= ch <= "鿿" for ch in term):
        return [term]
    if not _jieba_tried:
        _jieba_tried = True
        try:
            import jieba

            jieba.setLogLevel(logging.WARNING)
            _jieba_cut = jieba.cut_for_search
        except Exception:
            _log.info("jieba 不在位，中文整串查询按短语降级")
    if _jieba_cut is None:
        return [term]
    words = [w for w in _jieba_cut(term) if len(w) >= 2]
    if len(words) <= 1:
        return [term]
    out: list[str] = []
    for w in [term, *words,
              *(a + b for a, b in zip(words, words[1:]))]:
        if w not in out:
            out.append(w)
    return out


def _like_escape(s: str) -> str:
    """LIKE 通配符转义（配合 ESCAPE '\\'）：%/_/\\ 字面量化。"""
    return s.replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")


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


def rebuild_fts_prefix(conn: sqlite3.Connection, batch: int = 50_000) -> int:
    """存量 fts 一次性重建（新表分批重建+原子换名）。

    v2（2026-09-17）：fts 行显式携带 chunks 同款 rowid——rowid 配对
    后 upsert 的整文件替换走 B 树直击，根治 `DELETE WHERE path=?`
    86 万行全表扫的入库瓶颈。前缀路径归一为正斜杠形态。重建期间
    旧表可查（换名一瞬完成切换）；meta.fts_prefix 标记幂等，二跑
    零成本。返回重建行数。
    """
    from paistation.sense.localfiles.inventory import _norm_path
    conn.execute(
        "CREATE TABLE IF NOT EXISTS meta(key TEXT PRIMARY KEY,"
        " value TEXT NOT NULL)")
    if conn.execute(
            "SELECT 1 FROM meta WHERE key='fts_prefix'"
            " AND value='v2-rowid'").fetchone():
        return 0
    conn.execute(
        "CREATE VIRTUAL TABLE IF NOT EXISTS chunks_fts_new USING fts5("
        " text, path UNINDEXED, seq UNINDEXED, tokenize='trigram')")
    conn.execute("DELETE FROM chunks_fts_new")
    total, last = 0, 0
    while True:
        rows = conn.execute(
            "SELECT rowid, path, seq, text FROM chunks"
            " WHERE rowid > ? ORDER BY rowid LIMIT ?", (last, batch)).fetchall()
        if not rows:
            break
        last = rows[-1]["rowid"] if isinstance(rows[-1], sqlite3.Row) \
            else rows[-1][0]
        with conn:
            conn.executemany(
                "INSERT INTO chunks_fts_new(rowid, text, path, seq)"
                " VALUES(?,?,?,?)",
                [(rid, f"[{_norm_path(p)}] {t}", _norm_path(p), s)
                 for rid, p, s, t in rows])
        total += len(rows)
    with conn:  # 原子换名：DROP 旧 + 换名 + 打标一事务
        conn.execute("DROP TABLE IF EXISTS chunks_fts")
        conn.execute("ALTER TABLE chunks_fts_new RENAME TO chunks_fts")
        conn.execute(
            "INSERT OR REPLACE INTO meta(key, value)"
            " VALUES('fts_prefix','v2-rowid')")
    return total
