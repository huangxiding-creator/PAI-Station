# -*- coding: utf-8 -*-
"""提取队列消费 priority + Calibre 式毒文件退避（V3 缝合件落地）。

- pending() 按 priority 高者先出（打分器 2b20646 的消费端）
- 失败计数封顶出队 + attempts² 小时冷却退避（毒文件不拖死整轮）
- 崩溃恢复零额外位：status 即断点，killed 进程留下的 pending 下轮原样重取
"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.sense.localfiles.inventory import Inventory


def _rec(path, size=10, mtime=1000.0, secret=0):
    return {"path": path, "size": size, "mtime": mtime, "secret": secret}


class TestPriorityQueue:
    def test_pending_orders_by_priority_desc(self, tmp_path):
        inv = Inventory(tmp_path / "inv.db")
        inv.apply_scan([_rec("low.txt"), _rec("high.txt"), _rec("mid.txt")])
        inv._db.execute("UPDATE files SET priority=40 WHERE path='high.txt'")
        inv._db.execute("UPDATE files SET priority=10 WHERE path='mid.txt'")
        inv._db.execute("UPDATE files SET priority=-30 WHERE path='low.txt'")
        inv._db.commit()
        assert [r["path"] for r in inv.pending()] == [
            "high.txt", "mid.txt", "low.txt"]
        inv.close()

    def test_null_priority_counts_as_zero(self, tmp_path):
        # 生产库 ALTER 加列（可空）：未打分行 priority=NULL，
        # 排序当 0 处理，不炸也不垫底于负分
        db = tmp_path / "prod-like.db"
        conn = sqlite3.connect(str(db))
        conn.execute(
            "CREATE TABLE files (path TEXT PRIMARY KEY, kind TEXT"
            " NOT NULL DEFAULT '', secret INTEGER"
            " NOT NULL DEFAULT 0, status TEXT NOT NULL DEFAULT 'pending',"
            " last_seen REAL NOT NULL DEFAULT 0)")
        conn.execute("ALTER TABLE files ADD COLUMN priority REAL")  # cx_prioritize 形态
        conn.execute("INSERT INTO files(path,secret,status,last_seen)"
                     " VALUES('n.txt',0,'pending',1)")
        conn.execute("INSERT INTO files(path,secret,status,last_seen,priority)"
                     " VALUES('neg.txt',0,'pending',1,-5)")
        conn.commit()
        conn.close()
        inv = Inventory(db)
        assert [r["path"] for r in inv.pending()] == ["n.txt", "neg.txt"]
        inv.close()

    def test_old_db_queue_cols_added_in_place(self, tmp_path):
        # 老库（priority/attempts 四列全缺）打开即补列，存量 pending 照常出队
        db = tmp_path / "old.db"
        conn = sqlite3.connect(str(db))
        conn.execute(
            "CREATE TABLE files (path TEXT PRIMARY KEY, size INTEGER,"
            " mtime REAL, kind TEXT, hash_full TEXT, hash_partial TEXT,"
            " secret INTEGER, seen_gen INTEGER, first_seen REAL,"
            " last_seen REAL, extracted_at REAL, parser_id TEXT,"
            " parser_ver TEXT, status TEXT)")
        conn.execute(
            "INSERT INTO files(path,status,secret,last_seen)"
            " VALUES('a.txt','pending',0,1)")
        conn.commit()
        conn.close()
        inv = Inventory(db)
        cols = {r[1] for r in inv._db.execute("PRAGMA table_info(files)")}
        assert {"priority", "priority_reason",
                "attempts", "last_attempt"} <= cols
        assert [r["path"] for r in inv.pending()] == ["a.txt"]
        inv.close()


class TestPoisonBackoff:
    def test_fail_counts_and_cools_down(self, tmp_path):
        inv = Inventory(tmp_path / "inv.db")
        inv.apply_scan([_rec("poison.pdf")])
        inv.mark_extracted("poison.pdf", "pymupdf", "?", "", "pdf",
                           status="failed", now=1000.0)
        row = inv._db.execute(
            "SELECT attempts, last_attempt FROM files"
            " WHERE path='poison.pdf'").fetchone()
        assert row["attempts"] == 1 and row["last_attempt"] == 1000.0
        # 冷却期内（1h）不回队
        assert [r["path"] for r in inv.pending(now=1060.0)] == []
        # 冷却期满回队重试
        assert [r["path"] for r in inv.pending(now=4601.0)] == ["poison.pdf"]
        inv.close()

    def test_poison_capped_after_three_fails(self, tmp_path):
        inv = Inventory(tmp_path / "inv.db")
        inv.apply_scan([_rec("poison.pdf")])
        for _ in range(3):
            inv.mark_extracted("poison.pdf", "pymupdf", "?", "", "pdf",
                               status="failed", now=1000.0)
        assert inv.pending(now=1e9) == []  # 封顶出队，永不重试
        inv.close()

    def test_ok_resets_attempts(self, tmp_path):
        inv = Inventory(tmp_path / "inv.db")
        inv.apply_scan([_rec("a.pdf")])
        inv.mark_extracted("a.pdf", "pymupdf", "?", "", "pdf",
                           status="failed", now=1000.0)
        inv.mark_extracted("a.pdf", "pymupdf", "v1", "h", "pdf", now=1001.0)
        row = inv._db.execute(
            "SELECT attempts, status FROM files WHERE path='a.pdf'").fetchone()
        assert row["attempts"] == 0 and row["status"] == "ok"
        inv.close()
