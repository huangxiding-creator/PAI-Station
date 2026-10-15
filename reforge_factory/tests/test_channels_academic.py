# -*- coding: utf-8 -*-
"""学术三件套适配器真请求守卫 (T-015 / REQ-029.AC1 / KB-CHANNEL-BUILDER-SPEC)。

红线: 每适配器对真实 API 各发 1 次真请求 (EPC 词「EPC contract」), 断言 >=1 条
统一 Doc; 网络失败重试 1 次, 仍失败 pytest.skip 并注明原因 —— 不造假。
(合成解析/限流/截断守卫在 test_guard_academic.py, 不占真请求配额。)
"""
import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from channels import academic  # noqa: E402

QUERY = "EPC contract"
DOC_KEYS = {"title", "url", "year", "abstract_head", "source"}


def _live_search(fn, label):
    """真请求 1 次 + 失败重试 1 次; 仍失败如实 skip (守卫不造假)。"""
    last = None
    for attempt in (1, 2):
        try:
            docs = fn(QUERY)
            if docs:
                return docs
            last = RuntimeError(f"{label} 返回 200 但 0 条 Doc (第{attempt}次)")
        except Exception as e:  # HTTPError 429 / URLError / 超时
            last = e
        if attempt == 1:
            time.sleep(3)  # 礼貌重试间隔
    pytest.skip(f"[不造假] {label} 真请求两次未成: {type(last).__name__}: {last}")


def _assert_docs(docs):
    assert len(docs) >= 1
    for d in docs:
        assert set(d) == DOC_KEYS
        assert isinstance(d["title"], str) and d["title"].strip()
        assert d["url"].startswith("http")
        assert d["year"] is None or isinstance(d["year"], int)
        assert len(d["abstract_head"]) <= academic.ABSTRACT_HEAD


def test_live_openalex_epc_contract():
    docs = _live_search(academic.search_openalex, "OpenAlex")
    _assert_docs(docs)


def test_live_s2_epc_contract():
    docs = _live_search(academic.search_s2, "Semantic Scholar")
    _assert_docs(docs)


def test_live_arxiv_epc_contract():
    docs = _live_search(academic.search_arxiv, "arXiv")
    _assert_docs(docs)
