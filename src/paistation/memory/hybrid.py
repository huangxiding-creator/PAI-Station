"""M2.2 混合检索（02 卷缝合）：多路由召回 → RRF 融合 → token 预算裁剪。

路由即插件：Everything（文件名秒搜）/ sqlite-vec（语义，独立 vec.db）/
FTS5（全文，M2.5 接入）——任何路由缺席即降级为"不参与融合"，绝无
硬依赖。融合用 RRF（Reciprocal Rank Fusion，k=60）：双路由共识天然
优先，且无须跨路由分数归一（各路由量纲不可比，RRF 只看名次）。
"""
from __future__ import annotations

import dataclasses
import logging
import re
import shutil
import sqlite3
import subprocess
import threading
from pathlib import Path

import numpy as np

_log = logging.getLogger("paistation.memory.hybrid")

WORD_RE = re.compile(r"[A-Za-z0-9]+")


def _is_cjk(ch: str) -> bool:
    return "\u4e00" <= ch <= "\u9fff"


def approx_tokens(text: str) -> int:
    """token 估算：中文≈1字1token；英文≈每词 ceil(len/4) token。"""
    cjk = sum(1 for ch in text if _is_cjk(ch))
    ascii_tokens = sum(max(1, (len(w) + 3) // 4) for w in WORD_RE.findall(text))
    return cjk + ascii_tokens


@dataclasses.dataclass
class Hit:
    """检索单元：路径+层级+分数+片段+来源路由。"""

    path: str
    layer: str = "L2"        # L0 名字级 / L1 摘要卡 / L2 片段级
    score: float = 0.0
    snippet: str = ""
    source: str = ""         # fts / vec / everything / ...


class RrfFuser:
    """倒数排名融合：score = Σ_routes 1/(k+rank)。"""

    def __init__(self, k: int = 60):
        self._k = k

    def fuse(self, routes: dict[str, list[Hit]]) -> list[Hit]:
        scores: dict[str, float] = {}
        first: dict[str, Hit] = {}
        sources: dict[str, set[str]] = {}
        for name, hits in routes.items():
            for rank, hit in enumerate(hits, start=1):
                scores[hit.path] = scores.get(hit.path, 0.0) + 1.0 / (self._k + rank)
                first.setdefault(hit.path, hit)
                sources.setdefault(hit.path, set()).add(name)
        order = {p: i for i, p in enumerate(scores)}  # 平分秋色按首见序
        fused = [
            dataclasses.replace(first[p], score=round(scores[p], 6),
                                source="+".join(sorted(sources[p])))
            for p in scores
        ]
        fused.sort(key=lambda h: (-h.score, order[h.path]))
        return fused


class TokenBudget:
    """按片段成本裁剪：装不下就裁，首条保底保留（宁可超不可空）。"""

    def __init__(self, budget_tokens: int = 4000):
        self.budget_tokens = budget_tokens

    def trim(self, hits: list[Hit]) -> list[Hit]:
        out: list[Hit] = []
        remaining = self.budget_tokens
        for hit in hits:
            cost = approx_tokens(hit.snippet)
            if out and cost > remaining:
                continue
            out.append(hit)
            remaining -= cost
        return out


class EverythingRoute:
    """Everything 命令行（es.exe）文件名路由——在位即用否则静默降级。"""

    _FALLBACKS = (r"C:\Program Files\Everything\es.exe",
                  r"C:\Program Files (x86)\Everything\es.exe")

    def __init__(self, es_exe: str | Path | None = None):
        cand = shutil.which("es") or shutil.which("es.exe") if es_exe is None else str(es_exe)
        if cand is None:
            for p in self._FALLBACKS:
                if Path(p).is_file():
                    cand = p
                    break
        self._es = Path(cand) if cand else None

    def available(self) -> bool:
        return self._es is not None and self._es.is_file()

    def search(self, query: str, k: int = 10) -> list[Hit]:
        if not self.available():
            return []
        try:
            proc = subprocess.run([str(self._es), "-n", str(k), query],
                                  capture_output=True, text=True, timeout=10)
        except (OSError, subprocess.SubprocessError) as exc:
            _log.warning("Everything 查询失败: %s", exc)
            return []
        hits = []
        for rank, line in enumerate(proc.stdout.splitlines(), start=1):
            line = line.strip()
            if line:
                hits.append(Hit(path=line, layer="L0", score=1.0 / rank,
                                snippet="", source="everything"))
        return hits[:k]


def _f32_blob(vec: np.ndarray) -> bytes:
    return np.asarray(vec, dtype=np.float32).tobytes()


class VecRoute:
    """sqlite-vec 语义路由：独立 vec.db，path 即主键（upsert 替换语义）。"""

    def __init__(self, db_path: str | Path, embedder):
        import sqlite_vec  # 惰性：无 sqlite_vec 时本路由不注册

        self._emb = embedder
        self._lock = threading.Lock()
        self._db_path = Path(db_path)
        self._db_path.parent.mkdir(parents=True, exist_ok=True)
        self._db = sqlite3.connect(str(self._db_path), check_same_thread=False)
        self._db.enable_load_extension(True)
        sqlite_vec.load(self._db)
        self._dim = int(embedder.dim)
        self._db.execute(
            f"CREATE VIRTUAL TABLE IF NOT EXISTS vec_docs USING vec0("
            f"embedding float[{self._dim}])")
        self._db.execute(
            "CREATE TABLE IF NOT EXISTS doc_map ("
            "doc_id INTEGER PRIMARY KEY, path TEXT NOT NULL UNIQUE)")
        self._db.commit()

    def available(self) -> bool:
        return True

    def upsert(self, docs: list[tuple[str, str]]) -> int:
        """docs: [(path, text)]——同 path 再写即整条替换（旧向量删除）。"""
        vecs = self._emb.embed([t for _, t in docs])
        with self._lock:
            cur = self._db.cursor()
            for (path, _text), vec in zip(docs, vecs):
                row = cur.execute("SELECT doc_id FROM doc_map WHERE path=?",
                                  (path,)).fetchone()
                if row:  # 替换：删旧向量，doc_id 复用
                    doc_id = row[0]
                    cur.execute("DELETE FROM vec_docs WHERE rowid=?", (doc_id,))
                else:
                    cur.execute("INSERT INTO doc_map (path) VALUES (?)", (path,))
                    doc_id = cur.lastrowid
                cur.execute("INSERT INTO vec_docs (rowid, embedding) VALUES (?, ?)",
                            (doc_id, _f32_blob(vec)))
            self._db.commit()
        return len(docs)

    def search(self, query: str, k: int = 8) -> list[Hit]:
        vec = self._emb.embed([query])[0]
        try:
            with self._lock:
                rows = self._db.execute(
                    "SELECT rowid, distance FROM vec_docs "
                    "WHERE embedding MATCH ? AND k = ? ORDER BY distance",
                    (_f32_blob(vec), int(k))).fetchall()
                if not rows:
                    return []
                marks = ",".join("?" * len(rows))
                paths = dict(self._db.execute(
                    f"SELECT doc_id, path FROM doc_map WHERE doc_id IN ({marks})",
                    [r[0] for r in rows]).fetchall())
        except sqlite3.Error as exc:
            _log.warning("vec 查询失败: %s", exc)
            return []
        hits = []
        for doc_id, dist in rows:
            path = paths.get(doc_id)
            if path is None:
                continue
            hits.append(Hit(path=path, layer="L2", score=1.0 / (1.0 + float(dist)),
                            snippet="", source="vec"))
        return hits

    def close(self) -> None:
        self._db.close()


class HybridRetriever:
    """组装件：可用路由并行召回→RRF 融合→预算裁剪。单路由故障不连坐。"""

    def __init__(self, routes: dict[str, object] | None = None,
                 fuser: RrfFuser | None = None, budget: TokenBudget | None = None):
        self._routes = routes or {}
        self._fuser = fuser or RrfFuser()
        self._budget = budget

    def retrieve(self, query: str, k: int = 8, budget_tokens: int = 4000) -> list[Hit]:
        routes: dict[str, list[Hit]] = {}
        for name, route in self._routes.items():
            if hasattr(route, "available") and not route.available():
                continue
            try:
                routes[name] = route.search(query, k=k)
            except Exception as exc:  # noqa: BLE001 - 路由故障降级不连坐
                _log.warning("路由 %s 检索失败（跳过）: %s", name, exc)
        fused = self._fuser.fuse(routes)
        budget = self._budget or TokenBudget(budget_tokens)
        return budget.trim(fused[:k])
