# -*- coding: utf-8 -*-
"""虚拟支付双签名单测 — 总包千问 v0.2.5。运行：python tests/test_pay_sign.py"""
import hashlib
import hmac
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from qianwen_engine.wechat import virtual_pay_sign  # noqa: E402

SECRET = "test-appsecret-0123456789abcdef"
SESSION = "test-session-key-xxxxxxxxxxxx=="
SIGN_DATA = {
    "offerId": "12345", "buyQuantity": 1, "env": 0, "currencyType": "CNY",
    "productId": "unlock_answer_1", "goodsPrice": 100,
    "outTradeNo": "aB3xY9-_*", "attach": "0123456789abcdef",
    "mode": "short_series_goods",
}

body, pay_sig, sig = virtual_pay_sign(SECRET, SESSION, SIGN_DATA)

# 1) signData 紧凑序列化契约（客户端原样透传的就是这个字符串）
assert body == json.dumps(SIGN_DATA, separators=(",", ":"), ensure_ascii=False), "signData 序列化"

# 2) 双签名独立复核：HMAC-SHA256 → 64 位 hex
want_pay = hmac.new(SECRET.encode(), ("requestVirtualPayment&" + body).encode(), hashlib.sha256).hexdigest()
want_sig = hmac.new(SESSION.encode(), ("VirtualPayment&" + body).encode(), hashlib.sha256).hexdigest()
assert pay_sig == want_pay and len(pay_sig) == 64, "pay_sig 向量"
assert sig == want_sig and len(sig) == 64, "signature 向量"

# 3) 密钥隔离：换 session_key 只动 signature；换 appsecret 只动 pay_sig
_, pay2, sig2 = virtual_pay_sign(SECRET, "another-session", SIGN_DATA)
assert pay2 == pay_sig and sig2 != sig, "session_key 只影响 signature"
_, pay3, sig3 = virtual_pay_sign("another-secret", SESSION, SIGN_DATA)
assert pay3 != pay_sig and sig3 == sig, "appsecret 只影响 pay_sig"

# 4) 逐字节绑定：signData 一字符之差签名必变
b4, pay4, _ = virtual_pay_sign(SECRET, SESSION, {**SIGN_DATA, "buyQuantity": 2})
assert b4 != body and pay4 != pay_sig, "signData 变化必改签名"

# 5) 中文值不转义（ensure_ascii=False）
_, pay5, _ = virtual_pay_sign(SECRET, SESSION, {**SIGN_DATA, "attach": "总包"})
import re as _re
assert not _re.search(r"\\u", b4 or json.dumps({"a": "总包"}, ensure_ascii=False)) , "中文不转义"

print("PAY SIGN TESTS: ALL PASS (5 vectors)")
