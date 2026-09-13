"""Phase D1 x402/ACP 客户端：HTTP 402 微结算语义（免费期也全程计量）。

真钱闭环留待用户配置支付处理器；协议语义+计量先行（网络零依赖，opener 注入）。
"""
import base64
import json

from paistation.market.x402 import X402Client


class FakeResponse:
    def __init__(self, status: int, headers: dict, body: dict):
        self.status = status
        self.headers = headers
        self._body = json.dumps(body).encode("utf-8")

    def read(self):
        return self._body

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeOpener:
    """可编程响应序列，记录请求头。"""

    def __init__(self, responses):
        self._responses = responses
        self.requests = []

    def open(self, req, timeout=None):
        self.requests.append({"url": req.full_url,
                              "headers": dict(req.headers)})
        r = self._responses.pop(0)
        return r


INVOICE = {"scheme": "x402", "amount": "0.05", "asset": "USDC",
           "pay_to": "0xabc", "nonce": "n1"}


def _payment_header(invoice: dict) -> str:
    return base64.b64encode(json.dumps(invoice).encode()).decode()


def test_free_200_passes_through(tmp_path):
    op = FakeOpener([FakeResponse(200, {}, {"data": "ok"})])
    client = X402Client(home=tmp_path, opener=op)
    r = client.fetch("https://api.example.com/dataset")
    assert r["status"] == 200
    assert r["body"]["data"] == "ok"


def test_402_returns_invoice_when_no_provider(tmp_path):
    op = FakeOpener([FakeResponse(
        402, {"X-Payment-Required": _payment_header(INVOICE)}, {})])
    client = X402Client(home=tmp_path, opener=op)
    r = client.fetch("https://api.example.com/dataset")
    assert r["status"] == "payment_required"
    assert r["invoice"]["amount"] == "0.05"


def test_paid_refetch_with_payment_header(tmp_path):
    op = FakeOpener([
        FakeResponse(402, {"X-Payment-Required": _payment_header(INVOICE)}, {}),
        FakeResponse(200, {}, {"data": "paid-ok"}),
    ])
    paid = []

    def provider(invoice):
        paid.append(invoice)
        return "PAYMENT-PROOF-123"

    client = X402Client(home=tmp_path, opener=op, payment_provider=provider)
    r = client.fetch("https://api.example.com/dataset")
    assert r["status"] == 200
    assert r["body"]["data"] == "paid-ok"
    # 第二次请求带支付证明头
    assert op.requests[1]["headers"].get("X-payment") == "PAYMENT-PROOF-123"


def test_payment_always_metered_even_dry(tmp_path):
    """免费期/无 provider：402 也全程计量（花钱意识先行）。"""
    op = FakeOpener([FakeResponse(
        402, {"X-Payment-Required": _payment_header(INVOICE)}, {})])
    client = X402Client(home=tmp_path, opener=op)
    client.fetch("https://api.example.com/dataset")
    from paistation.control.meter import usage

    u = usage(tmp_path)["x402:https://api.example.com/dataset"]
    assert u["yuan"] > 0


def test_paid_fetch_metered_once(tmp_path):
    op = FakeOpener([
        FakeResponse(402, {"X-Payment-Required": _payment_header(INVOICE)}, {}),
        FakeResponse(200, {}, {"data": "ok"}),
    ])
    client = X402Client(home=tmp_path, opener=op,
                        payment_provider=lambda inv: "P")
    client.fetch("https://api.example.com/dataset")
    from paistation.control.meter import usage

    u = usage(tmp_path)["x402:https://api.example.com/dataset"]
    assert u["yuan"] == 0.05
    assert u["tokens"] > 0            # 响应体也计量


def test_non_402_error_returned(tmp_path):
    op = FakeOpener([FakeResponse(500, {}, {"error": "boom"})])
    client = X402Client(home=tmp_path, opener=op)
    r = client.fetch("https://api.example.com/x")
    assert r["status"] == 500
