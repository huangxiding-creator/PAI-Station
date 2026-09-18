# -*- coding: utf-8 -*-
"""cx_opinions_map：jsonl → md 观点池地图（卷宗检索域格式转换）。"""
from __future__ import annotations

import importlib.util
from pathlib import Path

SCRIPT = Path(__file__).resolve().parent.parent / "tools" / "cx_opinions_map.py"


def load_module():
    spec = importlib.util.spec_from_file_location("opinions_map", SCRIPT)
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


ROWS = [
    {"verdict": "A-", "doc": "rss_x", "title": "标题一", "sent": "句子甲"},
    {"verdict": "A-", "doc": "sogou_y", "sent": "句子乙"},  # 第二批无 title
    {"verdict": "B-mix", "doc": "rss_z", "title": "标题三", "sent": "句子丙"},
]


def test_layer_headers_carry_facts():
    md = load_module().build_map(ROWS)
    assert "## A- 层（总包之声主笔，2 句）" in md
    assert "## B-mix 层（约稿/转载掺杂，1 句）" in md


def test_sentences_preserved_verbatim():
    md = load_module().build_map(ROWS)
    for s in ("句子甲", "句子乙", "句子丙"):
        assert s in md


def test_title_fallback_to_doc():
    md = load_module().build_map(ROWS)
    assert "【sogou_y】句子乙" in md  # 无 title 行用 doc 兜底


def test_density_king_note():
    md = load_module().build_map(ROWS)
    assert "密度之王" in md and "2 句 A-" in md
