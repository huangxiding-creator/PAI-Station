"""M2 企微通道：webhook 直连（防乱码 + 直连不走代理 + errcode 判定）。"""
import json
import urllib.error

import pytest

from paistation.channels.wecom import WeComChannel


class FakeResponse:
    def __init__(self, body: dict):
        self._data = json.dumps(body).encode("utf-8")

    def read(self):
        return self._data

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeOpener:
    """记录请求并可编程响应。"""
    def __init__(self, responses=None, error=None):
        self.requests = []
        self._responses = responses or [{"errcode": 0, "errmsg": "ok"}]
        self._error = error

    def open(self, req, timeout=None):
        self.requests.append({"url": req.full_url,
                              "data": json.loads(req.data.decode("utf-8")),
                              "timeout": timeout,
                              "headers": dict(req.headers)})
        if self._error:
            raise self._error
        return FakeResponse(self._responses.pop(0))


def test_send_ok():
    op = FakeOpener()
    ch = WeComChannel(webhook="https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=x",
                      _opener=op)
    r = ch.send("标题", "正文")
    assert r["ok"] is True and r["errcode"] == 0
    body = op.requests[0]
    assert body["url"].startswith("https://qyapi.weixin.qq.com/")
    assert body["data"]["msgtype"] == "markdown"
    assert "标题" in body["data"]["markdown"]["content"]


def test_send_ensure_ascii_immune_to_gbk():
    """中文转 \\uXXXX：传输层免疫 GBK 乱码（notify_wecom 配方）。"""
    op = FakeOpener()
    ch = WeComChannel(webhook="https://qyapi.weixin.qq.com/send?key=x", _opener=op)
    ch.send("里程碑", "完成")
    raw = json.dumps(op.requests[0]["data"], ensure_ascii=True)
    assert "\\u" in raw


def test_send_api_error_not_ok():
    op = FakeOpener(responses=[{"errcode": 93000, "errmsg": "invalid webhook"}])
    ch = WeComChannel(webhook="https://qyapi.weixin.qq.com/send?key=x", _opener=op)
    r = ch.send("t", "b")
    assert r["ok"] is False and r["errcode"] == 93000


def test_send_http_exception_captured():
    op = FakeOpener(error=urllib.error.URLError("网络断"))
    ch = WeComChannel(webhook="https://qyapi.weixin.qq.com/send?key=x", _opener=op)
    r = ch.send("t", "b")
    assert r["ok"] is False and "网络断" in r["errmsg"]


def test_send_timeout_passed():
    op = FakeOpener()
    ch = WeComChannel(webhook="https://qyapi.weixin.qq.com/send?key=x",
                      timeout=7, _opener=op)
    ch.send("t", "b")
    assert op.requests[0]["timeout"] == 7


def test_rejects_non_wecom_url():
    """只允许企微域名：防 webhook 参数被指到别处（SSRF 面）。"""
    with pytest.raises(ValueError):
        WeComChannel(webhook="https://evil.example.com/send?key=x")
