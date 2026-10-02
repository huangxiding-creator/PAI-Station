# -*- coding: utf-8 -*-
"""组队域 [P1]——3 人 ¥998 状态机：创建/加入/满员/到期（FR-P1-10；API P1-9）。

状态机：open（招募）→ full（满 3 人，全队各发 entitlements source=invite）；
open 且首笔付款起 72h（AGREEMENT_COPY §四口径）未满员 → expired（解散，
team_events 落到期事件；「未到期强退」有守卫测试）。到期惰性清扫=
expire_due_teams()（team 域写操作前必调；E2 可定时巡检同函数）。
**退款执行=E2 refund 域职责**——本域只落事件+供 due_expired_refunds()
快照（见其 docstring 对接约定），绝不实现退款本身。

座位拆档（API P1-9 TBD 默认案②）：3 座 33266/33266/33268 分合计 99800
（FR「组队订单金额=99800 分」；案①队长单笔 99800 与「各自付款」不一致须
RUN_LEDGER 变更，未采）。真支付定案前本域不进回归集（WBS T-P1-12）；
dev/测试走 XY_FAKE_PAY=1 影子支付（入队即建 per-seat orders 单直落 paid，
env=1 沙箱单不进营收对账；生产禁启自检在 app 启动腿，virtual_pay 同款纪律）。
生产闸关时创建/入队 503 TEAM_PAY_NOT_CONFIGURED——真支付回调接线位在
_pay_seat（照抄 virtual_pay.mark_paid 幂等骨架，定案后实装）。
"""
from __future__ import annotations

import json
import os
import time
import uuid
from datetime import datetime, timedelta

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store
from .catalog import get_report
from .errors import ApiError
from .me import _uid

router = APIRouter(prefix="/api/v1", tags=["team"])

CAPACITY = 3        # 3 人成队（FR-P1-10）
EXPIRE_HOURS = 72   # 首笔付款起 72h 未满员自动解散（AGREEMENT_COPY §四）


def seat_price(total_fen: int, seat_idx: int, capacity: int = CAPACITY) -> int:
    """座位差 1 分拆档：前 N-1 座 total//N，末座吃余数（合计恒=total）。"""
    base = total_fen // capacity
    return base if seat_idx < capacity - 1 else total_fen - base * (capacity - 1)


def _fake_pay_enabled() -> bool:
    return os.environ.get("XY_FAKE_PAY") == "1"


def _pay_seat(c, team_id: str, report_id: str, uid: str, seat_idx: int, now: str) -> str:
    """座位支付落单（须在 _LOCK 持有段内调用，共用调用方连接）。

    dev/测试（XY_FAKE_PAY=1 影子位）：建 per-seat orders 单并直落 paid
    （wx_order_sn='fakepay' 前缀，对账可辨假支付单；env=1 沙箱口径）。
    生产（闸关）：503 TEAM_PAY_NOT_CONFIGURED——真支付接线位在此，实装时
    建pending单+回调 mark paid 幂等推进（virtual_pay.py 同款骨架）。
    """
    if not _fake_pay_enabled():
        raise ApiError(503, "TEAM_PAY_NOT_CONFIGURED",
                       "组队支付通道开通中（虚拟支付组队拆档定案后开放）")
    out = f"{team_id}s{seat_idx}_{int(time.time())}"
    c.execute(
        "INSERT INTO orders(out_trade_no,user_id,report_id,offer_id,product_id,"
        "price_fen,env,mode,status,wx_order_sn,paid_at,created_at)"
        " VALUES(?,?,?,?,?,?,?,?,?,?,?,?)",
        (out, uid, report_id, "", config.PRODUCT_ID,
         seat_price(config.TEAM_PRICE_FEN, seat_idx), 1, "short_series_goods",
         "paid", "fakepay", now, now),
    )
    return out


def _team_view(team_id: str) -> dict:
    """契约响应形状（API P1-9：team_id/report_id/leader_uid/size/capacity/total/status）。"""
    with store._db() as c:
        t = c.execute("SELECT * FROM teams WHERE id=?", (team_id,)).fetchone()
        if not t:
            raise ApiError(404, "TEAM_NOT_FOUND", "组队不存在")
        n = c.execute("SELECT COUNT(*) n FROM team_members WHERE team_id=?",
                      (team_id,)).fetchone()["n"]
    return {"team_id": t["id"], "report_id": t["report_id"],
            "leader_uid": t["leader_uid"], "size": n, "capacity": CAPACITY,
            "total_price_fen": config.TEAM_PRICE_FEN, "status": t["status"]}


def _finalize_full(c, team_id: str, report_id: str, now: str) -> None:
    """满员收口：open→full+全队发权益（source=invite）+满员事件落账（同事务）。"""
    c.execute("UPDATE teams SET status='full' WHERE id=? AND status='open'", (team_id,))
    members = c.execute("SELECT uid FROM team_members WHERE team_id=?",
                        (team_id,)).fetchall()
    for m in members:
        c.execute(
            "INSERT OR IGNORE INTO entitlements(id,user_id,report_id,source,order_id,"
            "granted_at) VALUES(?,?,?,?,?,?)",
            (f"e{uuid.uuid4().hex[:16]}", m["uid"], report_id, "invite",
             team_id, now),
        )
    c.execute(
        "INSERT INTO team_events(id,team_id,kind,payload,ts) VALUES(?,?,?,?,?)",
        (f"ev{uuid.uuid4().hex[:16]}", team_id, "full",
         json.dumps({"team_id": team_id, "report_id": report_id,
                     "members": [m["uid"] for m in members]}, ensure_ascii=False), now),
    )


def _refund_snapshot(c, team_id: str) -> dict:
    """到期退款执行所需快照：每人座位实付额（全额退判据=按座位实付全额退）。"""
    t = c.execute("SELECT * FROM teams WHERE id=?", (team_id,)).fetchone()
    members = c.execute(
        "SELECT tm.uid, tm.out_trade_no, o.price_fen FROM team_members tm"
        " LEFT JOIN orders o ON o.out_trade_no=tm.out_trade_no WHERE tm.team_id=?",
        (team_id,),
    ).fetchall()
    return {"team_id": team_id, "report_id": t["report_id"], "status": "expired",
            "members": [{"uid": m["uid"], "out_trade_no": m["out_trade_no"],
                         "paid_fen": m["price_fen"] or 0} for m in members]}


def expire_due_teams(now: str | None = None) -> int:
    """到期清扫（幂等）：open+首笔付款满 72h 未满员→expired+事件落库。

    - 未到期不动（「未到期强退」守卫，tests/test_team.py 断言）；
    - 无任何已付座位的 open 队不计龄（支付未接线/全未付形态，契约以
      「第一笔付款完成起」为钟起点）；
    - 触发位：本域写操作前惰性清扫；E2 可挂定时巡检调用本函数（同幂等）。
    now 可注入（测试造 +72h 边界；生产缺省=store.now()）。
    """
    now = now or store.now()
    cutoff = (datetime.fromisoformat(now) - timedelta(hours=EXPIRE_HOURS)
              ).isoformat(timespec="seconds")
    with store._LOCK, store._db() as c:
        rows = c.execute(
            "SELECT t.id tid, (SELECT MIN(o.paid_at) FROM team_members tm JOIN"
            " orders o ON o.out_trade_no=tm.out_trade_no WHERE tm.team_id=t.id)"
            " first_paid FROM teams t WHERE t.status='open'",
        ).fetchall()
        due = [r["tid"] for r in rows if r["first_paid"] and r["first_paid"] <= cutoff]
        for tid in due:
            payload = _refund_snapshot(c, tid)
            c.execute("UPDATE teams SET status='expired' WHERE id=? AND status='open'",
                      (tid,))
            c.execute(
                "INSERT INTO team_events(id,team_id,kind,payload,ts) VALUES(?,?,?,?,?)",
                (f"ev{uuid.uuid4().hex[:16]}", tid, "expired",
                 json.dumps(payload, ensure_ascii=False), now),
            )
    return len(due)


def due_expired_refunds() -> list[dict]:
    """待执行的到期退款快照清单——**E2 refund 域对接接口（本域红线止步于此）**。

    调用方：refund.py 退款执行器 / E2 定时巡检（实装归退款域）。
    数据源=team_events(kind='expired').payload（uid/out_trade_no/paid_fen 三件，
    Android 原路退、iOS 等额书券的判据字段齐备）；退款执行器处理完应在
    refunds/orders 域自行记账（orders.refund_state/refunds 表），
    不回写 team_events（事件账只增不改）。
    """
    with store._db() as c:
        rows = c.execute(
            "SELECT payload FROM team_events WHERE kind='expired' ORDER BY ts"
        ).fetchall()
    return [json.loads(r["payload"]) for r in rows]


class TeamIn(BaseModel):
    report_id: str


@router.post("/team")
def create_team(body: TeamIn, request: Request):
    """开队（队长=创建者，自动占首座并支付）。

    错误：401｜404 REPORT_NOT_FOUND｜503 TEAM_PAY_NOT_CONFIGURED（生产闸未开）。
    支付失败（503）时队伍行随事务回滚——不留无付款空队。
    """
    uid = _uid(request)
    if not get_report(body.report_id):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    expire_due_teams()
    team_id = f"t{uuid.uuid4().hex[:16]}"
    now = store.now()
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO teams(id,report_id,leader_uid,status,created_at)"
            " VALUES(?,?,?,?,?)",
            (team_id, body.report_id, uid, "open", now),
        )
        out_no = _pay_seat(c, team_id, body.report_id, uid, 0, now)
        c.execute(
            "INSERT INTO team_members(team_id,uid,out_trade_no,joined_at)"
            " VALUES(?,?,?,?)",
            (team_id, uid, out_no, now),
        )
    return _team_view(team_id)


@router.post("/team/{team_id}/join")
def join_team(team_id: str, request: Request):
    """入队占座（付座位价；满 3 人即收口发全队权益）。

    错误：401｜404 TEAM_NOT_FOUND｜409 TEAM_EXPIRED（到期解散）｜
    409 TEAM_DUP（重复加入，含队长再入）｜409 TEAM_FULL（满员）｜
    503 TEAM_PAY_NOT_CONFIGURED。
    """
    uid = _uid(request)
    expire_due_teams()
    with store._db() as c:
        team = c.execute("SELECT * FROM teams WHERE id=?", (team_id,)).fetchone()
        dup = c.execute("SELECT 1 FROM team_members WHERE team_id=? AND uid=?",
                        (team_id, uid)).fetchone()
    if not team:
        raise ApiError(404, "TEAM_NOT_FOUND", "组队不存在")
    t = dict(team)
    if t["status"] == "expired":
        raise ApiError(409, "TEAM_EXPIRED", "组队已到期解散（72 小时未满员）")
    if dup:
        raise ApiError(409, "TEAM_DUP", "已在组队中，无需重复加入")
    if t["status"] != "open":
        raise ApiError(409, "TEAM_FULL", "组队已满员")
    now = store.now()
    with store._LOCK, store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM team_members WHERE team_id=?",
                      (team_id,)).fetchone()["n"]
        if n >= CAPACITY:
            raise ApiError(409, "TEAM_FULL", "组队已满员")
        out_no = _pay_seat(c, team_id, t["report_id"], uid, n, now)
        c.execute(
            "INSERT INTO team_members(team_id,uid,out_trade_no,joined_at)"
            " VALUES(?,?,?,?)",
            (team_id, uid, out_no, now),
        )
        if n + 1 >= CAPACITY:
            _finalize_full(c, team_id, t["report_id"], now)
    return _team_view(team_id)
