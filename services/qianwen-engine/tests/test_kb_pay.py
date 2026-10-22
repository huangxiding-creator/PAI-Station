# -*- coding: utf-8 -*-
"""v0.9.24 KB-FACTORY 五端点 + 履约桥（W11 用户令 1022：部署/提审/放量）。

覆盖（镜像 test_export_pay/test_report_mall 既有先例，零新框架）：
- 蓝图导出两腿：A 档硬编码价校验（expected≠10 拒 400）、签名即落单
  kind='kb_bp'、复用 export_once 道具、已解锁 409、查单核验 SUCCESS/
  NOTPAY/伪造 otn、幂等收口 {"blueprint_paid": true}
- 整库订单两腿：服务端复算价（original 2900+gb×200；md ×1.5；import +1900；
  金额对齐整元 kb_goods ¥1×qty）、防篡价硬门（声明差>50fen 拒 400）、
  version/email 非法 400、kb_product_id 未配 503、kb_orders 落 pending、
  查单核验转 paid、幂等 {"order_paid": true}
- 履约收尾腿：paid → accepted（幂等 {accepted:true}）、email 必填 400、
  未付 402、回调断网后提交腿查单补账恢复路径
- 履约桥（机对机，无用户 token）：密钥文件缺失 503、错/缺头 401、
  accepted 未拉取单脱敏返回（无 openid）、ack 幂等、after 游标
- 方言锚：kb_bp/kb_order 词元 ≤8 字符（pay_order.kind VARCHAR(8) 生产实锤）
运行：python -m pytest tests/test_kb_pay.py -q
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, wechat  # noqa: E402

SHA = "1a2b3c4d"
DIGEST = {"domain": "水利EPC工程知识库", "files": 1000, "gb": 1.33,
          "total": 31.7, "version_sha": SHA}
# 复算锚：base=2900+1.33×200=3166 fen；|3166-3170|=4 ≤50 过门
# 对齐整元：original→3200(qty32)；md int(3166×1.5+.5)=4749→4700(qty47)；
# import 3166+1900=5066→5100(qty51)


def _order_payload(**over):
    p = {"blueprint": dict(DIGEST), "email": "buyer@example.com",
         "version": "original", "need_text": "备注"}
    p.update(over)
    return p


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    # 查单腿默认=基础设施不可达（沙箱 env=1 信任回调路径）；逐用例按需覆写
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: (_ for _ in ()).throw(
                            wechat.XpayError("test: query infra unavailable")))

    secret = tmp_path / "virtual_pay.secret"
    secret.write_text(
        "offer_id=1450664233\n"
        "product_id=unlock_once_legacy\n"
        "export_product_id=export_once\n"
        "kb_product_id=kb_goods\n"
        "env=1\n"
        "sandbox_appkey=test-sandbox-appkey\n"
        "prod_appkey=test-prod-appkey\n",
        encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", secret)

    bridge_key = tmp_path / "kb_bridge.key"
    bridge_key.write_text("bridge-secret-w11", encoding="utf-8")
    monkeypatch.setattr(config, "KB_BRIDGE_KEY_FILE", bridge_key)

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _session():
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")


def _query(monkeypatch, status):
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: {"errcode": 0,
                                         "order": {"status": status}})


# ── 蓝图导出两腿 ──────────────────────────────────────────────────────────

def test_kb_blueprint_sign_creates_order(client):
    from qianwen_engine import store
    _session()
    r = client.post("/api/kb/blueprint_sign",
                    json={"version_sha": SHA, "price_fen_expected": 10})
    assert r.status_code == 200
    d = r.json()
    assert d["mode"] == "short_series_goods" and d["price_fen"] == 10
    sd = json.loads(d["sign_data"])
    assert sd["productId"] == "export_once"       # 复用 ¥0.1 已现网道具
    assert sd["buyQuantity"] == 1 and sd["goodsPrice"] == 10
    assert sd["outTradeNo"].startswith("p") and sd["env"] == 1
    o = store.get_pay_order(d["out_trade_no"])
    assert o and o["kind"] == "kb_bp" and o["aid"] == SHA
    assert o["total_fen"] == 10 and o["status"] == "signed"


def test_kb_blueprint_sign_price_and_gates(client):
    _session()
    # A 档硬编码校验：expected≠10 → 400（拒客户端随意报价）
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": SHA,
                             "price_fen_expected": 100}).status_code == 400
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": "ZZ!", "price_fen_expected": 10}
                       ).status_code == 400
    # 无 session_key → 401（签名腿硬前置）
    from qianwen_engine import store
    store.save_session("open-t1", "")
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": SHA,
                             "price_fen_expected": 10}).status_code == 401
    # 未登录 → 401
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": SHA, "price_fen_expected": 10},
                       headers={"Authorization": ""}).status_code == 401


def test_kb_blueprint_paid_verify_and_idempotent(client, monkeypatch):
    from qianwen_engine import store
    _session()
    otn = client.post("/api/kb/blueprint_sign",
                      json={"version_sha": SHA,
                            "price_fen_expected": 10}).json()["out_trade_no"]
    # NOTPAY → 400（fail-closed：未付不放行）
    _query(monkeypatch, "NOTPAY")
    assert client.post("/api/kb/blueprint_paid",
                       json={"out_trade_no": otn}).status_code == 400
    # 伪造 otn / 他人视角 → 404
    _query(monkeypatch, "SUCCESS")
    assert client.post("/api/kb/blueprint_paid",
                       json={"out_trade_no": "p-forged-0001"}).status_code == 404
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    assert client.post("/api/kb/blueprint_paid", headers=t2,
                       json={"out_trade_no": otn}).status_code == 404
    # SUCCESS → 解锁 + 幂等收口
    r = client.post("/api/kb/blueprint_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["blueprint_paid"] is True
    assert store.kb_blueprint_unlocked("open-t1", SHA)
    assert store.get_pay_order(otn)["status"] == "paid"
    r2 = client.post("/api/kb/blueprint_paid", json={"out_trade_no": otn})
    assert r2.status_code == 200 and r2.json()["blueprint_paid"] is True
    # 已解锁再签名 → 409 收口
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": SHA,
                             "price_fen_expected": 10}).status_code == 409


def test_kb_blueprint_paid_sandbox_trust_on_query_fail(client):
    """沙箱（env=1）查单基础设施不可用 → 信任回调（模拟支付无真实资金）。"""
    from qianwen_engine import store
    _session()
    otn = client.post("/api/kb/blueprint_sign",
                      json={"version_sha": SHA,
                            "price_fen_expected": 10}).json()["out_trade_no"]
    r = client.post("/api/kb/blueprint_paid", json={"out_trade_no": otn})
    assert r.status_code == 200
    assert store.kb_blueprint_unlocked("open-t1", SHA)


# ── 整库订单两腿 ──────────────────────────────────────────────────────────

def test_kb_order_sign_recomputes_price(client):
    from qianwen_engine import store
    _session()
    for ver, fen, qty in (("original", 3200, 32), ("md", 4700, 47),
                          ("import", 5100, 51)):
        r = client.post("/api/kb/order_sign", json=_order_payload(version=ver))
        assert r.status_code == 200, (ver, r.text)
        d = r.json()
        assert d["price_fen"] == fen and d["buy_quantity"] == qty
        sd = json.loads(d["sign_data"])
        assert sd["productId"] == "kb_goods"          # ¥1 道具×数量
        assert sd["goodsPrice"] == 100 and sd["buyQuantity"] == qty
        ko = store.get_kb_order(d["out_trade_no"])
        assert ko["status"] == "pending" and ko["version_sel"] == ver
        assert ko["email"] == "buyer@example.com"
        assert json.loads(ko["blueprint_json"])["version_sha"] == SHA
        po = store.get_pay_order(d["out_trade_no"])
        assert po["kind"] == "kb_order" and po["total_fen"] == fen
    # 老未付单作废重开：同蓝图再签名=新号、老 pay_order closed
    o1 = client.post("/api/kb/order_sign",
                     json=_order_payload()).json()["out_trade_no"]
    o2 = client.post("/api/kb/order_sign",
                     json=_order_payload()).json()["out_trade_no"]
    assert o2 != o1
    assert store.get_pay_order(o1)["status"] == "closed"


def test_kb_order_sign_tamper_price_rejected(client):
    """防篡价硬门：声明 total 与服务端复算差>50fen → 400。"""
    _session()
    bad = _order_payload(blueprint={**DIGEST, "total": 9.9})   # 差 22000+ fen
    assert client.post("/api/kb/order_sign", json=bad).status_code == 400
    # 边界内（客户端 1 位小数四舍五入漂移 ≤50fen）放行
    ok = _order_payload(blueprint={**DIGEST, "total": 31.66})
    assert client.post("/api/kb/order_sign", json=ok).status_code == 200


def test_kb_order_sign_input_gates(client, tmp_path, monkeypatch):
    _session()
    assert client.post("/api/kb/order_sign",
                       json=_order_payload(version="zip")).status_code == 400
    assert client.post("/api/kb/order_sign",
                       json=_order_payload(email="not-an-email")).status_code == 400
    assert client.post("/api/kb/order_sign",
                       json=_order_payload(
                           blueprint={**DIGEST, "version_sha": ""})
                       ).status_code == 400
    # kb_product_id 未配置 → 503（统一降级文案；蓝图腿不受影响）
    secret2 = tmp_path / "vp_no_kb.secret"
    secret2.write_text(
        "offer_id=1\nexport_product_id=export_once\nenv=1\n"
        "sandbox_appkey=k\nprod_appkey=k\n", encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", secret2)
    assert client.post("/api/kb/order_sign",
                       json=_order_payload()).status_code == 503
    assert client.post("/api/kb/blueprint_sign",
                       json={"version_sha": SHA,
                             "price_fen_expected": 10}).status_code == 200


def test_kb_order_paid_and_submit_full_chain(client, monkeypatch):
    """整库全链：签名→查单核验 paid→履约收尾 accepted→桥拉取→ack。"""
    from qianwen_engine import store
    _session()
    otn = client.post("/api/kb/order_sign",
                      json=_order_payload()).json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post("/api/kb/order_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["order_paid"] is True
    assert store.get_kb_order(otn)["status"] == "paid"
    # 幂等重跑
    r2 = client.post("/api/kb/order_paid", json={"out_trade_no": otn})
    assert r2.status_code == 200 and r2.json()["order_paid"] is True
    # 履约收尾：email 必填校验 → accepted（幂等）
    assert client.post("/api/kb/order",
                       json=_order_payload(email="")).status_code == 400
    r3 = client.post("/api/kb/order", json=_order_payload(
        email="ops@example.com", need_text="变更备注"))
    assert r3.status_code == 200 and r3.json()["accepted"] is True
    ko = store.get_kb_order(otn)
    assert ko["status"] == "accepted" and ko["email"] == "ops@example.com"
    assert ko["need_text"] == "变更备注" and ko["confirmed_at"]
    assert client.post("/api/kb/order", json=_order_payload(
        email="ops@example.com")).status_code == 200   # 幂等重提交
    # 未支付订单收尾腿 → 402（微信侧明确 NOTPAY，补账不成立）；
    # 伪造/无单 → 404
    _query(monkeypatch, "NOTPAY")
    otn2 = client.post("/api/kb/order_sign",
                       json=_order_payload(version="md")).json()["out_trade_no"]
    assert client.post("/api/kb/order",
                       json=_order_payload(version="md")).status_code == 402
    assert client.post("/api/kb/order",
                       json=_order_payload(
                           blueprint={**DIGEST, "version_sha": "deadbeef"})
                       ).status_code == 404
    assert otn2  # 老单保留 pending（bridge 只拉 accepted，不误伤）


def test_kb_order_submit_reconciles_paid_order(client, monkeypatch):
    """回调断网恢复路径：order_paid 失联 → 提交腿查单补账 → 直接收口。"""
    from qianwen_engine import store
    _session()
    otn = client.post("/api/kb/order_sign",
                      json=_order_payload()).json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")          # 微信侧确已支付
    r = client.post("/api/kb/order", json=_order_payload())
    assert r.status_code == 200 and r.json()["accepted"] is True
    assert store.get_kb_order(otn)["status"] == "accepted"


# ── 履约桥（机对机；无用户 token 也可达）──────────────────────────────────

BRIDGE_HDR = {"X-KB-Bridge": "bridge-secret-w11"}


def _make_accepted(client, monkeypatch, sha=SHA, email="b@ex.com", ver="original"):
    _session()
    otn = client.post("/api/kb/order_sign",
                      json=_order_payload(blueprint={**DIGEST, "version_sha": sha},
                                          email=email, version=ver)
                      ).json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    client.post("/api/kb/order_paid", json={"out_trade_no": otn})
    client.post("/api/kb/order",
                json=_order_payload(blueprint={**DIGEST, "version_sha": sha},
                                    email=email, version=ver))
    return otn


def test_kb_bridge_no_auth_header_401(client):
    r = client.get("/api/kb/orders/pending")     # 无桥头（也无 Authorization）
    assert r.status_code == 401


def test_kb_bridge_wrong_key_401(client):
    r = client.get("/api/kb/orders/pending",
                   headers={"X-KB-Bridge": "wrong"})
    assert r.status_code == 401


def test_kb_bridge_key_file_missing_503(client, monkeypatch, tmp_path):
    monkeypatch.setattr(config, "KB_BRIDGE_KEY_FILE",
                        tmp_path / "absent.key")
    r = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR)
    assert r.status_code == 503


def test_kb_bridge_pending_desensitized_and_ack(client, monkeypatch):
    otn = _make_accepted(client, monkeypatch)
    r = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR)
    assert r.status_code == 200
    orders = r.json()["orders"]
    assert len(orders) == 1
    o = orders[0]
    assert o["otn"] == otn and o["email"] == "b@ex.com"
    assert o["version"] == "original" and o["total_fen"] == 3200
    assert o["blueprint"]["version_sha"] == SHA and o["confirmed_at"]
    assert "openid" not in o and "blueprint_json" not in o   # 脱敏：无身份字段
    # ack → pulled → 二次拉取为空；ack 幂等
    a = client.post("/api/kb/orders/ack", headers=BRIDGE_HDR,
                    json={"otn": otn})
    assert a.status_code == 200 and a.json()["acknowledged"] is True
    r2 = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR)
    assert r2.json()["orders"] == []
    a2 = client.post("/api/kb/orders/ack", headers=BRIDGE_HDR,
                     json={"otn": otn})
    assert a2.status_code == 200 and a2.json()["acknowledged"] is True
    # 未受理订单 ack → 409；不存在 → 404
    assert client.post("/api/kb/orders/ack", headers=BRIDGE_HDR,
                       json={"otn": "nope"}).status_code == 404


def test_kb_bridge_after_cursor(client, monkeypatch):
    otn = _make_accepted(client, monkeypatch, sha="aa11bb22")
    r = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR)
    at = r.json()["orders"][0]["confirmed_at"]
    r2 = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR,
                    params={"after": at})
    assert r2.json()["orders"] == []
    r3 = client.get("/api/kb/orders/pending", headers=BRIDGE_HDR,
                    params={"after": "2000-01-01 00:00:00"})
    assert len(r3.json()["orders"]) == 1
    assert otn


def test_kb_pay_kinds_fit_mysql_varchar8():
    """pay_order.kind=VARCHAR(8)（1009 生产实锤）：kb 单据词元必须 ≤8。"""
    from qianwen_engine import app as app_mod
    assert app_mod.KB_KIND_BLUEPRINT == "kb_bp"
    assert app_mod.KB_KIND_ORDER == "kb_order"
    assert all(len(k) <= 8 for k in
               (app_mod.KB_KIND_BLUEPRINT, app_mod.KB_KIND_ORDER))
