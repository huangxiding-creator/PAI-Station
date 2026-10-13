# -*- coding: utf-8 -*-
"""v0.9.17 软删（用户令②：咨询记录删除）——store 原语与可见性地基（T-009）。

端点 DELETE /api/answers/{aid} 的 401/404/200 契约归端点任务；此处只铺
store+schema 地基：
- REQ-004.AC1 store：delete_answer 本人 → True；二次 → False（已删幂等，
  200 语义由端点调用方判定）；非 owner/未知 aid → False 且行不置 deleted
- REQ-004.AC3 store：删除后 history/history_all/get_answer/get_answer_visible
  对该 aid 全部不可见（已删 = 列表/详情 404 语义）
- REQ-005.AC1：软删零外溢——quota_left / pay_log 行数 / reward_exists 前后不变
- REQ-007.AC1 冒烟：init 后 answers 含 deleted 列（新库 CREATE TABLE 直含 +
  老库 v0.7 基线重放经 _ANSWER_UPGRADES ALTER 补列；四点同步源结构断言归 T-014）

端点层（T-010）：DELETE /api/answers/{aid} 全契约 + 锅圈幽灵修
- REQ-004.AC1 端点：本人删 → 200 {"deleted":true}；二次删幂等 200 同体
  （owner 门按 include_deleted 原行判定，不因已删误 404）
- REQ-004.AC2 端点：他人删 → 404；未知 aid → 404；无/坏 Bearer → 401
- REQ-004.AC3 端点：删除后 /api/history 无幽灵行、/api/answer/{aid} 本人 404；
  锅圈幽灵修——软删的共享答案即刻撤出 /api/pot/list（修前：列表仍挂
  问题+预览而详情 404，pot_list JOIN 漏 a.deleted=0 过滤）
- REQ-005.AC1 端点：软删零外溢——quota/pay_log/rewards 前后不变
运行：python -m pytest tests/test_delete_answer.py -q
"""
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


def _seed(s, openid: str, q: str) -> str:
    """异步主链落一行 ready 记录：create_pending → complete_answer。"""
    aid = s.create_pending(openid, q)
    assert s.complete_answer(aid, "答" * 50, [{"source": "书", "loc": "1", "n": 1}])
    return aid


def _pay_log_rows(s, openid: str) -> int:
    with s._db() as c:
        return c.execute(
            "SELECT COUNT(*) FROM pay_log WHERE openid=?", (openid,)).fetchone()[0]


# ── REQ-004.AC1：本人删 / 幂等 / 非 owner 拒绝（store 原语层） ──

def test_req_004_ac1_owner_delete_then_second_false(tmp_db):
    s = tmp_db
    a1 = _seed(s, "open-A", "问题一")
    a2 = _seed(s, "open-A", "问题二")
    assert s.delete_answer(a1, "open-A") is True
    # 已删再删：store 原语返 False（端点仍回 200 幂等，由调用方判定）
    assert s.delete_answer(a1, "open-A") is False
    # 兄弟行不受牵连
    assert s.get_answer(a2, "open-A") is not None
    assert [i["id"] for i in s.history("open-A")] == [a2]


def test_req_004_ac1_wrong_owner_or_unknown_rejected(tmp_db):
    s = tmp_db
    a1 = _seed(s, "open-A", "问题一")
    assert s.delete_answer(a1, "open-B") is False        # 非 owner：零改动
    assert s.delete_answer("no-such-aid", "open-A") is False
    row = s.get_answer(a1, "open-A")
    assert row is not None and not row["deleted"]        # 行仍可取且未置删
    assert [i["id"] for i in s.history("open-A")] == [a1]


# ── REQ-004.AC3：四条可见性门全部排除已删行 ──

def test_req_004_ac3_visibility_gates_exclude_deleted(tmp_db):
    s = tmp_db
    a1 = _seed(s, "open-A", "问题一")
    a2 = _seed(s, "open-A", "问题二")
    b1 = _seed(s, "open-B", "锅圈外来题")
    a3 = s.save_answer("open-A", "同步直落", "答", [])   # save_answer 腿同口径
    assert s.delete_answer(a1, "open-A") is True
    # history / history_all：我的页与批量导出计数均不含已删行
    assert [i["id"] for i in s.history("open-A")] == [a3, a2]
    assert [r["id"] for r in s.history_all("open-A")] == [a2, a3]
    assert [r["id"] for r in s.history_all("open-B")] == [b1]   # 他人不受牵连
    # 本人取行 / 观看者可见性门：已删 = 404 语义（None）
    assert s.get_answer(a1, "open-A") is None
    assert s.get_answer_visible(a1, "open-A") is None
    assert s.get_answer_visible(a1, "open-B") is None


# ── REQ-005.AC1：软删零外溢（quota / pay_log / rewards） ──

def test_req_005_ac1_soft_delete_zero_side_effects(tmp_db):
    s = tmp_db
    a1 = _seed(s, "open-A", "问题一")
    # 预置外溢观测点：导出对账行（pay_log）+ 互动赠次（rewards）+ 用户在册（quota）
    assert s.mark_export_paid(a1, "open-A", "otn-del-1")
    assert s.grant_reward("open-A", a1, "like")
    q0 = s.quota_left("open-A")
    n0 = _pay_log_rows(s, "open-A")
    rew0 = s.reward_exists("open-A", a1, "like")
    assert n0 == 1 and rew0 is True
    assert s.delete_answer(a1, "open-A") is True
    assert s.quota_left("open-A") == q0                        # quota 零变化
    assert _pay_log_rows(s, "open-A") == n0                    # pay_log 零删零增
    assert s.reward_exists("open-A", a1, "like") is rew0       # rewards 判定不变
    # 物理行仍在（deleted=1，审计链可追溯）
    with s._db() as c:
        raw = c.execute("SELECT deleted FROM answers WHERE id=?", (a1,)).fetchone()
    assert raw is not None and raw["deleted"] == 1


# ── REQ-007.AC1 冒烟：deleted 列迁移（新库直含 + 老库 ALTER 补列） ──

def test_req_007_ac1_deleted_column_fresh_and_legacy(tmp_db):
    s = tmp_db
    s.init()
    with s._db() as c:
        cols = [r["name"] for r in c.execute("PRAGMA table_info(answers)").fetchall()]
    assert "deleted" in cols                                  # 新库：CREATE TABLE 直含
    # 老库重放：v0.7 基线（无演进列）→ init 升级链 ALTER 幂等补列
    with s._db() as c:
        c.execute("DROP TABLE answers")
        c.execute(
            """CREATE TABLE answers (
                id TEXT PRIMARY KEY, openid TEXT NOT NULL, question TEXT NOT NULL,
                answer_full TEXT DEFAULT '', citations TEXT DEFAULT '[]',
                via TEXT DEFAULT 'kb', status TEXT DEFAULT 'ready',
                unlocked INTEGER DEFAULT 0, liked INTEGER DEFAULT 0, criticized INTEGER DEFAULT 0,
                elapsed_sec REAL DEFAULT 0, views INTEGER DEFAULT 0, shares INTEGER DEFAULT 0,
                created_at TEXT DEFAULT (datetime('now','localtime')))""")
    s._init_done = False
    s.init()
    with s._db() as c:
        cols = [r["name"] for r in c.execute("PRAGMA table_info(answers)").fetchall()]
    assert "deleted" in cols and "export_paid" in cols        # 新老演进列同链补齐


# ════════════════════════════════════════════════════════════════════
# 端点层（T-010）：DELETE /api/answers/{aid} + 锅圈幽灵修
# ════════════════════════════════════════════════════════════════════

@pytest.fixture()
def api(tmp_path, monkeypatch):
    """端点腿：TestClient + 临时库（seed 走 store 原语直落，不碰引擎异步链）。"""
    from fastapi.testclient import TestClient

    from qianwen_engine import app as app_mod, config, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False
    with TestClient(app_mod.app) as c:
        yield c
    store._init_done = False


def _auth(openid: str) -> dict:
    from qianwen_engine import wechat
    return {"Authorization": "Bearer " + wechat.issue_token(openid)}


# ── REQ-004.AC1 端点：本人删 → 200；二次删幂等 200 同体 ──

def test_req_004_ac1_endpoint_owner_delete_idempotent(api):
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "问题一")
    r1 = api.delete(f"/api/answers/{a1}", headers=_auth("open-A"))
    assert r1.status_code == 200 and r1.json() == {"deleted": True}
    # 已删再删：幂等 200 同体（owner 门按 include_deleted 原行判定，不误 404）
    r2 = api.delete(f"/api/answers/{a1}", headers=_auth("open-A"))
    assert r2.status_code == 200 and r2.json() == {"deleted": True}
    with store._db() as c:   # 物理行仍在、deleted=1（软删非物理抹除，审计链可溯）
        raw = c.execute("SELECT deleted FROM answers WHERE id=?", (a1,)).fetchone()
    assert raw is not None and raw["deleted"] == 1


# ── REQ-004.AC2 端点：他人 → 404；未知 aid → 404；无/坏 Bearer → 401 ──

def test_req_004_ac2_endpoint_non_owner_404(api):
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "问题一")
    assert api.delete(f"/api/answers/{a1}", headers=_auth("open-B")).status_code == 404
    assert store.get_answer(a1, "open-A") is not None   # 非 owner 删除零改动（行未置删）


def test_req_004_ac2_endpoint_unknown_aid_404(api):
    assert api.delete("/api/answers/no-such-aid", headers=_auth("open-A")).status_code == 404


def test_req_004_ac2_endpoint_no_auth_401(api):
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "问题一")
    assert api.delete(f"/api/answers/{a1}").status_code == 401                    # 无 Bearer
    assert api.delete(f"/api/answers/{a1}",
                      headers={"Authorization": "Bearer bad"}).status_code == 401  # 坏 Bearer


# ── REQ-004.AC3 端点：删除后 history 无幽灵行、本人详情 404 ──

def test_req_004_ac3_endpoint_history_and_detail_gone(api):
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "问题一")
    a2 = _seed(store, "open-A", "问题二")
    assert api.delete(f"/api/answers/{a1}", headers=_auth("open-A")).status_code == 200
    ids = [i["id"] for i in api.get("/api/history", headers=_auth("open-A")).json()["items"]]
    assert a1 not in ids and set(ids) == {a2}                 # 列表无幽灵行
    assert api.get(f"/api/answer/{a1}", headers=_auth("open-A")).status_code == 404


# ── REQ-004.AC3 锅圈幽灵修：软删的共享答案即刻撤出公共锅圈 ──

def test_req_004_ac3_pot_ghost_deleted_shared_leaves_pot_feed(api):
    """修前缺陷（T-009 移交）：pot_list JOIN answers 只过滤 status/answer_full，
    owner 软删共享答案后，锅圈列表仍挂其问题+预览而详情 404——公共 feed 幽灵。"""
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "共享后软删的锅圈条目")
    assert store.share_on(a1, "open-A") is True               # 共享入锅圈（落 pot_items 行）

    def _pot_ids():   # 观看者 open-B 视角的公共锅圈 feed
        return [it["id"] for it in
                api.get("/api/pot/list", headers=_auth("open-B")).json()["items"]]

    assert a1 in _pot_ids()                                   # 前置：删前确在锅圈
    assert api.get(f"/api/answer/{a1}", headers=_auth("open-B")).status_code == 200
    assert api.delete(f"/api/answers/{a1}", headers=_auth("open-A")).status_code == 200
    assert a1 not in _pot_ids()                               # 幽灵修：列表即刻撤下
    assert a1 not in [it["id"] for it in store.pot_list()]    # store 层同口径
    assert api.get(f"/api/answer/{a1}", headers=_auth("open-B")).status_code == 404


# ── REQ-005.AC1 端点：软删零外溢（quota / pay_log / rewards） ──

def test_req_005_ac1_endpoint_zero_side_effects(api):
    from qianwen_engine import store
    a1 = _seed(store, "open-A", "问题一")
    assert store.mark_export_paid(a1, "open-A", "otn-del-ep-1")
    assert store.grant_reward("open-A", a1, "like")
    q0 = store.quota_left("open-A")
    n0 = _pay_log_rows(store, "open-A")
    assert api.delete(f"/api/answers/{a1}", headers=_auth("open-A")).status_code == 200
    assert store.quota_left("open-A") == q0                   # quota 零变化
    assert _pay_log_rows(store, "open-A") == n0               # pay_log 零删零增
    assert store.reward_exists("open-A", a1, "like") is True  # rewards 判定不变
