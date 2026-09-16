# -*- coding: utf-8 -*-
"""全盘 FTS 检索：data/local_index/index.db chunks_fts 的关键词检索封装。

用途：任何会话一句话查"全盘哪些文档提到 X"（58.8 万文件工作记忆层）。
只读（URI mode=ro，绝不写索引库）。

分词现实（2026-09-16 实证）：索引 tokenize='trigram'——任意 ≥3 字符子串可
索引级命中；但 <3 字词（"总包"/"AI"）FTS 零命中，须 LIKE 兜底（0.1s 级）。
"""
from __future__ import annotations

import sqlite3
from collections import defaultdict
from pathlib import Path
from typing import NamedTuple

_TRIGRAM_MIN = 3  # trigram 索引可命中的最短查询


def build_match_expr(query: str) -> str:
    """查询词 → FTS5 MATCH 表达式：逐词短语化（隐式 AND），引号转义防语法错。"""
    parts = ['"' + w.replace('"', '""') + '"' for w in query.split() if w]
    return " ".join(parts)


def like_pattern(term: str) -> str:
    """词 → LIKE 模式（%/_ 转义，反斜杠作 ESCAPE 字符）。"""
    escaped = term.replace("\\", "\\\\").replace("%", "\\%").replace("_", "\\_")
    return f"%{escaped}%"


class QueryPlan(NamedTuple):
    mode: str            # fts | like | mixed
    fts_words: list[str]   # ≥3 字符，走 trigram FTS
    like_terms: list[str]  # <3 字符，走 LIKE 兜底


def resolve_query(query: str) -> QueryPlan:
    """按词长分流：trigram 最小 3 字符，短词必须 LIKE 否则静默零命中。"""
    words = [w for w in query.split() if w]
    fts_words = [w for w in words if len(w) >= _TRIGRAM_MIN]
    like_terms = [w for w in words if len(w) < _TRIGRAM_MIN]
    mode = ("like" if not fts_words
            else "mixed" if like_terms else "fts")
    return QueryPlan(mode, fts_words, like_terms)


def search_like(index_db: str | Path, terms: list[str],
                limit: int = 500) -> list[tuple[str, str]]:
    """LIKE 兜底检索（AND 全部词），走 chunks 明表。"""
    if not terms:
        return []
    conn = sqlite3.connect(f"file:{Path(index_db)}?mode=ro", uri=True)
    try:
        where = " AND ".join(
            f"text LIKE ? ESCAPE '\\'" for _ in terms)
        return conn.execute(
            f"SELECT path, text FROM chunks WHERE {where} LIMIT ?",
            [like_pattern(t) for t in terms] + [limit],
        ).fetchall()
    finally:
        conn.close()


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


def run_query(index_db: str | Path, query: str,
              limit: int = 500) -> tuple[list[tuple[str, str]], str]:
    """统一入口：按 QueryPlan 分流。返回 (rows, mode)。

    mixed 语义：长词 FTS 命中块集合内，短词同块 AND 过滤——AND 语义无损。
    """
    plan = resolve_query(query)
    if plan.mode == "like":
        return search_like(index_db, plan.like_terms, limit), plan.mode
    rows = search(index_db, " ".join(plan.fts_words), limit)
    if plan.mode == "mixed":
        rows = [(p, t) for p, t in rows
                if all(w in t for w in plan.like_terms)]
    return rows, plan.mode


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
