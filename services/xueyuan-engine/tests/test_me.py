# -*- coding: utf-8 -*-
"""me 腿单测（T-P0-10）：已购即时出现/收藏幂等服务端为准。"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402


def test_me_requires_login(engine, client):
    assert client.get("/api/v1/me").status_code == 401


def test_me_shape_and_entitlements_after_pay(engine, client, buyer, monkeypatch, pay_on):
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")
    out = client.post("/api/v1/pay/sign", json={"report_id": PILOT},
                      headers=buyer).json()["out_trade_no"]
    me0 = client.get("/api/v1/me", headers=buyer).json()
    assert me0["entitlements"] == []  # 支付前无权益
    client.post("/api/v1/pay/callback", json={"outTradeNo": out})
    me1 = client.get("/api/v1/me", headers=buyer).json()  # 支付成功即时出现
    assert me1["uid"] == buyer["uid"]
    assert [e["report_id"] for e in me1["entitlements"]] == [PILOT]
    assert me1["entitlements"][0]["source"] == "purchase"
    assert me1["refund_monthly_limit"] == 2 and me1["vouchers_balance_fen"] == 0


def test_favorite_idempotent_server_truth(engine, client, buyer):
    url = f"/api/v1/reports/{PILOT}/favorite"
    assert client.post(url, headers=buyer).json() == {"favorited": True}
    assert client.post(url, headers=buyer).json() == {"favorited": True}   # 重复幂等
    me = client.get("/api/v1/me", headers=buyer).json()
    assert [f["report_id"] for f in me["favorites"]] == [PILOT]
    assert client.delete(url, headers=buyer).json() == {"favorited": False}
    assert client.delete(url, headers=buyer).json() == {"favorited": False}  # 重复删幂等
    assert client.get("/api/v1/me", headers=buyer).json()["favorites"] == []
    # 详情页收藏态以服务端为准
    client.post(url, headers=buyer)
    assert client.get(f"/api/v1/reports/{PILOT}", headers=buyer).json()["favorited"] is True


def test_favorite_requires_login_and_valid_report(engine, client, buyer):
    assert client.post("/api/v1/reports/x/favorite").status_code == 401
    assert client.post("/api/v1/reports/ghost/favorite",
                       headers=buyer).status_code == 404
