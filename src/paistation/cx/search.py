# -*- coding: utf-8 -*-
"""全盘 FTS 检索：data/local_index/index.db chunks_fts 的关键词检索封装。

用途：任何会话一句话查"全盘哪些文档提到 X"（58.8 万文件工作记忆层）。
只读（URI mode=ro，绝不写索引库）。
"""
from __future__ import annotations

import sqlite3
from collections import defaultdict
from pathlib import Path


def build_match_expr(query: str) -> str:
    """查询词 → FTS5 MATCH 表达式：逐词短语化（隐式 AND），引号转义防语法错。"""
    parts = ['"' + w.replace('"', '""') + '"' for w in query.split() if w]
    return " ".join(parts)


def search(index_db: str | Path, query: str, limit: int = 500) -> list[tuple[str, str]]:
    """只读检索，返回 [(path, text), ...]（≤limit 行）。"""
    expr = build_match_expr(query)
    conn = sqlite3.connect(f"file:{Path(index_db)}?mode=ro", uri=True)
    try:
        return conn.execute(
            "SELECT path, text FROM chunks_fts WHERE chunks_fts MATCH ? LIMIT ?",
            (expr, limit),
        ).fetchall()
    finally:
        conn.close()


def aggregate_by_file(rows: list[tuple[str, str]]) -> list[tuple[str, list[str]]]:
    """按文件聚合命中块，命中多的排前（并列保持原序）。"""
    by: dict[str, list[str]] = defaultdict(list)
    for path, text in rows:
        by[path].append(text or "")
    return sorted(by.items(), key=lambda kv: -len(kv[1]))


def keyword_window(text: str, words: list[str], width: int = 60) -> str:
    """取首个关键词出现处前后各半宽的窗口；无命中退化为开头截断。"""
    low = text.lower()
    for w in words:
        i = low.find(w.lower())
        if i >= 0:
            s, e = max(0, i - width // 2), min(len(text), i + len(w) + width)
            seg = text[s:e].replace("\r", " ").replace("\n", " ").strip()
            return ("…" if s else "") + seg + ("…" if e < len(text) else "")
    return "…" + text.replace("\r", " ").replace("\n", " ").strip()[:width]
