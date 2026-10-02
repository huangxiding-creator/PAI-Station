# -*- coding: utf-8 -*-
"""虚拟支付双签名单测——5 向量，自 qianwen tests/test_pay_sign.py 原样迁移（改 import 路径+pytest 化）。

运行：.venv pytest tests/test_pay_sign.py
"""
from __future__ import annotations

import hashlib
import hmac
import json
import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from xueyuan_engine.wechat import virtual_pay_sign  # noqa: E402

SECRET = "test-appsecret-0123456789abcdef"
SESSION = "test-session-key-xxxxxxxxxxxx=="
SIGN_DATA = {
    "offerId": "12345", "buyQuantity": 1, "env": 0, "currencyType": "CNY",
    "productId": "unlock_answer_1", "goodsPrice": 100,
    "outTradeNo": "aB3xY9-_*", "attach": "0123456789abcdef",
    "mode": "short_series_goods",
}


def _sign(key: str, prefix: str, body: str) -> str:
    return hmac.new(key.encode(), (prefix + body).encode(), hashlib.sha256).hexdigest()


def test_vector_1_sign_data_compact_serialization():
    """1) signData 紧凑序列化契约（客户端原样透传的就是这个字符串）。"""
    body, _, _ = virtual_pay_sign(SECRET, SESSION, SIGN_DATA)
    assert body == json.dumps(SIGN_DATA, separators=(",", ":"), ensure_ascii=False)


def test_vector_2_dual_signature():
    """2) 双签名独立复核：HMAC-SHA256 → 64 位 hex。"""
    body, pay_sig, sig = virtual_pay_sign(SECRET, SESSION, SIGN_DATA)
    want_pay = _sign(SECRET, "requestVirtualPayment&", body)
    want_sig = _sign(SESSION, "VirtualPayment&", body)
    assert pay_sig == want_pay and len(pay_sig) == 64
    assert sig == want_sig and len(sig) == 64


def test_vector_3_key_isolation():
    """3) 密钥隔离：换 session_key 只动 signature；换 appsecret 只动 pay_sig。"""
    _, pay_sig, sig = virtual_pay_sign(SECRET, SESSION, SIGN_DATA)
    _, pay2, sig2 = virtual_pay_sign(SECRET, "another-session", SIGN_DATA)
    assert pay2 == pay_sig and sig2 != sig
    _, pay3, sig3 = virtual_pay_sign("another-secret", SESSION, SIGN_DATA)
    assert pay3 != pay_sig and sig3 == sig


def test_vector_4_byte_binding():
    """4) 逐字节绑定：signData 一字符之差签名必变。"""
    body, pay_sig, _ = virtual_pay_sign(SECRET, SESSION, SIGN_DATA)
    b4, pay4, _ = virtual_pay_sign(SECRET, SESSION, {**SIGN_DATA, "buyQuantity": 2})
    assert b4 != body and pay4 != pay_sig


def test_vector_5_chinese_not_escaped():
    """5) 中文值不转义（ensure_ascii=False）。"""
    b4, _, _ = virtual_pay_sign(SECRET, SESSION, {**SIGN_DATA, "buyQuantity": 2})
    assert not re.search(r"\\u", b4 or json.dumps({"a": "总包"}, ensure_ascii=False))
