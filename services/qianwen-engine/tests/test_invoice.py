# -*- coding: utf-8 -*-
"""v0.9.4 发票（1009 用户令：累计满 ¥200 可申请增值税专用发票；企微推送运营）。

覆盖：
- status 软鉴权：未登录只看门槛口径（total=0 / can_apply=False）
- 门槛闸：不足 ¥200 → 403；paid 求和只认 status='paid'（signed 不计）
- 申请成功：落库字段回显 + 企微推送被调起（monkeypatch 捕获）
- 必填/格式闸：邮箱必填且格式校验（422）、税号 15-20 位（422）、抬头 2-64 字（422）
- 重复闸：pending 期间再申请 → 409
- fail-open：企微推送抛异常不阻断申请（200 照常）
运行：python -m pytest tests/test_invoice.py -q
"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, wechat  # noqa: E402


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    monkeypatch.setattr(config, "INVOICE_THRESHOLD_FEN", 20000)
    store._init_done = False
    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    # 企微推送缺省静默（各用例按需捕获/置炸）
    monkeypatch.setattr(app_mod, "_invoice_wecom_push", lambda row: None)

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _seed_paid(store, fen=20000, status="paid", otn="otn-1"):
    store.create_pay_order(otn, "open-t1", "report", "SKU-A", "", 1, fen)
    if status == "paid":
        assert store.mark_order_paid(otn)


BODY = {
    "title": "中建总包科技有限公司",
    "tax_no": "91310000MA1FL2XX9K",
    "email": "invoice@example.com",
    "addr_phone": "上海市浦东新区 021-88886666",
    "bank_acct": "招商银行上海分行 1219 0888 6666",
    "note": "开票内容：信息服务费",
}


# ── 状态腿（软鉴权）──

def test_status_anonymous_only_threshold(client):
    r = client.get("/api/invoice/status", headers={"Authorization": ""})
    assert r.status_code == 200
    d = r.json()
    assert d["total_fen"] == 0 and d["threshold_fen"] == 20000
    assert d["can_apply"] is False and d["applications"] == []


def test_status_sums_paid_only(client):
    from qianwen_engine import store
    _seed_paid(store, fen=20000, status="signed", otn="otn-signed")  # 未付不计
    _seed_paid(store, fen=49800, status="paid", otn="otn-paid")
    d = client.get("/api/invoice/status").json()
    assert d["total_fen"] == 49800
    assert d["can_apply"] is True


# ── 门槛闸 ──

def test_apply_below_threshold_403(client):
    from qianwen_engine import store
    _seed_paid(store, fen=19990, status="paid", otn="otn-small")
    r = client.post("/api/invoice/apply", json=BODY)
    assert r.status_code == 403
    assert "满 ¥200" in r.json()["detail"]


# ── 申请成功 + 企微推送 ──

def test_apply_ok_and_wecom_pushed(client, monkeypatch):
    from qianwen_engine import app as app_mod, store
    _seed_paid(store, fen=49800, status="paid", otn="otn-paid")
    pushed = []
    monkeypatch.setattr(app_mod, "_invoice_wecom_push", lambda row: pushed.append(row))
    r = client.post("/api/invoice/apply", json=BODY)
    assert r.status_code == 200
    d = r.json()
    assert d["ok"] is True
    app_row = d["application"]
    assert app_row["title"] == BODY["title"]
    assert app_row["tax_no"] == BODY["tax_no"].upper()
    assert app_row["email"] == BODY["email"]
    assert app_row["total_fen"] == 49800 and app_row["status"] == "pending"
    assert pushed and pushed[0]["email"] == BODY["email"]      # 推送被调起且带邮箱
    # status 反映 pending → can_apply 关闸
    s = client.get("/api/invoice/status").json()
    assert s["can_apply"] is False and len(s["applications"]) == 1


def test_apply_push_failure_fail_open(client, monkeypatch):
    from qianwen_engine import app as app_mod, store
    _seed_paid(store, fen=20000, status="paid", otn="otn-paid")
    def _boom(row):
        raise RuntimeError("wecom down")
    monkeypatch.setattr(app_mod, "_invoice_wecom_push", _boom)
    r = client.post("/api/invoice/apply", json=BODY)
    assert r.status_code == 200 and r.json()["ok"] is True     # 推送炸不影响落库


def test_apply_duplicate_pending_409(client):
    from qianwen_engine import store
    _seed_paid(store, fen=20000, status="paid", otn="otn-paid")
    assert client.post("/api/invoice/apply", json=BODY).status_code == 200
    r = client.post("/api/invoice/apply", json=BODY)
    assert r.status_code == 409


# ── 必填/格式闸 ──

def test_apply_email_required_and_valid(client):
    from qianwen_engine import store
    _seed_paid(store, fen=20000, status="paid", otn="otn-paid")
    bad = dict(BODY, email="")
    assert client.post("/api/invoice/apply", json=bad).status_code == 422
    bad2 = dict(BODY, email="not-an-email")
    assert client.post("/api/invoice/apply", json=bad2).status_code == 422


def test_apply_tax_no_format(client):
    from qianwen_engine import store
    _seed_paid(store, fen=20000, status="paid", otn="otn-paid")
    assert client.post("/api/invoice/apply",
                       json=dict(BODY, tax_no="123")).status_code == 422
    assert client.post("/api/invoice/apply",
                       json=dict(BODY, tax_no="9" * 21)).status_code == 422
    assert client.post("/api/invoice/apply",
                       json=dict(BODY, tax_no="91310000ma1fl2xx9k")).status_code == 200 \
        or client.post("/api/invoice/apply",
                       json=dict(BODY, tax_no="91310000ma1fl2xx9k")).status_code == 409


def test_apply_title_length(client):
    from qianwen_engine import store
    _seed_paid(store, fen=20000, status="paid", otn="otn-paid")
    assert client.post("/api/invoice/apply", json=dict(BODY, title="甲")).status_code == 422
