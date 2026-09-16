# -*- coding: utf-8 -*-
"""Contextual 元前缀（V2 零成本档）：路径拼进 FTS 文本。

- chunks 明表 text 保持原文（重嵌/去重/PII 扫描不受污染）
- chunks_fts.text = "[路径] 原文"——trigram 使路径词可检索，
  正文不含该词的块也能按路径词召回（文件级召回白拿）
"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.sense.localfiles.store import ChunkIndex, rebuild_fts_prefix

LOGIC = "cv1"


def test_fts_path_terms_recall_textless_chunk(tmp_path):
    idx = ChunkIndex(tmp_path / "index.db")
    idx.upsert_file("E:/AI-Station/07 任务/白龟湖法律诉讼/证据.md",
                    ["此处完全不提项目名"], LOGIC)
    rows = idx._db.execute(
        "SELECT text FROM chunks_fts WHERE chunks_fts MATCH ?",
        ('"白龟湖"',)).fetchall()
    assert rows and rows[0]["text"].startswith(
        "[E:/AI-Station/07 任务/白龟湖法律诉讼/证据.md]")
    idx.close()


def test_chunks_table_text_stays_raw(tmp_path):
    idx = ChunkIndex(tmp_path / "index.db")
    idx.upsert_file("E:/docs/a.md", ["原始正文"], LOGIC)
    row = idx._db.execute("SELECT text FROM chunks LIMIT 1").fetchone()
    assert row["text"] == "原始正文"  # 明表不掺路径
    idx.close()


def test_rebuild_legacy_fts_idempotent(tmp_path):
    # 老库：存量块 fts 无前缀——新表重建+原子换名，meta 标记幂等；
    # 反斜杠旧路径的前缀须归一（trigram 分隔符形态统一）
    db = tmp_path / "index.db"
    idx = ChunkIndex(db)
    conn = idx._db
    conn.execute(
        "INSERT INTO chunks(chunk_id, path, seq, text, logic_ver,"
        " file_gen, updated_at) VALUES('c1','E:/old/x.md',1,"
        " '存量正文', 'v0', 0, 0)")
    legacy = "E:" + chr(92) + "old" + chr(92) + "y.md"
    conn.execute(
        "INSERT INTO chunks(chunk_id, path, seq, text, logic_ver,"
        " file_gen, updated_at) VALUES('c2',?,1,"
        " '老路径正文', 'v0', 0, 0)", (legacy,))
    conn.commit()
    assert rebuild_fts_prefix(conn) == 2
    got = conn.execute(
        "SELECT text, path FROM chunks_fts WHERE seq=1 AND path='E:/old/y.md'"
    ).fetchone()
    assert got["text"] == "[E:/old/y.md] 老路径正文"  # 前缀归一
    assert rebuild_fts_prefix(conn) == 0  # 已标记，幂等跳过
    idx.close()
