# -*- coding: utf-8 -*-
"""金标准跑分 harness 纯函数契约测试（不触真实考卷——内容敏感留本地）。"""

from __future__ import annotations

from types import SimpleNamespace

from paistation.cx.golden import classify_miss, extract_tokens, is_hit


def test_extract_tokens_prefers_long_distinctive():
    toks = extract_tokens("黄河勘测规划设计研究院（黄河设计院）总承包事业部·信息化岗")
    assert toks[0] == "黄河勘测规划设计研究院"
    assert len(toks) <= 3
    assert "信息化" not in toks  # 通用词剔除


def test_extract_tokens_generic_only_yields_empty():
    assert extract_tokens("我的主业单位与岗位是什么？") == []


def test_extract_tokens_short_fallback():
    toks = extract_tokens("真名叫黄牛")
    assert toks  # 全短词时退 2 字 token 仍可命中


def test_is_hit_and_miss_classification():
    hit = SimpleNamespace(text="……黄细丁（git 邮箱拼音双证）……")
    miss = SimpleNamespace(text="无关内容")
    assert is_hit([hit, miss], ["黄细丁"])
    assert not is_hit([miss], ["黄细丁"])
    assert classify_miss([], ["黄细丁"]) == "零结果（索引无此词汇面）"
    assert classify_miss([miss], ["黄细丁"]) == "词面不匹配（问答鸿沟：问题词≠文档词）"
    assert classify_miss([miss], []) == "答案无区分 token（考题待修）"
