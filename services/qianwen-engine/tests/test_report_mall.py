# -*- coding: utf-8 -*-
"""v0.9.0 报告商城六腿（用户令 1008：研究报告售卖整合进总包AI顾问）。

覆盖：
- 目录可售判定：无 PDF（BLUEBOOK 预售类）/ 超大 PDF（TOPIC-06 事故类）→ 整理中
- 公开浏览（软鉴权）：未登录可看目录/详情/试读，unlocked 恒 false
- 签名腿：价格分档道具（report_product_<元>）、签名即落单 kind='report' aid=sku、
  老未付单作废重开（用户令 1009：不保留待支付态）、已解锁 409、未配档 503、未售 404
- 回调腿：查单 SUCCESS 放行 / NOTPAY 400 / 伪造 otn 404 / 他人单 404 /
  幂等重跑；沙箱查单不可用信任回调；生产 fail-closed 503
- PDF 闸门：未购 402 / 已购 200 application/pdf / 他人已购不越权
- 已付补标记恢复路径（回调断网 → 重点签名 → 409 收口）
运行：python -m pytest tests/test_report_mall.py -q
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, report_catalog, wechat  # noqa: E402


def _mk_content(cdir: Path) -> None:
    """迷你目录（cdir=内容根）：A(498 可售) B(1999 可售) NOPDF(598 无pdf) HUGE(698 超限pdf)。"""
    (cdir / "full").mkdir(parents=True)
    (cdir / "sample").mkdir(parents=True)

    def _r(sku, price, title):
        return {"sku": sku, "title": title, "subtitle": title + "副题",
                "price": price, "price_label": f"¥{price}", "words_wan": 5,
                "badges": ["全渠道"], "cat": "ent", "cat_name": "企业研究",
                "intro_lede": title + "导语", "intro": "简介" * 10,
                "audience": "工程总承包从业者",
                "chapters": [{"id": 1, "title": "第一章", "desc": "章述"}],
                "sample_file": f"{sku.lower()}.md", "sample_label": "试读"}

    reports = {
        "reports": [
            _r("SKU-A", 498, "甲报告"), _r("SKU-B", 1999, "乙报告"),
            _r("NOPDF", 598, "预售报告"), _r("HUGE", 698, "巨物报告"),
        ]
    }
    (cdir / "report.json").write_text(
        json.dumps(reports, ensure_ascii=False), encoding="utf-8")
    (cdir / "full" / "SKU-A.pdf").write_bytes(b"%PDF-1.4 " + b"a" * 40)
    (cdir / "full" / "SKU-B.pdf").write_bytes(b"%PDF-1.4 " + b"b" * 40)
    (cdir / "full" / "HUGE.pdf").write_bytes(b"%PDF-1.4 " + b"h" * 200)
    (cdir / "sample" / "sku-a.md").write_text("# 试读\n正文" * 3, encoding="utf-8")
    (cdir / "sample" / "sku-b.md").write_text("# 试读B", encoding="utf-8")


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    _mk_content(tmp_path / "content")
    monkeypatch.setattr(config, "REPORT_CONTENT_DIR", tmp_path / "content")
    monkeypatch.setattr(config, "REPORT_PDF_MAX_BYTES", 100)   # HUGE(>100B)=整理中
    report_catalog._CACHE.update({"mtime": 0.0, "reports": [], "by_sku": {}})
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    monkeypatch.setattr(wechat, "msg_sec_check", lambda content, openid, scene=2: True)
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: (_ for _ in ()).throw(
                            wechat.XpayError("test: query infra unavailable")))

    secret = tmp_path / "virtual_pay.secret"
    secret.write_text(
        "offer_id=1450664233\n"
        "product_id=unlock_once_legacy\n"
        "export_product_id=export_once\n"
        "report_product_498=report_498\n"
        "report_product_1999=report_1999\n"
        "env=1\n"
        "sandbox_appkey=test-sandbox-appkey\n"
        "prod_appkey=test-prod-appkey\n",
        encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", secret)

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _sess():
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")


def _query(monkeypatch, status):
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: {"errcode": 0,
                                         "order": {"status": status}})


# ── 目录与可售判定 ──

def test_catalog_sellability(client):
    d = client.get("/api/reports").json()
    by = {r["sku"]: r for r in d["reports"]}
    assert len(d["reports"]) == 4                       # 全量展示（整理中也可见）
    assert by["SKU-A"]["sellable"] and by["SKU-B"]["sellable"]
    assert by["NOPDF"]["sellable"] is False             # 无 PDF（预售类）
    assert by["HUGE"]["sellable"] is False              # 超大 PDF（TOPIC-06 事故类）
    assert all(r["unlocked"] is False for r in d["reports"])  # 未购目录态
    # 大字段不进目录（intro 只走详情腿）
    assert "intro" not in by["SKU-A"] and "chapters" not in by["SKU-A"]


def test_catalog_public_browse_without_login(client):
    """软鉴权：未登录可浏览目录（漏斗前宽），解锁态恒 false。"""
    r = client.get("/api/reports", headers={"Authorization": ""})
    assert r.status_code == 200
    r2 = client.get("/api/report/SKU-A", headers={"Authorization": ""})
    assert r2.status_code == 200 and r2.json()["unlocked"] is False
    assert client.get("/api/report/SKU-A/sample").status_code == 200


def test_detail_and_sample(client):
    d = client.get("/api/report/SKU-A").json()
    assert d["price"] == 498 and d["cat_name"] == "企业研究"
    assert d["chapters"] and d["audience"] and d["sample_label"] == "试读"
    assert client.get("/api/report/NOPE").status_code == 404
    s = client.get("/api/report/SKU-A/sample").json()
    assert "试读" in s["text"]
    assert client.get("/api/report/SKU-B/sample").status_code == 200
    # 无试读文件（fixture 未写）→ 404 试读整理中（NOPDF 同理不 500）
    assert client.get("/api/report/NOPDF/sample").status_code == 404


# ── 签名腿 ──

def test_unlock_sign_creates_order(client):
    from qianwen_engine import store
    _sess()
    r = client.post("/api/report/SKU-A/unlock_sign")
    assert r.status_code == 200
    d = r.json()
    assert d["mode"] == "short_series_goods" and d["price_fen"] == 49800
    sd = json.loads(d["sign_data"])
    assert sd["productId"] == "report_498"              # 价格分档道具
    assert sd["buyQuantity"] == 1 and sd["goodsPrice"] == 49800
    assert sd["outTradeNo"].startswith("r")
    o = store.get_pay_order(d["out_trade_no"])
    assert o and o["kind"] == "report" and o["aid"] == "SKU-A"
    assert o["buy_quantity"] == 1 and o["total_fen"] == 49800
    # 1999 档走另一道具
    sd2 = json.loads(client.post("/api/report/SKU-B/unlock_sign").json()["sign_data"])
    assert sd2["productId"] == "report_1999" and sd2["goodsPrice"] == 199900


def test_unlock_sign_gates(client):
    from qianwen_engine import store
    _sess()
    # 整理中（无 PDF / 超大 PDF）→ 404
    assert client.post("/api/report/NOPDF/unlock_sign").status_code == 404
    assert client.post("/api/report/HUGE/unlock_sign").status_code == 404
    assert client.post("/api/report/NOPE/unlock_sign").status_code == 404
    # 未配档价位（598 无道具）→ 503
    assert client.post("/api/report/NOPDF/unlock_sign").status_code == 404  # 未售先挡
    # 已解锁 → 409
    store.mark_report_paid("open-t1", "SKU-A", "r-paid-0001")
    assert client.post("/api/report/SKU-A/unlock_sign").status_code == 409
    # 无 session_key → 401（客户端静默重登后重试）
    store.save_session("open-t1", "")
    assert client.post("/api/report/SKU-B/unlock_sign").status_code == 401


def test_unlock_sign_price_without_product_503(client, tmp_path, monkeypatch):
    """可售但该价位未配道具 → 503（未开售，不是 500）。"""
    from qianwen_engine import store
    _sess()
    secret = tmp_path / "vp2.secret"
    secret.write_text("offer_id=1\nreport_product_498=report_498\nenv=1\n"
                      "sandbox_appkey=k\nprod_appkey=k\n", encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", secret)
    assert client.post("/api/report/SKU-B/unlock_sign").status_code == 503   # 1999 未配
    assert client.post("/api/report/SKU-A/unlock_sign").status_code == 200   # 498 在


def test_sign_cancels_open_order_mints_fresh(client):
    """用户令 1009（不保留待支付态，想买重新下单）：重复签名=老未付单作废 +
    新号重开——绝不复用已取消 otn。真机缺陷根因锚：首单取消后微信侧订单已关
    （ORDER_CLOSED -15012），本地若继续复用同号，支付面板永远拉不起。
    fixture 查单默认抛 XpayError（查不出）→ 也必须作废重开（fail-safe 新号）。"""
    from qianwen_engine import store
    _sess()
    o1 = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    o2 = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    assert o2 != o1                                      # 重新下单必新号
    assert store.get_pay_order(o1)["status"] == "closed"   # 老单作废
    assert store.get_pay_order(o2)["status"] == "signed"      # 新单在途
    o3 = client.post("/api/report/SKU-B/unlock_sign").json()["out_trade_no"]
    assert o3 not in (o1, o2)                             # 不同报告不同号


def test_unlock_sign_reconciles_paid_old_order(client, monkeypatch):
    """老单微信侧确已支付（回调丢失）→ 查单补账 + 409 收口（已扣款必解锁，
    防二次扣款——作废重开仅针对未付单）。"""
    from qianwen_engine import store
    _sess()
    o1 = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post("/api/report/SKU-A/unlock_sign")
    assert r.status_code == 409 and "已解锁" in r.json()["detail"]
    assert store.get_pay_order(o1)["status"] == "paid"
    assert "SKU-A" in store.report_unlocked_skus("open-t1")


# ── 回调腿 ──

def test_unlock_paid_full_flow_and_pdf_gate(client, monkeypatch):
    from qianwen_engine import store
    _sess()
    # 未购 → PDF 402
    r402 = client.get("/api/report/SKU-A/pdf")
    assert r402.status_code == 402
    otn = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post("/api/report/SKU-A/unlock_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["unlocked"] is True
    # PDF 放行（application/pdf，文件名字面量）
    pdf = client.get("/api/report/SKU-A/pdf")
    assert pdf.status_code == 200
    assert pdf.headers["content-type"].startswith("application/pdf")
    assert pdf.content.startswith(b"%PDF-1.4")
    # 幂等重跑
    assert client.post("/api/report/SKU-A/unlock_paid",
                       json={"out_trade_no": otn}).status_code == 200
    # 目录/详情解锁态翻转
    by = {x["sku"]: x for x in client.get("/api/reports").json()["reports"]}
    assert by["SKU-A"]["unlocked"] is True and by["SKU-B"]["unlocked"] is False
    assert client.get("/api/report/SKU-A").json()["unlocked"] is True
    with store._db() as c:
        rows = c.execute("SELECT * FROM pay_log WHERE aid='SKU-A'").fetchall()
    assert len(rows) == 1 and rows[0]["out_trade_no"] == otn
    assert store.get_pay_order(otn)["status"] == "paid"


def test_unlock_paid_forged_and_cross_user(client, monkeypatch):
    _sess()
    _query(monkeypatch, "SUCCESS")          # 查单通配 SUCCESS 也不放行无单者
    assert client.post("/api/report/SKU-A/unlock_paid",
                       json={"out_trade_no": "r-forged-00001"}).status_code == 404
    assert client.post("/api/report/SKU-A/unlock_paid",
                       json={"out_trade_no": ""}).status_code == 404
    otn = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    assert client.post("/api/report/SKU-A/unlock_paid", headers=t2,
                       json={"out_trade_no": otn}).status_code == 404   # 他人单
    assert client.get("/api/report/SKU-A/pdf", headers=t2).status_code == 402
    assert client.get("/api/report/SKU-A/pdf").status_code == 402       # 本人仍未购


def test_unlock_paid_notpay_400(client, monkeypatch):
    _sess()
    otn = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    _query(monkeypatch, "NOTPAY")
    assert client.post("/api/report/SKU-A/unlock_paid",
                       json={"out_trade_no": otn}).status_code == 400
    assert client.get("/api/report/SKU-A/pdf").status_code == 402


def test_sandbox_trust_and_prod_fail_closed(client, monkeypatch, tmp_path):
    _sess()
    otn = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    # 沙箱查单不可用（fixture 默认抛 XpayError）→ 信任回调
    r = client.post("/api/report/SKU-A/unlock_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and client.get("/api/report/SKU-A/pdf").status_code == 200

    otn2 = client.post("/api/report/SKU-B/unlock_sign").json()["out_trade_no"]
    prod = tmp_path / "prod.secret"
    prod.write_text("offer_id=1\nreport_product_1999=report_1999\nenv=0\n"
                    "sandbox_appkey=k\nprod_appkey=k\n", encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", prod)
    r2 = client.post("/api/report/SKU-B/unlock_paid", json={"out_trade_no": otn2})
    assert r2.status_code == 503                          # 生产 fail-closed
    assert client.get("/api/report/SKU-B/pdf").status_code == 402


def test_sign_recovery_marks_paid_409(client, monkeypatch):
    """已扣款未标记（回调断网）→ 重点签名 → 查单补标记 + 409 收口。"""
    from qianwen_engine import store
    _sess()
    otn = client.post("/api/report/SKU-A/unlock_sign").json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post("/api/report/SKU-A/unlock_sign")
    assert r.status_code == 409 and "已解锁" in r.json()["detail"]
    assert store.get_pay_order(otn)["status"] == "paid"
    assert client.get("/api/report/SKU-A/pdf").status_code == 200


def test_pdf_gates_unsellable_and_missing(client):
    _sess()
    assert client.get("/api/report/NOPDF/pdf").status_code == 404
    assert client.get("/api/report/HUGE/pdf").status_code == 404
    assert client.get("/api/report/NOPE/pdf").status_code == 404
