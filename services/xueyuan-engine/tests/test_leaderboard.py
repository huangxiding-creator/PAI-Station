# -*- coding: utf-8 -*-
"""榜单/故事/K 看板域单测（3c）：金额解析/三榜口径/ISO 周快照冻结与翻周/
故事确定性轮换/公众号出稿/K 漏斗四级+运营令牌闸。零网络零真微信。"""
from __future__ import annotations

import sys
from datetime import datetime
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

import pytest  # noqa: E402

from tests.conftest import PILOT, SECOND, THIRD  # noqa: E402
from tests.test_cards import _write_cards  # noqa: E402

from xueyuan_engine import config, leaderboard, store  # noqa: E402
from xueyuan_engine import cards as cards_mod  # noqa: E402


def _card(rid: str, n: int, **kw) -> dict:
    base = {"id": f"{rid}-c{n:03d}", "title": f"测试商机{n}", "amount": "",
            "amount_raw": "", "owner": "", "stage": "", "window": "",
            "province": "江苏", "source_chapter": "ch01", "summary": f"摘要{n}"}
    return {**base, **kw}


@pytest.fixture()
def rank_env(engine, monkeypatch):
    """卡数据就位（试点大额江苏卡+广东两卡+浙江新报告卡）+令牌文件指到 tmp。"""
    _write_cards(engine.pkg, PILOT, [
        _card(PILOT, 1, title="入海水道二期", amount="3.2 亿", owner="省水利厅",
              stage="立项", window="2026年", province="江苏"),
        _card(PILOT, 2, amount="1,200 万元", owner="市交通局", province="江苏",
              stage="-"),   # 占位 '-'（生产实锤形态：故事段归一回归目标）
        _card(PILOT, 3, amount="面议", owner="市水利局", province="江苏"),
    ])
    _write_cards(engine.pkg, SECOND, [
        _card(SECOND, 1, amount="800 万元", owner="港务集团", province="广东"),
    ])
    _write_cards(engine.pkg, THIRD, [
        _card(THIRD, 1, amount="9,500 万元", owner="新航运集团", province="浙江"),
    ])
    cards_mod._CACHE.clear()          # 夹具内容区换位后强制重载索引
    key = engine.tmp / "op.key"
    key.write_text("op-token-fixture", encoding="utf-8")
    monkeypatch.setattr(config, "OPERATOR_TOKEN_FILE", key)
    yield engine
    cards_mod._CACHE.clear()


# ── 金额解析（排序口径；无数字不猜）────────────────────────────────────
@pytest.mark.parametrize("text,want", [
    ("3.2 亿", 3.2), ("3.2亿", 3.2), ("1,200 万元", 0.12), ("500万", 0.05),
    ("120000000", 1.2), ("", None), ("面议", None), (None, None),
])
def test_amount_yi(text, want):
    got = leaderboard.amount_yi(text)
    assert (got is None) == (want is None)
    if want is not None:
        assert abs(got - want) < 1e-9


# ── 三榜口径 ──────────────────────────────────────────────────────────
def test_rankings_shape(rank_env, client):
    r = client.get("/api/v1/rankings")
    assert r.status_code == 200
    d = r.json()
    assert d["week"] == leaderboard.iso_week()[0]
    # 省级热度：score=卡数+2×扫码（无扫码=纯卡数）；江苏 3 卡居首
    heat = d["province_heat"]
    assert heat[0]["province"] == "江苏" and heat[0]["cards"] == 3
    assert all(x["score"] >= y["score"] for x, y in zip(heat, heat[1:]))
    # 最大单：3.2 亿居首且按亿元降序；面议卡不入榜
    deals = d["max_deals"]
    assert deals[0]["title"] == "入海水道二期" and deals[0]["amount_yi"] == 3.2
    assert all(x["amount_yi"] >= y["amount_yi"] for x, y in zip(deals, deals[1:]))
    assert all(x["card_id"] != f"{PILOT}-c003" for x in deals)
    assert deals[0]["report_title"]          # 报告标题富化在位
    # 新入榜业主：THIRD=最新 published_at（夹具 09-27/26/25，试点最新）…
    # 试点=09-27 最新 → 新报告=PILOT；旧报告业主（港务集团）不得入榜
    owners = d["rising_owners"]
    assert owners and all(o["owner"] != "港务集团" for o in owners)
    # 故事：三段非空字符串、卡真实存在
    s = d["story"]
    assert s and len(s["paragraphs"]) == 3 and all(s["paragraphs"])
    assert cards_mod.find_card(s["card_id"])
    assert d["formula"]["province_heat"].startswith("score =")


def test_snapshot_freeze(rank_env, client):
    """同 ISO 周快照冻结：落库后追加扫码事件，榜单不动（周更节奏语义）。"""
    d1 = client.get("/api/v1/rankings").json()
    with store._LOCK, store._db() as c:   # 直插扫码+分享（不动卡索引）
        c.execute("INSERT INTO poster_code(scene_code,report_id,inviter_uid,"
                  "channel,pregenerated,created_at) VALUES('r=x&i=y',?,?,'scan',0,?)",
                  (PILOT, "u1", store.now()))
        c.execute("INSERT INTO scan_visit(scene_code,user_id,entry_page,ts)"
                  " VALUES('r=x&i=y','','pages/index/index',?)", (store.now(),))
    d2 = client.get("/api/v1/rankings").json()
    assert d2 == d1                        # 冻结：周内新扫码不改本周榜
    with store._db() as c:
        assert c.execute("SELECT COUNT(*) n FROM rank_week").fetchone()["n"] == 1


def test_week_rollover_recomputes(rank_env, client, monkeypatch):
    """跨周翻新：iso_week 指到下一周 → 重算+新快照行（首访冻结语义）。"""
    wk, no = leaderboard.iso_week()
    assert client.get("/api/v1/rankings").json()["week"] == wk   # 本周先冻结
    with store._LOCK, store._db() as c:   # 本周落一码一扫码（归省江苏）
        c.execute("INSERT INTO poster_code(scene_code,report_id,inviter_uid,"
                  "channel,pregenerated,created_at) VALUES('r=x&i=y',?,?,'scan',0,?)",
                  (PILOT, "u1", store.now()))
        c.execute("INSERT INTO scan_visit(scene_code,user_id,entry_page,ts)"
                  " VALUES('r=x&i=y','','pages/index/index',?)", (store.now(),))
    nxt = datetime.fromisocalendar(no // 53, (no % 53) + 1, 1)
    monkeypatch.setattr(leaderboard, "iso_week",
                        lambda now=None: (f"{nxt.isocalendar()[0]}-W{nxt.isocalendar()[1]:02d}", no + 1))
    d = client.get("/api/v1/rankings").json()
    assert d["week"] != wk
    assert d["province_heat"][0]["scans_7d"] >= 1   # 冻结后的扫码计入新周榜
    with store._db() as c:
        assert c.execute("SELECT COUNT(*) n FROM rank_week").fetchone()["n"] == 2


def test_story_rotates_by_week(rank_env, monkeypatch):
    _, no = leaderboard.iso_week()
    monkeypatch.setattr(leaderboard, "iso_week", lambda now=None: ("w", no))
    s1 = leaderboard.rankings()["story"]
    monkeypatch.setattr(leaderboard, "iso_week", lambda now=None: ("w2", no + 1))
    s2 = leaderboard.rankings()["story"]
    assert s1["card_id"] != s2["card_id"]  # 候选池按周序号轮换（4 张有金额卡）


def test_story_stage_placeholder_normalized(rank_env):
    """生产实锤回归：stage 占位 '-' 不得拼进故事段（「项目处于-阶段」泄漏）。"""
    rmap = leaderboard._report_map()
    # 金额池序（降序）：c001 3.2亿 → THIRD c001 0.95亿 → c002 0.12亿 → SECOND c001 0.08亿
    s = leaderboard._story(2, rmap)       # 指针=2 → PILOT c002（stage 占位 '-'）
    assert s["card_id"] == f"{PILOT}-c002"
    assert all("-阶段" not in p for p in s["paragraphs"])
    assert all("阶段" not in p for p in s["paragraphs"])   # 归一为空→整句略


def test_export_markdown(rank_env, client):
    r = client.get("/api/v1/rankings/export")
    assert r.status_code == 200
    assert "markdown" in r.headers["content-type"]
    body = r.text
    assert "商机周报" in body and "省级商机热度榜" in body
    assert "最大商机单" in body and "新入榜业主" in body
    assert "非投资建议" in body          # 免责句随出稿


def test_empty_content_no_snapshot(engine, client):
    """卡区空：三榜全空不落快照行（防内容未就位把空周钉死）。"""
    d = client.get("/api/v1/rankings").json()
    assert d["province_heat"] == [] and d["story"] is None
    with store._db() as c:
        assert c.execute("SELECT COUNT(*) n FROM rank_week").fetchone()["n"] == 0


# ── K 看板（判据⑥四级漏斗+运营令牌闸）─────────────────────────────────
def test_k_dashboard_gate(rank_env, client):
    assert client.get("/api/v1/k/dashboard").status_code == 403
    r = client.get("/api/v1/k/dashboard", headers={"X-Operator-Token": "wrong"})
    assert r.status_code == 403 and r.json()["code"] == "OPERATOR_DENIED"
    r = client.get("/api/v1/k/dashboard", headers={"X-Operator-Token": "op-token-fixture"})
    assert r.status_code == 200


def test_k_dashboard_funnel(rank_env, client, buyer):
    # 造四级事件各 ≥1：分享/扫码/有效关系/成交单
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO share_event(id,user_id,report_id,channel,ts)"
                  " VALUES('sh1',?,?,'poster',?)", (buyer["uid"], PILOT, store.now()))
        c.execute("INSERT INTO scan_visit(scene_code,user_id,entry_page,ts)"
                  " VALUES('r=x&i=y','','p',?)", (store.now(),))
        c.execute("INSERT INTO invite_relation(id,inviter_uid,invitee_uid,report_id,"
                  "scene_code,status,ts) VALUES('i1','u9',?,?,'','effective',?)",
                  (buyer["uid"], PILOT, store.now()))
        c.execute("INSERT INTO orders(out_trade_no,user_id,report_id,price_fen,"
                  "platform,status,paid_at,created_at) VALUES('ot1',?,?,49800,"
                  "'android','paid',?,?)",
                  (buyer["uid"], PILOT, store.now(), store.now()))
    r = client.get("/api/v1/k/dashboard", headers={"X-Operator-Token": "op-token-fixture"})
    d = r.json()
    stages = {f["key"]: f for f in d["funnel"]}
    assert [f["key"] for f in d["funnel"]] == ["shares", "scans", "effective", "paid"]
    assert stages["shares"]["total"] >= 1 and stages["shares"]["last_7d"] >= 1
    assert stages["scans"]["total"] >= 1
    assert stages["effective"]["total"] >= 1
    assert stages["paid"]["total"] >= 1 and stages["paid"]["gmv_fen"] >= 49800
    assert d["conversion"]["scan_per_share"] is not None
    assert d["cards_total"] >= 5
