# -*- coding: utf-8 -*-
"""v0.8.0 导出收费·对抗审计版（用户令 1008+1008「不容许遗留任何问题」）。

四腿端点 + 订单核验矩阵（审计 CRITICAL-1/2、HIGH-3、MEDIUM-4/5、LOW-6 全锚定）：
- login 真路径落 session_key（盲区#1：此前 fixture 手工 save_session 替学生答题）
- 签名即落单 pay_order；老未付单作废重开（用户令 1009：不保留待支付态）+ 已付补账 409 收口
- 回调腿凭订单 + 微信查单核验：SUCCESS 放行 / NOTPAY 400 / 生产查不出 503 fail-closed
  / 沙箱查单不可用信任回调（模拟支付无真实资金）
- 伪造 otn / 空串 / 他人订单 → 404（盲区#2：零支付解锁死路）
- 批量快照制：签名后新完成的咨询不被顺带解锁（盲区#3）
- otn 熵：同毫秒两单不同号（盲区#5 半）；批量锚点=openid 哈希非明文
- /api/history 权威计数 export_unpaid_all（盲区#6）
- 仅 pending 用户 export_all_sign → 404（盲区#7）
- QW_DEV_LOGIN 开发登录无 session_key → 签名腿 401（盲区#8）
运行：python -m pytest tests/test_export_pay.py -q
"""
from __future__ import annotations

import json
import re
import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config, metaso_kb, wechat, zhipu  # noqa: E402


def _kb_answer(q):
    return metaso_kb.KbAnswer(
        question=q, answer="结论[[书†1]]" + "详" * 300,
        cid="123456789012345678",
        url="https://metaso.cn/x",
        citations=[{"n": 1, "source": "测试规范", "loc": 12}],
        elapsed_sec=14.0)


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod, store

    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    store._init_done = False

    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": f"open-{code}", "unionid": ""})
    monkeypatch.setattr(wechat, "msg_sec_check", lambda content, openid, scene=2: True)
    monkeypatch.setattr(metaso_kb, "ask", lambda q, model="fast", sleep=None, on_event=None: _kb_answer(q))
    monkeypatch.setattr(metaso_kb, "_guard_enter", lambda cost=3: None)
    monkeypatch.setattr(metaso_kb, "_record", lambda ok: None)
    monkeypatch.setattr(zhipu, "configured", lambda: False)
    monkeypatch.setattr(zhipu, "rewrite", lambda prompt: (_ for _ in ()).throw(
        RuntimeError("测试默认禁用 zhipu")))
    # 查单腿默认=基础设施不可达（沙箱信任路径）；逐测试用例按需覆写应答
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: (_ for _ in ()).throw(
                            wechat.XpayError("test: query infra unavailable")))

    # 虚拟支付配置：tmp secret 文件（export_once 道具 + 沙箱键）
    secret = tmp_path / "virtual_pay.secret"
    secret.write_text(
        "offer_id=1450664233\n"
        "product_id=unlock_once_legacy\n"
        "export_product_id=export_once\n"
        "env=1\n"
        "sandbox_appkey=test-sandbox-appkey\n"
        "prod_appkey=test-prod-appkey\n",
        encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", secret)

    with TestClient(app_mod.app) as c:
        c.headers.update({"Authorization": "Bearer " + wechat.issue_token("open-t1")})
        yield c
    store._init_done = False


def _wait_ready(client, aid, tries=100):
    d = {}
    for _ in range(tries):
        d = client.get(f"/api/answer/{aid}").json()
        if d.get("status") != "pending":
            return d
        time.sleep(0.05)
    return d


def _ask_ready(client, q="导出收费测试问题"):
    aid = client.post("/api/ask", json={"question": q}).json()["id"]
    _wait_ready(client, aid)
    return aid


def _query(monkeypatch, status):
    """覆写查单应答：微信侧订单态=status。"""
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: {"errcode": 0,
                                         "order": {"status": status}})


_OTN_RE = re.compile(r"^[0-9A-Za-z_\-|*@]{8,32}$")


def test_login_persists_session_key(client, monkeypatch):
    """盲区#1（审计 CRITICAL-1 根治锚）：login 真路径必须落 session_key——
    不落盘=支付签名腿生产 100% 死锁。"""
    from qianwen_engine import store
    monkeypatch.delenv("QW_DEV_LOGIN", raising=False)
    monkeypatch.setattr(wechat, "code2session",
                        lambda code: {"openid": "open-t9", "session_key": "sk-t9"})
    r = client.post("/api/login", json={"code": "c9"})
    assert r.status_code == 200
    assert store.get_session("open-t9") == "sk-t9"
    # session_key 绝不出现在任何 API 响应（只住服务端）
    assert "sk-t9" not in r.text


def test_dev_login_without_session_cannot_sign(client, monkeypatch):
    """盲区#8：QW_DEV_LOGIN 开发登录不落 session_key → 签名腿 401（真实支付
    必须走真实 login 链路，开发态签不出有效单）。"""
    monkeypatch.setenv("QW_DEV_LOGIN", "1")
    r = client.post("/api/login", json={"code": "dev-x"})
    assert r.status_code == 200
    aid = _ask_ready(client)
    assert client.post(f"/api/answer/{aid}/export_sign").status_code == 401


def test_detail_carries_export_fields(client):
    aid = _ask_ready(client)
    d = client.get(f"/api/answer/{aid}").json()
    assert d["is_owner"] is True
    assert d["export_paid"] is False            # 新答案未解锁
    assert d["unlocked"] is True                # 咨询免费语义不变（v0.7.0 公益令）


def test_export_sign_single_creates_order(client):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    r = client.post(f"/api/answer/{aid}/export_sign")
    assert r.status_code == 200
    d = r.json()
    assert d["mode"] == "short_series_goods"
    assert d["price_fen"] == config.EXPORT_PRICE_FEN == 10
    sd = json.loads(d["sign_data"])          # sign_data=紧凑 JSON 串（客户端字节级透传契约）
    assert sd["buyQuantity"] == 1 and sd["goodsPrice"] == 10
    assert sd["productId"] == "export_once"      # 导出道具，非旧解锁道具
    assert sd["env"] == 1 and sd["currencyType"] == "CNY"
    assert _OTN_RE.match(sd["outTradeNo"]) and not sd["outTradeNo"].startswith("_")
    assert sd["outTradeNo"].startswith("e")
    assert d["pay_sig"] and d["signature"]        # 双签名在位
    # 签名即落单（审计 CRITICAL-2 前置）：订单行 status=signed、金额对
    o = store.get_pay_order(d["out_trade_no"])
    assert o and o["kind"] == "single" and o["aid"] == aid
    assert o["buy_quantity"] == 1 and o["total_fen"] == 10
    assert o["status"] == "signed"


def test_export_sign_gates(client):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    # 非本人 → 404（虚拟支付绝不为他人内容签名）
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    assert client.post(f"/api/answer/{aid}/export_sign", headers=t2).status_code == 404
    assert client.post("/api/answer/nope404/export_sign").status_code == 404
    # 无 session_key → 401（客户端静默重登后重试）
    store.save_session("open-t1", "")
    assert client.post(f"/api/answer/{aid}/export_sign").status_code == 401
    store.save_session("open-t1", "sess-key-t1")
    # 已解锁 → 409
    store.mark_export_paid(aid, "open-t1", "e-paid-otn-0001")
    assert client.post(f"/api/answer/{aid}/export_sign").status_code == 409


def test_export_sign_unconfigured(client, tmp_path, monkeypatch):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", tmp_path / "absent.secret")
    assert client.post(f"/api/answer/{aid}/export_sign").status_code == 503


def test_sign_cancels_open_order_new_otn(client, monkeypatch):
    """用户令 1009（不保留待支付态，想买重新下单）：同一答案重复签名=老未付单
    作废 + 新号重开——绝不复用已取消 otn（复用必 ORDER_CLOSED，面板拉不起）；
    不同答案各开各单。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    o1 = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    o2 = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    assert o2 != o1                                    # 重新下单必新号
    assert store.get_pay_order(o1)["status"] == "closed"
    assert store.get_pay_order(o2)["status"] == "signed"
    aid2 = _ask_ready(client, "另一篇")
    o3 = client.post(f"/api/answer/{aid2}/export_sign").json()["out_trade_no"]
    assert o3 != o2                                    # 不同目标不同号


def test_otn_entropy_same_millisecond():
    """审计 LOW-6：同毫秒双开单 otn 必不相同（token_hex 熵）。"""
    from qianwen_engine import app as app_mod
    a = app_mod._make_otn("e", "aaaaaaaa")
    b = app_mod._make_otn("e", "aaaaaaaa")
    assert a != b and _OTN_RE.match(a) and _OTN_RE.match(b)


def test_pay_order_status_tokens_fit_mysql_varchar8():
    """方言盲区锚：MySQL pay_order.status 是 VARCHAR(8)——store 源里所有
    status='…' 词元必须 ≤8 字符（'cancelled' 9 字符曾致生产 500 而 sqlite
    测试全绿，1009 ORDER_CLOSED 修复战的实锤翻车点）。"""
    import re
    from qianwen_engine import store as store_mod
    src = open(store_mod.__file__, encoding="utf-8").read()
    toks = set(re.findall(r"status\s*=\s*'(\w+)'", src))
    assert {"signed", "paid", "closed"} <= toks
    assert all(len(t) <= 8 for t in toks), sorted(toks)


def test_export_paid_verifies_via_query(client, monkeypatch):
    """回调腿 happy path：微信查单 SUCCESS → 标记 + 导出放行 + pay_log。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 402
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["export_paid"] is True
    # 幂等重跑
    assert client.post(f"/api/answer/{aid}/export_paid",
                       json={"out_trade_no": otn}).status_code == 200
    e = client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"})
    assert e.status_code == 200 and e.json()["filename"].endswith(".docx")
    assert client.get(f"/api/answer/{aid}").json()["export_paid"] is True
    with store._db() as c:
        rows = c.execute("SELECT * FROM pay_log WHERE aid=?", (aid,)).fetchall()
    assert len(rows) == 1 and rows[0]["out_trade_no"] == otn
    assert store.get_pay_order(otn)["status"] == "paid"


def test_export_paid_forged_otn_rejected(client, monkeypatch):
    """盲区#2（审计 CRITICAL-2）：零支付解锁死路——伪造/空/他人 otn 一律 404。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    _query(monkeypatch, "SUCCESS")          # 即便查单通配 SUCCESS，无真单也不放行
    assert client.post(f"/api/answer/{aid}/export_paid",
                       json={"out_trade_no": "e-forged-00000001"}).status_code == 404
    assert client.post(f"/api/answer/{aid}/export_paid",
                       json={"out_trade_no": ""}).status_code == 404
    # 他人订单 → 404（不越权）
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    assert client.post(f"/api/answer/{aid}/export_paid", headers=t2,
                       json={"out_trade_no": otn}).status_code == 404
    # 答案保持未解锁
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 402


def test_export_paid_query_unpaid_rejected(client, monkeypatch):
    """查单明确未付 → 400，不放行。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    _query(monkeypatch, "NOTPAY")
    r = client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert r.status_code == 400
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 402


def test_prod_query_outage_fail_closed(client, monkeypatch, tmp_path):
    """生产（env=0）fail-closed：查单失败/状态不明 → 503 对账中，绝不放行。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    prod = tmp_path / "prod.secret"
    prod.write_text(
        "offer_id=1450664233\nexport_product_id=export_once\nenv=0\n"
        "sandbox_appkey=k\nprod_appkey=k\n", encoding="utf-8")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", prod)
    # 查单基础设施故障 → 503
    monkeypatch.setattr(wechat, "xpay_query_order",
                        lambda *a, **k: (_ for _ in ()).throw(
                            wechat.XpayError("prod outage")))
    r = client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert r.status_code == 503
    # 陌生订单态（非成功非未付枚举）→ 同样 503 对账中
    _query(monkeypatch, "WEIRD_STATE")
    assert client.post(f"/api/answer/{aid}/export_paid",
                       json={"out_trade_no": otn}).status_code == 503
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 402


def test_sandbox_trust_on_query_outage(client, monkeypatch):
    """沙箱（env=1）查单不可用 → 信任回调（模拟支付无真实资金，env 服务端定，
    客户端无法自选环境伪造）。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    # fixture 默认：query 抛 XpayError（基础设施不可达）
    r = client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["export_paid"] is True
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 200


def test_sign_recovery_marks_paid_and_409(client, monkeypatch):
    """审计 HIGH-3 恢复路径：已扣款未标记（回调断网）→ 用户重试点导出 →
    签名腿查单发现已付 → 当场补标记 + 409 收口（绝不二次扣款）。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    # 用户已在微信面板完成支付，但 export_paid 回调网络抖断——服务端未标记
    _query(monkeypatch, "SUCCESS")
    r = client.post(f"/api/answer/{aid}/export_sign")
    assert r.status_code == 409 and "已解锁" in r.json()["detail"]
    assert store.get_pay_order(otn)["status"] == "paid"
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 200


def test_export_all_sign_quantity_and_snapshot(client, monkeypatch):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aids = [_ask_ready(client, f"批量问题{i}") for i in range(2)]
    r = client.post("/api/answers/export_all_sign")
    assert r.status_code == 200
    d = r.json()
    assert d["quantity"] == 2 and d["total_fen"] == 20
    sd = json.loads(d["sign_data"])
    assert sd["buyQuantity"] == 2 and sd["goodsPrice"] == 10
    assert _OTN_RE.match(sd["outTradeNo"]) and sd["outTradeNo"].startswith("b")
    otn = d["out_trade_no"]
    # 批量锚点不带 openid 明文（审计 WARN：otn 进用户账单详情可见）
    from qianwen_engine import store as st
    assert "open-t1" not in otn
    o = st.get_pay_order(otn)
    assert o["aid_list"] == ",".join(aids) and o["buy_quantity"] == 2
    # 盲区#3（审计 MEDIUM-4）：签名后新完成的咨询不入本单
    _ask_ready(client, "签名后才完成的新咨询")
    _query(monkeypatch, "SUCCESS")
    r2 = client.post("/api/answers/export_all_paid", json={"out_trade_no": otn})
    assert r2.status_code == 200 and r2.json()["export_paid"] == 2
    assert client.get(f"/api/answer/{aids[0]}").json()["export_paid"] is True
    # 快照外的新咨询仍未解锁，留给下一单（quantity=1）
    assert client.post("/api/answers/export_all_sign").json()["quantity"] == 1


def test_export_all_sign_cancel_and_fresh(client, monkeypatch):
    """用户令 1009（不保留待支付态）：批量重复签名=老未付单作废 + 新号重开
    （快照变与否皆然），已付老单走查单补账 409 收口。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    _ask_ready(client, "复用问题A")
    o1 = client.post("/api/answers/export_all_sign").json()["out_trade_no"]
    o2 = client.post("/api/answers/export_all_sign").json()["out_trade_no"]
    assert o2 != o1                                   # 重新下单必新号
    assert store.get_pay_order(o1)["status"] == "closed"
    _ask_ready(client, "复用问题B")           # 快照变化 → 老单（若有）也作废
    o3 = client.post("/api/answers/export_all_sign").json()["out_trade_no"]
    assert o3 != o2


def test_export_all_sign_limits(client, monkeypatch):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    monkeypatch.setattr(config, "EXPORT_BATCH_MAX", 2)
    for i in range(3):
        _ask_ready(client, f"超限问题{i}")
    assert client.post("/api/answers/export_all_sign").status_code == 400


def test_export_all_paid_and_gate(client, monkeypatch):
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    for i in range(2):
        _ask_ready(client, f"批量闸门问题{i}")
    r402 = client.post("/api/answers/export_all", json={"fmt": "md"})
    assert r402.status_code == 402 and "0.1" in r402.json()["detail"]
    otn = client.post("/api/answers/export_all_sign").json()["out_trade_no"]
    _query(monkeypatch, "SUCCESS")
    r = client.post("/api/answers/export_all_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["export_paid"] == 2
    md = client.post("/api/answers/export_all", json={"fmt": "md"})
    assert md.status_code == 200 and md.json()["filename"].endswith(".md")
    # 幂等重跑安全
    assert client.post("/api/answers/export_all_paid",
                       json={"out_trade_no": otn}).status_code == 200
    # 伪造批量 otn → 404（盲区#2 批量面）
    assert client.post("/api/answers/export_all_paid",
                       json={"out_trade_no": "b-forged-0000001"}).status_code == 404
    with store._db() as c:
        n = c.execute(
            "SELECT COUNT(*) FROM pay_log WHERE openid='open-t1' AND out_trade_no=?",
            (otn,)).fetchone()[0]
    assert n == 1


def test_history_carries_export_unpaid_all(client, monkeypatch):
    """盲区#6（审计 MEDIUM-5）：/api/history 附服务端权威未解锁计数
    （客户端 20 条截断列表不可信）。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aids = [_ask_ready(client, f"计数问题{i}") for i in range(3)]
    store.mark_export_paid(aids[0], "open-t1", "e-cnt-otn-0001")
    d = client.get("/api/history").json()
    assert d["export_unpaid_all"] == 2
    _query(monkeypatch, "SUCCESS")
    otn = client.post("/api/answers/export_all_sign").json()["out_trade_no"]
    client.post("/api/answers/export_all_paid", json={"out_trade_no": otn})
    assert client.get("/api/history").json()["export_unpaid_all"] == 0


def test_export_all_pending_only_404(client, monkeypatch):
    """盲区#7：仅有 pending（未完成）答案的用户走批量签名 → 404。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    gate = {"go": False}

    def _slow_ask(q, model="fast", sleep=None, on_event=None):
        while not gate["go"]:
            time.sleep(0.02)
        return _kb_answer(q)

    monkeypatch.setattr(metaso_kb, "ask", _slow_ask)
    client.post("/api/ask", json={"question": "慢问题"})
    r = client.post("/api/answers/export_all_sign")
    assert r.status_code == 404
    gate["go"] = True


def test_pot_shared_paid_export_viewer_scoped(client):
    """v0.9.14（用户令 1010「锅圈也要支持付费导出」）：锅圈官方种子答案——
    观看者可签名→支付→导出；解锁按 (openid, aid) 记账，别的观看者不受沾光。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = store.save_pot_answer("锅圈公共问题", "公开答案" * 100, [], sort=1)
    # 观看者看详情：可见、非 owner、未解锁
    d = client.get(f"/api/answer/{aid}").json()
    assert d["is_owner"] is False and d["export_paid"] is False
    # 签名腿放行（修前=owner 门 404，真机「无法拉起支付」根因）
    r = client.post(f"/api/answer/{aid}/export_sign")
    assert r.status_code == 200 and r.json()["price_fen"] == 10
    otn = r.json()["out_trade_no"]
    # 支付前导出 → 402
    assert client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"}).status_code == 402
    # 沙箱查单不可用 → 信任回调 → 解锁
    r = client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert r.status_code == 200 and r.json()["export_paid"] is True
    e = client.post(f"/api/answer/{aid}/export", json={"fmt": "docx"})
    assert e.status_code == 200 and e.json()["filename"].endswith(".docx")
    assert client.get(f"/api/answer/{aid}").json()["export_paid"] is True
    # 解锁按人记账：观看者2 仍锁（不沾光）
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    d2 = client.get(f"/api/answer/{aid}", headers=t2).json()
    assert d2["export_paid"] is False
    # 观看者1 的行级 flag 不被误写（POT_OPENID 才是 owner 行）
    row = store.get_answer(aid)
    assert row["export_paid"] == 0
    assert store.answer_export_unlocked("open-t1", aid) is True
    assert store.answer_export_unlocked("open-t2", aid) is False


def test_user_shared_answer_other_user_can_export(client):
    """v0.9.14 用户 bug 实弹场景：t1 的答案共享入锅圈 → t2 在锅圈点开导出，
    付 ¥0.1 后可导出文件；t1 自己的解锁态与 t2 互不干扰。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    store.save_session("open-t2", "sess-key-t2")
    aid = _ask_ready(client, "要共享进锅圈的咨询")
    assert client.post(f"/api/answer/{aid}/share_on").status_code == 200
    # t2 视角：可见、未解锁、可签名、可支付、可导出
    t2 = {"Authorization": "Bearer " + wechat.issue_token("open-t2")}
    d = client.get(f"/api/answer/{aid}", headers=t2).json()
    assert d["export_paid"] is False
    r = client.post(f"/api/answer/{aid}/export_sign", headers=t2)
    assert r.status_code == 200
    otn = r.json()["out_trade_no"]
    assert client.post(f"/api/answer/{aid}/export_paid", headers=t2,
                       json={"out_trade_no": otn}).status_code == 200
    e = client.post(f"/api/answer/{aid}/export", headers=t2, json={"fmt": "md"})
    assert e.status_code == 200
    # t1 owner 视角不受沾光：仍按行级 flag（未解锁）
    assert client.get(f"/api/answer/{aid}").json()["export_paid"] is False
    # 未共享的第三者答案 → t2 仍 404（隐私门不变）
    aid3 = _ask_ready(client, "t1 私藏答案不共享")
    assert client.get(f"/api/answer/{aid3}", headers=t2).status_code == 404
    assert client.post(f"/api/answer/{aid3}/export_sign", headers=t2).status_code == 404


def test_owner_marking_writes_both_legs(client):
    """答主本人解锁：行级 flag + 按人行双落（幂等），批量/历史口径不变。"""
    from qianwen_engine import store
    store.save_session("open-t1", "sess-key-t1")
    aid = _ask_ready(client)
    otn = client.post(f"/api/answer/{aid}/export_sign").json()["out_trade_no"]
    client.post(f"/api/answer/{aid}/export_paid", json={"out_trade_no": otn})
    assert store.get_answer(aid)["export_paid"] == 1            # 行级（批量腿依赖）
    assert store.answer_export_unlocked("open-t1", aid) is True  # 按人行（详情腿依赖）
    # 历史未解锁计数不再把本人已解锁答案计入
    assert client.get("/api/history").json()["export_unpaid_all"] == 0


def test_legacy_endpoints_gone(client):
    """用户令 1008：¥1 解锁双腿 + 分享赠次端点已下线——旧端点必须 404（回归锚）。"""
    aid = _ask_ready(client)
    assert client.post(f"/api/answer/{aid}/pay_sign").status_code == 404
    assert client.post(f"/api/answer/{aid}/unlock_paid", json={"out_trade_no": "x"}).status_code == 404
    assert client.post(f"/api/answer/{aid}/share").status_code == 404
