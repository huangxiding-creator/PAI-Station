# -*- coding: utf-8 -*-
"""点赞赠域 [P1]——POST /reports/{id}/like：站内点赞必得一份赠阅（FR-P1-01；API P1-1）。

与分享行为完全解耦：得赠唯一入口=本端点——share_event/海报/收藏/扫码皆不
触发放（因果解耦断言见 tests/test_gift.py）。赠品池=该用户未购（无
entitlements）的在售报告随机指定一份；随机性仅在「指定哪份」，确定的
是「一定送」（必得·附条件赠送，NFR-09 无概率公示义务）。随机种子可经
XY_GIFT_SEED 注入（测试确定性）；不设即真随机。每日限 1 份判据=
gift_grants UNIQUE(user_id,grant_date)（写入碰撞=当日第二赞→429）。
数字口径对齐 AGREEMENT_COPY §三（文案真源不归本域改）。
"""
from __future__ import annotations

import os
import random
import sqlite3
import uuid

from fastapi import APIRouter, Request

from . import store
from .catalog import get_report
from .errors import ApiError
from .me import _uid

router = APIRouter(prefix="/api/v1", tags=["gift"])

GIFT_RULE = "每日限 1 份·必得·附条件赠送"  # 契约文案（API P1-1 gift_rule 字段）


def _today() -> str:
    """当日日期（UTC+8 DATE）——每日限 1 份判据键（测试 monkeypatch 造跨天边界）。"""
    return store.now()[:10]


def _gift_seed() -> int | None:
    """随机种子注入位（XY_GIFT_SEED，仅测试进程用；不设=None 即真随机）。"""
    v = os.environ.get("XY_GIFT_SEED", "")
    return int(v) if v.isdigit() else None


def choose_gift(candidates: list[str], seed: int | None) -> str:
    """从候选报告 ID 纯函数随机指定一份（入参不可变；空候选由调用方先拒）。"""
    return random.Random(seed).choice(list(candidates))


def _unowned_report_ids(uid: str) -> list[str]:
    """用户未购清单（在售且无任何来源权益；确定性排序保测试稳定）。"""
    with store._db() as c:
        rows = c.execute(
            "SELECT id FROM reports WHERE status='on' AND id NOT IN"
            " (SELECT report_id FROM entitlements WHERE user_id=?) ORDER BY id",
            (uid,),
        ).fetchall()
    return [r["id"] for r in rows]


@router.post("/reports/{rid}/like")
def like(rid: str, request: Request):
    """当日首次点赞→必得一份未购随机报告（赠阅权益立即可全文阅读）。

    错误：401 未登录｜404 REPORT_NOT_FOUND｜429 GIFT_DAILY_LIMIT（当日已得，
    「明日再来」）｜409 GIFT_POOL_EMPTY（已拥有全部在售报告，池空兜底）。
    """
    uid = _uid(request)
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    candidates = _unowned_report_ids(uid)
    if not candidates:
        raise ApiError(409, "GIFT_POOL_EMPTY", "您已拥有全部在售报告，暂无可赠报告")
    # 产品口径「第二个情报源」（REQUIREMENTS 用户故事）：优先不送被点赞的那份；
    # 池仅剩它时仍必得（必得承诺优先于不重样偏好）
    pool = [r for r in candidates if r != rid] or candidates
    granted_rid = choose_gift(pool, _gift_seed())
    with store._LOCK, store._db() as c:
        try:
            c.execute(
                "INSERT INTO gift_grants(id,user_id,liked_report_id,granted_report_id,"
                "grant_date,created_at) VALUES(?,?,?,?,?,?)",
                (f"g{uuid.uuid4().hex[:16]}", uid, rid, granted_rid,
                 _today(), store.now()),
            )
        except sqlite3.IntegrityError:  # UNIQUE(user_id,grant_date)：当日第二赞
            raise ApiError(429, "GIFT_DAILY_LIMIT",
                           "今日赠阅已领取，明日再来") from None
        c.execute(  # 赠阅权益（UNIQUE(user,report,source) 幂等；source=gift）
            "INSERT OR IGNORE INTO entitlements(id,user_id,report_id,source,order_id,"
            "granted_at) VALUES(?,?,?,?,?,?)",
            (f"e{uuid.uuid4().hex[:16]}", uid, granted_rid, "gift", "", store.now()),
        )
    return {"granted": True, "granted_report_id": granted_rid, "gift_rule": GIFT_RULE}
