# -*- coding: utf-8 -*-
"""情报官体系契约单测（AGREEMENT_COPY v1.2 §六）：有效带新两腿（读腿/停留腿）/
状态机 effective 幂等/600s 刷量防线/三档梯队闩锁只发一次/只升不降/旧口径
衔接不回退不重发//invite/relations 与 /me invite 冻结契约形状。
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from tests.conftest import PILOT, SECOND  # noqa: E402

from xueyuan_engine import store  # noqa: E402

ENTRY = {"entry_page": "pages/reader/reader"}


def _login(client, code):
    d = client.post("/api/v1/auth/login", json={"code": code}).json()
    return {"Authorization": f"Bearer {d['token']}", "uid": d["uid"]}


def _seed_code(scene: str, rid: str, inviter: str, channel: str = "poster"):
    with store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO poster_code(scene_code,report_id,inviter_uid,"
            "channel,pregenerated,created_at) VALUES(?,?,?,?,1,?)",
            (scene, rid, inviter, channel, store.now()))
    return scene


def _scene(rid: str, uid: str) -> str:
    return f"r={rid}&i={uid}"


def _recruit(client, inviter_uid: str, rid: str, tag: str, n: int,
             leg: str = "read") -> list[dict]:
    """造 n 位有效带新 invitee（扫码+读腿或停留腿）。"""
    scene = _seed_code(_scene(rid, inviter_uid), rid, inviter_uid)
    heads = []
    for i in range(n):
        h = _login(client, f"{tag}{i}")
        client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=h)
        if leg == "read":
            client.get(f"/api/v1/reports/{rid}/chapters", headers=h)
        else:
            client.post("/api/v1/invite/dwell",
                        json={"report_id": rid, "seconds": 200}, headers=h)
        heads.append(h)
    return heads


def _relation_status(invitee_uid: str, rid: str) -> str | None:
    with store._db() as c:
        row = c.execute(
            "SELECT status FROM invite_relation WHERE invitee_uid=? AND report_id=?",
            (invitee_uid, rid)).fetchone()
    return row["status"] if row else None


def _vouchers(uid: str, source: str) -> int:
    with store._db() as c:
        return c.execute(
            "SELECT COUNT(*) n FROM vouchers WHERE user_id=? AND source=?",
            (uid, source)).fetchone()["n"]


# ── 读腿（判据①：完整阅读≥1 章试读）────────────────────────────────
def test_read_leg_marks_effective_and_l1(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    assert _relation_status(invitee["uid"], SECOND) == "registered"
    r = client.get(f"/api/v1/reports/{SECOND}/chapters", headers=invitee)
    assert r.status_code == 200 and "chapters" in r.json()  # 响应形状不变
    assert _relation_status(invitee["uid"], SECOND) == "effective"  # 纯副作用
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["effective_count"] == 1 and d["level"] == "L1"
    assert d["level_name"] == "观察员" and d["progress"]["unlocked"] is True
    assert d["voucher_earned_fen"] == 5000
    assert _vouchers(inviter["uid"], "invite") == 1


def test_read_leg_anonymous_no_mark(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    assert client.get(f"/api/v1/reports/{SECOND}/chapters").status_code == 200
    assert _relation_status(invitee["uid"], SECOND) == "registered"  # 无 Bearer 不触发


def test_read_leg_idempotent_single_count(engine, client):
    inviter = _login(client, "inviter")
    invitee = _recruit(client, inviter["uid"], SECOND, "nb", 1)[0]
    for _ in range(3):  # 重复读不重复计（一次性幂等）
        client.get(f"/api/v1/reports/{SECOND}/chapters", headers=invitee)
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["effective_count"] == 1 and _vouchers(inviter["uid"], "invite") == 1


def test_read_leg_scoped_to_attributed_report(engine, client):
    """读他报告（无归因关系）不触发本关系的 effective（按 (invitee,report) 判）。"""
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    client.get(f"/api/v1/reports/{PILOT}/chapters", headers=invitee)
    assert _relation_status(invitee["uid"], SECOND) == "registered"


def test_unlock_flip_keeps_effective_rows(engine, client):
    """L1 解锁批量翻 unlocked 不吞 effective 行；未生效行翻后仍可再读补生效。"""
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    h1, h2 = _login(client, "nb1"), _login(client, "nb2")
    for h in (h1, h2):
        client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=h)
    client.get(f"/api/v1/reports/{SECOND}/chapters", headers=h1)  # 首位生效→L1 翻转
    assert _relation_status(h1["uid"], SECOND) == "effective"
    assert _relation_status(h2["uid"], SECOND) == "unlocked"  # 未生效行被批量翻
    client.get(f"/api/v1/reports/{SECOND}/chapters", headers=h2)  # unlocked 可再补生效
    assert _relation_status(h2["uid"], SECOND) == "effective"
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["effective_count"] == 2 and d["progress"]["new_users"] == 2


# ── 停留腿（判据②：累计满 3 分钟）──────────────────────────────────
def test_dwell_accumulates_to_effective(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    r1 = client.post("/api/v1/invite/dwell",
                     json={"report_id": SECOND, "seconds": 100}, headers=invitee)
    assert r1.status_code == 200 and r1.json()["effective"] is False
    assert _relation_status(invitee["uid"], SECOND) == "registered"
    r2 = client.post("/api/v1/invite/dwell",
                     json={"report_id": SECOND, "seconds": 100}, headers=invitee)
    assert r2.json()["accumulated_seconds"] == 200 and r2.json()["effective"] is True
    assert _relation_status(invitee["uid"], SECOND) == "effective"
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["effective_count"] == 1 and d["level"] == "L1"


def test_dwell_single_call_clamped(engine, client):
    """单次上报 clamp [1,600]：9999→600 一次即达标。"""
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 9999}, headers=invitee)
    assert r.json()["accumulated_seconds"] == 600 and r.json()["effective"] is True


def test_dwell_zero_seconds_clamps_to_one(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 0}, headers=invitee)
    assert r.status_code == 200 and r.json()["accumulated_seconds"] == 1
    assert r.json()["effective"] is False


def test_dwell_total_cap_600(engine, client):
    """刷量防线：每关系累计上限 600s，封顶后不再计入。"""
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    client.post("/api/v1/invite/dwell",
                json={"report_id": SECOND, "seconds": 600}, headers=invitee)
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 600}, headers=invitee)
    body = r.json()
    assert body["accumulated_seconds"] == 600 and body["capped"] is True
    with store._db() as c:  # 账上只计 600（第二笔截 0 不落死账）
        total = c.execute(
            "SELECT COALESCE(SUM(seconds),0) s FROM invite_dwell").fetchone()["s"]
    assert total == 600


def test_dwell_no_relation_always_200_false(engine, client):
    """无归因关系→{relation_marked:false} 恒 200（归因降级不报错）。"""
    user = _login(client, "lonely")
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 300}, headers=user)
    assert r.status_code == 200 and r.json() == {"relation_marked": False}
    ghost = client.post("/api/v1/invite/dwell",
                        json={"report_id": "ghost-report", "seconds": 300},
                        headers=user)
    assert ghost.status_code == 200 and ghost.json() == {"relation_marked": False}


def test_dwell_requires_login(engine, client):
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 100})
    assert r.status_code == 401


def test_dwell_below_threshold_no_effect(engine, client):
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    invitee = _login(client, "newbie1")
    client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=invitee)
    r = client.post("/api/v1/invite/dwell",
                    json={"report_id": SECOND, "seconds": 179}, headers=invitee)
    assert r.json()["relation_marked"] is True and r.json()["effective"] is False
    assert _relation_status(invitee["uid"], SECOND) == "registered"


def test_dwell_leg_drives_l2(engine, client):
    """停留腿同样驱动梯队（5 位纯 dwell 达 L2）。"""
    inviter = _login(client, "inviter")
    _recruit(client, inviter["uid"], SECOND, "dw", 5, leg="dwell")
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["level"] == "L2" and d["effective_count"] == 5
    assert _vouchers(inviter["uid"], "intellect_l2") == 1


# ── 三档梯队（只升不降；每级一次闩锁）──────────────────────────────
def test_l2_analyst_200_voucher_and_first_read(engine, client):
    inviter = _login(client, "inviter")
    _recruit(client, inviter["uid"], SECOND, "nb", 5)
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["level"] == "L2" and d["level_name"] == "分析师"
    assert d["next_threshold"] == 20
    assert [s["reached"] for s in d["ladder"]] == [True, True, False]
    assert d["voucher_earned_fen"] == 25000  # 5000+20000
    assert client.get("/api/v1/me", headers=inviter).json()["vouchers_balance_fen"] == 25000
    assert _vouchers(inviter["uid"], "intellect_l2") == 1
    flags = json.loads((store.get_user(inviter["uid"]) or {})["flags"])
    assert flags.get("intellect_l2") is True and flags.get("first_read") is True


def test_l3_intellect_officer_1000_voucher_and_badge(engine, client):
    inviter = _login(client, "inviter")
    _recruit(client, inviter["uid"], SECOND, "nb", 20)
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["level"] == "L3" and d["level_name"] == "情报官"
    assert d["next_threshold"] is None
    assert all(s["reached"] for s in d["ladder"])
    assert d["voucher_earned_fen"] == 5000 + 20000 + 100000
    assert _vouchers(inviter["uid"], "intellect_l3") == 1
    flags = json.loads((store.get_user(inviter["uid"]) or {})["flags"])
    assert flags.get("intellect_l3") is True and flags.get("weekly_badge") is True


def test_ladder_latch_issues_once_only(engine, client):
    inviter = _login(client, "inviter")
    _recruit(client, inviter["uid"], SECOND, "nb", 5)
    for _ in range(3):  # 多次自愈判定不双发（flags 闩锁幂等）
        client.get("/api/v1/invite/relations", headers=inviter)
        client.get("/api/v1/me", headers=inviter)
    assert _vouchers(inviter["uid"], "invite") == 1
    assert _vouchers(inviter["uid"], "intellect_l2") == 1
    _recruit(client, inviter["uid"], SECOND, "extra", 1)  # 门槛过后再进人：奖励不重发
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["effective_count"] == 6 and d["level"] == "L2"  # 只升不降
    assert d["voucher_earned_fen"] == 25000


def test_old_criteria_grandfathered_no_rollback(engine, client):
    """旧口径衔接：已按「邀 2 新用户」达成发放过的（flags 已闩）不回退不重发。"""
    inviter = _login(client, "inviter")
    scene = _seed_code(_scene(SECOND, inviter["uid"]), SECOND, inviter["uid"])
    aged = [_login(client, "old1"), _login(client, "old2")]
    for h in aged:
        client.post("/api/v1/invite/scan", json={"scene": scene, **ENTRY}, headers=h)
    now = store.now()
    with store._db() as c:  # 旧口径达成态直造：关系已翻 unlocked+flags 已闩+50 券已发
        c.execute("UPDATE invite_relation SET status='unlocked', unlocked_at=?"
                  " WHERE inviter_uid=?", (now, inviter["uid"]))
        c.execute("UPDATE users SET flags=? WHERE id=?",
                  (json.dumps({"invite_unlocked": True,
                               "invite_unlocked_at": now}, ensure_ascii=False),
                   inviter["uid"]))
        c.execute(
            "INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
            "created_at) VALUES(?,?,?,?,?,'active',?)",
            ("vold", inviter["uid"], 5000, "invite", f"unlock:{inviter['uid']}", now))
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d["level"] == "L1" and d["level_name"] == "观察员"  # 闩锁托底：只升不降
    assert d["effective_count"] == 0 and d["next_threshold"] == 5
    assert d["progress"] == {"new_users": 0, "required": 1, "unlocked": True}
    assert d["voucher_earned_fen"] == 5000  # 不重发（仍 1 张）
    assert _vouchers(inviter["uid"], "invite") == 1
    assert d["ladder"][0]["reached"] is True  # 闩锁位 reached
    # 旧关系再阅读→起算 effective（L2 通道不受影响）
    client.get(f"/api/v1/reports/{SECOND}/chapters", headers=aged[0])
    d2 = client.get("/api/v1/invite/relations", headers=inviter).json()
    assert d2["effective_count"] == 1 and d2["level"] == "L1"


# ── 冻结契约形状（前端 w3b-F 对接口径）──────────────────────────────
def test_me_invite_block_frozen_shape(engine, client):
    user = _login(client, "fresh")
    me = client.get("/api/v1/me", headers=user).json()
    inv = me["invite"]
    assert set(inv) == {"level", "level_name", "effective_count",
                        "next_threshold", "ladder"}
    assert inv["level"] == "none" and inv["level_name"] == ""
    assert inv["effective_count"] == 0 and inv["next_threshold"] == 1
    assert len(inv["ladder"]) == 3
    assert inv["ladder"][0] == {"level": "L1", "name": "观察员",
                                "threshold": 1, "reached": False}
    assert inv["ladder"][1]["name"] == "分析师" and inv["ladder"][1]["threshold"] == 5
    assert inv["ladder"][2] == {"level": "L3", "name": "情报官",
                                "threshold": 20, "reached": False}


def test_relations_contract_top_level_fields(engine, client):
    """/invite/relations：五新字段顶层并立，legacy 字段全保留（new_users=有效
    带新数、required=1）。"""
    inviter = _login(client, "inviter")
    _recruit(client, inviter["uid"], SECOND, "nb", 1)
    d = client.get("/api/v1/invite/relations", headers=inviter).json()
    for key in ("level", "level_name", "effective_count", "next_threshold", "ladder"):
        assert key in d
    for key in ("invited", "progress", "voucher_earned_fen"):  # 现有字段全保留
        assert key in d
    assert d["level"] == "L1" and d["progress"]["new_users"] == d["effective_count"] == 1
    assert d["progress"]["required"] == 1 and d["progress"]["unlocked"] is True
    assert d["next_threshold"] == 5
