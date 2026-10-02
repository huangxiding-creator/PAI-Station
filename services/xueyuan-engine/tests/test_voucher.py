# -*- coding: utf-8 -*-
"""书券账本契约单测（T-P1-14/FR-P1-11）：三条一致/兑换/部分核销/余额门/无提现出口。"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND  # noqa: E402

from xueyuan_engine import store, voucher, virtual_pay  # noqa: E402

REDEEM_FEN = 49800  # 498 券统一兑换价（AGREEMENT_COPY §五）


def _grant(uid: str, amount: int, source: str = "campaign", ref: str = ""):
    return voucher.grant_voucher(uid, amount, source, ref)


def test_vouchers_endpoints_require_login(engine, client):
    assert client.get("/api/v1/me/vouchers").status_code == 401
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": PILOT})
    assert r.status_code == 401


def test_ledger_three_way_consistency(engine, client, buyer):
    """发放/余额/来源明细三条一致可查（WBS T-P1-14 判据）。"""
    _grant(buyer["uid"], 5000, "invite", "unlock:t1")
    _grant(buyer["uid"], 3000, "criticism_thanks", "c1")
    d = client.get("/api/v1/me/vouchers", headers=buyer).json()
    assert d["balance_fen"] == 8000
    assert [l["source"] for l in d["ledger"]] == ["invite", "criticism_thanks"]
    assert all(l["status"] == "active" and l["remaining_fen"] == l["amount_fen"]
               for l in d["ledger"])
    assert sum(l["amount_fen"] for l in d["ledger"]) == d["balance_fen"]  # 三条一致
    assert d["ledger"][0]["source_ref"] == "unlock:t1"
    me = client.get("/api/v1/me", headers=buyer).json()  # 我的页余额同源
    assert me["vouchers_balance_fen"] == 8000


def test_redeem_success_grants_entitlement(engine, client, buyer):
    _grant(buyer["uid"], 25000)
    _grant(buyer["uid"], 25000)
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": PILOT},
                    headers=buyer)
    assert r.status_code == 200
    assert r.json() == {"redeemed": True, "deducted_fen": REDEEM_FEN,
                        "report_id": PILOT}
    me = client.get("/api/v1/me", headers=buyer).json()
    hit = [e for e in me["entitlements"] if e["report_id"] == PILOT]
    assert len(hit) == 1 and hit[0]["source"] == "voucher"
    assert me["vouchers_balance_fen"] == 200  # 50000-49800 余 200
    d = client.get("/api/v1/me/vouchers", headers=buyer).json()
    # FIFO：首券烧尽置 used+核销单；次券 active 剩 200
    assert [l["status"] for l in d["ledger"]] == ["used", "active"]
    assert d["ledger"][0]["used_order_id"]
    assert d["ledger"][1]["remaining_fen"] == 200
    with store._db() as c:  # 核销流水合计=实扣（部分核销不动面值行）
        burned = c.execute(
            "SELECT COALESCE(SUM(amount_fen),0) s FROM voucher_burns WHERE user_id=?",
            (buyer["uid"],)).fetchone()["s"]
    assert burned == REDEEM_FEN


def test_redeem_insufficient_balance_untouched(engine, client, buyer):
    _grant(buyer["uid"], REDEEM_FEN - 100)
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": PILOT},
                    headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "BALANCE_INSUFFICIENT"
    me = client.get("/api/v1/me", headers=buyer).json()
    assert me["entitlements"] == []
    assert me["vouchers_balance_fen"] == REDEEM_FEN - 100  # 不足不动账


def test_redeem_report_not_found(engine, client, buyer):
    _grant(buyer["uid"], REDEEM_FEN)
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": "ghost"},
                    headers=buyer)
    assert r.status_code == 404
    assert client.get("/api/v1/me/vouchers", headers=buyer).json()["balance_fen"] == REDEEM_FEN


def test_redeem_already_entitled_no_double_burn(engine, client, buyer):
    _grant(buyer["uid"], 60000)
    virtual_pay.grant_entitlement(buyer["uid"], PILOT, "purchase", "o1")
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": PILOT},
                    headers=buyer)
    assert r.status_code == 409 and r.json()["code"] == "ALREADY_ENTITLED"
    assert client.get("/api/v1/me/vouchers",
                      headers=buyer).json()["balance_fen"] == 60000  # 未烧
    r2 = client.post("/api/v1/vouchers/redeem", json={"report_id": SECOND},
                     headers=buyer)  # 换一份未持有的正常兑
    assert r2.status_code == 200


def test_multi_denomination_fifo_partial_burn(engine, client, buyer):
    """5000×11 券栈：实扣恰 49800（跨券部分核销+FIFO 提前断），余 5200。"""
    for _ in range(11):
        _grant(buyer["uid"], 5000, "invite")
    r = client.post("/api/v1/vouchers/redeem", json={"report_id": SECOND},
                    headers=buyer)
    assert r.status_code == 200 and r.json()["deducted_fen"] == REDEEM_FEN
    d = client.get("/api/v1/me/vouchers", headers=buyer).json()
    assert d["balance_fen"] == 55000 - REDEEM_FEN
    assert sum(1 for l in d["ledger"] if l["status"] == "used") == 9  # 前 9 券烧尽
    assert sum(1 for l in d["ledger"] if l["status"] == "active") == 2
    # 余额不足二兑（余 5200 < 49800）
    r2 = client.post("/api/v1/vouchers/redeem", json={"report_id": PILOT},
                     headers=buyer)
    assert r2.status_code == 400


def test_no_cashout_or_transfer_routes():
    """红线断言：书券无任何提现/转卖出口接口（FR-P1-11）。"""
    allowed = {"/api/v1/me/vouchers", "/api/v1/vouchers/redeem"}
    paths = {getattr(route, "path", "") for route in voucher.router.routes}
    assert paths
    assert paths <= allowed
