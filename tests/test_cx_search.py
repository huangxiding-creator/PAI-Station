# -*- coding: utf-8 -*-
"""cx_search：全盘 FTS 检索工具（58.8 万文件工作记忆层入口）。"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.search import (
    aggregate_by_file,
    build_match_expr,
    keyword_window,
    search,
)


def _db(tmp_path: Path) -> sqlite3.Connection:
    conn = sqlite3.connect(tmp_path / "i.db")
    conn.execute("CREATE VIRTUAL TABLE chunks_fts USING fts5(path, text)")
    conn.executemany(
        "INSERT INTO chunks_fts VALUES (?,?)",
        [("E:/a/白龟湖方案.md", "白龟湖 EPC 总包合同谈判"),
         ("E:/a/白龟湖方案.md", "白龟湖 大浪河 子项目"),
         ("E:/a/黄藏寺.md", "黄藏寺 变电站运维"),
         ("E:/a/日志.txt", "日常 白龟湖 提及一次")])
    conn.commit()
    return conn


class TestBuildMatchExpr:
    def test_plain_word(self):
        assert build_match_expr("白龟湖") == '"白龟湖"'

    def test_multi_words_quoted_each(self):
        # 多词各自动短语化（FTS5 AND 语义），防语法注入
        assert build_match_expr("白龟湖 大浪河") == '"白龟湖" "大浪河"'

    def test_quotes_escaped(self):
        assert build_match_expr('a"b') == '"a""b"'


class TestKeywordWindow:
    def test_window_around_first_hit(self):
        t = "前言" + "字" * 80 + "白龟湖项目收尾结算" + "字" * 80
        seg = keyword_window(t, ["白龟湖"])
        assert "白龟湖项目收尾结算" in seg
        assert seg.startswith("…") and seg.endswith("…")

    def test_no_hit_falls_back_to_head(self):
        assert keyword_window("任意长文本开头", ["白龟湖"]).startswith("…任意长文本开头")


class TestSearchAndAggregate:
    def test_search_and_group(self, tmp_path):
        conn = _db(tmp_path)
        rows = conn.execute(
            "SELECT path, text FROM chunks_fts WHERE chunks_fts MATCH ?",
            (build_match_expr("白龟湖"),)).fetchall()
        agg = aggregate_by_file(rows)
        assert agg[0][0].endswith("白龟湖方案.md")   # 命中最多排第一
        assert len(agg[0][1]) == 2
        assert len(agg) == 2

    def test_search_readonly(self, tmp_path):
        conn = _db(tmp_path)
        conn.close()
        rows = search(tmp_path / "i.db", "白龟湖")
        assert len(rows) == 3
        assert all("白龟湖" in t for _, t in rows)

    def test_search_multi_word_and(self, tmp_path):
        conn = _db(tmp_path)
        conn.close()
        rows = search(tmp_path / "i.db", "白龟湖 大浪河")
        assert rows == [("E:/a/白龟湖方案.md", "白龟湖 大浪河 子项目")]
