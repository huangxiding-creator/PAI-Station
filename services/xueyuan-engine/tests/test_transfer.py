# -*- coding: utf-8 -*-
"""转赠契约单测（T-P2-04/FR-P2-04）：终身 1 次/转出即失权/受赠方得 transfer
权益/自赠 403/受赠已有 409/hash 解析/作用域无副作用+v1.2 §四对齐（仅限本人
付费购买/在途退款闸/转后不可批评退款）。
"""
from __future__ import annotations

import hashlib
import sys
import uuid
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND  # noqa: E402

from xueyuan_engine import store, virtual_pay  # noqa: E402


def _own(uid, rid, source="purchase"):
    virtual_pay.grant_entitlement(uid, rid, source, "order-x")


def _friend(client):
    d = client.post("/api/v1/auth/login", json={"code": "friend"}).json()
    return {"Authorization": f"Bearer {d['token']}", "uid": d["uid"]}


def _transfer(client, buyer, rid, **body):
    return client.post(f"/api/v1/reports/{rid}/transfer", json=body, headers=buyer)


def test_requires_login(engine, client):
    assert client.post(f"/api/v1/reports/{PILOT}/transfer",
                       json={"to_uid": "uX"}).status_code == 401


def test_report_not_found(engine, client, buyer):
    assert _transfer(client, buyer, "ghost", to_uid="uX").status_code == 404


def test_not_entitled_403(engine, client, buyer):
    r = _transfer(client, buyer, PILOT, to_uid="u1234567890")
    assert r.status_code == 403 and r.json()["code"] == "NOT_ENTITLED"


def test_transfer_full_flow(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    r = _transfer(client, buyer, PILOT, to_uid=friend["uid"])
    assert r.status_code == 200
    body = r.json()
    assert body["transferred"] is True and body["to_uid"] == friend["uid"]
    assert body["transfer_id"].startswith("t") and body["rule"]
    # 受赠方得 source='transfer' 权益，可读付费章
    me = client.get("/api/v1/me", headers=friend).json()
    hit = [e for e in me["entitlements"] if e["report_id"] == PILOT]
    assert len(hit) == 1 and hit[0]["source"] == "transfer"
    ch = client.post(f"/api/v1/reports/{PILOT}/chapters/ch04", headers=friend)
    assert ch.status_code == 200 and "付费正文" in ch.json()["html"]
    # 转出即失权益：/me 消失+付费章 403
    me2 = client.get("/api/v1/me", headers=buyer).json()
    assert not [e for e in me2["entitlements"] if e["report_id"] == PILOT]
    assert client.post(f"/api/v1/reports/{PILOT}/chapters/ch04",
                       headers=buyer).status_code == 403
    # 事件账：from_source 审计快照
    with store._db() as c:
        row = c.execute("SELECT * FROM transfers WHERE report_id=?", (PILOT,)).fetchone()
    assert row["from_user"] == buyer["uid"] and row["to_user"] == friend["uid"]
    assert row["from_source"] == "purchase"


def test_second_transfer_409_even_after_losing_entitlement(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200
    r = _transfer(client, buyer, PILOT, to_uid="u1234567890")
    assert r.status_code == 409 and r.json()["code"] == "ALREADY_TRANSFERRED"


def test_self_transfer_403(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    r = _transfer(client, buyer, PILOT, to_uid=buyer["uid"])
    assert r.status_code == 403 and r.json()["code"] == "TRANSFER_SELF"


def test_recipient_already_entitled_409(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    _own(friend["uid"], PILOT, "gift")
    r = _transfer(client, buyer, PILOT, to_uid=friend["uid"])
    assert r.status_code == 409 and r.json()["code"] == "ALREADY_ENTITLED"


def test_to_openid_hash_resolution(engine, client, buyer):
    """to_openid_hash=sha256(openid) 与 uid 派生规则同源（openid 本体不外泄）。"""
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    h = hashlib.sha256(b"dev-friend").hexdigest()
    r = _transfer(client, buyer, PILOT, to_openid_hash=h)
    assert r.status_code == 200 and r.json()["to_uid"] == friend["uid"]


def test_bad_recipient_input_400(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    assert _transfer(client, buyer, PILOT).status_code == 400  # 两标识全空
    r = _transfer(client, buyer, PILOT, to_openid_hash="zz-not-hex")
    assert r.status_code == 400 and r.json()["code"] == "INVALID_PARAM"
    r = _transfer(client, buyer, PILOT, to_uid="uAAAAAAAAAA",
                  to_openid_hash="b" * 64)  # 两标识指向不同用户
    assert r.status_code == 400


def test_unknown_recipient_404(engine, client, buyer):
    _own(buyer["uid"], PILOT)
    r = _transfer(client, buyer, PILOT, to_uid="uNoSuchUser")
    assert r.status_code == 404 and r.json()["code"] == "USER_NOT_FOUND"


def test_transfer_scoped_no_side_effects(engine, client, buyer):
    """转 PILOT 不伤 SECOND：他报告权益/可读性原样。"""
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    _own(buyer["uid"], SECOND)
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200
    me = client.get("/api/v1/me", headers=buyer).json()
    assert [e for e in me["entitlements"] if e["report_id"] == SECOND]
    assert client.post(f"/api/v1/reports/{SECOND}/chapters/ch04",
                       headers=buyer).status_code == 200
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM transfers").fetchone()["n"]
    assert n == 1  # 只有一笔事件账


# ── v1.2 §四 对齐：仅限本人付费购买可转（获赠/兑换/组队/受赠不可转）────────
def test_gift_source_not_transferable(engine, client, buyer):
    _own(buyer["uid"], PILOT, "gift")  # 点赞获赠
    r = _transfer(client, buyer, PILOT, to_uid="u1234567890")
    assert r.status_code == 403 and r.json()["code"] == "NOT_TRANSFERABLE"
    assert "仅限本人付费购买" in r.json()["message"]


def test_voucher_source_not_transferable(engine, client, buyer):
    _own(buyer["uid"], PILOT, "voucher")  # 书券兑换
    r = _transfer(client, buyer, PILOT, to_uid="u1234567890")
    assert r.status_code == 403 and r.json()["code"] == "NOT_TRANSFERABLE"


def test_team_and_invite_source_not_transferable(engine, client, buyer):
    # 组队获得在本引擎落 source='invite'（team._finalize_full 真源），馆友同源
    _own(buyer["uid"], PILOT, "invite")
    r = _transfer(client, buyer, PILOT, to_uid="u1234567890")
    assert r.status_code == 403 and r.json()["code"] == "NOT_TRANSFERABLE"


def test_received_transfer_not_retransferable(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200
    third = client.post("/api/v1/auth/login", json={"code": "third"}).json()
    r = _transfer(client, friend, PILOT,
                  to_uid=third["uid"])  # 受赠方（source='transfer'）不可再转
    assert r.status_code == 403 and r.json()["code"] == "NOT_TRANSFERABLE"


def test_mixed_purchase_plus_gift_still_transferable(engine, client, buyer):
    """purchase 与他源并存（跨源允许）：报告确系本人付费购买过→可转。"""
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    _own(buyer["uid"], PILOT, "gift")
    r = _transfer(client, buyer, PILOT, to_uid=friend["uid"])
    assert r.status_code == 200 and r.json()["transferred"] is True


# ── v1.2 §四 对齐：在途退款闸（未完结批评/退款先完结再转）──────────────
def _seed_order(uid, rid, status="paid"):
    out = f"{rid}-ord{uuid.uuid4().hex[:8]}"
    with store._db() as c:
        c.execute(
            "INSERT INTO orders(out_trade_no,user_id,report_id,price_fen,status,"
            "created_at) VALUES(?,?,?,?,?,?)",
            (out, uid, rid, 49800, status, store.now()))
    return out


def _seed_criticism(uid, rid, out, status):
    cid = f"c{uuid.uuid4().hex[:12]}"
    with store._db() as c:
        c.execute(
            "INSERT INTO criticisms(id,user_id,report_id,order_id,content,char_count,"
            "read_verified,anchor_score,similarity_score,status,created_at)"
            " VALUES(?,?,?,?,?,60,1,0.6,0,?,?)",
            (cid, uid, rid, out,
             "第4章的30%数据与我的项目经验不符，矛盾点在测算口径，建议核实补充。",  # noqa: E501
             status, store.now()))
    return cid


def _seed_refund(uid, out, status):
    fid = f"r{uuid.uuid4().hex[:12]}"
    with store._db() as c:
        c.execute(
            "INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,tier,"
            "amount_fen,method,status,created_at) VALUES(?,?,?,?,?,'tier50',24900,"
            "'manual',?,?)", (fid, out, "", uid, "android", status, store.now()))
    return fid


def test_criticism_in_flight_blocks_transfer(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    out = _seed_order(buyer["uid"], PILOT)
    cid = _seed_criticism(buyer["uid"], PILOT, out, "pending_score")
    for status in ("pending_score", "scored", "manual_pending"):  # 同行推进（每报告限 1 次）
        with store._db() as c:
            c.execute("UPDATE criticisms SET status=? WHERE id=?", (status, cid))
        r = _transfer(client, buyer, PILOT, to_uid=friend["uid"])
        assert r.status_code == 409 and r.json()["code"] == "REFUND_IN_FLIGHT", status
        assert "须先完结再转赠" in r.json()["message"]
    with store._db() as c:  # 结案（终态 rejected/closed）→闸抬起
        c.execute("UPDATE criticisms SET status='closed' WHERE id=?", (cid,))
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200


def test_refund_row_in_flight_blocks_transfer(engine, client, buyer):
    friend = _friend(client)
    _own(buyer["uid"], PILOT)
    out = _seed_order(buyer["uid"], PILOT)
    fid = _seed_refund(buyer["uid"], out, "initiated")
    r = _transfer(client, buyer, PILOT, to_uid=friend["uid"])
    assert r.status_code == 409 and r.json()["code"] == "REFUND_IN_FLIGHT"
    with store._db() as c:  # 终态 failed（权益未关）→放行；settled 同理不再拦
        c.execute("UPDATE refunds SET status='failed' WHERE id=?", (fid,))
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200


# ── v1.2 §四 对齐：转赠后不可再批评/退款（订单推进 transferred→已购闸自然拒）──
def test_post_transfer_criticize_and_refund_blocked(
        engine, client, buyer, pay_on, monkeypatch):
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")
    out = client.post("/api/v1/pay/sign", json={"report_id": PILOT},
                      headers=buyer).json()["out_trade_no"]
    client.post("/api/v1/pay/callback", json={"outTradeNo": out})  # 真支付流：订单 paid
    client.get(f"/api/v1/reports/{PILOT}/chapters", headers=buyer)  # 阅读记录（批评资格）
    friend = _friend(client)
    assert _transfer(client, buyer, PILOT, to_uid=friend["uid"]).status_code == 200
    with store._db() as c:
        st = c.execute("SELECT status FROM orders WHERE out_trade_no=?",
                       (out,)).fetchone()["status"]
    assert st == "transferred"  # 订单脱离已付态（发票仍按本购买记录开具）
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": "第4章的30%数据与我的项目经验不符，建议核实。",
                          "order_id": out}, headers=buyer)
    assert r.status_code == 403 and r.json()["code"] == "NOT_PURCHASED"
    r2 = client.post("/api/v1/refund/apply", json={"order_id": out,
                                                   "reason": "转后尝试退款"},
                     headers=buyer)
    assert r2.status_code == 404 and r2.json()["code"] == "ORDER_NOT_FOUND"
