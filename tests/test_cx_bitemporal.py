# -*- coding: utf-8 -*-
"""entity_links bi-temporal 升级（J 组 graphiti 四列协议，存量零迁移）。"""

from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / "src"))

from paistation.cx.entities import EntityStore


class TestBiTemporal:
    def test_old_db_upgraded_in_place(self, tmp_path):
        # 老库（无时间列）打开即自动补列，存量边语义不变
        db = tmp_path / "old.db"
        conn = sqlite3.connect(str(db))
        conn.execute(
            "CREATE TABLE entity_links (from_id TEXT, to_id TEXT,"
            " relation TEXT, source TEXT, first_seen TEXT, last_seen TEXT,"
            " created_at TEXT, PRIMARY KEY (from_id,to_id,relation,source))")
        conn.execute("INSERT INTO entity_links VALUES('a','b','friend_of','x',"
                     "NULL,NULL,'2026-01-01')")
        conn.commit()
        conn.close()
        store = EntityStore(db)
        cols = [r[1] for r in store._conn.execute(
            "PRAGMA table_info(entity_links)")]
        assert {"valid_at", "invalid_at", "expired_at"} <= set(cols)
        store.register_link("a", "b", "friend_of", "x")  # 老边幂等
        n = store._conn.execute(
            "SELECT COUNT(*) FROM entity_links").fetchone()[0]
        assert n == 1
        store.close()

    def test_expire_then_active_filter(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        store.register("person", "甲", source="t")
        store.register("org", "某群", source="t")
        store.register_link("person/甲", "org/某群", "member_of", "wechat")
        active = store.active_links("person/甲")
        assert len(active) == 1
        # 退群：旧边双写失效（invalid_at=新边 valid_at），不删
        n = store.expire_link("person/甲", "org/某群", "member_of",
                              at="2026-09-01T00:00:00")
        assert n == 1
        assert store.active_links("person/甲") == []
        rows = store._conn.execute(
            "SELECT invalid_at, expired_at FROM entity_links "
            "WHERE relation='member_of'").fetchall()
        assert rows[0][0] == "2026-09-01T00:00:00" and rows[0][1]
        # 再入群：同边复活（invalid_at 清空，expired_at 留上次失效痕）
        store.register_link("person/甲", "org/某群", "member_of",
                            "wechat", seen_at="2026-09-05")
        assert len(store.active_links("person/甲")) == 1
        row = store._conn.execute(
            "SELECT invalid_at, expired_at, valid_at FROM entity_links "
            "WHERE relation='member_of'").fetchone()
        assert row[0] is None and row[1]  # invalid_at 清空；expired_at 留痕
        store.close()

    def test_expire_no_match_zero(self, tmp_path):
        store = EntityStore(tmp_path / "e.db")
        assert store.expire_link("x", "y", "friend_of") == 0
        store.close()
