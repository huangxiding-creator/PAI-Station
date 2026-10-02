# -*- coding: utf-8 -*-
"""邀请契约单测（T-P1-10/FR-P1-08/09）：降级兜底/首触不覆盖/邀2解锁/幂等不双发。"""
from __future__ import annotations

import json
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import SECOND  # noqa: E402

from xueyuan_engine import store  # noqa: E402

ENTRY = {"entry_page": "pages/reader/reader"}


def _login(client, code):
    d = client.post("/api/v1/auth/login", json={"code": code}).json()
    return {"Authorization": f"Bearer {d['token']}", "uid": d["uid"]}


def _seed_code(scene: str, rid: str, inviter: str, channel: str = "poster"):
    """码池播种（poster 域职责，测试直落表造前置态）。"""
    with store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO poster_code(scene_code,report_id,inviter_uid,"
            "channel,pregenerated,created_at) VALUES(?,?,?,?,1,?)",
            (scene, rid, inviter, channel, store.now()))
    return scene


def _scene(rid: str, uid: str) -> str:
    return f"r={rid}&i={uid}"


def test_scan_degraded_on_garbage_scene(engine, client):
    r = client.post("/api/v1/invite/scan", json={"scene": "garbage", **ENTRY})
    assert r.status_code == 200  # 归因降级不报错（免费兜底优先于归因）
    body = r.json()
    assert body["degraded"] is True and body["inviter_uid"] is None


def test_scan_short_code_unknown_degraded(engine, client):
    r = client.post("/api/v1/invite/scan", json={"scene": "s=ZZZZZ", **ENTRY})
    assert r.status_code == 200 and r.json()["degraded"] is True


def test_scan_empty_scene_degraded(engine, client):
    r = client.post("/api/v1/invite/scan", json={"scene": "", **ENTRY})
    assert r.status_code == 200 and r.json() == {
        "report_id": "", "inviter_uid": None, "degraded": True}


def test_scan_short_code_in_pool_resolves(engine, client):
    inviter = _login(client, "inviter")
    _seed_code("s=Ab3xK9", SECOND, inviter["uid"])  # 码池预生成短码
    invitee = _login(client, "newbie1")
    r = client.post("/api/v1/invite/scan", json={"scene": "s=Ab3xK9", **ENTRY},
                    headers=invitee)
    assert r.status_code == 200 and r.json() == {
        "report_id": SECOND, "inviter_uid": inviter["uid"], "degraded": False}
    with store._db() as c:
        visit = c.execute("SELECT scene_code FROM scan_visit").fetchone()
    assert visit["scene_code"] == "s=Ab3xK9"


def test_scan_anonymous_logs_visit_no_relation(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    r = client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY})
    assert r.status_code == 200 and r.json() == {
        "report_id": SECOND, "inviter_uid": inviter["uid"], "degraded": False}
    with store._db() as c:
        visit = c.execute("SELECT * FROM scan_visit WHERE scene_code=?",
                          (scene,)).fetchone()
        rel = c.execute("SELECT COUNT(*) n FROM invite_relation").fetchone()["n"]
    assert visit["user_id"] == ""  # 未登录先空（漏斗第一环仍记）
    assert rel == 0  # 匿名不建邀请关系


def test_scan_logged_creates_relation_and_scan_visit(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    r = client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                    headers=invitee)
    assert r.status_code == 200 and r.json()["degraded"] is False
    with store._db() as c:
        rel = c.execute("SELECT * FROM invite_relation").fetchone()
        visit = c.execute("SELECT user_id FROM scan_visit WHERE scene_code=?",
                          (scene,)).fetchone()
    assert rel["inviter_uid"] == inviter["uid"] and rel["invitee_uid"] == invitee["uid"]
    assert rel["status"] == "registered"  # 新用户（注册未满 24h 且首扫）
    assert visit["user_id"] == invitee["uid"]


def test_first_touch_never_overwritten(engine, client):
    """首触归因：再扫他人海报不覆盖（UNIQUE(invitee,report) 先到先记）。"""
    i1, i2 = _login(client, "inviter1"), _login(client, "inviter2")
    s1 = _seed_code(f"r={SECOND}&i={i1['uid']}", SECOND, i1["uid"])
    s2 = _seed_code(f"r={SECOND}&i={i2['uid']}", SECOND, i2["uid"], channel="session")
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": s1, **ENTRY}, headers=invitee)
    client.post("/api/v1/invite/scan", json={"scene": s2, **ENTRY}, headers=invitee)
    with store._db() as c:
        rows = c.execute("SELECT inviter_uid FROM invite_relation").fetchall()
    assert len(rows) == 1 and rows[0]["inviter_uid"] == i1["uid"]


def test_two_new_users_unlock_and_reward_once(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    for code in ("newbie1", "newbie2"):
        h = _login(client, code)
        client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=h)
        client.get(f"/api/v1/reports/{SECOND}/chapters", headers=h)  # 读腿→有效带新
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["progress"] == {"new_users": 2, "required": 1, "unlocked": True}
    assert d["voucher_earned_fen"] == 5000  # 50 书券=5000 分
    assert all(i["status"] == "effective" for i in d["invited"])
    me = client.get("/api/v1/me", headers=inviter).json()
    assert me["vouchers_balance_fen"] == 5000
    # 第 3 位再扫码+阅读：进度涨、奖励不双发（flags 闩锁幂等）
    h3 = _login(client, "newbie3")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=h3)
    client.get(f"/api/v1/reports/{SECOND}/chapters", headers=h3)
    d2 = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d2["progress"]["new_users"] == 3 and d2["voucher_earned_fen"] == 5000
    assert client.get("/api/v1/me", headers=inviter).json()["vouchers_balance_fen"] == 5000
    with store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM vouchers WHERE user_id=? AND source='invite'",
                      (inviter["uid"],)).fetchone()["n"]
    assert n == 1


def test_one_new_user_progress_visible_no_reward(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                headers=_login(client, "newbie1"))
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    # v1.2：扫码≠有效带新——未读未停留不计入 new_users（进度行可见但不发放）
    assert d["progress"] == {"new_users": 0, "required": 1, "unlocked": False}
    assert d["invited"] and d["invited"][0]["status"] == "registered"
    assert d["voucher_earned_fen"] == 0
    assert client.get("/api/v1/me", headers=inviter).json()["vouchers_balance_fen"] == 0


def test_old_user_scan_not_counted_as_new(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    aged = _login(client, "aged-user")
    with store._db() as c:  # 注册超 24h=老用户（新ness 信号窗外）
        c.execute("UPDATE users SET created_at=? WHERE id=?",
                  ("2026-09-01T00:00:00+08:00", aged["uid"]))
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=aged)
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["invited"] and d["invited"][0]["status"] == "scanned"
    assert d["progress"]["new_users"] == 0


def test_corrupt_created_at_treated_as_old(engine, client):
    """created_at 不可解析=保守按老用户（窗外），不炸不计数。"""
    from xueyuan_engine import invite as invite_mod

    assert invite_mod._within_hours("not-a-date", 24) is False
    assert invite_mod._within_hours(None, 24) is False


def test_self_invite_guard(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    r = client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                    headers=inviter)
    assert r.status_code == 200  # 自扫不报错、不建关系
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["invited"] == [] and d["progress"]["new_users"] == 0


def test_relations_require_login(engine, client):
    assert client.get("/api/v1/invite/relations").status_code == 401


# ── 卡码 c=<card_id>&i=<uid> 归因（w3a-2-E；复用既有首触/有效带新路径）──
SHORT = "ab-2026"   # 短 rid 夹具报告：c=<card_id>&i=<uid> 全形态 ≤32 可直拼


@pytest.fixture()
def card_env(engine):
    """卡码归因夹具：追加短 rid 报告（catalog/chapters/cards）+重同步进库。"""
    from xueyuan_engine import cards as cards_mod
    from xueyuan_engine import store

    chaps = [{"id": "ch01", "title": "测试第1章 标题1",
              "html": "<h1>测试第1章</h1><p>" + "商机正文。" * 20}]
    d = engine.pkg / "reports" / SHORT
    d.mkdir(parents=True)
    (d / "chapters.json").write_text(json.dumps(chaps, ensure_ascii=False),
                                     encoding="utf-8")
    cat = json.loads((engine.pkg / "catalog.json").read_text(encoding="utf-8"))
    cat["reports"] = [*cat["reports"], {"id": SHORT, "title": "短名测试商机报告",
                                        "summary": "卡码归因夹具", "price": 100,
                                        "chapterCount": 1, "source": "总包创研院",
                                        "publishedAt": "2026-09-28"}]
    (engine.pkg / "catalog.json").write_text(json.dumps(cat, ensure_ascii=False),
                                             encoding="utf-8")
    cards_mod._CACHE.clear()
    cd = engine.pkg / "cards"
    cd.mkdir(exist_ok=True)
    (cd / f"{SHORT}.json").write_text(json.dumps(
        {"report_id": SHORT, "generated_at": "2026-09-28T00:00:00", "source": "test",
         "cards": [{"id": f"{SHORT}-c001", "title": "测试商机", "amount": "",
                    "amount_raw": "", "owner": "", "stage": "-", "window": "",
                    "province": "湖北", "source_chapter": "ch01",
                    "summary": "测试卡"}]}, ensure_ascii=False), encoding="utf-8")
    store.sync_from_catalog(engine.pkg, engine.full)
    yield engine
    cards_mod._CACHE.clear()


def test_scan_card_scene_attributions_to_report(card_env, client):
    """c= 卡码扫码：card_id 反查 report_id 建首触关系（degraded=False）。"""
    inviter = _login(client, "cardhost")
    scene = f"c={SHORT}-c001&i={inviter['uid']}"
    assert len(scene) <= 32                       # 官方直拼窗内
    invitee = _login(client, "cardguest")
    r = client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                    headers=invitee)
    assert r.status_code == 200
    assert r.json() == {"report_id": SHORT, "inviter_uid": inviter["uid"],
                        "degraded": False}
    with store._db() as c:
        rel = c.execute("SELECT * FROM invite_relation").fetchone()
        visit = c.execute("SELECT scene_code FROM scan_visit").fetchone()
    assert rel["report_id"] == SHORT                # 反查归因到所属报告
    assert rel["inviter_uid"] == inviter["uid"]
    assert visit["scene_code"] == scene


def test_scan_card_scene_read_leg_to_effective(card_env, client):
    """卡码关系走读腿置有效带新（判据全复用，不新建归因路径）。"""
    inviter = _login(client, "cardhost")
    scene = f"c={SHORT}-c001&i={inviter['uid']}"
    invitee = _login(client, "cardguest")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                headers=invitee)
    client.get(f"/api/v1/reports/{SHORT}/chapters", headers=invitee)   # 读腿
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["progress"]["new_users"] == 1 and d["progress"]["unlocked"] is True


def test_scan_card_scene_unknown_card_degrades(card_env, client):
    """卡码查不到/坏格式：恒 200 降级（免费兜底优先于归因）。"""
    invitee = _login(client, "cardguest")
    r = client.post("/api/v1/invite/scan",
                    json={"scene": f"c={SHORT}-c999&i=u0123456789", **ENTRY},
                    headers=invitee)
    assert r.status_code == 200
    assert r.json() == {"report_id": "", "inviter_uid": None, "degraded": True}
    with store._db() as c:
        assert c.execute("SELECT COUNT(*) n FROM invite_relation"
                         ).fetchone()["n"] == 0


# ── 卡短码 s=<8hex> 归因（2026-09-28 根治切片：真实卡直拼全量超 32 上限）──
def test_scan_card_short_code_attributes_to_report(card_env, client):
    """s= 卡短码扫码：card_code 还原 (rid,inviter) 建首触关系（poster_code 未命中回落）。"""
    from xueyuan_engine import cards as cards_mod
    inviter = _login(client, "cardhost")
    scene = cards_mod.ensure_card_code(f"{SHORT}-c001", inviter["uid"])
    assert scene.startswith("s=") and len(scene) <= 32
    invitee = _login(client, "cardguest")
    r = client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY},
                    headers=invitee)
    assert r.status_code == 200
    assert r.json() == {"report_id": SHORT, "inviter_uid": inviter["uid"],
                        "degraded": False}
    with store._db() as c:
        rel = c.execute("SELECT * FROM invite_relation").fetchone()
    assert rel["report_id"] == SHORT and rel["inviter_uid"] == inviter["uid"]
