"""R2 通道扩展：飞书 webhook / 钉钉 webhook+签名 / 微信纯视觉只读。"""
import json

import pytest

from paistation.channels.dingtalk import DingTalkChannel
from paistation.channels.feishu import FeishuChannel
from paistation.channels.wechat_vision import WechatVisionChannel


class FakeResp:
    def __init__(self, body, status=200):
        self._body = json.dumps(body).encode("utf-8")
        self.status = status

    def read(self):
        return self._body

    def __enter__(self):
        return self

    def __exit__(self, *a):
        return False


class FakeOpener:
    def __init__(self, body):
        self.body = body
        self.calls = []

    def open(self, req, timeout=None):
        self.calls.append(req)
        return FakeResp(self.body)


# ---- 飞书 ----

def test_feishu_send_ok():
    op = FakeOpener({"code": 0, "msg": "success"})
    ch = FeishuChannel("https://open.feishu.cn/open-apis/bot/v2/hook/abc",
                       _opener=op)
    r = ch.send("标题", "正文")
    assert r["ok"] is True
    sent = json.loads(op.calls[0].data.decode("utf-8"))
    assert sent["msg_type"] == "text"
    assert "标题" in sent["content"]["text"]


def test_feishu_rejects_foreign_host():
    with pytest.raises(ValueError, match="域名不被允许"):
        FeishuChannel("https://evil.example.com/hook")


def test_feishu_old_code_zero_is_ok():
    """飞书旧版响应 StatusCode=0 也算成功。"""
    op = FakeOpener({"StatusCode": 0})
    ch = FeishuChannel("https://open.feishu.cn/open-apis/bot/v2/hook/abc",
                       _opener=op)
    assert ch.send("t", "b")["ok"] is True


def test_feishu_api_error_not_ok():
    op = FakeOpener({"code": 19021, "msg": "sign match fail"})
    ch = FeishuChannel("https://open.feishu.cn/open-apis/bot/v2/hook/abc",
                       _opener=op)
    r = ch.send("t", "b")
    assert r["ok"] is False and r["code"] == 19021


# ---- 钉钉 ----

def test_dingtalk_send_ok_with_sign():
    op = FakeOpener({"errcode": 0, "errmsg": "ok"})
    ch = DingTalkChannel(
        "https://oapi.dingtalk.com/robot/send?access_token=tok",
        secret="SEC123", _opener=op, _now=lambda: 1700000000.0)
    r = ch.send("标题", "正文")
    assert r["ok"] is True
    url = op.calls[0].full_url
    assert "timestamp=1700000000000" in url and "sign=" in url
    sent = json.loads(op.calls[0].data.decode("utf-8"))
    assert sent["msgtype"] == "markdown"


def test_dingtalk_sign_deterministic():
    """同 secret+timestamp 签名确定（HMAC-SHA256 base64）。"""
    sig = DingTalkChannel._sign("SEC", 1700000000000)
    sig2 = DingTalkChannel._sign("SEC", 1700000000000)
    assert sig == sig2 and len(sig) > 10
    assert DingTalkChannel._sign("SEC2", 1700000000000) != sig


def test_dingtalk_without_secret_no_sign_param():
    op = FakeOpener({"errcode": 0})
    ch = DingTalkChannel(
        "https://oapi.dingtalk.com/robot/send?access_token=tok", _opener=op)
    ch.send("t", "b")
    assert "sign=" not in op.calls[0].full_url


def test_dingtalk_rejects_foreign_host():
    with pytest.raises(ValueError, match="域名不被允许"):
        DingTalkChannel("https://evil.example.com/x")


# ---- 微信纯视觉只读 ----

def test_wechat_vision_send_is_forbidden():
    """红线：微信通道只读，send 永远拒绝（不注入不模拟点击零外发）。"""
    ch = WechatVisionChannel()
    with pytest.raises(PermissionError, match="只读"):
        ch.send("t", "b")


def test_wechat_vision_digest_from_snapshot():
    def fake_snapshot(image_path):
        return {"is_wechat": True, "messages_summary": "3 条工作群消息"}

    ch = WechatVisionChannel(snapshot_fn=fake_snapshot)
    digest = ch.digest("screen_1.png")
    assert digest["is_wechat"] is True
    assert digest["delivered"] is False  # 只入本地感知，绝不投递


def test_wechat_vision_digest_non_wechat_is_empty():
    def fake_snapshot(image_path):
        return {"is_wechat": False, "messages_summary": ""}

    ch = WechatVisionChannel(snapshot_fn=fake_snapshot)
    assert ch.digest("x.png") == {"is_wechat": False, "messages_summary": "",
                                  "delivered": False}
