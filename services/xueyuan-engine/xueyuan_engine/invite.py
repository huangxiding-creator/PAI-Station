# -*- coding: utf-8 -*-
"""邀请域 [P1]——POST /invite/scan 扫码归因+GET /invite/relations 进度
+POST /invite/dwell 停留上报（FR-P1-08/09；API P1-7/8；v1.2 §六情报官体系）。

首触归因：invite_relation UNIQUE(invitee_uid,report_id) 先到先记，再扫他人
海报不覆盖。scene 解析失败/短码查不到→degraded 免费兜底（归因降级不报错，
免费内容优先于归因，FR-P1-07 判据）。
新用户判据=扫码登录时账号 last_seen_at 尚空且注册未满 24h（新ness 信号在
登录边界本不归属本域——app.py 写权限受限，此为引擎侧可得的最诚实代理，
固化口径升 config.py 属主会话裁决项）。

有效带新（AGREEMENT_COPY v1.2 §六）：关系状态机 scanned/registered/unlocked
→ effective（一次性幂等，只进不出），两腿触发——
- 读腿：GET /reports/{rid}/chapters 带 Bearer（chapters 域挂
  invite.mark_effective 纯副作用钩子，响应形状不变）=「完整阅读≥1 章试读」；
- 停留腿：POST /invite/dwell 上报秒数 clamp [1,600]，按 (invitee,report)
  累计 ≥DWELL_EFFECTIVE_SECONDS（180s=满 3 分钟）置 effective；每关系累计
  上限 DWELL_RELATION_TOTAL_CAP（600s 刷量防线）；无归因关系→恒 200 降级。
情报官梯队（只升不降，每级一次 flags 闩锁防双发）：L1=1 位有效带新→馆友
解锁（invite_unlocked 闩锁沿用——旧口径「邀 2 新用户」已发放的不回退不
重发）+50 书券（source=invite）；L2=5 位→200 券（source=intellect_l2）
+first_read 权益位；L3=20 位→1000 券（source=intellect_l3）+weekly_badge
权益位。/me invite 块与 /invite/relations 共用 ladder_payload（冻结契约，
前端 w3b-F 对接口径）。
"""
from __future__ import annotations

import json
import uuid
from datetime import datetime, timedelta

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, poster, store, wechat
from .catalog import get_report
from .errors import ApiError
from .me import _uid

router = APIRouter(prefix="/api/v1", tags=["invite"])

INVITE_REWARD_FEN = 5000    # L1 奖励 50 书券=5000 分（AGREEMENT_COPY §六）
NEW_USER_WINDOW_HOURS = 24  # 新用户判据窗：注册未满 24h 且从未扫码


def parse_scene(scene: str) -> tuple[str, str]:
    """scene → (report_id, inviter_uid)；解析失败 ("", "")。

    委托 poster.parse_scene 真源（官方契约校验：合法字符集/≤32 可见字符；
    s= 短码经 poster.lookup_code 码池还原并验 report_id 非空）——E1/E3 并行期
    双实现归一，防漂移（E3 报告缝合缝项）。查不到/非法 → ("", "") 降级兜底。
    卡码 c=<card_id>&i=<uid> 走 poster.parse_card_scene 纯解析+cards 索引把
    card_id 反查为 report_id（查不到 ("", "") 降级）——首触/有效带新判据全部
    复用本域既有路径，不新建归因路径。卡短码 s=<8hex>（真实卡常态形态，直拼
    超 32 上限的根治通道）在 poster_code 未命中时回落 card_code。
    """
    if isinstance(scene, str) and scene.strip().startswith("c="):
        from . import cards as _cards  # 局部导入防环（cards→invite 链不回本域）
        res = poster.parse_card_scene(scene)
        if not res:
            return ("", "")
        card_id, inviter = res
        card = _cards.find_card(card_id)
        rid = str(card.get("report_id") or "") if card else ""
        return (rid, inviter or "") if rid else ("", "")
    res = poster.parse_scene(scene, code_lookup=poster.lookup_code)
    if not res and isinstance(scene, str) and scene.strip().startswith("s="):
        from . import cards as _cards  # 局部导入防环（同上）
        res = _cards.card_code_lookup(scene.strip())
    return (res[0], res[1] or "") if res else ("", "")


def _within_hours(ts: str, hours: float) -> bool:
    """ISO-8601 文本距今是否在 hours 窗内（解析失败=窗外，保守不计新）。"""
    try:
        return datetime.fromisoformat(ts) >= datetime.now(store._TZ8) - timedelta(hours=hours)
    except (ValueError, TypeError):
        return False


def _record_relation(inviter: str, invitee_uid: str, rid: str, scene_code: str) -> None:
    """首触关系落库（UNIQUE(invitee,report) 先到先记，INSERT OR IGNORE 不覆盖）。"""
    user = store.get_user(invitee_uid) or {}
    is_new = not user.get("last_seen_at") and _within_hours(
        str(user.get("created_at") or ""), NEW_USER_WINDOW_HOURS)
    status = "registered" if is_new else "scanned"
    now = store.now()
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO invite_relation(id,inviter_uid,invitee_uid,report_id,"
            "scene_code,status,ts) VALUES(?,?,?,?,?,?,?)",
            (f"i{uuid.uuid4().hex[:16]}", inviter, invitee_uid, rid, scene_code,
             status, now),
        )
        c.execute("UPDATE users SET last_seen_at=? WHERE id=?", (now, invitee_uid))


# ── 有效带新（v1.2 §六：状态机扩展+两腿判据）──────────────────────────
def _effective_count(inviter_uid: str) -> int:
    """有效带新数=DISTINCT invitee 且关系 status='effective'（首触归因去重）。"""
    with store._db() as c:
        return c.execute(
            "SELECT COUNT(DISTINCT invitee_uid) n FROM invite_relation"
            " WHERE inviter_uid=? AND status='effective'", (inviter_uid,),
        ).fetchone()["n"]


def mark_effective(invitee_uid: str, rid: str) -> bool:
    """置有效带新（一次性幂等）：scanned/registered/unlocked → effective。

    读腿（chapters 域纯副作用钩子）与停留腿（dwell 达标）共用；unlocked 纳入
    翻转集=旧口径已解锁关系再阅读仍可起算 L2/L3。首次翻转后即时评估邀请人
    梯队。返回是否本次翻转（幂等重入 False）。
    """
    with store._LOCK, store._db() as c:
        cur = c.execute(
            "UPDATE invite_relation SET status='effective' WHERE invitee_uid=?"
            " AND report_id=? AND status IN ('scanned','registered','unlocked')",
            (invitee_uid, rid))
        flipped = cur.rowcount > 0
        inviter = c.execute(
            "SELECT inviter_uid FROM invite_relation WHERE invitee_uid=? AND report_id=?",
            (invitee_uid, rid)).fetchone()
    if flipped and inviter:
        _evaluate_ladder(inviter["inviter_uid"])
    return flipped


def _evaluate_ladder(inviter_uid: str) -> None:
    """梯队判定（幂等，只升不降）：有效带新过阈→该级 flags 闩锁+书券+权益位。

    L1=馆友解锁+50 券（沿用 invite_unlocked 闩锁：旧口径已达成发放过的不回退
    不重发）；L2=200 券+first_read；L3=1000 券+weekly_badge。闩锁=users.flags
    CAS（WHERE flags=旧值），并发双判后到者碰撞即退出；发放/关系翻转/权益位
    同事务原子完成。GET /invite/relations 与 /me 也调本函数（自愈）。
    """
    user = store.get_user(inviter_uid) or {}
    old_flags = str(user.get("flags") or "{}")
    flags = json.loads(old_flags)
    if all(flags.get(k) for k in ("invite_unlocked", "intellect_l2", "intellect_l3")):
        return  # 三级全闩（快路径）
    n = _effective_count(inviter_uid)
    l1_hit = not flags.get("invite_unlocked") and n >= config.LADDER_THRESHOLDS[0]
    l2_hit = not flags.get("intellect_l2") and n >= config.LADDER_THRESHOLDS[1]
    l3_hit = not flags.get("intellect_l3") and n >= config.LADDER_THRESHOLDS[2]
    if not (l1_hit or l2_hit or l3_hit):
        return
    now = store.now()
    new_flags = dict(flags)
    if l1_hit:
        new_flags = {**new_flags, "invite_unlocked": True, "invite_unlocked_at": now}
    if l2_hit:
        new_flags = {**new_flags, "intellect_l2": True, "intellect_l2_at": now,
                     "first_read": True}
    if l3_hit:
        new_flags = {**new_flags, "intellect_l3": True, "intellect_l3_at": now,
                     "weekly_badge": True}
    with store._LOCK, store._db() as c:
        cur = c.execute("UPDATE users SET flags=? WHERE id=? AND flags=?",
                        (json.dumps(new_flags, ensure_ascii=False), inviter_uid,
                         old_flags))
        if cur.rowcount != 1:
            return  # 他人已闩锁（并发双判），幂等退出
        if l1_hit:
            c.execute(  # effective 行不在 IN 集，不会被翻回 unlocked（只进不出）
                "UPDATE invite_relation SET status='unlocked', unlocked_at=?"
                " WHERE inviter_uid=? AND status IN ('scanned','registered')",
                (now, inviter_uid),
            )
            c.execute(  # 50 书券入账（source_ref=解锁单号，对账可溯）
                "INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
                "created_at) VALUES(?,?,?,?,?,'active',?)",
                (f"v{uuid.uuid4().hex[:16]}", inviter_uid, INVITE_REWARD_FEN, "invite",
                 f"unlock:{inviter_uid}", now),
            )
        if l2_hit:
            c.execute(  # 200 书券（source_ref=等级单号，对账可溯）
                "INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
                "created_at) VALUES(?,?,?,?,?,'active',?)",
                (f"v{uuid.uuid4().hex[:16]}", inviter_uid, config.INTELLECT_L2_FEN,
                 "intellect_l2", f"intellect_l2:{inviter_uid}", now),
            )
        if l3_hit:
            c.execute(  # 1000 书券
                "INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
                "created_at) VALUES(?,?,?,?,?,'active',?)",
                (f"v{uuid.uuid4().hex[:16]}", inviter_uid, config.INTELLECT_L3_FEN,
                 "intellect_l3", f"intellect_l3:{inviter_uid}", now),
            )


def ladder_payload(uid: str) -> dict:
    """情报官梯队契约块（冻结契约，前端 w3b-F 正按此写；/me invite 块与
    /invite/relations 共用）：level/level_name/effective_count/next_threshold/
    ladder。等级=有效带新数与 flags 闩锁取高者（只升不降：旧口径已闩的不因
    判据升级回退）。
    """
    _evaluate_ladder(uid)  # 自愈判定（幂等闩锁）
    user = store.get_user(uid) or {}
    flags = json.loads(str(user.get("flags") or "{}"))
    latches = (bool(flags.get("invite_unlocked")), bool(flags.get("intellect_l2")),
               bool(flags.get("intellect_l3")))
    n = _effective_count(uid)
    idx = 0
    for i, th in enumerate(config.LADDER_THRESHOLDS):
        if n >= th or latches[i]:
            idx = i + 1
    ladder = [{"level": f"L{i + 1}", "name": config.LADDER_NAMES[i], "threshold": th,
               "reached": bool(n >= th or latches[i])}
              for i, th in enumerate(config.LADDER_THRESHOLDS)]
    return {
        "level": "none" if idx == 0 else f"L{idx}",
        "level_name": "" if idx == 0 else config.LADDER_NAMES[idx - 1],
        "effective_count": n,
        "next_threshold": (config.LADDER_THRESHOLDS[idx]
                           if idx < len(config.LADDER_THRESHOLDS) else None),
        "ladder": ladder,
    }


class ScanIn(BaseModel):
    scene: str
    entry_page: str = "pages/reader/reader"


@router.post("/invite/scan")
def scan(body: ScanIn, request: Request):
    """扫码进入归因（鉴权可选：匿名仅落 scan_visit，登录才建邀请关系）。

    免费兜底优先于归因：解析失败/短码查不到/邀请人无效→degraded:true +
    邀请人置空，恒 200 不报错（API P1-7 说明）。
    """
    openid = wechat.bearer_openid(request)  # 无头=None 游客；伪坏凭证 401
    scene = (body.scene or "").strip()
    rid, inviter = parse_scene(scene)
    inviter_known = bool(inviter and store.get_user(inviter))
    degraded = not (rid and inviter_known)
    scene_code = ""
    if scene and not scene.startswith("s=") and rid:
        # r=/i= 直存 scene 幂等补录码表（外键真源纪律；s= 短码必须先存在于码池）
        with store._LOCK, store._db() as c:
            c.execute(
                "INSERT OR IGNORE INTO poster_code(scene_code,report_id,inviter_uid,"
                "channel,pregenerated,created_at) VALUES(?,?,?,?,0,?)",
                (scene, rid, inviter, "scan", store.now()),
            )
        scene_code = scene
    elif scene.startswith("s=") and rid:
        scene_code = scene  # 短码已在码池（parse_scene 查到才走到这）
    uid = store.get_or_create_user(openid)["id"] if openid else None
    if scene_code:
        with store._LOCK, store._db() as c:
            c.execute(
                "INSERT INTO scan_visit(scene_code,user_id,entry_page,ts)"
                " VALUES(?,?,?,?)",
                (scene_code, uid or "", body.entry_page, store.now()),
            )
    if uid and not degraded and inviter != uid and get_report(rid):
        _record_relation(inviter, uid, rid, scene_code)
        _evaluate_ladder(inviter)
    return {"report_id": rid, "inviter_uid": inviter if inviter_known else None,
            "degraded": degraded}


class DwellIn(BaseModel):
    report_id: str
    seconds: int


@router.post("/invite/dwell")
def dwell(body: DwellIn, request: Request):
    """停留上报（有效带新判据②：累计满 3 分钟，v1.2 §六）。

    秒数 clamp [1,600]；按 (invitee,report) 累计（invite_dwell 追加式流水），
    累计 ≥DWELL_EFFECTIVE_SECONDS 置 effective；每关系累计上限
    DWELL_RELATION_TOTAL_CAP（刷量防线：封顶后不再计入）。无归因关系→
    {relation_marked:false} 恒 200（归因降级不报错，同 scan 哲学）。
    """
    uid = _uid(request)
    rid = (body.report_id or "").strip()
    sec = max(1, min(config.DWELL_REPORT_CLAMP_MAX, int(body.seconds)))
    with store._db() as c:
        rel = c.execute(
            "SELECT status FROM invite_relation WHERE invitee_uid=? AND report_id=?",
            (uid, rid)).fetchone()
        total = (c.execute(
            "SELECT COALESCE(SUM(seconds),0) s FROM invite_dwell WHERE invitee_uid=?"
            " AND report_id=?", (uid, rid)).fetchone()["s"] if rel else 0)
    if not rel:
        return {"relation_marked": False}
    add = min(sec, max(0, config.DWELL_RELATION_TOTAL_CAP - total))
    if add > 0:
        with store._LOCK, store._db() as c:
            c.execute(
                "INSERT INTO invite_dwell(invitee_uid,report_id,seconds,created_at)"
                " VALUES(?,?,?,?)", (uid, rid, add, store.now()))
    total += add
    effective = rel["status"] == "effective"
    if not effective and total >= config.DWELL_EFFECTIVE_SECONDS:
        effective = mark_effective(uid, rid)
    return {"relation_marked": True, "report_id": rid,
            "accumulated_seconds": total, "effective": effective,
            "capped": add < sec}


@router.get("/invite/relations")
def relations(request: Request):
    """邀请进度：被邀列表+progress（new_users=有效带新数，required=L1 门槛）+
    书券累计所得+情报官梯队契约块（P1-8；v1.2 §六升级）。"""
    uid = _uid(request)
    ladder = ladder_payload(uid)  # 自愈判定（幂等闩锁）+冻结契约块
    flags = json.loads((store.get_user(uid) or {}).get("flags") or "{}")
    with store._db() as c:
        rows = c.execute(
            "SELECT invitee_uid,status,ts FROM invite_relation WHERE inviter_uid=?"
            " ORDER BY ts",
            (uid,),
        ).fetchall()
        earned = c.execute(
            "SELECT COALESCE(SUM(amount_fen),0) s FROM vouchers WHERE user_id=?"
            " AND source IN ('invite','intellect_l2','intellect_l3')",
            (uid,),
        ).fetchone()["s"]
    invited = [{"invitee_uid": r["invitee_uid"], "status": r["status"], "ts": r["ts"]}
               for r in rows]
    return {"invited": invited,
            "progress": {"new_users": ladder["effective_count"],
                         "required": config.LADDER_THRESHOLDS[0],
                         "unlocked": bool(flags.get("invite_unlocked"))},
            "voucher_earned_fen": earned,
            **ladder}
