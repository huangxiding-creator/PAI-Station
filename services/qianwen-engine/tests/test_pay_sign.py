# -*- coding: utf-8 -*-
"""虚拟支付双签名单测 — 总包千问（2026-10 官方《签名详解》AppKey 新规格）。
运行：python tests/test_pay_sign.py"""
import hashlib
import hmac
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from qianwen_engine.wechat import virtual_pay_sign  # noqa: E402

APPKEY = "test-appkey-0123456789abcdef"
SESSION = "test-session-key-xxxxxxxxxxxx=="
SIGN_DATA = {
    "offerId": "12345", "buyQuantity": 1, "env": 0, "currencyType": "CNY",
    "productId": "unlock_once", "goodsPrice": 100,
    "outTradeNo": "aB3xY9-_*", "attach": "0123456789abcdef",
    "mode": "short_series_goods",
}

# 0) 官方向量端到端（AppKey 制 + 无前缀）：post_body 原文直签入口
V_URI = "/xpay/query_user_balance"
V_BODY = '{"openid": "xxx", "user_ip": "127.0.0.1", "env": 0}'
b0, pay0, sig0 = virtual_pay_sign("12345", "9hAb/NEYUlkaMBEsmFgzig==", None, uri=V_URI, body=V_BODY)
assert b0 == V_BODY, "官方向量 body 原文透传"
assert pay0 == "c37809f27c6d7fd1837ad2500a04512b66b34fd793a39a385fade56dca89a4b5", "官方 paySig 向量"
assert sig0 == "089d9e8dc5d308977360c4b79ec600a93d736802802a807d634192328032f6c7", "官方 signature 向量"

# 1) signData 紧凑序列化契约（客户端原样透传的就是这个字符串）
body, pay_sig, sig = virtual_pay_sign(APPKEY, SESSION, SIGN_DATA)
assert body == json.dumps(SIGN_DATA, separators=(",", ":"), ensure_ascii=False), "signData 序列化"

# 2) 双签名独立复核（新规格：paySig=HMAC(appKey, uri&+body)；signature=HMAC(session_key, body) 无前缀）
want_pay = hmac.new(APPKEY.encode(), ("requestVirtualPayment&" + body).encode(), hashlib.sha256).hexdigest()
want_sig = hmac.new(SESSION.encode(), body.encode(), hashlib.sha256).hexdigest()
assert pay_sig == want_pay and len(pay_sig) == 64, "pay_sig 向量"
assert sig == want_sig and len(sig) == 64, "signature 向量"

# 3) 密钥隔离：换 session_key 只动 signature；换 appKey 只动 pay_sig
_, pay2, sig2 = virtual_pay_sign(APPKEY, "another-session", SIGN_DATA)
assert pay2 == pay_sig and sig2 != sig, "session_key 只影响 signature"
_, pay3, sig3 = virtual_pay_sign("another-appkey", SESSION, SIGN_DATA)
assert pay3 != pay_sig and sig3 == sig, "appKey 只影响 pay_sig"

# 4) 逐字节绑定：signData 一字符之差签名必变
b4, pay4, _ = virtual_pay_sign(APPKEY, SESSION, {**SIGN_DATA, "buyQuantity": 2})
assert b4 != body and pay4 != pay_sig, "signData 变化必改签名"

# 5) 中文值不转义（ensure_ascii=False）
b5, _, _ = virtual_pay_sign(APPKEY, SESSION, {**SIGN_DATA, "attach": "总包"})
assert "总包" in b5 and "\\u" not in b5, "中文不转义"

print("PAY SIGN TESTS: ALL PASS (6 vectors, 官方向量锚定)")
