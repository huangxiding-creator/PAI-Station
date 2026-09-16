# -*- coding: utf-8 -*-
"""浏览器下载链对齐（K 组方案：downloads.current_path 主键对齐 files.path）。"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.download_link import (
    chromium_time,
    extract_downloads,
    save_sources,
)


def _hist_db(tmp_path: Path) -> Path:
    conn = sqlite3.connect(tmp_path / "History")
    conn.execute(
        "CREATE TABLE downloads(id INTEGER, current_path TEXT, target_path TEXT,"
        " start_time INTEGER, site_url TEXT, tab_url TEXT, state INTEGER)")
    conn.execute("INSERT INTO downloads VALUES(1,"
                 " 'C:\\\\Users\\\\91216\\\\Desktop\\\\报告.docx',"
                 " 'C:\\Users\\91216\\Desktop\\报告.docx',"
                 " 13425383410745106, 'https://a.com/file', 'https://tab/x', 1)")
    conn.commit()
    conn.close()
    return tmp_path / "History"


class TestChromiumTime:
    def test_epoch_convert(self):
        # 13425383410745106 µs since 1601-01-01 = 2026-06-08（实测下载时间）
        s = chromium_time(13425383410745106)
        assert s.startswith("2026-06")

    def test_zero_and_none(self):
        assert chromium_time(0) is None
        assert chromium_time(None) is None


class TestExtract:
    def test_extract_prefers_current_path_normalized(self, tmp_path):
        db = _hist_db(tmp_path)
        rows = extract_downloads(db, "edge")
        assert len(rows) == 1
        r = rows[0]
        assert r["path"] == "C:/Users/91216/Desktop/报告.docx"
        assert r["url"] == "https://a.com/file"
        assert r["browser"] == "edge"
        assert r["downloaded_at"].startswith("2026-06")


class TestSave:
    def test_idempotent_upsert(self, tmp_path):
        inv = sqlite3.connect(tmp_path / "inv.db")
        rows = [{"path": "C:/a/x.pdf", "url": "https://b.com/x",
                 "downloaded_at": "2026-09-01 10:00", "browser": "chrome"}]
        assert save_sources(inv, rows) == 1
        assert save_sources(inv, rows) == 0  # 幂等
        n = inv.execute("SELECT COUNT(*) FROM file_sources").fetchone()[0]
        assert n == 1
        inv.close()
