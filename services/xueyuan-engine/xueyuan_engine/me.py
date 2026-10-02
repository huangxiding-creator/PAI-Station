# -*- coding: utf-8 -*-
"""我的域——GET /me（已购权益+收藏）+ POST/DELETE /reports/{id}/favorite（FR-P0-09）。

收藏以服务端状态为真源（favorites 增补表，ARCHITECTURE §六）；重复 POST/DELETE
均幂等 200。Phase 8 切片①新增模块（目录规划外增补：用户侧聚合腿，逻辑微服务）。
"""
from __future__ import annotations

from fastapi import APIRouter, Request

from . import config, store, voucher, wechat
from .catalog import get_report
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["me"])


def _uid(request: Request) -> str:
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    return store.get_or_create_user(openid)["id"]


@router.get("/me")
def me(request: Request):
    """已购 entitlements+收藏列表（P1 扩展字段向后兼容追加）。"""
    uid = _uid(request)
    user = store.get_user(uid) or {}
    from . import invite as _invite  # 局部导入防环（invite 顶层引 me._uid）
    with store._db() as c:
        ents = c.execute(
            "SELECT report_id,source,order_id,granted_at,expires_at FROM entitlements"
            " WHERE user_id=? ORDER BY granted_at DESC", (uid,)).fetchall()
        favs = c.execute(
            "SELECT report_id,created_at FROM favorites WHERE user_id=?"
            " ORDER BY created_at DESC", (uid,)).fetchall()
    return {
        "uid": uid, "nickname": user.get("nickname", ""),
        "entitlements": [dict(e) for e in ents],
        "favorites": [{"report_id": f["report_id"], "favorited_at": f["created_at"]}
                      for f in favs],
        "vouchers_balance_fen": voucher.balance_fen(uid),  # 书券账本实值（T-P1-14）
        "refund_count_month": user.get("refund_count_month", 0),
        "refund_monthly_limit": config.REFUND_MONTHLY_LIMIT,
        "invite": _invite.ladder_payload(uid),  # 情报官梯队冻结契约块（v1.2 §六）
    }


@router.post("/reports/{rid}/favorite")
def favorite_add(rid: str, request: Request):
    uid = _uid(request)
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO favorites(user_id,report_id,created_at) VALUES(?,?,?)",
            (uid, rid, store.now()),
        )
    return {"favorited": True}


@router.delete("/reports/{rid}/favorite")
def favorite_del(rid: str, request: Request):
    uid = _uid(request)
    if not get_report(rid):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    with store._LOCK, store._db() as c:
        c.execute("DELETE FROM favorites WHERE user_id=? AND report_id=?", (uid, rid))
    return {"favorited": False}
