# -*- coding: utf-8 -*-
"""store DDL 建库烟测——表集合与 TABLES 清单动态对齐 + 幂等重跑（临时库隔离）。

Phase 8 并行实装期表数随域增补（P1 社交经济簇/退款熔断各加表）——计数断言
从硬编码 17 改为对齐 store.TABLES 真源，加表不再翻红（漏建/错名仍会红）。
"""
from __future__ import annotations

import sqlite3
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))


def _table_names(db_path) -> list:
    conn = sqlite3.connect(db_path)
    try:
        rows = conn.execute(
            "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
        ).fetchall()
        return sorted(r[0] for r in rows)
    finally:
        conn.close()


@pytest.fixture()
def tmp_db(tmp_path, monkeypatch):
    from xueyuan_engine import config, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False
    yield store
    store._init_done = False


def test_init_creates_declared_tables(tmp_db):
    s = tmp_db
    s.init()
    assert _table_names(_db_path()) == sorted(s.TABLES)


def test_init_idempotent(tmp_db):
    """幂等重跑不炸：重置完成闸后多次 init，表集仍与 TABLES 一致（CREATE IF NOT EXISTS）。"""
    s = tmp_db
    s.init()
    s._init_done = False
    s.init()
    s._init_done = False
    s.init()
    assert _table_names(_db_path()) == sorted(s.TABLES)


def test_tables_match_declared_list(tmp_db):
    """库内表集合与 store.TABLES 清单一一对应（防漏建/错名）。"""
    s = tmp_db
    s.init()
    assert _table_names(_db_path()) == sorted(s.TABLES)
    assert len(s.TABLES) >= 17  # 基线 17 表只增不减


def _db_path():
    from xueyuan_engine import config

    return config.DB_PATH
