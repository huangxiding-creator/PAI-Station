# -*- coding: utf-8 -*-
"""订阅消息契约单测（T-P2-02/FR-P2-02）：未配置 501 自拒/订阅关系 CRUD/
假闸回执不触网/生产端口拒绝/notify_new_report 一次性不重发。零真实外呼
（真发送腿全部 monkeypatch/bomb）。"""
from __future__ import annotations

import sys
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT  # noqa: E402

from xueyuan_engine import store, subscribe  # noqa: E402

TMPL_ENV = ('{"new_report_province": {"template_id": "TMPL-PROV-1",'
            ' "page": "pages/index/index"}}')


def _configured(monkeypatch):
    monkeypatch.setenv("XY_SUBSCRIBE_TEMPLATES", TMPL_ENV)


def _fake_gate(monkeypatch):
    monkeypatch.setenv("XY_FAKE_NOTIFY", "1")
    monkeypatch.setenv("XY_PORT", "8872")  # dev 端口口径（同 test_pay._fake_pay）


def _no_network(monkeypatch):
    """炸弹补丁：任何真实外呼即炸（假闸/静默跳过路径绝不允许触网）。"""
    def boom(*a, **kw):
        raise AssertionError("subscribe 域不允许真实外呼")
    monkeypatch.setattr(subscribe, "cr", SimpleNamespace(post=boom))


# ── 端点：未配置 501 自拒（与 /refund/callback 同款 idiom）──────────
def test_post_unconfigured_501(engine, client, buyer):
    r = client.post("/api/v1/subscriptions", json={"provinces": ["江苏"]},
                    headers=buyer)
    assert r.status_code == 501 and r.json()["code"] == "SUBSCRIBE_NOT_CONFIGURED"


def test_get_unconfigured_501(engine, client, buyer):
    r = client.get("/api/v1/subscriptions", headers=buyer)
    assert r.status_code == 501 and r.json()["code"] == "SUBSCRIBE_NOT_CONFIGURED"


def test_delete_unconfigured_501(engine, client, buyer):
    r = client.request("DELETE", "/api/v1/subscriptions",
                       json={"kind": "province", "value": "江苏"}, headers=buyer)
    assert r.status_code == 501


def test_endpoints_require_login(engine, client, monkeypatch):
    _configured(monkeypatch)
    assert client.post("/api/v1/subscriptions",
                       json={"provinces": ["江苏"]}).status_code == 401
    assert client.get("/api/v1/subscriptions").status_code == 401


# ── 订阅关系 CRUD ────────────────────────────────────────────
def test_post_get_roundtrip_and_privacy(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    r = client.post("/api/v1/subscriptions",
                    json={"provinces": ["江苏", " 江苏 "], "topics": ["水网"]},
                    headers=buyer)
    assert r.status_code == 200
    items = {(i["kind"], i["value"]) for i in r.json()["items"]}
    assert items == {("province", "江苏"), ("topic", "水网")}  # 去重合并
    other = client.post("/api/v1/auth/login", json={"code": "other-user"}).json()
    got = client.get("/api/v1/subscriptions", headers={
        "Authorization": f"Bearer {other['token']}"}).json()
    assert got["items"] == []  # 只见自己的订阅


def test_post_idempotent_single_row(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    for _ in range(2):
        client.post("/api/v1/subscriptions", json={"provinces": ["江苏"]},
                    headers=buyer)
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM subscriptions WHERE user_id=?",
                      (buyer["uid"],)).fetchone()["n"]
    assert n == 1


def test_post_empty_and_oversize_400(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    assert client.post("/api/v1/subscriptions", json={}, headers=buyer).status_code == 400
    r = client.post("/api/v1/subscriptions",
                    json={"provinces": [f"省{i}" for i in range(21)]}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "INVALID_PARAM"


def test_unsubscribe_idempotent(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    client.post("/api/v1/subscriptions", json={"provinces": ["江苏"]}, headers=buyer)
    for _ in range(2):  # 重复退订幂等 200
        r = client.request("DELETE", "/api/v1/subscriptions",
                           json={"kind": "province", "value": "江苏"}, headers=buyer)
        assert r.status_code == 200
    assert client.get("/api/v1/subscriptions", headers=buyer).json()["items"] == []
    bad = client.request("DELETE", "/api/v1/subscriptions",
                         json={"kind": "channel", "value": "x"}, headers=buyer)
    assert bad.status_code == 400


# ── send_subscribe：假闸/静默跳过/生产自拒 ───────────────────────
def test_send_subscribe_fake_receipt_no_network(engine, client, buyer, monkeypatch):
    _fake_gate(monkeypatch)
    _no_network(monkeypatch)
    user = store.get_user(buyer["uid"])
    res = subscribe.send_subscribe(user, "new_report_province", {})
    assert res["errcode"] == 0 and res["fake"] is True
    assert res["msgid"].startswith("fakenotify-")
    again = subscribe.send_subscribe(user, "new_report_province", {})
    assert again["msgid"] == res["msgid"]  # 确定性假单号


def test_send_subscribe_unconfigured_template_skips(engine, client, buyer, monkeypatch):
    monkeypatch.delenv("XY_SUBSCRIBE_TEMPLATES", raising=False)
    monkeypatch.delenv("XY_FAKE_NOTIFY", raising=False)
    _no_network(monkeypatch)
    user = store.get_user(buyer["uid"])
    assert subscribe.send_subscribe(user, "new_report_province", {}) is None


def test_send_subscribe_unknown_template_key_skips(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    _no_network(monkeypatch)
    user = store.get_user(buyer["uid"])
    assert subscribe.send_subscribe(user, "no_such_template", {}) is None


def test_send_subscribe_prod_port_refused(engine, client, buyer, monkeypatch):
    monkeypatch.setenv("XY_FAKE_NOTIFY", "1")
    monkeypatch.setenv("XY_PORT", "8871")  # 生产端口=拒绝执行（同 XY_FAKE_PAY 纪律）
    user = store.get_user(buyer["uid"])
    with pytest.raises(RuntimeError, match="拒绝执行"):
        subscribe.send_subscribe(user, "new_report_province", {})


def test_send_subscribe_missing_openid_skips(engine, client, monkeypatch):
    monkeypatch.delenv("XY_FAKE_NOTIFY", raising=False)
    assert subscribe.send_subscribe({"id": "uX"}, "new_report_province", {}) is None


# ── notify_new_report：一次性「收到一次」不重发 ─────────────────────
def test_notify_new_report_fake_gate_once_per_user(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    _fake_gate(monkeypatch)
    _no_network(monkeypatch)
    d = client.post("/api/v1/auth/login", json={"code": "friend"}).json()
    friend = {"Authorization": f"Bearer {d['token']}", "uid": d["uid"]}
    for h in (buyer, friend):
        r = client.post("/api/v1/subscriptions", json={"provinces": ["江苏"]},
                        headers=h)
        assert r.status_code == 200
    report = {"id": PILOT, "province": "江苏", "title": "江苏省水网工程商机研究"}
    d1 = subscribe.notify_new_report(report)
    assert d1["sent"] == 2 and d1["skipped"] == 0
    with store._db() as c:
        rows = c.execute("SELECT user_id,result FROM subscribe_sends").fetchall()
    assert len(rows) == 2 and all(r["result"] == "ok" for r in rows)
    d2 = subscribe.notify_new_report(report)  # 重放：一次性语义不重发
    assert d2["sent"] == 0 and d2["skipped"] == 2


def test_notify_new_report_skips_other_province(engine, client, buyer, monkeypatch):
    _configured(monkeypatch)
    _fake_gate(monkeypatch)
    _no_network(monkeypatch)
    client.post("/api/v1/subscriptions", json={"provinces": ["广东"]},
                headers=buyer)
    d = subscribe.notify_new_report({"id": PILOT, "province": "江苏", "title": "x"})
    assert d["sent"] == 0 and d["skipped"] == 0  # 订广东者不收江苏上新
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM subscribe_sends").fetchone()["n"]
    assert n == 0


def test_notify_new_report_unconfigured_aborts(engine, client, monkeypatch):
    monkeypatch.delenv("XY_SUBSCRIBE_TEMPLATES", raising=False)
    monkeypatch.delenv("XY_FAKE_NOTIFY", raising=False)
    d = subscribe.notify_new_report({"id": PILOT, "province": "江苏", "title": "x"})
    assert d == {"sent": 0, "skipped": 0, "aborted": "template_not_configured"}


# ── 启动腿：XY_FAKE_NOTIFY 生产端口禁启（app.assert_fake_pay_allowed）──
def test_fake_notify_startup_guard(engine):
    from xueyuan_engine import app as app_mod

    with pytest.raises(RuntimeError, match="拒绝启动"):
        app_mod.assert_fake_pay_allowed({"XY_FAKE_NOTIFY": "1"},
                                        ["uvicorn", "--port", "8871"])
    app_mod.assert_fake_pay_allowed({"XY_FAKE_NOTIFY": "1"},
                                    ["uvicorn", "--port", "8872"])  # dev 端口放行
    app_mod.assert_fake_pay_allowed({}, ["uvicorn", "--port", "8871"])  # 无闸不拦
