# -*- coding: utf-8 -*-
"""卷宗语义路由——keyword 通道收口后的下一段（金标准 79 往上打）。

不等全局 4.5M 块嵌入回填：卷宗域只有 ~450 节，本地 Ollama bge-m3
全量嵌入 <1 分钟。语义路由天然容忍措辞变体（keyword 通道剩余 6 个
语料缺口全是「答案在库里、问法用词不同」类）。向量缓存 data/cx/
dossier_vecs.npz（sha1(text) 键——卷宗节变了只重嵌变化节）。

服务不在位时 make_ollama_embedder 返回 None → 上层 keyword-only 降级，
检索永不因此挂。
"""
from __future__ import annotations

import hashlib
import time
from pathlib import Path

import numpy as np

VEC_CACHE = Path("data/cx/dossier_vecs.npz")


def _embed_retry(embedder, text: str, tries: int = 3) -> list:
    """嵌入带重试（Ollama 偶发 500，实测重试即过）。"""
    for t in range(tries):
        try:
            return embedder(text)
        except Exception:
            if t == tries - 1:
                raise
            time.sleep(2.0)


def text_key(text: str) -> str:
    """节文本 → 缓存键（sha1 前 16 位）。"""
    return hashlib.sha1(text.encode("utf-8")).hexdigest()[:16]


def normalize_rows(m: np.ndarray) -> np.ndarray:
    """行归一（零向量防 NaN）。"""
    n = np.linalg.norm(m, axis=1, keepdims=True)
    return m / np.maximum(n, 1e-12)


def rrf_fuse(ranked_a: list, ranked_b: list, k: int = 8,
             kconst: int = 60) -> list:
    """倒数排名融合（RRF）：两路 ranked 列表 → 融合 top-k。

    纯函数；同对象在两路出现=双路共识加分（id 身份合并）。
    """
    score: dict[int, float] = {}
    by_id: dict[int, object] = {}
    for ranked in (ranked_a, ranked_b):
        for i, item in enumerate(ranked):
            key = id(item)
            by_id[key] = item
            score[key] = score.get(key, 0.0) + 1.0 / (kconst + i + 1)
    order = sorted(score, key=lambda key: -score[key])
    return [by_id[key] for key in order[:k]]


class SemanticIndex:
    """节向量索引：build 时嵌入+缓存，route 时查询向量点积 top-k。"""

    def __init__(self, sections: list, keys: list[str], matrix: np.ndarray):
        self.sections = sections
        self.keys = keys
        self.matrix = normalize_rows(matrix)

    @classmethod
    def build(cls, sections: list, embedder, cache: Path = None,
              save_every: int = 80) -> "SemanticIndex":
        cache = cache or VEC_CACHE
        cached: dict[str, np.ndarray] = {}
        if cache.exists():
            data = np.load(cache, allow_pickle=False)
            cached = {str(k): data[k] for k in data.files}
        keys, rows, n_new = [], [], 0

        def _save_progress() -> None:
            cache.parent.mkdir(parents=True, exist_ok=True)
            np.savez_compressed(
                cache, **{k: rows[i] for i, k in enumerate(keys)})

        for s in sections:
            key = text_key(s.text)
            keys.append(key)
            if key in cached:
                rows.append(cached[key])
            else:
                # 截 2400：Ollama 默认 num_ctx 下 3.5k+ 中文字节稳 500
                rows.append(_embed_retry(embedder, s.text[:2400]))
                n_new += 1
                if n_new % save_every == 0:
                    _save_progress()  # 分段落盘：中途 500 不丢已嵌节
        if n_new or not cache.exists():
            _save_progress()
        matrix = np.array(rows, dtype=np.float32)
        return cls(sections, keys, matrix)

    def route(self, query: str, embedder, k: int = 8) -> list:
        """查询 → 余弦 top-k 节（沿用 Section.score 字段放相似度）。"""
        q = normalize_rows(np.array([embedder(query)], dtype=np.float32))[0]
        sims = self.matrix @ q
        order = np.argsort(-sims)[:k]
        out = []
        for i in order:
            if not np.isfinite(sims[i]) or sims[i] <= 0:
                continue
            sec = self.sections[int(i)]
            sec.score = float(sims[i])
            out.append(sec)
        return out


def hybrid_route(idx, sem, embedder, query: str, k: int = 8,
                 depth: int = 40) -> list:
    """生产检索入口：keyword 深池 + 语义深池 → RRF 融合 top-k。

    深池融合实测（2026-09-18 金标准 100 题）：kw 79 / sem 76 /
    RRF(depth40) 86=双通道并集上限——浅池融合（8+8）反而 76（语义
    噪声挤掉 keyword 冠军）。嵌入不在位 → 自动降级纯 keyword。
    """
    kw_pool = idx.route(query, k=depth)
    if sem is None or embedder is None:
        return kw_pool[:k]
    try:
        sem_pool = sem.route(query, embedder, k=depth)
    except Exception:
        return kw_pool[:k]  # 嵌入服务抖动不挡检索
    return rrf_fuse(kw_pool, sem_pool, k=k)
