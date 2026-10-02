# -*- coding: utf-8 -*-
"""点赞赠契约单测（T-P1-01/FR-P1-01）：必得即读/每日限 1/跨天/解耦/池空/种子确定性。"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND, THIRD  # noqa: E402

from xueyuan_engine import gift, store, virtual_pay  # noqa: E402


def _like(client, buyer, rid):
    return client.post(f"/api/v1/reports/{rid}/like", headers=buyer)


def test_like_requires_login(engine, client):
    assert _like(client, {}, PILOT).status_code == 401


def test_like_report_not_found(engine, client, buyer):
    assert _like(client, buyer, "ghost").status_code == 404


def test_first_like_grants_and_immediately_readable(engine, client, buyer, monkeypatch):
    monkeypatch.setenv("XY_GIFT_SEED", "3")
    r = _like(client, buyer, PILOT)
    assert r.status_code == 200
    body = r.json()
    assert body["granted"] is True
    assert body["gift_rule"] == "每日限 1 份·必得·附条件赠送"  # 契约文案逐字
    assert body["granted_report_id"] in (SECOND, THIRD)  # 未购清单且非被点赞那份
    # 赠品计入「赠阅」权益且立即可全文阅读（付费章正文直取）
    me = client.get("/api/v1/me", headers=buyer).json()
    hit = [e for e in me["entitlements"] if e["report_id"] == body["granted_report_id"]]
    assert len(hit) == 1 and hit[0]["source"] == "gift"
    ch = client.post(f"/api/v1/reports/{body['granted_report_id']}/chapters/ch04",
                     headers=buyer)
    assert ch.status_code == 200 and "付费正文" in ch.json()["html"]
    # gift_grants 落账（被点赞报告正确关联）
    with store._db() as c:
        row = c.execute("SELECT * FROM gift_grants WHERE user_id=?",
                        (buyer["uid"],)).fetchone()
    assert row["liked_report_id"] == PILOT
    assert row["granted_report_id"] == body["granted_report_id"]


def test_second_like_same_day_429(engine, client, buyer, monkeypatch):
    monkeypatch.setenv("XY_GIFT_SEED", "1")
    assert _like(client, buyer, PILOT).status_code == 200
    r = _like(client, buyer, SECOND)  # 换一篇点赞同样计入当日额度
    assert r.status_code == 429 and r.json()["code"] == "GIFT_DAILY_LIMIT"


def test_cross_day_boundary_grants_again(engine, client, buyer, monkeypatch):
    monkeypatch.setenv("XY_GIFT_SEED", "5")
    monkeypatch.setattr(gift, "_today", lambda: "2026-09-28")
    day1 = _like(client, buyer, PILOT).json()
    assert _like(client, buyer, SECOND).status_code == 429  # 当日已领
    monkeypatch.setattr(gift, "_today", lambda: "2026-09-29")  # 次日再得
    r = _like(client, buyer, SECOND)
    assert r.status_code == 200
    # 未购清单随机：次日赠品不与已赠/已拥有重复（发放时点判）
    assert r.json()["granted_report_id"] != day1["granted_report_id"]


def test_gift_pool_empty_when_all_owned(engine, client, buyer):
    for rid in (PILOT, SECOND, THIRD):  # 全部在售报告已有权益→池空兜底
        virtual_pay.grant_entitlement(buyer["uid"], rid, "purchase", "x")
    r = _like(client, buyer, PILOT)
    assert r.status_code == 409 and r.json()["code"] == "GIFT_POOL_EMPTY"


def test_choose_gift_seed_determinism():
    pool = [SECOND, THIRD, PILOT]
    assert gift.choose_gift(pool, 7) == gift.choose_gift(pool[:], 7)  # 同种子同结果
    assert gift.choose_gift(pool, 7) in pool                            # 恒在池内
    picks = {gift.choose_gift(pool, s) for s in range(20)}
    assert len(picks) >= 2  # 种子可注入随机性（测试确定性判据）


def test_share_actions_never_grant_gift(engine, client, buyer):
    """因果解耦断言（FR-P1-01）：分享事件/收藏/扫码访问零得赠。"""
    now = store.now()
    with store._db() as c:  # 直接落 share_event+scan_visit（分享侧数据形态）
        c.execute(
            "INSERT INTO share_event(id,user_id,report_id,channel,ts)"
            " VALUES(?,?,?,?,?)", ("sh1", buyer["uid"], PILOT, "moments", now))
        c.execute(
            "INSERT INTO scan_visit(scene_code,user_id,entry_page,ts)"
            " VALUES(?,?,?,?)", ("r=x&i=y", "", "pages/reader/reader", now))
    client.post(f"/api/v1/reports/{PILOT}/favorite", headers=buyer)
    me = client.get("/api/v1/me", headers=buyer).json()
    assert me["entitlements"] == []  # 无点赞→零赠阅
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM gift_grants WHERE user_id=?",
                      (buyer["uid"],)).fetchone()["n"]
    assert n == 0
