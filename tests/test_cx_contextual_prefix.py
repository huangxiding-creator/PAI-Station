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


def test_upsert_rowid_paired_no_zombie_fts(tmp_path):
    """rowid 配对（09-17 根治）：重提取替换后 fts 与 chunks 行数一致，
    两表 rowid 集合相等——无僵尸命中、无全表扫删除。"""
    from paistation.sense.localfiles.store import ChunkIndex
    ci = ChunkIndex(tmp_path / "idx.db")
    ci.upsert_file("C:/Docs/a.txt", ["第一版内容甲", "第一版内容乙"], "v1")
    ci.upsert_file("C:/Docs/b.txt", ["另一文件"], "v1")
    # 重提取：文本全换
    ci.upsert_file("C:/Docs/a.txt", ["第二版内容丙"], "v2")
    n_c = ci._db.execute("SELECT COUNT(*) FROM chunks").fetchone()[0]
    n_f = ci._db.execute("SELECT COUNT(*) FROM chunks_fts").fetchone()[0]
    assert n_c == n_f == 2  # b(1) + a 新版(1)
    rids_c = {r[0] for r in ci._db.execute("SELECT rowid FROM chunks")}
    rids_f = {r[0] for r in ci._db.execute("SELECT rowid FROM chunks_fts")}
    assert rids_c == rids_f
    # 旧词不再命中（第一版已被替换干净）
    hits = ci.search("第一版内容甲", k=5)
    assert all("第一版内容甲" not in h.text for h in hits)
    assert any("第二版内容丙" in h.text for h in
               ci.search("第二版内容", k=5))
    ci.close()


def test_rebuild_v2_carries_rowid(tmp_path):
    """v2 重建：fts 显式携带 chunks rowid（老库失配一次性同步）。"""
    import sqlite3
    from paistation.sense.localfiles.store import ChunkIndex, rebuild_fts_prefix
    ci = ChunkIndex(tmp_path / "idx.db")
    ci.upsert_file("C:/Docs/a.txt", ["内容甲内容甲"], "v1")
    ci.upsert_file("C:/Docs/b.txt", ["内容乙内容乙"], "v1")
    db = ci._db
    # 模拟老库失配：打乱 fts rowid（删了重插）
    with db:
        db.execute("DELETE FROM chunks_fts")
        db.execute("INSERT INTO chunks_fts(text, path, seq) VALUES(?,?,?)",
                   ("[C:/Docs/a.txt] 内容甲内容甲", "C:/Docs/a.txt", 0))
    db.execute("DELETE FROM meta WHERE key='fts_prefix'")
    n = rebuild_fts_prefix(db)
    assert n == 2
    rids = {r[0] for r in db.execute("SELECT rowid FROM chunks_fts")}
    want = {r[0] for r in db.execute("SELECT rowid FROM chunks")}
    assert rids == want  # 同步完成
    assert rebuild_fts_prefix(db) == 0  # v2 标记幂等
    ci.close()
