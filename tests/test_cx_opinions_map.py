# -*- coding: utf-8 -*-
"""cx_opinions_map：观点池 jsonl → md（卷宗检索域格式转换，双池）。"""
from __future__ import annotations

import importlib.util
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "tools" / "cx_opinions_map.py"


def load_module():
    spec = importlib.util.spec_from_file_location("opinions_map", SCRIPT)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


ZBZS_ROWS = [
    {"verdict": "A-", "doc": "rss_x", "title": "标题一", "sent": "句子甲"},
    {"verdict": "A-", "doc": "sogou_y", "sent": "句子乙"},  # 第二批无 title
    {"verdict": "B-mix", "doc": "rss_z", "title": "标题三", "sent": "句子丙"},
]
FEISHU_ROWS = [
    {"verdict": "A", "doc": "d1", "title": "refly 访谈", "sent": "原声句"},
    {"verdict": "collected", "doc": "d2", "title": "收藏文", "sent": "他者句"},
]


def test_zbzs_layer_headers_carry_facts():
    md = load_module().build_zbzs(ZBZS_ROWS)
    assert "## A- 层（总包之声主笔，2 句）" in md
    assert "## B-mix 层（约稿/转载掺杂，1 句）" in md


def test_sentences_preserved_verbatim():
    md = load_module().build_zbzs(ZBZS_ROWS)
    for s in ("句子甲", "句子乙", "句子丙"):
        assert s in md


def test_title_fallback_to_doc():
    md = load_module().build_zbzs(ZBZS_ROWS)
    assert "【sogou_y】句子乙" in md  # 无 title 行用 doc 兜底


def test_zbzs_density_king_note():
    md = load_module().build_zbzs(ZBZS_ROWS)
    assert "密度之王" in md and "2 句 A-" in md


def test_feishu_only_curated_layers():
    md = load_module().build_feishu(FEISHU_ROWS)
    assert "## A 层·refly 访谈（1 句）" in md  # 按源分节（整层大节吸流教训）
    assert "原声句" in md
    assert "他者句" not in md  # collected 不入图


def test_feishu_verdict_counts_in_note():
    md = load_module().build_feishu(FEISHU_ROWS)
    assert "真思想资产 1 句（A 1 + A- 0" in md
