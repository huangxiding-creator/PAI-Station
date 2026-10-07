# -*- coding: utf-8 -*-
"""微信 code2session + 引擎侧用户 token（HMAC，免依赖）+ 小程序码（v0.6.0）。"""
from __future__ import annotations

import hashlib
import hmac
import json
import threading
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


def virtual_pay_sign(app_key: str, session_key: str, sign_data: dict | None = None, *,
                     uri: str = "requestVirtualPayment",
                     body: str | None = None) -> tuple[str, str, str]:
    """wx.requestVirtualPayment 双签名（2026-10 官方《签名详解》AppKey 新规格）。

    pay_sig   = HMAC-SHA256(appKey,      uri + "&" + signData)   ← 旧规格误用 appsecret
    signature = HMAC-SHA256(session_key, signData)               ← 旧规格多 "VirtualPayment&" 前缀，新规格无
    appKey 随 env 取沙箱/现网两把（虚拟支付后台-基本配置-基础配置-复制 AppKey）。
    返回 (signData JSON 原文, pay_sig, signature)——客户端必须原样透传 signData 字符串，
    签名与该字符串逐字节绑定。body= 供 /xpay/* 服务端原文直签（官方向量走此入口）。
    官方向量：appkey="12345" uri=/xpay/query_user_balance
    body='{"openid": "xxx", "user_ip": "127.0.0.1", "env": 0}'
    → pay_sig=c37809f2…a4b5 / signature=089d9e8d…2f6c7（tests/test_pay_sign.py §0 锚定）
    """
    if body is None:
        body = json.dumps(sign_data or {}, separators=(",", ":"), ensure_ascii=False)
    pay_sig = hmac.new(
        (app_key or "").encode(), (uri + "&" + body).encode(), hashlib.sha256
    ).hexdigest()
    signature = hmac.new(
        (session_key or "").encode(), body.encode(), hashlib.sha256
    ).hexdigest()
    return body, pay_sig, signature


# ── v0.6.0 海报小程序码（wxacode.getUnlimited：扫码直达 + scene 可归因）──
_TOKEN_LOCK = threading.Lock()
_TOKEN_CACHE: dict = {"token": "", "exp": 0.0}


def _access_token() -> str:
    """小程序接口凭证（缓存至到期前 2 分钟；失败抛 RuntimeError）。"""
    now = time.time()
    with _TOKEN_LOCK:
        if _TOKEN_CACHE["token"] and now < _TOKEN_CACHE["exp"]:
            return _TOKEN_CACHE["token"]
    secret = mp_secret()
    if not secret:
        raise RuntimeError("appsecret 未配置")
    r = cr.get(
        "https://api.weixin.qq.com/cgi-bin/token",
        params={"grant_type": "client_credential",
                "appid": config.WX_APPID, "secret": secret},
        impersonate="chrome", timeout=15,
    )
    d = r.json()
    if d.get("errcode"):
        raise RuntimeError(f"access_token {d.get('errcode')}: {d.get('errmsg')}")
    with _TOKEN_LOCK:
        _TOKEN_CACHE.update(
            token=d["access_token"],
            exp=now + max(600, int(d.get("expires_in", 7200)) - 120))
    return d["access_token"]


def _invalidate_token() -> None:
    """作废进程内 token 缓存（外部新取 token 会让旧 token 5 分钟内失效——40001 自愈用）。"""
    with _TOKEN_LOCK:
        _TOKEN_CACHE.update(token="", exp=0.0)


def wxacode_unlimited(scene: str, page: str, env_version: str = "",
                      check_path: bool = False) -> bytes:
    """不限量小程序码 PNG 字节（scene ≤32 字符）。磁盘缓存：同 scene+page+env 恒同图。
    check_path 默认 False——老页面表解析教训（线上表无新页则报错），提审前一律不查路径。
    token 抖动自愈：40001/42001（凭证被他处取新而失效）→ 清缓存取新重试一次。"""
    env = env_version or config.POSTER_QR_ENV_VERSION
    cache_dir = config.DATA_DIR / "wxacode"
    key = hashlib.sha256(f"{scene}|{page}|{env}".encode()).hexdigest()[:24]
    cache = cache_dir / f"{key}.png"
    if cache.exists():
        return cache.read_bytes()

    def _once() -> bytes:
        r = cr.post(
            "https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=" + _access_token(),
            json={"scene": scene, "page": page, "check_path": check_path,
                  "env_version": env, "width": 430},
            impersonate="chrome", timeout=20,
        )
        ctype = r.headers.get("content-type", "")
        if "json" in ctype.lower():
            d = r.json()
            if d.get("errcode") in (40001, 42001):
                raise _TokenStale(d.get("errcode"), d.get("errmsg"))
            raise RuntimeError(f"wxacode {d.get('errcode')}: {d.get('errmsg')}")
        if r.status_code != 200 or len(r.content) < 100:
            raise RuntimeError(f"wxacode 响应异常 HTTP {r.status_code}")
        return r.content

    try:
        content = _once()
    except _TokenStale:
        _invalidate_token()
        content = _once()
    cache_dir.mkdir(parents=True, exist_ok=True)
    cache.write_bytes(content)
    return content


class _TokenStale(Exception):
    """access_token 被外部刷新（40001/42001）——可自愈重试。"""

    def __init__(self, code, msg):
        super().__init__(f"token stale {code}: {msg}")
        self.code = code


def msg_sec_check(content: str, openid: str, scene: int = 2) -> bool:
    """security.msgSecCheck v2：UGC 公开展示门（v0.7.4 提审合规）。

    scene=2 评论场景；openid 须为本小程序用户（共享者本人）。
    返回 True=通过（suggest=pass）；review/risky → False；
    API 异常抛 RuntimeError（调用方 fail-closed，宁可拒共享不放行）。"""
    text = (content or "").strip()
    if not text:
        return True

    def _once() -> dict:
        r = cr.post(
            "https://api.weixin.qq.com/wxa/msg_sec_check?access_token=" + _access_token(),
            json={"content": text[:2500], "version": "2", "scene": scene, "openid": openid},
            impersonate="chrome", timeout=15,
        )
        d = r.json()
        if d.get("errcode") in (40001, 42001):
            raise _TokenStale(d.get("errcode"), d.get("errmsg"))
        if d.get("errcode"):
            raise RuntimeError(f"msgSecCheck {d.get('errcode')}: {d.get('errmsg')}")
        return d.get("result") or {}

    try:
        result = _once()
    except _TokenStale:
        _invalidate_token()
        result = _once()
    return result.get("suggest") == "pass"


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
