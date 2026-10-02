# -*- coding: utf-8 -*-
"""虚拟支付契约单测（T-P0-08）：409/503 降级体/真签名/回调幂等重放/状态机/禁启自检。"""
from __future__ import annotations

import hashlib
import hmac
import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import FAKE_APPSECRET, PILOT  # noqa: E402

from xueyuan_engine import app as app_mod  # noqa: E402


def _sign(client, buyer, rid=PILOT):
    return client.post("/api/v1/pay/sign", json={"report_id": rid}, headers=buyer)


def test_sign_requires_login(engine, client):
    assert client.post("/api/v1/pay/sign", json={"report_id": PILOT}).status_code == 401


def test_sign_503_degrade_body_shape(engine, client, buyer):
    """未配 offerId→503 精确降级体（NFR-10）：code+message+degrade 三字段。"""
    r = _sign(client, buyer)
    assert r.status_code == 503
    assert r.json() == {"code": "PAY_NOT_CONFIGURED", "message": "虚拟支付尚未开通",
                        "degrade": "pay_gray"}


def test_sign_real_signature_path(engine, client, buyer, pay_on):
    r = _sign(client, buyer)
    assert r.status_code == 200
    body = r.json()
    assert body["mode"] == "short_series_goods" and body["price_fen"] == 990
    sd = json.loads(body["sign_data"])
    assert sd["offerId"] == "test" and sd["productId"] == "xy_report_unlock"
    assert sd["env"] == 1 and sd["goodsPrice"] == 990 and sd["mode"] == "short_series_goods"
    assert sd["outTradeNo"].startswith(f"{PILOT}_") and len(sd["outTradeNo"]) <= 32
    want_pay = hmac.new(FAKE_APPSECRET.encode(),
                        ("requestVirtualPayment&" + body["sign_data"]).encode(),
                        hashlib.sha256).hexdigest()
    assert body["pay_sig"] == want_pay and len(body["signature"]) == 64


def test_sign_report_not_found(engine, client, buyer, pay_on):
    assert _sign(client, buyer, "no-such").status_code == 404


def test_sign_reuses_pending_order(engine, client, buyer, pay_on):
    o1 = _sign(client, buyer).json()["out_trade_no"]
    o2 = _sign(client, buyer).json()["out_trade_no"]
    assert o1 == o2  # 同 (user,report) pending 单复用同 outTradeNo（幂等键）


def test_sign_409_when_already_entitled(engine, client, buyer, pay_on):
    assert _sign(client, buyer).status_code == 200
    from xueyuan_engine import virtual_pay

    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "x")
    r = _sign(client, buyer)
    assert r.status_code == 409 and r.json()["code"] == "ALREADY_ENTITLED"


def _fake_pay(monkeypatch):
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")  # lifespan 禁启自检的 dev 端口口径


def test_callback_rejects_without_fake_gate(engine, client, monkeypatch):
    monkeypatch.delenv("XY_FAKE_PAY", raising=False)
    r = client.post("/api/v1/pay/callback", json={"outTradeNo": "x"})
    assert r.status_code == 501 and r.json()["code"] == "CALLBACK_VERIFY_NOT_READY"


def test_full_pay_flow_idempotent_callback(engine, client, buyer, pay_on, monkeypatch):
    _fake_pay(monkeypatch)
    out = _sign(client, buyer).json()["out_trade_no"]
    # 待支付状态：pending 未发货
    st = client.get("/api/v1/pay/status", params={"out_trade_no": out}, headers=buyer).json()
    assert st["status"] == "pending" and st["entitlement_granted"] is False
    # 首回调：mark paid+发权益
    cb1 = client.post("/api/v1/pay/callback",
                      json={"outTradeNo": out, "transactionId": "wxsn-1"})
    assert cb1.status_code == 200 and cb1.json()["first"] is True
    # 重复回调重放：恒 200 同果，不重复发放（harness D 场景）
    cb2 = client.post("/api/v1/pay/callback", json={"outTradeNo": out})
    assert cb2.status_code == 200 and cb2.json()["first"] is False
    me = client.get("/api/v1/me", headers=buyer).json()
    ents = [e for e in me["entitlements"] if e["report_id"] == PILOT]
    assert len(ents) == 1 and ents[0]["source"] == "purchase"
    st2 = client.get("/api/v1/pay/status", params={"out_trade_no": out}, headers=buyer).json()
    assert st2["status"] == "paid" and st2["entitlement_granted"] is True
    # 回调原文快照落库（pay_log 对账）
    from xueyuan_engine import store

    with store._db() as c:
        raw = c.execute("SELECT raw_notify FROM orders WHERE out_trade_no=?",
                        (out,)).fetchone()["raw_notify"]
    assert "wxsn-1" in raw


def test_callback_errors(engine, client, buyer, pay_on, monkeypatch):
    _fake_pay(monkeypatch)
    assert client.post("/api/v1/pay/callback", content=b"not-json").status_code == 400
    r = client.post("/api/v1/pay/callback", json={"foo": 1})
    assert r.status_code == 400 and r.json()["code"] == "INVALID_CALLBACK"
    assert client.post("/api/v1/pay/callback",
                       json={"outTradeNo": "ghost_1"}).status_code == 404


def test_pay_status_scoped_to_owner(engine, client, buyer, pay_on, monkeypatch):
    _fake_pay(monkeypatch)
    out = _sign(client, buyer).json()["out_trade_no"]
    other = client.post("/api/v1/auth/login", json={"code": "other-buyer"}).json()
    r = client.get("/api/v1/pay/status", params={"out_trade_no": out},
                   headers={"Authorization": f"Bearer {other['token']}"})
    assert r.status_code == 404  # 他人订单同 404（不泄漏存在性）


def test_fake_pay_startup_guard(engine, monkeypatch):
    """XY_FAKE_PAY 生产端口禁启自检（与 QW_FAKE_ASK 同款纪律）。"""
    env = {"XY_FAKE_PAY": "1"}
    with pytest.raises(RuntimeError, match="拒绝启动"):
        app_mod.assert_fake_pay_allowed(env, ["uvicorn", "--port", "8871"])
    with pytest.raises(RuntimeError):
        app_mod.assert_fake_pay_allowed(env, ["uvicorn"])  # 端口未知=按生产对待拒绝
    app_mod.assert_fake_pay_allowed(env, ["uvicorn", "--port", "8872"])  # dev 端口放行
    app_mod.assert_fake_pay_allowed({"XY_FAKE_PAY": "0"}, ["uvicorn", "--port", "8871"])
    app_mod.assert_fake_pay_allowed({}, ["uvicorn", "--port", "8871"])   # 无闸不拦


def test_admin_resync_dev_gated(engine, client, buyer):
    r = client.post("/api/v1/admin/resync", headers=buyer)
    assert r.status_code == 200 and r.json()["sync"]["reports"] >= 1
    assert client.post("/api/v1/admin/resync").status_code == 401
