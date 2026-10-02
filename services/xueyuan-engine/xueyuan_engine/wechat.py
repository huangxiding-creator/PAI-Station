# -*- coding: utf-8 -*-
"""微信 code2session + 引擎侧用户 token（HMAC，免依赖）。

逐行照抄 services/qianwen-engine/qianwen_engine/wechat.py（在役母本），
仅换 config 引用（xueyuan_mp.secret / xueyuan_engine_hmac.key）与命名空间种子。
"""
from __future__ import annotations

import hashlib
import hmac
import json
import time

from curl_cffi import requests as cr

from . import config


def mp_secret() -> str:
    """从小程序 secret 文件读 appsecret（§五-1 密钥外置）。"""
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
    """wx.requestVirtualPayment 双签名（照抄 qianwen v0.2.5 在役实现）。

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
        f.write_bytes(hmac.HMAC(b"seed", b"xueyuan", hashlib.sha256).digest())
    return f.read_bytes()


def issue_token(openid: str) -> str:
    payload = {"openid": openid, "exp": int(time.time()) + config.TOKEN_TTL_DAYS * 86400}
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


def bearer_openid(request) -> str | None:
    """从请求头解析 Bearer→openid（登录域辅助）。

    - 无 Authorization 头 → None（调用方自定游客态或 401）
    - 带头但凭证无效/过期 → 401（API_DESIGN §一：前端静默重登重试一次）
    """
    auth = request.headers.get("Authorization", "")
    token = auth[7:] if auth.startswith("Bearer ") else ""
    if not token:
        return None
    openid = verify_token(token)
    if not openid:
        from .errors import ApiError

        raise ApiError(401, "UNAUTHORIZED", "未登录或凭证过期")
    return openid


def short_uid(openid: str) -> str:
    """openid→uid 短 ID（确定性哈希，映射入库幂等；openid 28 字符不进 scene/日志）。"""
    return "u" + hashlib.sha256(openid.encode()).hexdigest()[:10]


def dev_session_key(code: str) -> str:
    """XY_DEV_LOGIN 双闸下的服务端 session_key 替身（仅测试进程，绝不下发）。"""
    return "devsk-" + code


# ── refund_order 封装（P1-4 Android 自动原路退；仅文件末尾追加段）────────
# 官方虚拟支付 refund_order 的端点/字段未公开（KNOWLEDGE_BASE/virtual_pay.md
# §8 TBD 实测），真调用只允许生产+真凭证场景；当前唯一可用路径=XY_FAKE_REFUND=1
# dev 闸（照 XY_FAKE_PAY 生产自拒 idiom：非 dev 端口携闸运行即拒绝执行）。
def _refund_dev_port(env: dict, argv: list) -> int | None:
    """XY_FAKE_REFUND 允许端口探测（app.detect_port 同口径局部只读复刻，
    避免 wechat→app 循环导入；端口未知=按生产对待）。"""
    import sys

    for i, a in enumerate(argv if argv is not None else sys.argv):
        if a == "--port" and i + 1 < len(argv) and argv[i + 1].isdigit():
            return int(argv[i + 1])
        if a.startswith("--port=") and a[7:].isdigit():
            return int(a[7:])
    for k in ("XY_PORT", "PORT"):
        if str(env.get(k, "")).isdigit():
            return int(env[k])
    return None


def refund_order(out_trade_no: str, refund_amount_fen: int) -> str:
    """虚拟支付退款（部分退款语义官方 TBD）。成功返回微信退款单号。

    - XY_FAKE_REFUND=1 且端口∈config.DEV_FAKE_PAY_PORTS：dev 假回执（确定性
      hash 单号，测试/沙箱联调；绝不触网）；
    - 生产真调用位：官方 refund_order 契约未实测——开通后在此一处按实测接线；
      接线前一律 RuntimeError 自拒（宁可不自动退，也不瞎调真钱通道）。
    """
    import os
    import sys

    if os.environ.get("XY_FAKE_REFUND") == "1":
        port = _refund_dev_port(dict(os.environ), sys.argv)
        if port not in config.DEV_FAKE_PAY_PORTS:
            raise RuntimeError(
                f"XY_FAKE_REFUND=1 仅允许 dev 端口 {sorted(config.DEV_FAKE_PAY_PORTS)}"
                f"（当前 {port}）——生产进程严禁假退款，拒绝执行"
            )
        return "fakeref-" + hashlib.sha256(
            f"{out_trade_no}:{refund_amount_fen}".encode()
        ).hexdigest()[:16]
    raise RuntimeError(
        "refund_order 官方契约未实测（virtual_pay.md §8 TBD），生产接线前自拒"
    )


# ── 公共 access_token 助手（P2 订阅消息腿；仅文件末尾追加段）──────────
# 纪律：token 只存进程内存（缓存+过期前 300s 提前刷新），绝不落盘/绝不下发/
# 绝不进日志（异常与日志只含 errcode/errmsg）；网络腿仅在显式调用本函数时发生
# （测试一律 monkeypatch wechat.cr 或本函数——本域零隐式外呼）。
import threading as _threading  # noqa: E402 —— 追加段局部导入，不触文件头

_TOKEN_REFRESH_MARGIN = 300.0     # 过期裕量（秒）：提前刷新防临界 401
_token_lock = _threading.Lock()
_token_cache: dict = {"token": "", "expires_at": 0.0}


def get_access_token(force_refresh: bool = False) -> str:
    """小程序全局凭据 access_token（/cgi-bin/token；内存缓存+过期刷新）。

    - 缓存命中且距过期 >300s → 直接返回，不打微信；
    - appsecret 未配置 → RuntimeError（调用方自决降级，订阅消息静默跳过）；
    - 微信侧失败 → RuntimeError 只含 errcode/errmsg（绝不携带凭据）。
    """
    secret = mp_secret()
    if not secret:
        raise RuntimeError("appsecret 未配置（无法获取 access_token）")
    with _token_lock:
        cached = _token_cache["token"]
        if (not force_refresh and cached
                and _token_cache["expires_at"] - _TOKEN_REFRESH_MARGIN > time.time()):
            return cached
    r = cr.get(
        "https://api.weixin.qq.com/cgi-bin/token",
        params={"grant_type": "client_credential",
                "appid": config.WX_APPID, "secret": secret},
        impersonate="chrome", timeout=15,
    )
    try:
        d = r.json()
    except Exception as exc:  # noqa: BLE001 —— 非 JSON 回执按失败处理（不含凭据）
        raise RuntimeError(f"access_token 回执非 JSON（HTTP {r.status_code}）") from exc
    if d.get("errcode") or not d.get("access_token"):
        raise RuntimeError(f"access_token 获取失败 {d.get('errcode')}: {d.get('errmsg')}")
    with _token_lock:
        _token_cache["token"] = str(d["access_token"])
        _token_cache["expires_at"] = time.time() + int(d.get("expires_in") or 7200)
    return _token_cache["token"]


def _reset_token_cache() -> None:
    """清 access_token 内存缓存（测试/密钥轮换复位；不触网不落盘）。"""
    with _token_lock:
        _token_cache["token"] = ""
        _token_cache["expires_at"] = 0.0
