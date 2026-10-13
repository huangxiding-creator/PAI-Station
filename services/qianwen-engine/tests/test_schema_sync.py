# -*- coding: utf-8 -*-
"""test_schema_sync.py — REQ-007.AC1 四点列同步静态锚（pytest 引擎线源结构断言）。

deleted 列必须四点同步（缺一=新库/老库/部署镜像三者漂移）：
  ① store.py sqlite CREATE TABLE answers
  ② store.py mysql   CREATE TABLE answers
  ③ store.py _ANSWER_UPGRADES（老库逐列 ALTER 平滑）
  ④ scripts/mysql_schema.sql（部署手册镜像，TCB_DEPLOY 既定纪律）
"""
from pathlib import Path

ENGINE = Path(__file__).resolve().parents[1]
STORE = (ENGINE / "qianwen_engine" / "store.py").read_text(encoding="utf-8")
MYSQL_SQL = (ENGINE / "scripts" / "mysql_schema.sql").read_text(encoding="utf-8")


def test_req_007_ac1_deleted_column_four_point_sync():
    """四点同步：sqlite CREATE / mysql CREATE / _ANSWER_UPGRADES / mysql_schema.sql。"""
    # ① sqlite 方言 CREATE（answers 块内）
    sqlite_block = STORE.split("CREATE TABLE IF NOT EXISTS answers")[1].split('")""')[0]
    assert "deleted INTEGER DEFAULT 0" in sqlite_block
    # ② mysql 方言 CREATE（第二个 answers 块）
    mysql_block = STORE.split("CREATE TABLE IF NOT EXISTS answers")[2].split('")""')[0]
    assert "deleted INT DEFAULT 0" in mysql_block
    # ③ _ANSWER_UPGRADES 迁移对（sqlite 原文 + mysql 变体同元组）
    upgrades = STORE.split("_ANSWER_UPGRADES")[1].split("_USER_UPGRADES")[0]
    assert '("deleted INTEGER DEFAULT 0", "deleted INT DEFAULT 0")' in upgrades
    # ④ 部署镜像 mysql_schema.sql
    assert "deleted INT DEFAULT 0" in MYSQL_SQL
