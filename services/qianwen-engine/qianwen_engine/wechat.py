# -*- coding: utf-8 -*-
"""微信 code2session + 引擎侧用户 token（HMAC，免依赖）。"""
from __future__ import annotations

import hashlib
import hmac
import json
import time

from curl_cffi import requests as cr

from . import config


def mp_secret() -> str:
    """从小程序 secret 文件读 appsecret（R7 密钥外置）。"""
    f = config.MP_SECRET_FILE
    if not f.exists():
        return ""
    for line in f.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if line.startswith("appsecret") and "=" in line:
            return line.split("=", 1)[1].strip()
    return ""


def code2session(code: str) -> dict:
    """jscode → {openid, session_key?, unionid?}。失败抛 RuntimeError。"""
    secret = mp_secret()
    if not secret:
        raise RuntimeError("appsecret 未配置")
    r = cr.get(
        "https://api.weixin.qq.com/sns/jscode2session",
        params={
            "appid": config.WX_APPID, "secret": secret,
            "js_code": code, "grant_type": "authorization_code",
        },
        impersonate="chrome", timeout=15,
    )
    d = r.json()
    if d.get("errcode"):
        raise RuntimeError(f"code2session {d.get('errcode')}: {d.get('errmsg')}")
    return d


def virtual_pay_sign(appsecret: str, session_key: str, sign_data: dict) -> tuple[str, str, str]:
    """wx.requestVirtualPayment 双签名（v0.2.5）。

    pay_sig   = HMAC-SHA256(appsecret,   "requestVirtualPayment&" + signData JSON)
    signature = HMAC-SHA256(session_key, "VirtualPayment&" + signData JSON)
    返回 (signData JSON 原文, pay_sig, signature)——客户端必须原样透传 signData 字符串，
    签名与该字符串逐字节绑定。若真机报 -15005/-15006，按官方《签名详解》核前缀后改此处一处即可。
    """
    body = json.dumps(sign_data, separators=(",", ":"), ensure_ascii=False)
    pay_sig = hmac.new(
        (appsecret or "").encode(), ("requestVirtualPayment&" + body).encode(), hashlib.sha256
    ).hexdigest()
    signature = hmac.new(
        (session_key or "").encode(), ("VirtualPayment&" + body).encode(), hashlib.sha256
    ).hexdigest()
    return body, pay_sig, signature


# ── 引擎 HMAC token ────────────────────────────────────────
def _hmac_key() -> bytes:
    f = config.ENGINE_TOKEN_FILE
    if not f.exists():
        f.parent.mkdir(parents=True, exist_ok=True)
        f.write_bytes(hmac.HMAC(b"seed", b"qianwen", hashlib.sha256).digest())
    return f.read_bytes()


def issue_token(openid: str) -> str:
    payload = {"openid": openid, "exp": int(time.time()) + 30 * 86400}
    body = json.dumps(payload, separators=(",", ":")).encode()
    sig = hmac.new(_hmac_key(), body, hashlib.sha256).hexdigest()[:32]
    return f"{body.hex()}.{sig}"


def verify_token(token: str) -> str | None:
    """校验并返回 openid；失败返回 None。"""
    try:
        body_hex, sig = token.split(".", 1)
        body = bytes.fromhex(body_hex)
        want = hmac.new(_hmac_key(), body, hashlib.sha256).hexdigest()[:32]
        if not hmac.compare_digest(sig, want):
            return None
        payload = json.loads(body)
        if payload.get("exp", 0) < time.time():
            return None
        return payload.get("openid")
    except Exception:
        return None
