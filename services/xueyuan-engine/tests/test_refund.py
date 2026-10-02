# -*- coding: utf-8 -*-
"""退款双轨+L4 熔断单测（T-P1-05/06）：映射纯函数（70→¥348.60 字节级）、
Android 自动/人工双档、iOS 书券双轨、<50 感谢券、月度占额、黑名单、熔断
触发/恢复/已受理不中断、回调幂等、dev 假闸生产自拒。全流程真金通道全 mock。"""
from __future__ import annotations

import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND, THIRD  # noqa: E402

from xueyuan_engine import refund, store, wechat  # noqa: E402

BASE = ("第9章投资规模数据与我在江苏水网项目的实际经验不符，1.2亿的测算明显偏高，"
        "我觉得口径需要校准，建议补充资金流向分析。")
FILLER = "另外第3章的业主结构分析也应更贴近实际。"


def _crit(n: int) -> str:
    s = BASE
    while len(s) < n:
        s += FILLER
    return s[:n]


def _dev(monkeypatch):  # 假支付+假退款 dev 双闸（8872=dev 端口）
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")


def _settle_score(cid: str, final: float) -> None:  # 确定性分数覆写（映射断言用）
    with store._LOCK, store._db() as c:
        c.execute("UPDATE criticisms SET final_score=?, refund_tier=?, status='scored'"
                  " WHERE id=?", (final, refund.tier_label(final), cid))


def _paid_read_crit(client, buyer, pay_on, monkeypatch, rid=SECOND) -> str:
    """假支付+阅读+批评+等异步评分完成，返回 criticism_id。"""
    _dev(monkeypatch)
    out = client.post("/api/v1/pay/sign", json={"report_id": rid},
                      headers=buyer).json()["out_trade_no"]
    client.post("/api/v1/pay/callback", json={"outTradeNo": out,
                                              "transactionId": "wxsn-1"})
    client.get(f"/api/v1/reports/{rid}/chapters", headers=buyer)
    cid = client.post(f"/api/v1/reports/{rid}/criticize",
                      json={"content": _crit(80)}, headers=buyer).json()["criticism_id"]
    deadline = time.time() + 6
    while time.time() < deadline:
        d = client.get(f"/api/v1/criticisms/{cid}", headers=buyer).json()
        if d["status"] != "pending_score":
            return cid
        time.sleep(0.05)
    raise AssertionError("评分超时未回填")


def _seed_order(out: str, uid: str, rid: str, price: int, status: str,
                refund_state: str = "", platform: str = "android",
                env: int = 1, paid: bool = True) -> None:
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO orders(out_trade_no,user_id,report_id,price_fen,platform,"
            "env,status,refund_state,paid_at,created_at) VALUES(?,?,?,?,?,?,?,?,?,?)",
            (out, uid, rid, price, platform, env, status, refund_state,
             store.now() if paid else "", store.now()),
        )


def _seed_refund(rid_: str, out: str, uid: str, amount: int,
                 status: str = "settled") -> None:
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,tier,"
            "amount_fen,method,status,created_at) VALUES(?,?,?,?,?,?,?,?,?,?)",
            (rid_, out, "", uid, "android", "tier50", amount, "auto", status,
             store.now()),
        )


def _row(sql: str, *args):
    with store._db() as c:
        return c.execute(sql, args).fetchone()


# ── 层③映射纯函数（字节级锚点）──────────────────────────────────
def test_amount_mapping():
    assert refund.refund_amount_fen(70, 49800) == 34860   # ¥348.60（AGREEMENT 2.4 例）
    assert refund.refund_amount_fen(50, 49800) == 24900   # 50→50%
    assert refund.refund_amount_fen(100, 49800) == 49800  # 100→100%
    assert refund.refund_amount_fen(76.7, 49800) == 38197  # 线性含小数四舍五入
    assert refund.refund_amount_fen(49.9, 49800) == 0      # <50 不退
    assert refund.refund_amount_fen(0, 49800) == 0
    assert refund.refund_amount_fen(120, 1000) == 1000     # clamp 上限
    assert refund.refund_amount_fen(70, 0) == 0
    assert refund.tier_percent(76.7) == 76 and refund.tier_percent(49) == 0


# ── 双轨执行（Android 自动/人工 + iOS 书券）───────────────────────
def test_apply_requires_login_and_404(engine, client, buyer):
    assert client.post("/api/v1/refund/apply",
                       json={"criticism_id": "c1"}).status_code == 401
    r = client.post("/api/v1/refund/apply", json={"criticism_id": "ghost"},
                    headers=buyer)
    assert r.status_code == 404 and r.json()["code"] == "CRITICISM_NOT_FOUND"


def test_android_auto_low_tier_settles(engine, client, buyer, pay_on, monkeypatch):
    """≤50% 档自动退：tier50 → refund_order（dev 假闸）即时结+关权益+订单态。"""
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    body = r.json()
    assert r.status_code == 200
    assert (body["method"], body["status"], body["amount_fen"]) == ("auto", "settled", 24900)
    assert body["platform"] == "android" and body["tier"] == "tier50"
    row = _row("SELECT * FROM refunds WHERE id=?", body["refund_id"])
    assert row["wx_refund_sn"].startswith("fakeref-")
    out = _row("SELECT order_id FROM criticisms WHERE id=?", cid)["order_id"]
    order = _row("SELECT status,refund_state FROM orders WHERE out_trade_no=?", out)
    assert order["status"] == "refund_partial" and order["refund_state"] == "partial"
    assert _row("SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? AND"
                " source='purchase'", buyer["uid"], SECOND) is None  # 阅读权限关闭
    assert _row("SELECT refund_count_month FROM users WHERE id=?",
                buyer["uid"])["refund_count_month"] == 1


def test_android_70_manual_then_execute(engine, client, buyer, pay_on, monkeypatch):
    """GWT：得分 70（¥498）→Android 退 ¥348.60 且订单「已退款」。

    超 50% 档先转人工（AN#8），人工复核通过经 execute_refund 执行（运维位）。
    """
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 70)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    body = r.json()
    assert r.status_code == 200
    assert (body["method"], body["status"], body["amount_fen"]) == \
        ("manual", "initiated", 34860)  # ¥348.60
    assert body["ios_track"] is None
    out = _row("SELECT order_id FROM criticisms WHERE id=?", cid)["order_id"]
    assert _row("SELECT manual_review FROM criticisms WHERE id=?", cid)["manual_review"] == 1
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    res = refund.execute_refund(body["refund_id"])
    assert res["status"] == "settled" and res["already"] is False
    assert _row("SELECT amount_fen FROM refunds WHERE id=?",
                body["refund_id"])["amount_fen"] == 34860
    order = _row("SELECT status,refund_state FROM orders WHERE out_trade_no=?", out)
    assert order["refund_state"] == "partial"  # 70% 部分退款
    assert refund.execute_refund(body["refund_id"])["already"] is True  # 幂等


def test_ios_voucher_track(engine, client, buyer, pay_on, monkeypatch):
    """iOS 双轨：不可主动退→498×70%=34860 书券入账+苹果通道引导+关权益。"""
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    out = _row("SELECT order_id FROM criticisms WHERE id=?", cid)["order_id"]
    with store._LOCK, store._db() as c:
        c.execute("UPDATE orders SET platform='ios' WHERE out_trade_no=?", (out,))
    _settle_score(cid, 70)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    body = r.json()
    assert (body["method"], body["status"], body["amount_fen"]) == \
        ("voucher", "settled", 34860)
    assert body["ios_track"] and "苹果" in body["ios_track"]
    v = _row("SELECT amount_fen,source FROM vouchers WHERE source=?",
             "ios_refund")
    assert v["amount_fen"] == 34860
    assert _row("SELECT voucher_granted FROM refunds WHERE id=?",
                body["refund_id"])["voucher_granted"]
    assert _row("SELECT 1 FROM entitlements WHERE user_id=? AND report_id=?",
                buyer["uid"], SECOND) is None


def test_below_50_no_refund_thanks_voucher(engine, client, buyer, pay_on, monkeypatch):
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 40)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "SCORE_BELOW_THRESHOLD"
    v = _row("SELECT amount_fen,source FROM vouchers WHERE source_ref=?", cid)
    assert v["source"] == "criticism_thanks" and v["amount_fen"] == 500
    assert _row("SELECT COUNT(*) n FROM refunds WHERE criticism_id=?",
                cid)["n"] == 0  # 不建退款单


def test_apply_dup_409(engine, client, buyer, pay_on, monkeypatch):
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    assert client.post("/api/v1/refund/apply", json={"criticism_id": cid},
                       headers=buyer).status_code == 200
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    assert r.status_code == 409 and r.json()["code"] == "REFUND_DUP"


def test_auto_channel_not_ready_falls_back_manual(engine, client, buyer, pay_on,
                                                  monkeypatch):
    """生产真契约 TBD 自拒→自动降级人工不丢单（宁可不自动退）。"""
    monkeypatch.delenv("XY_FAKE_REFUND", raising=False)
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    body = r.json()
    assert r.status_code == 200 and body["method"] == "manual"
    assert body["status"] == "initiated"  # 丢单不丢：待人工执行


# ── L4 熔断（触发/恢复/黑名单）──────────────────────────────────
def _seed_fuse_prone_orders(rid: str) -> None:  # 3 付+买家 1 付+2 退=2/6=33%>25%
    for i in range(3):
        _seed_order(f"fo_{rid}_{i}", f"u{i}", rid, 49800, "paid")
    for i in range(2):
        _seed_order(f"fr_{rid}_{i}", f"u9{i}", rid, 49800, "refunded", "full")


def test_fuse_line_a_blocks_and_keeps_accepted(engine, client, buyer, pay_on,
                                               monkeypatch):
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    _seed_fuse_prone_orders(SECOND)
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    _seed_refund("rFuse1", "fr_" + SECOND + "_0", "u90", 24900, "initiated")
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    assert r.status_code == 423 and r.json()["code"] == "FUSE_OPEN"
    fuse = _row("SELECT opened,reason FROM fuse_state WHERE key=?", f"report:{SECOND}")
    assert fuse["opened"] == 1 and "退款率" in fuse["reason"]
    # 已受理的不中断：熔断打开下存量 initiated 单仍可执行（义务继续履行）
    assert refund.execute_refund("rFuse1")["status"] == "settled"
    # 再申请仍被拦（新发起停）
    assert client.post("/api/v1/refund/apply", json={"criticism_id": cid},
                       headers=buyer).status_code == 423


def test_fuse_reset_recovers(engine, client, buyer, pay_on, monkeypatch):
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    _seed_fuse_prone_orders(SECOND)
    assert client.post("/api/v1/refund/apply", json={"criticism_id": cid},
                       headers=buyer).status_code == 423
    assert refund.reset_fuse(f"report:{SECOND}") is True  # 人工恢复
    assert _row("SELECT opened FROM fuse_state WHERE key=?",
                f"report:{SECOND}")["opened"] == 0
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    assert client.post("/api/v1/refund/apply", json={"criticism_id": cid},
                       headers=buyer).status_code == 200


def test_fuse_line_b_global_week(engine, client, buyer, pay_on, monkeypatch):
    """/周退款额>营收15%（env=0 正式单口径；沙箱 env=1 不进营收）。"""
    _seed_order("gw_rev1", "uA", PILOT, 1000, "paid", env=0)   # 营收 1000
    _seed_refund("gw_ref1", "gw_rev1", "uA", 200)               # 退款 200=20%>15%
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch, rid=THIRD)
    _settle_score(cid, 50)
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    assert r.status_code == 423  # 全站线拦（global）
    assert _row("SELECT opened FROM fuse_state WHERE key='global'")["opened"] == 1


def test_blacklist_history_ratio(engine, client, buyer, pay_on, monkeypatch):
    """历史退款率>30%（1/2=50%）→黑名单→method=manual（内部判据不外泄）。"""
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    out = _row("SELECT order_id FROM criticisms WHERE id=?", cid)["order_id"]
    _seed_order("bl_1", buyer["uid"], PILOT, 990, "refunded", "full")
    _settle_score(cid, 50)
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    r = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    assert r.status_code == 200 and r.json()["method"] == "manual"
    assert _row("SELECT is_blacklisted FROM users WHERE id=?",
                buyer["uid"])["is_blacklisted"] == 1
    assert out  # 批评关联订单在库


# ── 回调（P1-5）与 dev 假闸生产自拒 ─────────────────────────────
def test_refund_callback_gate_and_idempotent(engine, client, buyer, pay_on, monkeypatch):
    cid = _paid_read_crit(client, buyer, pay_on, monkeypatch)
    _settle_score(cid, 50)
    r1 = client.post("/api/v1/refund/apply", json={"criticism_id": cid}, headers=buyer)
    rid = r1.json()["refund_id"]
    out = _row("SELECT order_id FROM criticisms WHERE id=?", cid)["order_id"]
    no_gate = client.post("/api/v1/refund/callback", json={"outTradeNo": out})
    assert no_gate.status_code == 501 and no_gate.json()["code"] == \
        "REFUND_CALLBACK_VERIFY_NOT_READY"
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    c1 = client.post("/api/v1/refund/callback",
                     json={"outTradeNo": out, "refundId": "wxrn-1"})
    assert c1.status_code == 200 and c1.json()["first"] is True
    c2 = client.post("/api/v1/refund/callback", json={"outTradeNo": out})
    assert c2.status_code == 200 and c2.json()["first"] is False  # 幂等重放
    row = _row("SELECT status,wx_refund_sn FROM refunds WHERE id=?", rid)
    assert row["status"] == "settled" and row["wx_refund_sn"] == "wxrn-1"
    raw = _row("SELECT raw_notify FROM orders WHERE out_trade_no=?", out)["raw_notify"]
    assert "refund_notify" in raw  # 回调原文快照并入对账


def test_refund_callback_bad_payload(engine, client, monkeypatch):
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    assert client.post("/api/v1/refund/callback",
                       content=b"not-json").status_code == 400
    r = client.post("/api/v1/refund/callback", json={"foo": 1})
    assert r.status_code == 400 and r.json()["code"] == "INVALID_CALLBACK"
    assert client.post("/api/v1/refund/callback",
                       json={"outTradeNo": "ghost_1"}).status_code == 404


def test_wechat_refund_order_dev_gate(engine, monkeypatch):
    """refund_order 封装三态：无闸自拒（TBD）/dev 假回执/生产端口自拒。"""
    monkeypatch.delenv("XY_FAKE_REFUND", raising=False)
    with pytest.raises(RuntimeError, match="自拒"):
        wechat.refund_order("o1", 100)
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    monkeypatch.setenv("XY_PORT", "8872")
    sn = wechat.refund_order("o1", 34860)
    assert sn.startswith("fakeref-") and len(sn) == len("fakeref-") + 16
    monkeypatch.setenv("XY_PORT", "8871")  # 生产端口=拒绝执行（同 XY_FAKE_PAY 纪律）
    with pytest.raises(RuntimeError, match="拒绝执行"):
        wechat.refund_order("o1", 100)


# ── 边角分支（书券幂等/闸矩阵/客诉/执行腿/熔断标记回收）────────────
def test_grant_voucher_and_thanks_edges(engine):
    assert refund.grant_voucher("u1", 0, "x", "r0") == ""  # 非正数→不发
    v1 = refund.grant_voucher("u1", 500, "criticism_thanks", "edge1")
    assert refund.grant_voucher("u1", 900, "criticism_thanks", "edge1") == v1  # 幂等


def test_apply_gate_matrix_and_complaint(engine, client, buyer, monkeypatch):
    r = client.post("/api/v1/refund/apply", json={}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "INVALID_PARAM"
    with store._LOCK, store._db() as c:
        for cid, st, rep in (("cPend", "pending_score", "rg1"),
                             ("cMan", "manual_pending", "rg2"),
                             ("cClosed", "closed", "rg3")):
            c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                      "char_count,read_verified,status,created_at)"
                      " VALUES(?,?,?,?,?,?,1,?,?)",
                      (cid, buyer["uid"], rep, "oX", "x", 1, st, store.now()))
    for cid, code, want in (("cPend", "SCORE_NOT_READY", 400),
                            ("cMan", "MANUAL_REVIEW_PENDING", 409),
                            ("cClosed", "CRITICISM_CLOSED", 409)):
        r = client.post("/api/v1/refund/apply", json={"criticism_id": cid},
                        headers=buyer)
        assert r.status_code == want and r.json()["code"] == code
    with store._LOCK, store._db() as c:  # 已评分但订单缺失→404
        c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                  "char_count,read_verified,anchor_score,llm_scores,final_score,"
                  "refund_tier,status,created_at) VALUES('cOrph',?,?,?,'x',1,1,0,"
                  "'{}',70,'tier70','scored',?)",
                  (buyer["uid"], "rg4", "oGhost", store.now()))
    r = client.post("/api/v1/refund/apply", json={"criticism_id": "cOrph"},
                    headers=buyer)
    assert r.status_code == 404 and r.json()["code"] == "ORDER_NOT_FOUND"
    _seed_order("cp1", buyer["uid"], PILOT, 990, "paid")
    r = client.post("/api/v1/refund/apply",
                    json={"order_id": "cp1", "reason": "客诉测试"}, headers=buyer)
    body = r.json()
    assert r.status_code == 200 and body["method"] == "manual"  # 客诉无评分一律人工
    assert body["amount_fen"] == 990 and body["tier"] == "custom"


def test_thanks_fen_env_invalid(engine, monkeypatch):
    monkeypatch.setenv("XY_THANKS_VOUCHER_FEN", "bad")
    assert refund._thanks_fen() == 500  # 坏值→默认面值


def test_execute_refund_edges(engine):
    with pytest.raises(Exception, match="退款单不存在"):
        refund.execute_refund("ghost")
    _seed_order("ex_o", "u1", PILOT, 990, "paid")
    with store._LOCK, store._db() as c:  # 非 android（iOS 书券轨）→不执行不报错
        c.execute("INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,tier,"
                  "amount_fen,method,status,created_at) VALUES('ex_ios','ex_o','','u1',"
                  "'ios','custom',990,'voucher','initiated',?)", (store.now(),))
    res = refund.execute_refund("ex_ios")
    assert res["already"] is False and res["status"] == "initiated"
    _seed_refund("ex_gh", "ghost_order", "u1", 100, "initiated")  # android 订单缺失
    with pytest.raises(Exception, match="订单不存在"):
        refund.execute_refund("ex_gh")


def test_callback_raw_merge_bad_json(engine, client, monkeypatch):
    monkeypatch.setenv("XY_FAKE_REFUND", "1")
    _seed_order("cb_o", "u1", PILOT, 990, "paid")
    with store._LOCK, store._db() as c:
        c.execute("UPDATE orders SET raw_notify='not-json' WHERE out_trade_no='cb_o'")
        c.execute("INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,tier,"
                  "amount_fen,method,status,created_at) VALUES('cb_r','cb_o','','u1',"
                  "'android','tier50',495,'manual','initiated',?)", (store.now(),))
    r = client.post("/api/v1/refund/callback",
                    json={"outTradeNo": "cb_o", "refundId": "wxrn-9"})
    assert r.status_code == 200 and r.json()["first"] is True  # 原文合并失败不阻塞


def test_fuse_marker_cleared_after_ratio_recovers(engine):
    _seed_order("mk_paid1", "u1", "rep_mk", 990, "paid")
    _seed_order("mk_paid2", "u2", "rep_mk", 990, "paid")
    _seed_order("mk_ref1", "u3", "rep_mk", 990, "refunded", "full")
    assert refund.evaluate_fuses("rep_mk") == ["report:rep_mk"]  # 1/3=33%>25%
    assert refund.reset_fuse("report:rep_mk") is True
    assert refund.evaluate_fuses("rep_mk") == []  # 人工放行：比例未回落不重开
    with store._LOCK, store._db() as c:
        c.execute("UPDATE orders SET refund_state='' WHERE out_trade_no='mk_ref1'")
    assert refund.evaluate_fuses("rep_mk") == []
    row = _row("SELECT opened,reason FROM fuse_state WHERE key=?", "report:rep_mk")
    assert row["opened"] == 0 and row["reason"] == ""  # 比例回落→清放行标记
