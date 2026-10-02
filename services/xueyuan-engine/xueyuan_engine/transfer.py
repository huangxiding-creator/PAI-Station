# -*- coding: utf-8 -*-
"""转赠域 [P2]——POST /reports/{rid}/transfer：水印版转赠 1 次（FR-P2-04）。

v1.2 对齐（AGREEMENT_COPY §四「转赠规则」已生效，2026-09-28）：
- 转赠范围=仅限本人付费购买（entitlements source='purchase'；组队在本引擎
  落 source='invite'）——获赠/兑换/组队/受赠报告→403 NOT_TRANSFERABLE；
- 与退款互斥：(uid,rid) 存在未完结批评/退款→409 REFUND_IN_FLIGHT
  （须先完结再转赠）；
- 转赠后不可再批评退款：转出成功同事务把 (uid,rid) 已付订单推进
  status='transferred'——criticize/refund 的已购闸（orders paid/delivered）
  自然拒之，无需改动那两个域。

语义（REQUIREMENTS FR-P2-04 验收锚点）：
- 每报告终身 1 次：transfers UNIQUE(report_id, from_user) 写入碰撞→
  409 ALREADY_TRANSFERRED（第二次转赠被拒）；
- 转出即失权益：转出方该报告全部 entitlements 当场删除（阅读/下载立即
  失权——付费章 403、/me 权益消失）；受赠方得 source='transfer' 权益
  （受赠的报告不可再转赠=NOT_TRANSFERABLE 闸天然覆盖；水印细节归 download
  域，引擎只记账）。
受赠方解析：to_uid 直查；to_openid_hash=sha256(openid) 十六进制（与
uid 派生规则 u+sha256[:10] 同源，取前 10 位即可定位，openid 本体不外泄）。
错误：401｜404 REPORT_NOT_FOUND｜409 ALREADY_TRANSFERRED（已转）｜
403 NOT_ENTITLED（未购）｜403 NOT_TRANSFERABLE（非本人付费购买）｜
409 REFUND_IN_FLIGHT（未完结批评/退款）｜403 TRANSFER_SELF（自赠）｜
409 ALREADY_ENTITLED（受赠方已有）｜404 USER_NOT_FOUND｜400 INVALID_PARAM。
"""
from __future__ import annotations

import logging
import re
import sqlite3
import uuid

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import store
from .catalog import get_report
from .errors import ApiError
from .me import _uid

router = APIRouter(prefix="/api/v1", tags=["transfer"])
logger = logging.getLogger("xueyuan.transfer")

TRANSFER_RULE = "每份报告终身限转赠 1 次·转出即失去该报告阅读权"
_HEX_RE = re.compile(r"^[0-9a-f]{10,64}$")
# 未完结态镜像（criticize/refund 域状态机只读镜像——两域禁碰，漂移须同步此处）：
# criticisms: pending_score（评分中）/scored（可发起退款）/manual_pending（人工
# 复核中）/approved（已批待执行）→ 终态仅 rejected/closed；
# refunds: initiated/notify_received → 终态 settled/failed
_CRITICISM_OPEN_STATES = ("pending_score", "scored", "manual_pending", "approved")
_REFUND_OPEN_STATES = ("initiated", "notify_received")


def _refund_in_flight(c, uid: str, rid: str) -> bool:
    """(uid,rid) 是否存在未完结批评/退款（v1.2 §四：与退款互斥判据）。"""
    marks = ",".join("?" * len(_CRITICISM_OPEN_STATES))
    if c.execute(
        f"SELECT 1 FROM criticisms WHERE user_id=? AND report_id=?"
        f" AND status IN ({marks}) LIMIT 1", (uid, rid, *_CRITICISM_OPEN_STATES),
    ).fetchone():
        return True
    marks = ",".join("?" * len(_REFUND_OPEN_STATES))
    return c.execute(
        f"SELECT 1 FROM refunds r JOIN orders o ON o.out_trade_no=r.order_id"
        f" WHERE r.user_id=? AND o.report_id=? AND r.status IN ({marks}) LIMIT 1",
        (uid, rid, *_REFUND_OPEN_STATES),
    ).fetchone() is not None


class TransferIn(BaseModel):
    to_openid_hash: str = ""
    to_uid: str = ""


def _recipient_uid(body: TransferIn) -> str:
    """受赠方 uid 解析（纯函数式校验；错误就地 ApiError）。"""
    explicit = (body.to_uid or "").strip()
    h = (body.to_openid_hash or "").strip().lower()
    from_hash = ""
    if h:
        if not _HEX_RE.fullmatch(h):
            raise ApiError(400, "INVALID_PARAM",
                           "to_openid_hash 须为 sha256 十六进制（≥10 位）")
        from_hash = "u" + h[:10]
    if explicit and from_hash and explicit != from_hash:
        raise ApiError(400, "INVALID_PARAM", "to_uid 与 to_openid_hash 指向不同用户")
    target = explicit or from_hash
    if not target:
        raise ApiError(400, "INVALID_PARAM", "缺少受赠方标识（to_uid / to_openid_hash）")
    return target


@router.post("/reports/{rid}/transfer")
def transfer_report(rid: str, body: TransferIn, request: Request):
    uid = _uid(request)
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    target_uid = _recipient_uid(body)
    with store._db() as c:
        prior = c.execute(
            "SELECT id FROM transfers WHERE report_id=? AND from_user=?",
            (rid, uid)).fetchone()
        owned = c.execute(
            "SELECT source FROM entitlements WHERE user_id=? AND report_id=?"
            " ORDER BY CASE source WHEN 'purchase' THEN 0 ELSE 1 END", (uid, rid)
        ).fetchall()
        in_flight = _refund_in_flight(c, uid, rid)
        target_has = c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (target_uid, rid)).fetchone()
    if prior:  # 已转（先于未购判：转出方权益已删，须报「已转」而非「未购」）
        raise ApiError(409, "ALREADY_TRANSFERRED",
                       "该报告已转赠过（每份报告终身限转 1 次）")
    if not owned:
        raise ApiError(403, "NOT_ENTITLED", "尚未持有该报告权益，不可转赠")
    if not any(r["source"] == "purchase" for r in owned):  # v1.2 §四：仅限本人付费购买
        raise ApiError(403, "NOT_TRANSFERABLE",
                       "仅限本人付费购买解锁的报告可转赠（获赠/兑换/组队报告不可转）")
    if in_flight:  # v1.2 §四：与退款互斥（未完结批评/退款先完结再转）
        raise ApiError(409, "REFUND_IN_FLIGHT",
                       "存在未完结的批评评分退款申请，须先完结再转赠")
    if target_uid == uid:
        raise ApiError(403, "TRANSFER_SELF", "不能把报告转赠给自己")
    if target_has:
        raise ApiError(409, "ALREADY_ENTITLED", "受赠方已拥有该报告，无需转赠")
    if not store.get_user(target_uid):
        raise ApiError(404, "USER_NOT_FOUND", "受赠方账号不存在")
    tid = f"t{uuid.uuid4().hex[:16]}"
    from_source = owned[0]["source"]
    with store._LOCK, store._db() as c:
        try:
            c.execute(
                "INSERT INTO transfers(id,report_id,from_user,to_user,from_source,"
                "created_at) VALUES(?,?,?,?,?,?)",
                (tid, rid, uid, target_uid, from_source, store.now()),
            )
        except sqlite3.IntegrityError:  # UNIQUE(report_id,from_user)：并发二次转
            raise ApiError(409, "ALREADY_TRANSFERRED",
                           "该报告已转赠过（每份报告终身限转 1 次）") from None
        c.execute(  # 转出即失权益（该报告全部来源一并清）
            "DELETE FROM entitlements WHERE user_id=? AND report_id=?", (uid, rid))
        c.execute(  # 受赠方得 transfer 权益（幂等；order_id 位挂转赠单号可溯源）
            "INSERT OR IGNORE INTO entitlements(id,user_id,report_id,source,order_id,"
            "granted_at) VALUES(?,?,?,?,?,?)",
            (f"e{uuid.uuid4().hex[:16]}", target_uid, rid, "transfer", tid,
             store.now()),
        )
        c.execute(  # v1.2 §四：转后不可再批评/退款——订单脱离已付态（已购闸自然拒；
            #           发票仍按本购买记录开具，行不删）
            "UPDATE orders SET status='transferred' WHERE user_id=? AND report_id=?"
            " AND status IN ('paid','delivered')", (uid, rid))
    logger.info("transfer %s: %s -> %s (from_source=%s)", rid, uid, target_uid,
                from_source)
    return {"transferred": True, "transfer_id": tid, "report_id": rid,
            "from_uid": uid, "to_uid": target_uid, "transferred_at": store.now(),
            "rule": TRANSFER_RULE}
