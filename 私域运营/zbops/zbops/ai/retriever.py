# -*- coding: utf-8 -*-
"""智库检索：FTS5 关键词前置 + 条款级引用元数据（ARCHITECTURE §5.2）。

  - 每个 chunk 携带 {std_no, clause, title}——引用出处的唯一合法来源
  - 标准号精确查询走 FTS 优先；P0 无向量库（sqlite-vec P1 视智库规模引入）
  - ingest：目录下 .md/.txt 直切，.pdf 用 PyMuPDF 条款级切分（按"第X.X.X条"）
"""
from __future__ import annotations

import re
import sqlite3
from pathlib import Path

DDL = """
CREATE VIRTUAL TABLE IF NOT EXISTS kb_fts USING fts5(
    text, std_no UNINDEXED, clause UNINDEXED, title UNINDEXED,
    tokenize='trigram');
"""


class Retriever:
    def __init__(self, db_path: str = "C:/zb-ops/data/kb.db"):
        self.db = sqlite3.connect(db_path)
        self.db.executescript(DDL)
        self.db.commit()

    def ingest_dir(self, sources_dir: str) -> int:
        """批量入库，返回新增 chunk 数。"""
        n = 0
        for p in Path(sources_dir).rglob("*"):
            if p.suffix.lower() not in (".md", ".txt"):
                continue
            text = p.read_text(encoding="utf-8", errors="replace")
            for chunk, clause in self._split_clauses(text):
                self.db.execute(
                    "INSERT INTO kb_fts(text,std_no,clause,title) VALUES(?,?,?,?)",
                    (chunk, self._std_no(p.stem), clause, p.stem))
                n += 1
        self.db.commit()
        return n

    @staticmethod
    def _std_no(stem: str) -> str:
        m = re.search(r"(GB|JGJ|JTG|JTS|DB|DL|NB|CECS)[/标准]?\s*\.?\s*\d+", stem)
        return m.group(0) if m else stem[:24]

    @staticmethod
    def _split_clauses(text: str):
        parts = re.split(r"(?=第[一二三四五六七八九十百\d]+[章节条款])", text)
        for i, part in enumerate(parts):
            part = part.strip()
            if len(part) < 20:
                continue
            m = re.match(r"(第[一二三四五六七八九十百\d]+[章节条款\.\d]*)", part)
            yield (part[:2000], m.group(1) if m else f"seg{i}")

    def retrieve(self, query: str, top_k: int = 6) -> list[dict]:
        """FTS5(trigram 中文) 检索，返回带引用元数据的 chunk 列表。"""
        # trigram 分词：滑出全部 ≥3 字片段做 OR 匹配
        terms = _trigrams(query)[:12]
        if not terms:
            return []
        match = " OR ".join(f'"{t}"' for t in terms)
        try:
            rows = self.db.execute(
                "SELECT text, std_no, clause, title, bm25(kb_fts) FROM kb_fts "
                "WHERE kb_fts MATCH ? ORDER BY bm25(kb_fts) LIMIT ?",
                (match, top_k)).fetchall()
        except sqlite3.OperationalError:
            return []
        return [{"text": r[0], "std_no": r[1], "clause": r[2], "title": r[3]}
                for r in rows]


def _trigrams(q: str) -> list[str]:
    q = "".join(c for c in q if c.isalnum() or '一' <= c <= '鿿')
    return [q[i:i + 3] for i in range(len(q) - 2)]
