"""D1 x402/ACP 客户端：HTTP 402 微结算语义。

流程：GET → 402+X-Payment-Required（base64 JSON invoice）→ 支付处理器
（注入式；缺省=dry，返回 payment_required 状态）→ 带 X-Payment 重放 → 200。
**免费期也全程计量**（花钱意识先行）：402 即刻按 invoice 金额入账
meter；响应体字节数折算 tokens 计量。
"""
from __future__ import annotations

import base64
import json
import urllib.request
from collections.abc import Callable
from pathlib import Path

from paistation.control.meter import Meter

_OPENER = urllib.request.build_opener(urllib.request.ProxyHandler({}))


class X402Client:
    def __init__(self, home: str | Path, opener=None,
                 payment_provider: Callable[[dict], str] | None = None):
        self._home = Path(home)
        self._opener = opener or _OPENER
        self._provider = payment_provider
        self._meter = Meter(home)

    def fetch(self, url: str, timeout: int = 30) -> dict:
        req = urllib.request.Request(url)
        resp = self._opener.open(req, timeout=timeout)
        body_bytes = resp.read()
        status = getattr(resp, "status", 200) or 200
        headers = {k.lower(): v for k, v in (resp.headers or {}).items()}
        if status != 402:
            self._meter.record(f"x402:{url}", tokens=len(body_bytes) // 4)
            try:
                body = json.loads(body_bytes.decode("utf-8"))
            except (ValueError, UnicodeDecodeError):
                body = {"raw_len": len(body_bytes)}
            return {"status": status, "body": body}
        invoice_raw = headers.get("x-payment-required", "")
        try:
            invoice = json.loads(base64.b64decode(invoice_raw).decode("utf-8"))
        except (ValueError, UnicodeDecodeError):
            invoice = {"raw": invoice_raw[:100]}
        self._meter.record(f"x402:{url}",
                           yuan=float(invoice.get("amount", 0) or 0))
        if self._provider is None:
            return {"status": "payment_required", "invoice": invoice}
        proof = self._provider(invoice)
        req2 = urllib.request.Request(url, headers={"X-Payment": proof})
        resp2 = self._opener.open(req2, timeout=timeout)
        body2 = resp2.read()
        status2 = getattr(resp2, "status", 200) or 200
        self._meter.record(f"x402:{url}", tokens=len(body2) // 4)
        try:
            parsed = json.loads(body2.decode("utf-8"))
        except (ValueError, UnicodeDecodeError):
            parsed = {"raw_len": len(body2)}
        return {"status": status2, "body": parsed}
