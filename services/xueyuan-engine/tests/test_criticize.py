# -*- coding: utf-8 -*-
"""批评评分四层闸单测（T-P1-02/03/04）：L1 各闸正/边界、L2 启发式恶意降分、
异步评分回填、待评分重试、感谢券、查重转人工、GET 作者可见性。"""
from __future__ import annotations

import sys
import time
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND  # noqa: E402

from xueyuan_engine import criticize, refund, store  # noqa: E402

BASE = ("第9章投资规模数据与我在江苏水网项目的实际经验不符，1.2亿的测算明显偏高，"
        "我觉得口径需要校准，建议补充资金流向分析。")
FILLER = "另外第3章的业主结构分析也应更贴近实际。"


def _crit(n: int) -> str:
    """恰好 n 个非空白字符的带锚点批评（锚点前置，填充不含空白）。"""
    s = BASE
    while len(s) < n:
        s += FILLER
    return s[:n]


def _fake_pay_env(monkeypatch):
    monkeypatch.setenv("XY_FAKE_PAY", "1")
    monkeypatch.setenv("XY_PORT", "8872")  # dev 端口口径（禁启自检）


def _paid_and_read(client, buyer, pay_on, monkeypatch, rid=PILOT) -> str:
    """假支付全流程+阅读落账，返回 out_trade_no。"""
    _fake_pay_env(monkeypatch)
    out = client.post("/api/v1/pay/sign", json={"report_id": rid},
                      headers=buyer).json()["out_trade_no"]
    assert client.post("/api/v1/pay/callback",
                       json={"outTradeNo": out, "transactionId": "wxsn-1"}).status_code == 200
    client.get(f"/api/v1/reports/{rid}/chapters", headers=buyer)  # 阅读记录
    return out


def _wait_scored(client, buyer, cid, timeout=6.0) -> dict:
    deadline = time.time() + timeout
    d = {}
    while time.time() < deadline:
        d = client.get(f"/api/v1/criticisms/{cid}", headers=buyer).json()
        if d.get("status") != "pending_score":
            return d
        time.sleep(0.05)
    return d


# ── L1 资格与代码闸（正/边界）────────────────────────────────────
def test_submit_requires_login(engine, client, buyer):
    assert client.post(f"/api/v1/reports/{PILOT}/criticize",
                       json={"content": _crit(60)}).status_code == 401


def test_submit_report_not_found(engine, client, buyer):
    assert client.post("/api/v1/reports/no-such/criticize",
                       json={"content": _crit(60)}, headers=buyer).status_code == 404


def test_submit_not_purchased(engine, client, buyer):
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(60)}, headers=buyer)
    assert r.status_code == 403 and r.json()["code"] == "NOT_PURCHASED"


def test_submit_no_read_record(engine, client, buyer, pay_on, monkeypatch):
    _fake_pay_env(monkeypatch)
    out = client.post("/api/v1/pay/sign", json={"report_id": PILOT},
                      headers=buyer).json()["out_trade_no"]
    client.post("/api/v1/pay/callback", json={"outTradeNo": out})
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(60)}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "NO_READ_RECORD"


def test_submit_length_gate_49_301(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    for n in (49, 301):
        r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                        json={"content": _crit(n)}, headers=buyer)
        assert r.status_code == 400 and r.json()["code"] == "LENGTH_INVALID", n


def test_submit_anchor_zero_template(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    tpl = ("这个报告写得不好内容质量差看完很失望不建议购买反正就是不满意等各种"
           "吐槽纯属浪费时间钱花得冤枉毫无收获。")  # 60 字纯模板：无章节/数据锚点
    assert len(tpl) >= 50
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": tpl}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "ANCHOR_ZERO"


def test_submit_monthly_limit(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)
    with store._LOCK, store._db() as c:  # 本月已有 2 次退款占额（第三发起→拒）
        for i in range(2):
            c.execute("INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,"
                      "tier,amount_fen,method,status,created_at) VALUES(?,?,?,?,?,?,"
                      "?,?,'settled',?)",
                      (f"rM{i}", out, "", buyer["uid"], "android", "tier50", 100,
                       "auto", store.now()))
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(60)}, headers=buyer)
    assert r.status_code == 429 and r.json()["code"] == "REFUND_MONTHLY_LIMIT"


def test_submit_dup_once_per_report(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    assert client.post(f"/api/v1/reports/{PILOT}/criticize",
                       json={"content": _crit(60)}, headers=buyer).status_code == 200
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(70)}, headers=buyer)
    assert r.status_code == 400 and r.json()["code"] == "CRITICISM_DUP"


def test_submit_similarity_high_manual_pending(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)
    content = _crit(80)
    with store._LOCK, store._db() as c:  # 历史批评（他人同报告）与本次全同
        c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                  "char_count,read_verified,anchor_score,similarity_score,status,"
                  "created_at) VALUES(?,?,?,?,?,?,1,1.0,0,'scored',?)",
                  ("cHist1", "u_other", PILOT, out, content, len(content), store.now()))
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": content}, headers=buyer)
    body = r.json()
    assert r.status_code == 409 and body["code"] == "SIMILARITY_HIGH"
    assert body["stage"] == "manual_pending" and body["criticism_id"]
    with store._db() as c:
        row = c.execute("SELECT status,manual_review,dup_flag FROM criticisms WHERE id=?",
                        (body["criticism_id"],)).fetchone()
    assert row["status"] == "manual_pending" and row["manual_review"] == 1
    assert row["dup_flag"] == 1  # 跨账号雷同告警位


# ── 受理回执+异步评分回填（L2）───────────────────────────────────
def test_submit_ok_and_async_scored(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(80)}, headers=buyer)
    body = r.json()
    assert r.status_code == 200
    assert body["stage"] == "pre_gate_passed" and body["scoring"] == "async"
    assert body["anchor_score"] > 0 and body["similarity_score"] < 0.6
    assert body["poll"].endswith(body["criticism_id"])
    d = _wait_scored(client, buyer, body["criticism_id"])
    assert d["status"] == "scored"
    assert set(d["llm_scores"]) >= {"sincerity", "authenticity",
                                    "constructiveness", "rationale"}
    assert 0 <= d["final_score"] <= 100 and d["refund_tier"].startswith("tier")
    assert d["refund"] is None  # 尚未发起退款


def test_pending_score_retry_on_provider_failure(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)
    monkeypatch.setenv("XY_JUDGE_PROVIDER", "openai_compat")  # 未配端点→评分失败
    cid = client.post(f"/api/v1/reports/{PILOT}/criticize",
                      json={"content": _crit(80)}, headers=buyer).json()["criticism_id"]
    time.sleep(0.6)
    d = client.get(f"/api/v1/criticisms/{cid}", headers=buyer).json()
    assert d["status"] == "pending_score"  # 失败降级=待评分，绝不丢批评
    monkeypatch.setenv("XY_JUDGE_PROVIDER", "heuristic")
    d = _wait_scored(client, buyer, cid)  # GET 触发重试→回填
    assert d["status"] == "scored" and d["final_score"] > 0


def test_score_below_50_grants_thanks_voucher(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    copy_paste = "第9章数据与实际不符。" * 5  # 50 字复读机样本
    cid = client.post(f"/api/v1/reports/{PILOT}/criticize",
                      json={"content": copy_paste}, headers=buyer).json()["criticism_id"]
    d = _wait_scored(client, buyer, cid)
    assert d["final_score"] < refund.SCORE_THRESHOLD and d["refund_tier"] == "none"
    with store._db() as c:
        rows = c.execute("SELECT amount_fen,source FROM vouchers WHERE source_ref=?",
                         (cid,)).fetchall()
    assert len(rows) == 1 and rows[0]["source"] == "criticism_thanks"
    assert rows[0]["amount_fen"] == 500  # 默认面值（运营参数 env 可调）


# ── L2 启发式恶意样本降分（≥3 例）────────────────────────────────
def test_heuristic_malicious_samples_downgraded(engine):
    from xueyuan_engine.catalog import chapter_rows
    chapters = chapter_rows(PILOT)
    honest = criticize.compose_final(criticize.heuristic_scores(_crit(80), chapters))
    again = criticize.compose_final(criticize.heuristic_scores(_crit(80), chapters))
    garbled = criticize.compose_final(criticize.heuristic_scores(
        "第9章zqx8v4m1k9w7e3r2t6y5u8i1o4p7a2s5d8f3g6h4j7k1l5pq", chapters))
    emoji = criticize.compose_final(criticize.heuristic_scores(
        "第9章😡😅😆🤔😱🙄😮😭🤡😏😌😆😴🙃 touted😡😅😆🤔😱", chapters))
    copy_paste = criticize.compose_final(criticize.heuristic_scores(
        "第9章数据与实际不符。" * 5, chapters))
    assert honest == again and honest >= 60  # 纯函数确定性+真诚带锚点样本高分
    for name, score in (("复制粘贴", copy_paste), ("乱码", garbled), ("纯表情", emoji)):
        assert score < refund.SCORE_THRESHOLD, f"{name}样本应低于退款线: {score}"
        assert score < honest, f"{name}样本应低于真诚样本: {score} vs {honest}"


# ── GET 可见性与纯函数 ────────────────────────────────────────
def test_get_criticism_author_only(engine, client, buyer, pay_on, monkeypatch):
    _paid_and_read(client, buyer, pay_on, monkeypatch)
    cid = client.post(f"/api/v1/reports/{PILOT}/criticize",
                      json={"content": _crit(60)}, headers=buyer).json()["criticism_id"]
    assert client.get(f"/api/v1/criticisms/{cid}").status_code == 401
    other = client.post("/api/v1/auth/login", json={"code": "other"}).json()
    r = client.get(f"/api/v1/criticisms/{cid}",
                   headers={"Authorization": f"Bearer {other['token']}"})
    assert r.status_code == 404  # 他人批评同 404（不泄漏存在性）
    assert client.get("/api/v1/criticisms/ghost",
                      headers=buyer).status_code == 404  # 不存在同 404


def test_compose_final_and_tier_label():
    assert criticize.compose_final({"sincerity": 78, "authenticity": 82,
                                    "constructiveness": 70}) == 76.7  # API_DESIGN 实样
    assert refund.tier_label(76.7) == "tier76"
    assert refund.tier_label(49.9) == "none"
    assert refund.tier_label(100) == "tier100"


def test_openai_compat_adapter_parse(engine, monkeypatch):
    """适配器 JSON 解析+clamp（全 mock，零外呼；provider 免费端点由运维配置）。"""
    monkeypatch.setenv("XY_JUDGE_PROVIDER", "openai_compat")
    monkeypatch.setenv("XY_JUDGE_BASE_URL", "https://free.example/api")
    monkeypatch.setenv("XY_JUDGE_MODEL", "free-model")
    monkeypatch.setenv("XY_JUDGE_API_KEY", "k")

    def _post(url, **kw):
        assert url.endswith("/chat/completions")
        return SimpleNamespace(
            status_code=200,
            raise_for_status=lambda: None,
            json=lambda: {"choices": [{"message": {"content":
                '{"sincerity": 188, "authenticity": 95, "constructiveness": 60,'
                ' "rationale": "第9章↔第九章"}'}}]},
        )

    monkeypatch.setattr(criticize, "cr", SimpleNamespace(post=_post))
    out = criticize.run_judge(_crit(60), {"title": "t"}, [])
    assert out["sincerity"] == 100 and out["authenticity"] == 95  # clamp 0-100
    assert out["provider"] == "openai_compat" and "第9章" in out["rationale"]

    def _bad(**kw):
        return SimpleNamespace(status_code=200, raise_for_status=lambda: None,
                               json=lambda: {"choices": [{"message": {"content": "缺维"}}]})

    monkeypatch.setattr(criticize, "cr", SimpleNamespace(post=lambda u, **k: _bad()))
    with pytest.raises(RuntimeError, match="缺三维"):
        criticize.run_judge(_crit(60), {"title": "t"}, [])


def test_similarity_and_anchor_helpers(engine):
    assert criticize.char_count("  第9章\n数据 1.2亿\r\n ") == len("第9章数据1.2亿")
    assert criticize.anchor_score("第9章的数据与1.2亿不符") == 1.0
    assert criticize.anchor_score("第9章写得很差") == 0.6
    assert criticize.anchor_score("这报告不行") == 0.0
    g = criticize._ngrams("第9章数据")
    assert g and all(len(x) == 3 for x in g)
    assert 0 <= criticize.similarity_threshold()


# ── 边角分支（env 坏值/短文本/幂等跳过/坏 JSON/显式单号）──────────
ALT = ("第3章业主结构与我在苏州产业园的真实观察不一致，2.4万平的口径偏乐观，"
       "建议补充完整租户名单与违约条款分析。")


def test_helper_edge_branches(engine, monkeypatch):
    monkeypatch.setenv("XY_SIMILARITY_THRESHOLD", "bad")
    assert criticize.similarity_threshold() == 0.6  # env 坏值→默认阈值
    assert criticize._ngrams("ab") == {"ab"}  # 短文本单 gram
    assert criticize.similarity_scan("", PILOT)["score"] == 0.0
    assert criticize._repeat_ratio("第9章") == 0.0  # gram 数不足→重复率 0
    with store._LOCK, store._db() as c:  # 历史空内容行→比对安全跳过
        c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                  "char_count,read_verified,status,created_at)"
                  " VALUES('cEmpty','u_e',?,'','',0,1,'scored',?)",
                  (PILOT, store.now()))
    assert criticize.similarity_scan(_crit(60), PILOT)["score"] == 0.0
    monkeypatch.setenv("XY_THANKS_VOUCHER_FEN", "bad")
    assert criticize._thanks_fen() == 500  # 坏值→默认面值
    monkeypatch.delenv("XY_SIMILARITY_THRESHOLD")
    monkeypatch.delenv("XY_THANKS_VOUCHER_FEN")


def test_score_one_skips_non_pending(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                  "char_count,read_verified,anchor_score,similarity_score,status,"
                  "created_at) VALUES('cDone',?,?,?,'x',1,1,0,0,'scored',?)",
                  (buyer["uid"], PILOT, out, store.now()))
    criticize._score_one("cDone")  # 非 pending_score→不动（幂等守卫）
    criticize._score_one("ghost")  # 不存在→安全返回
    with store._db() as c:
        assert c.execute("SELECT status FROM criticisms WHERE id='cDone'"
                         ).fetchone()["status"] == "scored"


def test_get_bad_llm_scores_json(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO criticisms(id,user_id,report_id,order_id,content,"
                  "char_count,read_verified,anchor_score,similarity_score,llm_scores,"
                  "final_score,refund_tier,status,created_at)"
                  " VALUES('cBad',?,?,?,'x',1,1,0,0,'not-json',70,'tier70','scored',?)",
                  (buyer["uid"], PILOT, out, store.now()))
    d = client.get("/api/v1/criticisms/cBad", headers=buyer).json()
    assert d["llm_scores"] == {} and d["final_score"] == 70  # 坏 JSON 降级空对象


def test_submit_explicit_order_id_paths(engine, client, buyer, pay_on, monkeypatch):
    out = _paid_and_read(client, buyer, pay_on, monkeypatch)          # PILOT
    _paid_and_read(client, buyer, pay_on, monkeypatch, rid=SECOND)    # 第二份
    r = client.post(f"/api/v1/reports/{PILOT}/criticize",
                    json={"content": _crit(70), "order_id": out}, headers=buyer)
    assert r.status_code == 200  # 显式单号命中已付订单
    r2 = client.post(f"/api/v1/reports/{SECOND}/criticize",
                     json={"content": ALT, "order_id": "bogus"}, headers=buyer)
    assert r2.status_code == 200  # 显式单号未命中→最新已付单兜底


def test_openai_compat_keyfile(engine, monkeypatch, tmp_path):
    """密钥文件路径留缝（XY_JUDGE_KEY_FILE）：key 不入 env 亦可配。"""
    monkeypatch.setenv("XY_JUDGE_PROVIDER", "openai_compat")
    monkeypatch.setenv("XY_JUDGE_BASE_URL", "https://free.example/api")
    monkeypatch.setenv("XY_JUDGE_MODEL", "free-model")
    monkeypatch.delenv("XY_JUDGE_API_KEY", raising=False)
    kf = tmp_path / "judge_key.txt"
    kf.write_text("  filekey  ", encoding="utf-8")
    monkeypatch.setenv("XY_JUDGE_KEY_FILE", str(kf))

    def _post(url, **kw):
        content = ('{"sincerity": 80, "authenticity": 80,'
                   ' "constructiveness": 80}')
        return SimpleNamespace(
            status_code=200, raise_for_status=lambda: None,
            json=lambda: {"choices": [{"message": {"content": content}}]},
        )

    monkeypatch.setattr(criticize, "cr", SimpleNamespace(post=_post))
    out = criticize.run_judge(_crit(60), {"title": "t"}, [])
    assert out["sincerity"] == 80 and out["provider"] == "openai_compat"
