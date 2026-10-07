# -*- coding: utf-8 -*-
"""pay/server 比例退款+反馈取证 单测 — F5a-2 (真实可信协议/状态机/签名).

覆盖: ①grade_feedback 五档 ②apply_refund 状态机 (部分退保留阅读权/满额吊销)
③auto_refund 护栏 (态门/次数门/封顶/渠道 mock) ④_full_sig 签名对错+吊销拒.
"""
from __future__ import annotations

import sqlite3
import sys
import types
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import pay as PAY   # noqa: E402


def _db() -> sqlite3.Connection:
    con = sqlite3.connect(":memory:")
    con.execute("CREATE TABLE orders(id INTEGER PRIMARY KEY, created TEXT, "
                "sku TEXT, order_no TEXT, contact TEXT, note TEXT, "
                "state TEXT DEFAULT 'pending')")
    PAY.ensure_columns(con)
    PAY.ensure_feedback_table(con)
    return con


def _paid(con, no="T001", price=199900, state="paid"):
    con.execute("INSERT INTO orders(created,sku,order_no,contact,note,state,"
                "access_token,channel) VALUES('t','R50-SNEI',?,'c','','"
                + state + "','tok123','wxpay')", (no,))
    con.execute("INSERT INTO pay_amounts(order_no,price) VALUES(?,?)",
                (no, price))


def _mock_channel(ok=True):
    """渠道 mock: 拦截 wx_refund 真网络."""
    calls = []

    def fake(w, out_trade_no, refund_no, refund_fen, total_fen, reason):
        calls.append((refund_no, refund_fen))
        return ({"ok": True, "refund_id": "rf_" + refund_no} if ok else
                {"ok": False, "error": "wx 500: mock fail"})
    PAY.wx_refund = fake
    return calls


# ------------------------------------------------ ① grade 分档
def test_01_grade_tiers():
    g = PAY.grade_feedback(1, "quality", "第7章数据缺失,与描述不符")
    assert g["pct"] == 100 and g["severity"] == "high"
    g = PAY.grade_feedback(2, "quality", "引用的数据不对,过时了")
    assert g["pct"] == 40 and g["severity"] == "medium"
    g = PAY.grade_feedback(2, "quality", "整体不满意")
    assert g["pct"] == 40
    g = PAY.grade_feedback(3, "quality", "个别图表有错误")
    assert g["pct"] == 20 and g["severity"] == "light"
    g = PAY.grade_feedback(5, "quality", "很好")
    assert g["pct"] == 0
    g = PAY.grade_feedback(1, "suggest", "希望增加海外案例")
    assert g["pct"] == 0 and g["severity"] == "none"


# ------------------------------------------------ ② apply_refund 状态机
def test_02_partial_keeps_reading():
    con = _db()
    _paid(con)
    calls = _mock_channel()
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    r = PAY.auto_refund(con, sec, "T001", "局部缺陷", pct=40)
    assert r["ok"] and r["refund_fen"] == 79960 and len(calls) == 1
    st = con.execute("SELECT state,access_token,refunded_fen,refund_rounds "
                     "FROM orders WHERE order_no='T001'").fetchone()
    assert st[0] == "partial_refunded" and st[1] == "tok123"   # 阅读权保留
    assert st[2] == 79960 and st[3] == 1


def test_03_full_revokes_token():
    con = _db()
    _paid(con)
    _mock_channel()
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    assert PAY.auto_refund(con, sec, "T001", "严重", pct=100)["ok"]
    st = con.execute("SELECT state,access_token,refunded_fen "
                     "FROM orders WHERE order_no='T001'").fetchone()
    assert st[0] == "refunded" and st[1] == "" and st[2] == 199900


def test_04_accumulate_caps_at_total():
    con = _db()
    _paid(con)
    _mock_channel()
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    assert PAY.auto_refund(con, sec, "T001", "a", pct=40)["ok"]
    assert PAY.auto_refund(con, sec, "T001", "b", pct=40)["ok"]   # 累计 80%
    r = PAY.auto_refund(con, sec, "T001", "c", pct=40)            # 只剩 20%
    assert r["ok"] and r["refund_fen"] == 199900 * 20 // 100
    st = con.execute("SELECT state,refunded_fen FROM orders "
                     "WHERE order_no='T001'").fetchone()
    assert st[0] == "refunded" and st[1] == 199900                # 封顶实付


# ------------------------------------------------ ③ 护栏
def test_05_guards():
    con = _db()
    _mock_channel()
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    assert not PAY.auto_refund(con, sec, "NOPE", "x")["ok"]      # 订单不存在
    _paid(con, "T002", state="pending")
    assert not PAY.auto_refund(con, sec, "T002", "x")["ok"]      # 非 paid 族
    _paid(con, "T003")
    for _ in range(PAY.MAX_REFUND_ROUNDS):
        assert PAY.auto_refund(con, sec, "T003", "x", pct=10)["ok"]
    r = PAY.auto_refund(con, sec, "T003", "x", pct=10)           # 次数门
    assert not r["ok"] and "上限" in r["error"]


def test_06_channel_fail_no_state_change():
    con = _db()
    _paid(con)
    _mock_channel(ok=False)
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    r = PAY.auto_refund(con, sec, "T001", "x", pct=40)
    assert not r["ok"]
    st = con.execute("SELECT state,refunded_fen FROM orders "
                     "WHERE order_no='T001'").fetchone()
    assert st == ("paid", 0)                                     # 渠道败=零状态变化


def test_07_refund_no_unique_per_round():
    con = _db()
    _paid(con)
    calls = _mock_channel()
    sec = {"wxpay": {"_ok": True}, "alipay": None}
    PAY.auto_refund(con, sec, "T001", "a", pct=10)
    PAY.auto_refund(con, sec, "T001", "b", pct=10)
    assert calls[0][0] != calls[1][0]                           # R1/R2 唯一


# ------------------------------------------------ ④ 读者签名
def test_08_bare_ini_stub():
    """裸键/损坏 secret.ini → 全 stub 不崩 (真因: admin_token 裸键格式)."""
    import tempfile
    orig = PAY.INI
    try:
        f = Path(tempfile.mkstemp(suffix=".ini")[1])
        f.write_text("admin_token=abc123\n", encoding="utf-8")
        PAY.INI = f
        sec = PAY.load_secrets()
        assert sec == {"notify_base": "", "wxpay": None, "alipay": None}
        assert PAY.pay_ready(sec) == {"wxpay": False, "alipay": False}
        f.write_text("[wxpay]\nmchid=x\n[broken", encoding="utf-8")
        sec = PAY.load_secrets()                       # 截断段也不崩
        assert isinstance(sec, dict)
    finally:
        PAY.INI = orig


def test_08b_full_sig():
    import server as SV
    assert SV._full_sig("T001", "tok123") == SV._full_sig("T001", "tok123")
    assert SV._full_sig("T001", "tok123") != SV._full_sig("T001", "tok999")
    assert len(SV._full_sig("T001", "tok123")) == 32
    assert SV._qesc("weixin://wxpay/br?a=1&b=2") == \
        "weixin%3A%2F%2Fwxpay%2Fbr%3Fa%3D1%26b%3D2"


def test_09_feedback_evidence_columns():
    con = _db()
    _paid(con)
    PAY.save_feedback(con, "T001", "R50-SNEI", 2, "7.2 节", "quality",
                      "数据缺失", severity="high", refund_pct=100,
                      read_verified=True)
    row = con.execute("SELECT severity,refund_pct,read_verified,action "
                      "FROM feedback WHERE order_no='T001'").fetchone()
    assert row == ("high", 100, 1, "refund")


if __name__ == "__main__":
    fns = [v for k, v in sorted(globals().items())
           if k.startswith("test_") and callable(v)]
    fail = 0
    for fn in fns:
        try:
            fn()
            print(f"  PASS {fn.__name__}")
        except Exception as e:
            fail += 1
            print(f"  FAIL {fn.__name__}: {type(e).__name__}: {e}")
    print(f"\n{len(fns) - fail}/{len(fns)} passed")
    sys.exit(1 if fail else 0)
