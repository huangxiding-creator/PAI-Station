# -*- coding: utf-8 -*-
"""书券域 [P1]——非现金内循环统一账本：发放/核销/余额（FR-P1-11；API P1-10；SCHEMAS §8）。

账本式追加（只增不删，并发安全=store._LOCK+短连接既有模式）：
- 发放=INSERT vouchers 行（面值不可变）；
- 核销=INSERT voucher_burns 流水（部分核销不动 vouchers 行），烧尽的券才置
  status='used'+used_order_id（契约「核销以 vouchers.used_order_id 唯一」幂等键）；
- 余额=Σ发放-Σ核销——发放/余额/来源明细三条一致可查（WBS T-P1-14 判据）。
49800 分（498 券，1 券=1 元）兑任一报告（AGREEMENT_COPY §五统一兑换价，
不随单报 price_fen 浮动），entitlements source='voucher'。
红线：书券无任何提现/转卖出口接口（tests 断言路由白名单）。
来源=invite(邀请解锁)/criticism_thanks(感谢券)/ios_refund(iOS 补偿)/campaign。
"""
from __future__ import annotations

import uuid

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store, wechat
from .catalog import get_report
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["voucher"])


def _uid(request: Request) -> str:
    # 与 me._uid 同式复制（me.py 反向引用本域余额，顶层互导成环；四行换零环）
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    return store.get_or_create_user(openid)["id"]


def grant_voucher(uid: str, amount_fen: int, source: str, source_ref: str = "") -> dict:
    """发放书券（追加式；invite.py 邀请解锁等域复用，仅此一个发放口）。"""
    vid = f"v{uuid.uuid4().hex[:16]}"
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
            "created_at) VALUES(?,?,?,?,?,'active',?)",
            (vid, uid, int(amount_fen), source, source_ref, store.now()),
        )
        row = c.execute("SELECT * FROM vouchers WHERE id=?", (vid,)).fetchone()
    return dict(row)


def _rows_with_remaining(uid: str) -> list[dict]:
    """用户全部券行+动态剩余额（FIFO 按发放序=rowid 插入序——created_at 同秒
    并列时 uuid 主键序不确定，rowid 才是确定性 FIFO 键；烧尽行剩余恒 0）。"""
    with store._db() as c:
        rows = c.execute(
            "SELECT v.*, COALESCE((SELECT SUM(b.amount_fen) FROM voucher_burns b"
            " WHERE b.voucher_id=v.id), 0) burned FROM vouchers v WHERE v.user_id=?"
            " ORDER BY v.rowid",
            (uid,),
        ).fetchall()
    out: list[dict] = []
    for r in rows:
        d = dict(r)
        burned = d.pop("burned")
        d["remaining_fen"] = max(0, d["amount_fen"] - burned) if d["status"] == "active" else 0
        out.append(d)
    return out


def balance_fen(uid: str) -> int:
    """余额=Σ(发放-核销)（me.py 我的页与对账日报共用口径）。"""
    return sum(r["remaining_fen"] for r in _rows_with_remaining(uid))


def ledger(uid: str) -> list[dict]:
    """账本明细视图（GET /me/vouchers 契约字段+remaining_fen 追加便于前端展示）。"""
    return [
        {"id": r["id"], "amount_fen": r["amount_fen"], "source": r["source"],
         "source_ref": r["source_ref"], "status": r["status"],
         "used_order_id": r["used_order_id"], "expires_at": r["expires_at"],
         "created_at": r["created_at"], "remaining_fen": r["remaining_fen"]}
        for r in _rows_with_remaining(uid)
    ]


@router.get("/me/vouchers")
def me_vouchers(request: Request):
    """书券余额+逐笔账本（发放/来源明细/剩余额三条一致可查）。"""
    uid = _uid(request)
    return {"balance_fen": balance_fen(uid), "ledger": ledger(uid)}


class RedeemIn(BaseModel):
    report_id: str


@router.post("/vouchers/redeem")
def redeem(body: RedeemIn, request: Request):
    """498 书券（49800 分）兑一份报告：FIFO 部分核销+发阅读权（source=voucher）。

    错误：401｜404 REPORT_NOT_FOUND｜409 ALREADY_ENTITLED（已解锁不重复兑——
    engine_conventions §6b「已解锁再购 409」同款语义，防双烧）｜
    400 BALANCE_INSUFFICIENT（余额不足不动账）。
    """
    uid = _uid(request)
    if not get_report(body.report_id):
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    with store._db() as c:
        owned = c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (uid, body.report_id)).fetchone() is not None
    if owned:
        raise ApiError(409, "ALREADY_ENTITLED", "已解锁该报告，无需兑换")
    cost = config.REPORT_PRICE_FEN
    with store._LOCK:
        rows = _rows_with_remaining(uid)
        if sum(r["remaining_fen"] for r in rows) < cost:
            raise ApiError(400, "BALANCE_INSUFFICIENT",
                           f"书券余额不足（兑换需 {cost // 100} 券）")
        redeem_ref = f"r{uuid.uuid4().hex[:16]}"  # 兑换单号=burns 流水与权益关联键
        burns: list[tuple[dict, int]] = []
        need = cost
        for r in rows:  # FIFO 烧券：部分核销只记流水，vouchers 面值行不动
            if need <= 0:
                break
            take = min(need, r["remaining_fen"])
            if take > 0:
                burns.append((r, take))
                need -= take
        now = store.now()
        with store._db() as c:
            for r, take in burns:
                c.execute(
                    "INSERT INTO voucher_burns(id,voucher_id,user_id,amount_fen,"
                    "redeem_ref,created_at) VALUES(?,?,?,?,?,?)",
                    (f"b{uuid.uuid4().hex[:16]}", r["id"], uid, take, redeem_ref, now),
                )
                if take >= r["remaining_fen"]:  # 烧尽→置 used+核销单（幂等键）
                    c.execute(
                        "UPDATE vouchers SET status='used', used_order_id=? WHERE id=?",
                        (redeem_ref, r["id"]),
                    )
            c.execute(  # 阅读权（UNIQUE(user,report,source) 幂等）
                "INSERT OR IGNORE INTO entitlements(id,user_id,report_id,source,"
                "order_id,granted_at) VALUES(?,?,?,?,?,?)",
                (f"e{uuid.uuid4().hex[:16]}", uid, body.report_id, "voucher",
                 redeem_ref, now),
            )
    return {"redeemed": True, "deducted_fen": cost, "report_id": body.report_id}
