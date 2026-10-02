# -*- coding: utf-8 -*-
"""虚拟支付域——/pay/sign /pay/callback /pay/status + orders 状态机（链路②；ADR A5）。

四步闸（ARCHITECTURE §四链路②-3）：权益查重（已解锁→409）→订单 upsert
（outTradeNo={reportId}_{ts} 幂等键，同 (user,report) pending 单复用）→
offerId/product_id 缺→503 降级 {code:PAY_NOT_CONFIGURED, degrade:pay_gray}→
wechat.virtual_pay_sign 双签名。

回调幂等（NFR-13）：首回调 mark paid+发 entitlements(source=purchase)+raw_notify
落库；重复回调恒 200 同果不重复发放。验签方式官方未公开（TBD 切片③ T-P0-21 实测），
XY_FAKE_PAY=1 dev 闸免验签直落账（生产禁启，app.assert_fake_pay_allowed 自检）。
"""
from __future__ import annotations

import hashlib
import json
import os
import re
import time
import uuid

from fastapi import APIRouter, Request
from pydantic import BaseModel

from . import config, store, wechat
from .errors import ApiError

router = APIRouter(prefix="/api/v1", tags=["pay"])

_OUT_TRADE_NO_RE = re.compile(r"^[0-9A-Za-z_\-*@|]{8,32}$")


def load_pay_config() -> dict | None:
    """读 virtual_pay_xueyuan.secret（offer_id=/product_id=/env= 三行 key=value）。

    每次调用重读文件（µs 级）：secret 回填即刻生效，重启亦恢复（NFR-10/WFR #45 同款）。
    缺失或 offer_id/product_id 为空 → None（=未配置 → 503 降级）。
    """
    f = config.VIRTUAL_PAY_FILE
    if not f.exists():
        return None
    kv: dict[str, str] = {}
    for line in f.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if "=" in line and not line.startswith("#"):
            k, v = line.split("=", 1)
            kv[k.strip()] = v.strip()
    if not kv.get("offer_id") or not kv.get("product_id"):
        return None
    return {
        "offer_id": kv["offer_id"],
        "product_id": kv["product_id"],
        "env": int(kv.get("env") or 0),  # 0=正式 1=沙箱（CONTEXT 统一语言）
    }


def pay_configured() -> bool:
    return load_pay_config() is not None


# ── orders / entitlements 存储（pay_log 对账由 orders 表承载，SCHEMAS §5）──
def find_pending_order(uid: str, report_id: str) -> dict | None:
    with store._db() as c:
        row = c.execute(
            "SELECT * FROM orders WHERE user_id=? AND report_id=? AND status='pending'"
            " ORDER BY id DESC LIMIT 1",
            (uid, report_id),
        ).fetchone()
    return dict(row) if row else None


def create_order(uid: str, report_id: str, price_fen: int, pay_cfg: dict) -> dict:
    out = f"{report_id}_{int(time.time())}"
    if not _OUT_TRADE_NO_RE.match(out):  # 长度/字符集兜底（API_DESIGN P0-8 合法字符约束）
        out = f"{hashlib.sha1(report_id.encode()).hexdigest()[:12]}{int(time.time())}"
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT INTO orders(out_trade_no,user_id,report_id,offer_id,product_id,"
            " price_fen,env,mode,status,created_at) VALUES(?,?,?,?,?,?,?,?,?,?)",
            (out, uid, report_id, pay_cfg["offer_id"], pay_cfg["product_id"],
             price_fen, pay_cfg["env"], "short_series_goods", "pending", store.now()),
        )
    return get_order(out) or {}


def get_order(out_trade_no: str) -> dict | None:
    with store._db() as c:
        row = c.execute("SELECT * FROM orders WHERE out_trade_no=?", (out_trade_no,)).fetchone()
    return dict(row) if row else None


def mark_paid(out_trade_no: str, wx_order_sn: str, raw_notify: str) -> bool:
    """pending→paid；返回是否首笔（重复回调 False=幂等不重发放）。"""
    with store._LOCK, store._db() as c:
        cur = c.execute(
            "UPDATE orders SET status='paid', wx_order_sn=?, paid_at=?, raw_notify=?"
            " WHERE out_trade_no=? AND status='pending'",
            (wx_order_sn, store.now(), raw_notify, out_trade_no),
        )
        return cur.rowcount == 1


def grant_entitlement(uid: str, report_id: str, source: str, order_id: str) -> None:
    """发放阅读权益（UNIQUE(user,report,source) 幂等）。"""
    with store._LOCK, store._db() as c:
        c.execute(
            "INSERT OR IGNORE INTO entitlements(id,user_id,report_id,source,order_id,granted_at)"
            " VALUES(?,?,?,?,?,?)",
            (f"e{uuid.uuid4().hex[:16]}", uid, report_id, source, order_id, store.now()),
        )


def has_entitlement(uid: str, report_id: str) -> bool:
    with store._db() as c:
        row = c.execute(
            "SELECT 1 FROM entitlements WHERE user_id=? AND report_id=? LIMIT 1",
            (uid, report_id),
        ).fetchone()
    return row is not None


# ── POST /pay/sign（P0-8）────────────────────────────────────────
class SignIn(BaseModel):
    report_id: str


@router.post("/pay/sign")
def pay_sign(body: SignIn, request: Request):
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    user = store.get_or_create_user(openid)
    uid = user["id"]
    with store._db() as c:
        row = c.execute(
            "SELECT id,price_fen,status FROM reports WHERE id=? AND status='on'", (body.report_id,)
        ).fetchone()
    if not row:
        raise ApiError(404, "REPORT_NOT_FOUND", "报告不存在或已下架")
    if has_entitlement(uid, body.report_id):  # 闸①权益查重
        raise ApiError(409, "ALREADY_ENTITLED", "已解锁该报告，无需重复购买")
    pay_cfg = load_pay_config()  # 闸③503 降级（闸②订单 upsert 后置，未配置不建单）
    if pay_cfg is None:
        raise ApiError(503, "PAY_NOT_CONFIGURED", "虚拟支付尚未开通",
                       extra={"degrade": "pay_gray"})
    order = find_pending_order(uid, body.report_id) or create_order(
        uid, body.report_id, row["price_fen"], pay_cfg
    )
    session_key = user.get("session_key") or ""
    sign_data = {
        "offerId": pay_cfg["offer_id"], "buyQuantity": 1, "env": pay_cfg["env"],
        "currencyType": "CNY", "productId": pay_cfg["product_id"],
        "goodsPrice": row["price_fen"], "outTradeNo": order["out_trade_no"],
        "attach": hashlib.sha256(openid.encode()).hexdigest()[:16],
        "mode": "short_series_goods",
    }
    body_str, pay_sig, signature = wechat.virtual_pay_sign(
        wechat.mp_secret(), session_key, sign_data
    )
    with store._LOCK, store._db() as c:
        c.execute("UPDATE orders SET pay_sig=? WHERE out_trade_no=?", (pay_sig, order["out_trade_no"]))
    return {
        "mode": "short_series_goods", "sign_data": body_str, "pay_sig": pay_sig,
        "signature": signature, "out_trade_no": order["out_trade_no"],
        "price_fen": row["price_fen"],
    }


# ── POST /pay/callback（P0-9；微信服务端推送，无 Bearer）────────────
def _extract(payload: dict, *keys: str):
    for k in keys:  # 官方字段名 TBD（切片③ T-P0-21 实测收口），先容错多别名
        if payload.get(k):
            return payload[k]
    return None


@router.post("/pay/callback")
async def pay_callback(request: Request):
    if os.environ.get("XY_FAKE_PAY") != "1":  # dev 闸外一律拒（生产禁启自检在 app 启动腿）
        raise ApiError(501, "CALLBACK_VERIFY_NOT_READY", "回调验签未实装（切片③ T-P0-21）")
    try:
        payload = await request.json()
    except Exception:  # noqa: BLE001
        payload = None
    return _handle_callback(payload)


def _handle_callback(payload) -> dict:
    if not isinstance(payload, dict):
        raise ApiError(400, "INVALID_CALLBACK", "回调体必须是 JSON")
    out = _extract(payload, "outTradeNo", "out_trade_no", "OutTradeNo")
    if not out:
        raise ApiError(400, "INVALID_CALLBACK", "回调缺少 outTradeNo")
    order = get_order(str(out))
    if not order:
        raise ApiError(404, "ORDER_NOT_FOUND", "订单不存在")
    wx_sn = str(_extract(payload, "transactionId", "wx_order_sn", "orderSn") or "")
    first = mark_paid(str(out), wx_sn, json.dumps(payload, ensure_ascii=False))
    if first:  # 首回调发放；重复回调恒 200 同果不重复发放（harness D 场景）
        grant_entitlement(order["user_id"], order["report_id"], "purchase", str(out))
    return {"ok": True, "out_trade_no": str(out), "first": first}


# ── GET /pay/status（P0-10）──────────────────────────────────────
@router.get("/pay/status")
def pay_status(out_trade_no: str, request: Request):
    openid = wechat.bearer_openid(request)
    if not openid:
        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    user = store.get_or_create_user(openid)
    order = get_order(out_trade_no)
    if not order or order["user_id"] != user["id"]:  # 他人订单同 404（不泄漏存在性）
        raise ApiError(404, "ORDER_NOT_FOUND", "订单不存在")
    with store._db() as c:
        granted = c.execute(
            "SELECT 1 FROM entitlements WHERE order_id=? LIMIT 1", (out_trade_no,)
        ).fetchone() is not None
    return {
        "out_trade_no": out_trade_no, "report_id": order["report_id"],
        "status": order["status"], "entitlement_granted": granted,
    }
