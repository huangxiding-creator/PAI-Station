# -*- coding: utf-8 -*-
"""退款域 [P1]——四层闸层③④：确定性映射（纯函数）+双轨执行+L4 熔断硬门+黑名单。

- 映射（层③）：≥50 线性按分退（50→50%…100→100%），纯函数可单测；70 分×49800
  分=34860（¥348.60，AGREEMENT 2.4 字节级锚点）。
- 双轨：Android=refund_order 原路退（自动退仅 ≤50% 档 config.AUTO_REFUND_TIER_CAP，
  更高档/黑名单→manual，AN#8）；iOS=不可主动退→等额书券（source=ios_refund）
  +苹果通道引导（AGREEMENT 2.5 文案）。
- 熔断（层④）：单报告退款率>25% 或全站周退款额>营收 15% → 停「新发起」423
  FUSE_OPEN+告警；已受理义务继续履行（R-05）；fuse_state 原子翻转；人工恢复后
  比例未回落不自动重开。
- 黑名单：历史退款率>30% → is_blacklisted=1 → method=manual（内部判据零外泄，
  对外只写「平台保留权」；终审=用户，引擎执行=R-04）。
"""
from __future__ import annotations

import json
import logging
import os
import uuid
from datetime import datetime, timedelta, timezone

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, notify, store, wechat
from .errors import ApiError

logger = logging.getLogger("xueyuan.refund")
router = APIRouter(prefix="/api/v1", tags=["refund"])

_TZ8 = timezone(timedelta(hours=8))
SCORE_THRESHOLD = 50.0  # 退款触发分（AGREEMENT 2.4：≥50 线性，<50 不退+感谢券）
BLACKLIST_REFUND_RATIO = 0.30  # 历史退款率红线（内部判据，不外泄；R-04）
_MANUAL_RESET = "人工恢复"      # 熔断人工放行标记（比例回落前不自动重开）
IOS_TRACK_COPY = (
    "受苹果渠道规则限制无法直接退款：应退金额已发放等额书券至您的书券账户（1券=1元，"
    "攒满498券可兑换任一报告）；也可通过 App Store 购买记录的「报告问题」自行申请退款，"
    "是否退款及结果以苹果官方处理为准。"
)
_PAID_STATES = ("paid", "delivered", "refund_partial", "refunded")

# ── 层③确定性映射（纯函数，单测锚点）────────────────────────────
def refund_amount_fen(final_score: float, paid_fen: int) -> int:
    """≥50 线性按分退；<50 → 0。四舍五入到分，clamp [0, paid_fen]。"""
    if final_score < SCORE_THRESHOLD or paid_fen <= 0:
        return 0
    ratio = max(0.0, min(100.0, float(final_score))) / 100.0
    return int(round(paid_fen * ratio))

def tier_percent(final_score: float) -> int:
    """退款档位整数（76.7→76；<50→0=不退）。AUTO_REFUND_TIER_CAP 比较用。"""
    return 0 if final_score < SCORE_THRESHOLD else int(float(final_score))

def tier_label(final_score: float) -> str:
    """criticisms.refund_tier 标签（SCHEMAS §6：none/tier76…）。"""
    return "none" if final_score < SCORE_THRESHOLD else f"tier{tier_percent(final_score)}"

# ── 书券发放（criticism 感谢券/iOS 补偿共用；幂等）──────────────────
def grant_voucher(uid: str, amount_fen: int, source: str, source_ref: str) -> str:
    """发放书券（非现金内循环；同 (source,source_ref) 幂等返回既有单号）。"""
    if amount_fen <= 0:
        return ""
    vid = f"v{uuid.uuid4().hex[:16]}"
    with store._LOCK, store._db() as c:
        row = c.execute("SELECT id FROM vouchers WHERE source=? AND source_ref=? LIMIT 1",
                        (source, source_ref)).fetchone()
        if row:
            return row["id"]
        c.execute("INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,status,"
                  "created_at) VALUES(?,?,?,?,?,'active',?)",
                  (vid, uid, amount_fen, source, source_ref, store.now()))
    return vid

# ── 资格/风控计数（月度占额自愈式重算；黑名单）────────────────────
def refresh_month_counter(uid: str) -> int:
    """当月退款占额=本月非 failed 退款单数（受理即占额口径）；回写
    users.refund_count_month 自愈对齐——资格闸判据列。"""
    month_floor = datetime.now(_TZ8).strftime("%Y-%m") + "-01"
    with store._LOCK, store._db() as c:
        n = c.execute("SELECT COUNT(*) n FROM refunds WHERE user_id=? AND"
                      " status!='failed' AND created_at>=?", (uid, month_floor)
                      ).fetchone()["n"]
        c.execute("UPDATE users SET refund_count_month=? WHERE id=?", (n, uid))
    return n

def refresh_blacklist(uid: str) -> bool:
    """历史退款率>30% → is_blacklisted=1（后续转人工；判据不外泄）。
    幂等：仅首次置位告警一次（apply 前置+settle 后复算双点收敛）。"""
    with store._db() as c:
        row = c.execute(
            "SELECT COUNT(*) n, SUM(CASE WHEN refund_state IN ('partial','full')"
            " THEN 1 ELSE 0 END) r FROM orders WHERE user_id=? AND status IN"
            f" ({','.join('?' * len(_PAID_STATES))})", (uid, *_PAID_STATES)).fetchone()
        flagged = c.execute("SELECT is_blacklisted FROM users WHERE id=?",
                            (uid,)).fetchone()
    n, r = row["n"] or 0, row["r"] or 0
    hit = n > 0 and (r / n) > BLACKLIST_REFUND_RATIO
    if hit and flagged and flagged["is_blacklisted"] == 0:
        with store._LOCK, store._db() as c:
            c.execute("UPDATE users SET is_blacklisted=1 WHERE id=?", (uid,))
        notify.alert(f"[xueyuan 黑名单] {uid} 历史退款率 {r}/{n} 超30%，后续退款转人工")
    return hit

# ── L4 熔断（fuse_state 落库+原子翻转；阈值 config.BREAKER_*）────────
def _fuse_flip(key: str, reason: str) -> bool:
    """原子打开熔断（仅首个翻转者 True→由调用方告警一次，防重复告警）。"""
    with store._LOCK, store._db() as c:
        c.execute("INSERT OR IGNORE INTO fuse_state(key,opened,reason,opened_at,"
                  "updated_at) VALUES(?,0,'','',?)", (key, store.now()))
        cur = c.execute(
            "UPDATE fuse_state SET opened=1, reason=?,"
            " opened_at=CASE WHEN opened=0 THEN ? ELSE opened_at END, updated_at=?"
            " WHERE key=? AND opened=0", (reason, store.now(), store.now(), key))
        return cur.rowcount == 1

def _maybe_trip(key: str, over: bool, reason: str, tripped: list) -> None:
    """过线才翻；人工已放行不自动重开；比例回落即清放行标记。"""
    with store._db() as c:
        st = c.execute("SELECT opened, reason FROM fuse_state WHERE key=?",
                       (key,)).fetchone()
    if over:
        if st and st["opened"] == 0 and (st["reason"] or "").startswith(_MANUAL_RESET):
            return
        if _fuse_flip(key, reason):
            tripped.append(key)
    elif st and (st["reason"] or "").startswith(_MANUAL_RESET):
        with store._LOCK, store._db() as c:
            c.execute("UPDATE fuse_state SET reason='', updated_at=? WHERE key=?",
                      (store.now(), key))

def evaluate_fuses(report_id: str) -> list:
    """评估双线并翻转（线A 单报告退款率>25%；线B 周退款额>营收15%）；返回新开 key。"""
    tripped: list[str] = []
    with store._db() as c:
        row = c.execute(
            "SELECT COUNT(*) n, SUM(CASE WHEN refund_state IN ('partial','full')"
            " THEN 1 ELSE 0 END) r FROM orders WHERE report_id=? AND status IN"
            f" ({','.join('?' * len(_PAID_STATES))})", (report_id, *_PAID_STATES)
        ).fetchone()
    n, r = row["n"] or 0, row["r"] or 0
    _maybe_trip(f"report:{report_id}", n > 0 and (r / n) > config.BREAKER_REPORT_REFUND_RATIO,
                f"单报告退款率 {r}/{n}", tripped)
    week_ago = (datetime.now(_TZ8) - timedelta(days=7)).isoformat(timespec="seconds")
    with store._db() as c:
        rev = c.execute(
            "SELECT COALESCE(SUM(price_fen),0) s FROM orders WHERE status IN"
            f" ({','.join('?' * len(_PAID_STATES))}) AND paid_at>=? AND env=0",
            (*_PAID_STATES, week_ago)).fetchone()["s"]
        ref = c.execute("SELECT COALESCE(SUM(amount_fen),0) s FROM refunds WHERE"
                        " status!='failed' AND created_at>=?", (week_ago,)
                        ).fetchone()["s"]
    _maybe_trip("global", rev > 0 and (ref / rev) > config.BREAKER_WEEK_REFUND_REVENUE_RATIO,
                f"周退款额/营收 {ref}/{rev}", tripped)
    for key in tripped:
        notify.alert(f"[xueyuan 熔断] {key} 已打开：停新发起转人工复核"
                     "（已受理退款义务继续履行，R-05）")
    return tripped

def fuse_open_for(report_id: str) -> str | None:
    """返回打开中的熔断 key（先单报告线再全站线）；未开→None（423 判据）。"""
    for key in (f"report:{report_id}", "global"):
        with store._db() as c:
            row = c.execute("SELECT opened FROM fuse_state WHERE key=?",
                            (key,)).fetchone()
        if row and row["opened"] == 1:
            return key
    return None

def reset_fuse(key: str) -> bool:
    """人工恢复（运维位；黑名单终审=用户）。置放行标记：退款率未回落
    到阈值内前不自动重开（复核结论优先于机械阈值）。"""
    with store._LOCK, store._db() as c:
        cur = c.execute("UPDATE fuse_state SET opened=0, reason=?, updated_at=?"
                        " WHERE key=?", (_MANUAL_RESET, store.now(), key))
    if cur.rowcount:
        notify.alert(f"[xueyuan 熔断] {key} 已人工恢复")
    return cur.rowcount > 0

# ── 退款执行腿（双轨）──────────────────────────────────────
def _get_refund(refund_id: str) -> dict | None:
    with store._db() as c:
        row = c.execute("SELECT * FROM refunds WHERE id=?", (refund_id,)).fetchone()
    return dict(row) if row else None

def _close_entitlement(order: dict) -> None:
    """退款后关闭阅读权限（AGREEMENT 2.4/2.5：退款报告阅读权限同步关闭）。"""
    with store._LOCK, store._db() as c:
        c.execute("DELETE FROM entitlements WHERE user_id=? AND report_id=? AND"
                  " source='purchase' AND order_id=?",
                  (order["user_id"], order["report_id"], order["out_trade_no"]))

def _mark_order_refunded(order: dict, amount_fen: int) -> None:
    """订单退款态回写（refund_state none/partial/full；status 状态机推进）。"""
    state = "full" if amount_fen >= order["price_fen"] else "partial"
    status = "refunded" if state == "full" else "refund_partial"
    with store._LOCK, store._db() as c:
        c.execute("UPDATE orders SET refund_state=?, status=? WHERE out_trade_no=?",
                  (state, status, order["out_trade_no"]))

def _settle(refund_id: str, wx_refund_sn: str, order: dict, amount_fen: int) -> None:
    """结：refunds settled+关权益+订单态（幂等：仅未结单可推进）。"""
    with store._LOCK, store._db() as c:
        cur = c.execute("UPDATE refunds SET status='settled', wx_refund_sn=?,"
                        " settled_at=? WHERE id=? AND status!='settled'",
                        (wx_refund_sn, store.now(), refund_id))
    if cur.rowcount:
        _close_entitlement(order)
        _mark_order_refunded(order, amount_fen)
        refresh_month_counter(order["user_id"])
        refresh_blacklist(order["user_id"])

class ApplyIn(BaseModel):
    criticism_id: str = ""
    order_id: str = ""
    reason: str = ""

def _uid(request: Request) -> str:
    openid = wechat.bearer_openid(request)  # 与 criticize 同口径（路由域内联）
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    return store.get_or_create_user(openid)["id"]

def _paid_order(out_trade_no: str, uid: str) -> dict:
    with store._db() as c:
        row = c.execute("SELECT * FROM orders WHERE out_trade_no=? AND user_id=? AND"
                        " status IN ('paid','delivered')", (out_trade_no, uid)).fetchone()
    if not row:
        raise ApiError(404, "ORDER_NOT_FOUND", "订单不存在或不可退款")
    return dict(row)

def _thanks_fen() -> int:  # 感谢券面值（未冻结金额——运营参数 env 可调；默认 ¥5）
    try:
        return max(0, int(os.environ.get("XY_THANKS_VOUCHER_FEN", "500")))
    except ValueError:
        return 500

@router.post("/refund/apply")
def refund_apply(body: ApplyIn, request: Request):
    """P1-4：评分路径（criticism_id）或客诉路径（order_id+reason，转人工）。"""
    uid = _uid(request)
    if not (body.criticism_id or body.order_id):
        raise ApiError(400, "INVALID_PARAM", "缺少 criticism_id 或 order_id")
    if body.criticism_id:  # 评分路径
        with store._db() as c:
            crit = c.execute("SELECT * FROM criticisms WHERE id=? AND user_id=?",
                             (body.criticism_id, uid)).fetchone()
            dup = c.execute("SELECT id FROM refunds WHERE criticism_id=? LIMIT 1",
                            (body.criticism_id,)).fetchone()
        if not crit:
            raise ApiError(404, "CRITICISM_NOT_FOUND", "批评记录不存在")
        crit = dict(crit)
        if crit["status"] == "pending_score":
            raise ApiError(400, "SCORE_NOT_READY", "评分进行中，请稍后查看结果")
        if crit["status"] == "manual_pending":
            raise ApiError(409, "MANUAL_REVIEW_PENDING", "批评转人工复核中，结论将在结果页通知")
        if crit["status"] in ("rejected", "closed"):
            raise ApiError(409, "CRITICISM_CLOSED", "该批评已结案，不可发起退款")
        if dup:
            raise ApiError(409, "REFUND_DUP", "该批评已发起过退款")
        order = _paid_order(crit["order_id"], uid)
        final = float(crit["final_score"] or 0)
        if final < SCORE_THRESHOLD:  # <50 不退+感谢券（幂等补发）
            grant_voucher(uid, _thanks_fen(), "criticism_thanks", crit["id"])
            raise ApiError(400, "SCORE_BELOW_THRESHOLD", "总分未达50分退款线，已发放感谢券致谢")
        tier = crit["refund_tier"] or tier_label(final)
        reason = f"criticism {crit['id']} final={final}"
    else:  # 客诉路径：无评分，一律人工
        order = _paid_order(body.order_id, uid)
        crit, final, tier = None, 0.0, "custom"
        reason = f"complaint order={body.order_id} {body.reason[:60]}"
    evaluate_fuses(order["report_id"])  # 先评估（历史已超线→本次即拦）
    fuse_key = fuse_open_for(order["report_id"])
    if fuse_key:
        raise ApiError(423, "FUSE_OPEN", "该报告退款通道复核中，已受理的申请不受影响")
    amount = refund_amount_fen(final, order["price_fen"]) if crit else order["price_fen"]
    refresh_blacklist(uid)  # 复算黑名单（apply 前置点；>30% → 本次即转人工）
    with store._db() as c:
        blacklisted = c.execute("SELECT is_blacklisted FROM users WHERE id=?",
                                (uid,)).fetchone()["is_blacklisted"]
    platform = order["platform"]
    if platform == "ios":  # 双轨：iOS 不可主动退→等额书券+引导（AGREEMENT 2.5）
        method = "voucher"
    elif crit is None or blacklisted or tier_percent(final) > config.AUTO_REFUND_TIER_CAP:
        method = "manual"  # 客诉无评分/黑名单/超50%档→人工复核（AN#8；自动退仅≤50%档）
    else:
        method = "auto"
    rid = f"r{uuid.uuid4().hex[:16]}"
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,tier,"
                  "amount_fen,method,status,created_at) VALUES(?,?,?,?,?,?,?,?,"
                  "'initiated',?)", (rid, order["out_trade_no"],
                                     crit["id"] if crit else "", uid, platform,
                                     tier, amount, method, store.now()))
    if method == "voucher":
        vid = grant_voucher(uid, amount, "ios_refund", rid)
        with store._LOCK, store._db() as c:
            c.execute("UPDATE refunds SET voucher_granted=?, status='settled',"
                      " settled_at=? WHERE id=?", (vid, store.now(), rid))
        _close_entitlement(order)
        _mark_order_refunded(order, amount)
    elif method == "auto":
        try:
            sn = wechat.refund_order(order["out_trade_no"], amount)
            _settle(rid, sn, order, amount)  # dev 假闸即时结；真实回调腿见 P1-5
        except Exception as exc:  # noqa: BLE001 —— 通道未就绪不丢单：降级人工
            logger.warning("[refund] %s 自动退失败转人工: %s", rid, exc)
            with store._LOCK, store._db() as c:
                c.execute("UPDATE refunds SET method='manual' WHERE id=?", (rid,))
            method = "manual"
            notify.alert(f"[xueyuan 退款] {rid} 自动通道未就绪转人工（{order['out_trade_no']}）")
    if method == "manual":
        if crit:  # 复核位=退款单；批评本身不结案（进度可查、dup 闸兜底重复申请）
            with store._LOCK, store._db() as c:
                c.execute("UPDATE criticisms SET manual_review=1 WHERE id=?",
                          (crit["id"],))
        notify.alert(f"[xueyuan 退款] {rid} 转人工复核（{reason}，{amount} 分）")
    refresh_month_counter(uid)
    evaluate_fuses(order["report_id"])  # 本次落单后再评估（为后续申请拦线）
    row = _get_refund(rid) or {}
    return {"refund_id": rid, "platform": platform, "tier": tier, "method": method,
            "amount_fen": row.get("amount_fen"), "status": row.get("status"),
            "ios_track": IOS_TRACK_COPY if platform == "ios" else None}

def execute_refund(refund_id: str) -> dict:
    """人工复核通过后的执行腿（运维位无公开端点；>50% 档复核共用）。
    Android manual 单→refund_order 原路退→settled+关权益+订单态；幂等；
    熔断不拦执行（已受理义务继续履行，R-05）。"""
    row = _get_refund(refund_id)
    if not row:
        raise ApiError(404, "REFUND_NOT_FOUND", "退款单不存在")
    if row["status"] == "settled":
        return {"refund_id": refund_id, "status": "settled", "already": True}
    if row["platform"] != "android" or row["status"] == "failed":
        return {"refund_id": refund_id, "status": row["status"], "already": False}
    with store._db() as c:
        order = c.execute("SELECT * FROM orders WHERE out_trade_no=?",
                          (row["order_id"],)).fetchone()
    if not order:
        raise ApiError(404, "ORDER_NOT_FOUND", "订单不存在")
    sn = wechat.refund_order(row["order_id"], row["amount_fen"])
    _settle(refund_id, sn, dict(order), row["amount_fen"])
    return {"refund_id": refund_id, "status": "settled", "already": False}

# ── POST /refund/callback（P1-5；官方验签 TBD，dev 闸照 /pay/callback idiom）──
def _pick(payload: dict, keys: tuple) -> str:
    # 官方字段名 TBD（xpay_refund_notify 载荷实测收口）：按候选序取首个非空
    return next((str(payload[k]) for k in keys if payload.get(k)), "")

@router.post("/refund/callback")
async def refund_callback(request: Request):
    if os.environ.get("XY_FAKE_REFUND") != "1":  # dev 闸外一律拒（验签 TBD 不裸奔）
        raise ApiError(501, "REFUND_CALLBACK_VERIFY_NOT_READY",
                       "退款回调验签未实装（官方契约 TBD）")
    try:
        payload = await request.json()
    except Exception:  # noqa: BLE001
        payload = None
    return _handle_refund_callback(payload)

def _handle_refund_callback(payload) -> dict:
    if not isinstance(payload, dict):
        raise ApiError(400, "INVALID_CALLBACK", "回调体必须是 JSON")
    out = _pick(payload, ("outTradeNo", "out_trade_no", "OutTradeNo"))
    if not out:
        raise ApiError(400, "INVALID_CALLBACK", "回调缺少 outTradeNo")
    with store._db() as c:
        order = c.execute("SELECT * FROM orders WHERE out_trade_no=?",
                          (out,)).fetchone()
        refund = c.execute("SELECT * FROM refunds WHERE order_id=? ORDER BY id DESC"
                           " LIMIT 1", (out,)).fetchone()
    if not order or not refund:
        raise ApiError(404, "REFUND_NOT_FOUND", "订单或退款单不存在")
    sn = _pick(payload, ("refundId", "refund_id", "outRefundNo", "wx_refund_sn"))
    first = False
    if refund["status"] != "settled":
        _settle(refund["id"], sn, dict(order), refund["amount_fen"])
        first = True
        try:  # 回调原文快照并入 orders.raw_notify（对账兜底；解析失败不阻塞）
            with store._db() as c:
                raw = c.execute("SELECT raw_notify FROM orders WHERE out_trade_no=?",
                                (out,)).fetchone()["raw_notify"]
                merged = json.loads(raw or "{}")
                merged["refund_notify"] = payload
                with store._LOCK, store._db() as c2:
                    c2.execute("UPDATE orders SET raw_notify=? WHERE out_trade_no=?",
                               (json.dumps(merged, ensure_ascii=False), out))
        except Exception:  # noqa: BLE001
            pass
    return {"ok": True, "out_trade_no": out, "refund_id": refund["id"], "first": first}
