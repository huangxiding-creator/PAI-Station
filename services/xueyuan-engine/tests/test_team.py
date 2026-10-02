# -*- coding: utf-8 -*-
"""组队契约单测（T-P1-12/FR-P1-10）：状态机/满员发放/72h 到期/非法迁移/影子支付。"""
from __future__ import annotations

import sys
from datetime import datetime, timedelta
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import config, store, team  # noqa: E402


def _fake_pay(monkeypatch):
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")  # dev 影子位端口（禁启自检口径）


def _login(client, code):
    d = client.post("/api/v1/auth/login", json={"code": code}).json()
    return {"Authorization": f"Bearer {d['token']}", "uid": d["uid"]}


def _hours_later(hours: float) -> str:
    return (datetime.fromisoformat(store.now()) + timedelta(hours=hours)
            ).isoformat(timespec="seconds")


def test_team_requires_login(engine, client, monkeypatch):
    _fake_pay(monkeypatch)
    assert client.post("/api/v1/team", json={"report_id": PILOT}).status_code == 401


def test_team_report_not_found(engine, client, buyer, monkeypatch):
    _fake_pay(monkeypatch)
    r = client.post("/api/v1/team", json={"report_id": "ghost"}, headers=buyer)
    assert r.status_code == 404


def test_team_production_pay_gated_rollback(engine, client, buyer, monkeypatch):
    """生产闸关（XY_FAKE_PAY 不设）→503；且不留无付款空队（事务回滚）。"""
    monkeypatch.delenv("XY_FAKE_PAY", raising=False)
    r = client.post("/api/v1/team", json={"report_id": PILOT}, headers=buyer)
    assert r.status_code == 503 and r.json()["code"] == "TEAM_PAY_NOT_CONFIGURED"
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM teams").fetchone()["n"]
    assert n == 0


def test_seat_prices_sum_to_team_price():
    seats = [team.seat_price(config.TEAM_PRICE_FEN, i) for i in range(team.CAPACITY)]
    assert seats == [33266, 33266, 33268]  # 座位差 1 分拆档（TBD 默认案②）
    assert sum(seats) == config.TEAM_PRICE_FEN == 99800


def test_team_view_ghost_404(engine):
    from xueyuan_engine.errors import ApiError

    with pytest.raises(ApiError, match="组队不存在"):
        team._team_view("t-ghost")


def test_create_team_contract_shape(engine, client, buyer, monkeypatch):
    _fake_pay(monkeypatch)
    r = client.post("/api/v1/team", json={"report_id": PILOT}, headers=buyer)
    assert r.status_code == 200
    body = r.json()
    assert body["report_id"] == PILOT and body["leader_uid"] == buyer["uid"]
    assert body["size"] == 1 and body["capacity"] == 3
    assert body["total_price_fen"] == 99800 and body["status"] == "open"
    with store._db() as c:  # 队长座位单已建且 paid（影子位），座位价=33266
        row = c.execute(
            "SELECT o.* FROM orders o JOIN team_members tm ON tm.out_trade_no=o.out_trade_no"
            " WHERE tm.uid=?", (buyer["uid"],)).fetchone()
    assert row["status"] == "paid" and row["price_fen"] == 33266
    assert row["env"] == 1  # 沙箱单不进营收对账


def test_full_team_grants_all_members(engine, client, buyer, monkeypatch):
    _fake_pay(monkeypatch)
    m1, m2 = _login(client, "mate1"), _login(client, "mate2")
    tid = client.post("/api/v1/team", json={"report_id": PILOT},
                      headers=buyer).json()["team_id"]
    j1 = client.post(f"/api/v1/team/{tid}/join", headers=m1)
    assert j1.status_code == 200 and j1.json()["size"] == 2
    j2 = client.post(f"/api/v1/team/{tid}/join", headers=m2)
    body = j2.json()
    assert body["size"] == 3 and body["status"] == "full"
    for who in (buyer, m1, m2):  # 全队各得阅读权（source=invite）
        me = client.get("/api/v1/me", headers=who).json()
        hit = [e for e in me["entitlements"] if e["report_id"] == PILOT]
        assert len(hit) == 1 and hit[0]["source"] == "invite"
    with store._db() as c:  # 组队订单金额合计=99800 分（FR 判据）+满员事件落账
        total = c.execute(
            "SELECT COALESCE(SUM(o.price_fen),0) s FROM orders o JOIN team_members tm"
            " ON o.out_trade_no=tm.out_trade_no WHERE tm.team_id=?", (tid,)).fetchone()["s"]
        ev = c.execute("SELECT COUNT(*) n FROM team_events WHERE team_id=? AND kind='full'",
                       (tid,)).fetchone()["n"]
    assert total == 99800 and ev == 1


def test_join_illegal_transitions(engine, client, buyer, monkeypatch):
    _fake_pay(monkeypatch)
    m1, m2, m4 = _login(client, "mate1"), _login(client, "mate2"), _login(client, "mate4")
    tid = client.post("/api/v1/team", json={"report_id": PILOT},
                      headers=buyer).json()["team_id"]
    assert client.post(f"/api/v1/team/{tid}/join",
                       headers=buyer).status_code == 409  # 队长再入=TEAM_DUP
    assert client.post(f"/api/v1/team/{tid}/join",
                       headers=m1).status_code == 200
    dup = client.post(f"/api/v1/team/{tid}/join", headers=m1)  # 重复加入
    assert dup.status_code == 409 and dup.json()["code"] == "TEAM_DUP"
    client.post(f"/api/v1/team/{tid}/join", headers=m2)  # 满 3
    full = client.post(f"/api/v1/team/{tid}/join", headers=m4)  # 满员后再加
    assert full.status_code == 409 and full.json()["code"] == "TEAM_FULL"
    assert client.post("/api/v1/team/no-such/join",
                       headers=m4).status_code == 404  # 不存在的队


def test_team_expires_at_72h_not_before(engine, client, buyer, monkeypatch):
    _fake_pay(monkeypatch)
    tid = client.post("/api/v1/team", json={"report_id": PILOT},
                      headers=buyer).json()["team_id"]
    m1 = _login(client, "mate1")
    client.post(f"/api/v1/team/{tid}/join", headers=m1)
    # 未到期强退守卫：71h59m 清扫=零命中，队伍仍 open
    assert team.expire_due_teams(_hours_later(71 + 59 / 60)) == 0
    r = client.post(f"/api/v1/team/{tid}/join", headers=_login(client, "mate2"))
    assert r.status_code == 200 and r.json()["status"] == "full"  # 未被误解散
    tid2 = client.post("/api/v1/team", json={"report_id": PILOT},
                       headers=buyer).json()["team_id"]
    # 满 72h 未满员：到期解散+事件落库+退款快照（E2 对接口）
    assert team.expire_due_teams(_hours_later(72.01)) == 1
    with store._db() as c:
        t = c.execute("SELECT status FROM teams WHERE id=?", (tid2,)).fetchone()
        ev = c.execute("SELECT payload FROM team_events WHERE team_id=? AND kind='expired'",
                       (tid2,)).fetchone()
    assert t["status"] == "expired"
    import json as _json
    snapshot = _json.loads(ev["payload"])
    assert snapshot["status"] == "expired" and len(snapshot["members"]) == 1
    assert snapshot["members"][0]["paid_fen"] == 33266  # 按座位实付全额退判据
    due = team.due_expired_refunds()  # E2 refund 域消费的快照清单
    assert [d["team_id"] for d in due] == [tid2]
    # 到期后再加入/满员队不再受清扫影响（幂等：重复清扫零命中）
    assert team.expire_due_teams(_hours_later(73)) == 0
    expired_join = client.post(f"/api/v1/team/{tid2}/join",
                               headers=_login(client, "mate3"))
    assert expired_join.status_code == 409 and expired_join.json()["code"] == "TEAM_EXPIRED"
