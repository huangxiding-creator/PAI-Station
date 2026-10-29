# -*- coding: utf-8 -*-
"""T-08 notify 企微通知测试 — 全 fake transport，零真网（monkeypatch urllib）。

covers: FR6 / NFR4；webhook 解析机制复用 tools/notify_approval_wecom.py
（data/secrets/invoice_wecom_webhook.txt → F:/We-AIPO/.env 兜底）。
"""
import io
import json
import sys
import urllib.error
import urllib.request
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))  # zhipu-quota-guard 根

import zqg.notify as zn  # noqa: E402  (namespace package，无需 zqg/__init__.py)

OK_BODY = b'{"errcode":0,"errmsg":"ok"}'


# ---------------------------------------------------------------- fakes
class FakeResponse:
    def __init__(self, body=OK_BODY):
        self._body = body

    def read(self):
        return self._body

    def __enter__(self):
        return self

    def __exit__(self, *exc):
        return False


class FakeLedger:
    """T-02 Ledger 的鸭子替身：只记录 append(kind, payload)。"""

    def __init__(self):
        self.entries = []

    def append(self, kind, payload):
        self.entries.append((kind, payload))


class Clock:
    def __init__(self, t=1_700_000_000.0):
        self.t = t

    def __call__(self):
        return self.t

    def advance(self, sec):
        self.t += sec


def install_fake_transport(monkeypatch, *, exc=None, body=OK_BODY):
    calls = []

    def fake_urlopen(req, timeout=None):
        calls.append({"req": req, "timeout": timeout})
        if exc is not None:
            raise exc
        return FakeResponse(body)

    monkeypatch.setattr(urllib.request, "urlopen", fake_urlopen)
    return calls


def http_500():
    return urllib.error.HTTPError(
        "https://qyapi.example/hooks/xxx", 500, "Internal Server Error",
        None, io.BytesIO(b"boom"))


# ---------------------------------------------------------------- webhook 解析
def test_t08_webhook_prefers_station_secrets_file(tmp_path, monkeypatch):
    wf = tmp_path / "data" / "secrets" / "invoice_wecom_webhook.txt"
    wf.parent.mkdir(parents=True)
    wf.write_text("https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=K1\n", encoding="utf-8")
    monkeypatch.setattr(zn, "REPO", tmp_path)
    assert zn.webhook() == "https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=K1"


def test_t08_webhook_falls_back_to_we_aipo_env(tmp_path, monkeypatch):
    env = tmp_path / "fake.env"
    env.write_text("OTHER=1\nWECOM_WEBHOOK_URL=https://fb/hooks/yyy\n", encoding="utf-8")
    monkeypatch.setattr(zn, "REPO", tmp_path)  # 无 secrets 文件
    monkeypatch.setattr(zn, "FALLBACK_ENV", env)
    assert zn.webhook() == "https://fb/hooks/yyy"


def test_t08_webhook_empty_when_unconfigured(tmp_path, monkeypatch):
    monkeypatch.setattr(zn, "REPO", tmp_path)
    monkeypatch.setattr(zn, "FALLBACK_ENV", tmp_path / "nope.env")
    assert zn.webhook() == ""


def test_t08_webhook_secrets_file_non_http_ignored(tmp_path, monkeypatch):
    wf = tmp_path / "data" / "secrets" / "invoice_wecom_webhook.txt"
    wf.parent.mkdir(parents=True)
    wf.write_text("not-a-url", encoding="utf-8")
    env = tmp_path / "fake.env"
    env.write_text("WECOM_WEBHOOK_URL=https://fb/hooks/z\n", encoding="utf-8")
    monkeypatch.setattr(zn, "REPO", tmp_path)
    monkeypatch.setattr(zn, "FALLBACK_ENV", env)
    assert zn.webhook() == "https://fb/hooks/z"


# ---------------------------------------------------------------- send 核心
def test_t08_send_posts_markdown_payload(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    n = zn.Notifier(url="https://qyapi.example/hooks/xxx",
                    state_path=tmp_path / "dedup.json")
    assert n.send("zai 水位 92%", "预测 14:50 烧穿", "low_quota") is True
    assert len(calls) == 1
    req = calls[0]["req"]
    assert req.full_url == "https://qyapi.example/hooks/xxx"
    assert calls[0]["timeout"] == 10
    assert req.headers.get("Content-type") == "application/json"
    payload = json.loads(req.data.decode("utf-8"))
    assert payload["msgtype"] == "markdown"
    content = payload["markdown"]["content"]
    assert "[ZQG][低水位] zai 水位 92%" in content
    assert "预测 14:50 烧穿" in content


def test_t08_send_redacts_sensitive_text(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json")
    secret_detail = "key=sk-abcdef1234567890abcdef 泛化token=Bearer a1b2c3d4e5 " \
                    "hex=0123456789abcdef0123456789abcdef0123456789abcdef"
    n.send("带密钥的事故", secret_detail, "drift")
    content = json.loads(calls[0]["req"].data.decode())["markdown"]["content"]
    assert "sk-abcdef1234567890" not in content
    assert "Bearer a1b2c3d4e5" not in content
    assert "0123456789abcdef0123456789abcdef" not in content


def test_t08_send_fail_loud_after_two_retries(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch, exc=http_500())
    ledger = FakeLedger()
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json", ledger=ledger)
    with pytest.raises(zn.NotifyError):
        n.send("stub 500", "应重试2次后失败", "reset_result")
    assert len(calls) == 3  # 首发 + 重试2次
    kinds = [k for k, _ in ledger.entries]
    assert "error" in kinds  # 失败写账本 error 条目


def test_t08_send_wecom_errcode_nonzero_fails_loud(tmp_path, monkeypatch):
    install_fake_transport(monkeypatch, body=b'{"errcode":93000,"errmsg":"invalid webhook"}')
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json")
    with pytest.raises(zn.NotifyError):
        n.send("业务错误", "errcode!=0", "login_invalid")


def test_t08_send_without_webhook_raises(tmp_path, monkeypatch):
    install_fake_transport(monkeypatch)
    monkeypatch.setattr(zn, "webhook", lambda: "")
    n = zn.Notifier(state_path=tmp_path / "d.json")  # 无 url → 解析得空
    with pytest.raises(zn.NotifyError):
        n.send("无配置", "", "heartbeat")


def test_t08_unknown_kind_raises_value_error(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json")
    with pytest.raises(ValueError):
        n.send("x", "", "not_a_kind")
    assert calls == []  # 未触网


# ---------------------------------------------------------------- 去重节流
def test_t08_dedup_same_kind_title_suppressed_within_15min(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    clock = Clock()
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json", now=clock)
    assert n.send("zai 水位 92%", "", "low_quota") is True
    clock.advance(60)
    assert n.send("zai 水位 92%", "", "low_quota") is False   # 1 分钟内抑制
    clock.advance(839)                                        # 累计 899s < 900s
    assert n.send("zai 水位 92%", "", "low_quota") is False
    clock.advance(1)                                          # 恰满 15 分钟 → 放行
    assert n.send("zai 水位 92%", "", "low_quota") is True
    assert len(calls) == 2


def test_t08_dedup_allows_different_title_or_kind(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json")
    assert n.send("zai 水位 92%", "", "low_quota") is True
    assert n.send("bigmodel 水位 95%", "", "low_quota") is True  # 同 kind 异标题
    assert n.send("zai 水位 92%", "", "drift") is True           # 同标题异 kind
    assert len(calls) == 3


def test_t08_dedup_persisted_across_instances(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    state = tmp_path / "dedup.json"
    zn.Notifier(url="https://u/h", state_path=state).send("登录失效", "", "login_invalid")
    n2 = zn.Notifier(url="https://u/h", state_path=state)  # 新实例读同一 state 文件
    assert n2.send("登录失效", "", "login_invalid") is False
    assert len(calls) == 1


# ---------------------------------------------------------------- 事件模板
SEVEN = ["reset_exec", "reset_result", "low_quota",
         "login_invalid", "card_short", "drift", "heartbeat"]


def test_t08_seven_kinds_have_fixed_title_format(tmp_path, monkeypatch):
    calls = install_fake_transport(monkeypatch)
    state = tmp_path / "d.json"
    for kind in SEVEN:
        n = zn.Notifier(url="https://u/h", state_path=state)
        assert n.send("事由", "", kind) is True, kind
    assert len(calls) == 7
    for (call, kind) in zip(calls, SEVEN):
        content = json.loads(call["req"].data.decode())["markdown"]["content"]
        assert content.startswith(f"**[ZQG]{zn.TITLE_PREFIX[kind]} 事由**"), (
            kind, content)


# ---------------------------------------------------------------- 账本缝合
def test_t08_success_writes_notify_ledger_entry(tmp_path, monkeypatch):
    install_fake_transport(monkeypatch)
    ledger = FakeLedger()
    n = zn.Notifier(url="https://u/h", state_path=tmp_path / "d.json", ledger=ledger)
    n.send("重置执行", "five_hour FIFO 首卡", "reset_exec")
    notify_entries = [p for k, p in ledger.entries if k == "notify"]
    assert len(notify_entries) == 1
    assert notify_entries[0]["event"] == "reset_exec"
    assert "重置执行" in notify_entries[0]["title"]
