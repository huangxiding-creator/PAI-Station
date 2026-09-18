# -*- coding: utf-8 -*-
"""cx_semantic：卷宗语义路由纯函数（RRF 融合/归一化/缓存键）。"""
from __future__ import annotations

import numpy as np

from paistation.cx.semantic import (
    SemanticIndex,
    hybrid_route,
    normalize_rows,
    rrf_fuse,
    text_key,
)


class _Sec:
    def __init__(self, name):
        self.text = name


def test_text_key_stable():
    assert text_key("同一文本") == text_key("同一文本")
    assert text_key("甲") != text_key("乙")
    assert len(text_key("x")) == 16


def test_normalize_rows_zero_safe():
    m = np.array([[3.0, 4.0], [0.0, 0.0]], dtype=np.float32)
    out = normalize_rows(m)
    assert np.allclose(out[0], [0.6, 0.8])
    assert np.isfinite(out).all()  # 零向量不产生 NaN


def test_rrf_consensus_wins():
    """双路第一=共识冠军，单一通道第一居后。"""
    a = [_Sec(f"a{i}") for i in range(5)]   # a0 第一
    b = [_Sec(f"a{i}") for i in range(5)][::-1]  # a0 第一（同对象）
    fused = rrf_fuse(a, b, k=3)
    assert fused[0] is a[0]  # 双路共识
    assert len(fused) == 3


def test_rrf_union_covers_both():
    a = [_Sec("x1"), _Sec("x2")]
    b = [_Sec("y1"), _Sec("y2")]
    fused = rrf_fuse(a, b, k=4)
    assert len(fused) == 4  # 两路不相交=并集


def test_semantic_route_cosine_rank(tmp_path):
    """构造已知向量：查询应贴最近节。"""
    secs = [_Sec("甲"), _Sec("乙"), _Sec("丙")]
    matrix = np.array([[1.0, 0.0], [0.0, 1.0], [0.7, 0.7]], dtype=np.float32)
    idx = SemanticIndex(secs, ["k1", "k2", "k3"], matrix)
    calls = []

    def embed(text):
        calls.append(text)
        return [1.0, 0.05]  # 贴"甲"

    top = idx.route("问题", embed, k=2)
    assert top[0].text == "甲"
    assert len(top) == 2
    assert calls == ["问题"]


class _KwIdx:
    """keyword 路由桩：按注入顺序返回。"""

    def __init__(self, order):
        self.order = order

    def route(self, query, k=8):
        return self.order[:k]


def test_hybrid_degrades_to_keyword_when_no_embedder():
    order = [_Sec("a"), _Sec("b")]
    out = hybrid_route(_KwIdx(order), None, None, "q", k=8)
    assert out == order[:8]


def test_hybrid_embedder_failure_falls_back():
    order = [_Sec("a"), _Sec("b")]

    def boom(q):
        raise RuntimeError("嵌入服务抖动")

    sem = SemanticIndex(order, ["k1", "k2"],
                        np.array([[1.0, 0.0], [0.0, 1.0]], dtype=np.float32))
    out = hybrid_route(_KwIdx(order), sem, boom, "q", k=8)
    assert out == order[:8]  # 抖动不挡检索


def test_hybrid_fuses_both_channels():
    a, b = _Sec("kw冠军"), _Sec("sem冠军")
    kw = _KwIdx([a])
    sem = SemanticIndex([b], ["k1"], np.array([[1.0]], dtype=np.float32))
    out = hybrid_route(kw, sem, lambda t: [1.0], "q", k=2)
    assert {s.text for s in out} == {"kw冠军", "sem冠军"}  # 两路各有席位
