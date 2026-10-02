# -*- coding: utf-8 -*-
"""store 单测——临时库隔离（v0.5.0：6 次/天 + 互动赠次 + 锅圈 + 优化计数）。"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))


@pytest.fixture()
def tmp_db(tmp_path, monkeypatch):
    from qianwen_engine import config, store
    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False
    yield store
    store._init_done = False


def test_quota_flow(tmp_db):
    s = tmp_db
    q = s.quota_left("u1")
    assert q["total_left"] == 6 and q["free_left"] == 6 and q["bonus_left"] == 0
    for _ in range(6):
        assert s.consume_one("u1") is True
    assert s.consume_one("u1") is False   # 无互动=无赠次
    assert s.quota_left("u1")["total_left"] == 0


def test_reward_flow_per_answer_per_action(tmp_db):
    s = tmp_db
    assert s.grant_reward("u1", "a1", "like") is True      # 首次：+1
    assert s.grant_reward("u1", "a1", "like") is False     # 同答案同动作：只有一次
    assert s.grant_reward("u1", "a2", "like") is True      # 不同答案：再 +1（不封顶）
    assert s.grant_reward("u1", "a1", "share") is True     # 同答案不同动作：再 +1
    assert s.grant_reward("u1", "a1", "criticize") is True
    assert s.quota_left("u1")["bonus_left"] == 4
    # v0.7.3（用户令）：导出退出赠次动作表
    with pytest.raises(ValueError):
        s.grant_reward("u1", "a1", "export")
    with pytest.raises(ValueError):
        s.grant_reward("u1", "a1", "hack")                 # 未知动作拒绝


def test_reward_bonus_consumable(tmp_db):
    s = tmp_db
    for _ in range(6):
        assert s.consume_one("u1") is True
    assert s.consume_one("u1") is False
    assert s.grant_reward("u1", "a1", "share") is True
    assert s.consume_one("u1") is True                     # 赠次可用
    assert s.consume_one("u1") is False


def test_answer_lifecycle(tmp_db):
    s = tmp_db
    aid = s.save_answer("u1", "问", "答" * 300, [{"source": "书", "loc": "1", "n": 1}])
    row = s.get_answer(aid, "u1")
    assert row["question"] == "问" and len(row["answer_full"]) == 300
    assert s.get_answer(aid, "u2") is None          # 越权隔离
    assert s.mark_liked(aid, "u1") is True
    assert s.mark_liked(aid, "u1") is False          # 重复点赞拒绝
    assert s.save_criticism(aid, "u1", "太笼统") is True
    assert s.save_criticism(aid, "u1", "再批") is False   # 每答案一次
    assert s.mark_unlocked(aid, "u1") is True


def test_history(tmp_db):
    s = tmp_db
    s.save_answer("u1", "问题一", "答", [])
    s.save_answer("u1", "问题二", "答", [])
    items = s.history("u1")
    assert len(items) == 2 and items[0]["question"] == "问题二"
    # history_all：只收 ready，时间正序
    s.save_answer("u1", "问题三", "答", [])
    all_rows = s.history_all("u1")
    assert [r["question"] for r in all_rows] == ["问题一", "问题二", "问题三"]


def test_pot_public_visibility(tmp_db):
    s = tmp_db
    aid = s.save_pot_answer("锅圈问题一", "答案" * 200, [{"source": "书", "loc": "1", "n": 1}], sort=1)
    # 公共可见：任何登录用户都能读全文
    assert s.get_answer_visible(aid, "someone-else") is not None
    assert s.get_answer_visible(aid, "someone-else")["unlocked"] == 1
    # 私人答案对他人仍不可见
    own = s.save_answer("u1", "私问", "私答", [])
    assert s.get_answer_visible(own, "someone-else") is None


def test_pot_list_and_likes(tmp_db):
    s = tmp_db
    s.save_pot_answer("问题A", "甲" * 200, [], sort=2)
    s.save_pot_answer("问题B", "乙" * 150, [], sort=1)
    items = s.pot_list()
    # v0.7.0 排序：时间最新优先 + 互动加权（sort 列退役）；同刻落库 → 稳定保持插入序
    assert [i["question"] for i in items] == ["问题A", "问题B"]
    assert items[0]["preview"] == "甲" * 200 and len(items[0]["preview"]) == 200
    assert items[0]["likes"] == 0
    # 锅圈点赞：按人走 rewards 去重（人人可赞，mark_liked 只管本人答案）
    a_b = items[0]["id"]
    assert s.mark_liked(a_b, "u1") is False     # 非本人答案不吃行级 flag
    assert s.grant_reward("u1", a_b, "like") is True
    assert s.grant_reward("u1", a_b, "like") is False
    assert s.grant_reward("u2", a_b, "like") is True    # 第二个用户也能赞
    assert s.pot_list()[0]["likes"] == 2


def test_pot_seeding_idempotent(tmp_db):
    s = tmp_db
    assert s.pot_exists("锅圈问题X") is False
    s.save_pot_answer("锅圈问题X", "答" * 100, [])
    assert s.pot_exists("锅圈问题X") is True


def test_optimize_counter(tmp_db):
    s = tmp_db
    for _ in range(10):
        assert s.consume_optimize("u1") is True
    assert s.consume_optimize("u1") is False    # 每日 10 次上限
    assert s.opt_used_today("u1") == 10
    s.refund_optimize("u1")
    assert s.consume_optimize("u1") is True     # 失败退还后可用


def test_init_mysql_mode_never_executes_none(tmp_db, monkeypatch):
    """回归（v0.8.0 云托管实弹）：_SCHEMA 存在 (sqlite语句, None) 对（mysql 无对应，
    如 CREATE INDEX IF NOT EXISTS）——init() 在 mysql 模式必须跳过而非 execute(None)。
    实弹症状：/api/quota 等首个触库请求 500（'NoneType' has no attribute 'lstrip'）。"""
    import sqlite3
    from contextlib import contextmanager
    s = tmp_db
    executed: list = []

    class _Rec:
        def execute(self, sql, params=()):
            if sql is None:
                raise AssertionError("init() 在 mysql 模式执行了 None 模板")
            executed.append(sql)
            return self
        def fetchone(self):
            return None
        def fetchall(self):
            return []

    @contextmanager
    def fake_db():
        yield _Rec()

    monkeypatch.setattr(s, "_IS_MYSQL", True)
    monkeypatch.setattr(s, "_db", fake_db)
    # _upgrade 在 mysql 模式逐列 ALTER：模拟列已存在（dup column）走吞异常路径
    monkeypatch.setattr(s, "_upgrade", lambda *a, **k: None)
    s.init()
    assert executed, "应执行建表语句"
    assert all(isinstance(x, str) and x for x in executed)
    # mysql 侧 None 的两条 CREATE INDEX 不得出现，也不得把 sqlite 原文发去 mysql
    assert not any("CREATE INDEX" in x for x in executed)
