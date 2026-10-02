# -*- coding: utf-8 -*-
"""企微通知域单测（NFR-12）：webhook env 门（无配置静默跳过）、推送 payload
形状、外呼失败不抛错、日报构造（空库/有数据含熔断字段）、日报线程开关幂等。"""
from __future__ import annotations

import importlib
import sys
import threading
from pathlib import Path
from types import SimpleNamespace

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from xueyuan_engine import notify, store  # noqa: E402


class _Resp:
    def __init__(self, status_code=200, payload=None, raises=False):
        self.status_code = status_code
        self._payload = payload if payload is not None else {"errcode": 0}
        self._raises = raises

    def json(self):
        if self._raises:
            raise ValueError("not json")
        return self._payload


def test_push_without_env_skips_silently(engine, monkeypatch):
    monkeypatch.delenv(notify.WEBHOOK_ENV, raising=False)
    assert notify.push("hello") is False  # 静默跳过（记日志）绝不硬编码 URL


def test_push_posts_text_payload(engine, monkeypatch):
    monkeypatch.setenv(notify.WEBHOOK_ENV, "https://qyapi.weixin.qq.com/cgi-bin/hook/TEST")
    seen = {}

    def _post(url, json=None, timeout=None):
        seen["url"], seen["body"], seen["timeout"] = url, json, timeout
        return _Resp()

    monkeypatch.setattr(notify, "cr", SimpleNamespace(post=_post))
    assert notify.push("退款日报") is True
    assert seen["url"].endswith("/hook/TEST")
    assert seen["body"]["msgtype"] == "text"
    assert seen["body"]["text"]["content"] == "退款日报"


def test_push_failure_returns_false_never_raises(engine, monkeypatch):
    monkeypatch.setenv(notify.WEBHOOK_ENV, "https://qyapi.weixin.qq.com/cgi-bin/hook/TEST")

    def _raise(*a, **kw):
        raise OSError("network down")

    monkeypatch.setattr(notify, "cr", SimpleNamespace(post=_raise))
    assert notify.push("x") is False
    monkeypatch.setattr(notify, "cr", SimpleNamespace(
        post=lambda *a, **kw: _Resp(500, raises=True)))
    assert notify.push("x") is False  # 非 JSON 回执按失败处理


def test_alert_never_raises_even_if_push_explodes(engine, monkeypatch):
    def _boom(text):
        raise RuntimeError("push exploded")

    monkeypatch.setattr(notify, "push", _boom)
    notify.alert("[告警] 测试")  # 不得抛错阻塞业务响应
    monkeypatch.setattr(notify, "_webhook", lambda: "")
    notify.alert("[告警] 无配置")  # 无配置=纯日志路径


def test_build_daily_report_empty(engine):
    text = notify.build_daily_report()
    assert text.startswith("[总包学园·退款日报]")
    assert "熔断：全部关闭" in text and "书券发放：无" in text


def test_build_daily_report_with_rows_and_fuse(engine):
    ts = store.now()   # 时钟注入：绝对日期硬编码一跨日即永久红（夹具时钟陷阱变体二）
    with store._LOCK, store._db() as c:
        c.execute("INSERT INTO fuse_state(key,opened,reason,opened_at,updated_at)"
                  " VALUES('report:js-shuiwang-2026',1,'单报告退款率 2/6',?,?)",
                  (ts, ts))
        c.execute("INSERT INTO refunds(id,order_id,criticism_id,user_id,platform,"
                  "tier,amount_fen,method,status,created_at) VALUES('rN1','o1','',"
                  "'u1','android','tier50',24900,'auto','settled',?)", (ts,))
        c.execute("INSERT INTO vouchers(id,user_id,amount_fen,source,source_ref,"
                  "status,created_at) VALUES('vN1','u1',500,'criticism_thanks','c1',"
                  "'active',?)", (ts,))
    text = notify.build_daily_report()
    assert "report:js-shuiwang-2026（单报告退款率 2/6）" in text  # 熔断字段
    assert "auto×1" in text and "criticism_thanks×1=500分" in text
    assert "今日 1 笔 24900 分" in text


def test_send_daily_report_pushes_and_returns_text(engine, monkeypatch):
    sent = []
    monkeypatch.setattr(notify, "push", lambda t: sent.append(t) or True)
    text = notify.send_daily_report()
    assert sent == [text] and text.startswith("[总包学园·退款日报]")


def test_daily_thread_toggle_idempotent(engine):
    assert notify.start_daily_thread() is True   # 首启
    assert notify.start_daily_thread() is False  # 已活→幂等不重开
    notify.stop_daily_thread()
    assert notify.start_daily_thread() is True   # 停后可再启
    notify.stop_daily_thread()


def test_daily_autostart_gated_by_env(engine, monkeypatch):
    """默认关；XY_NOTIFY_DAILY=1 时 import 即启（systemd 生产腿）。"""
    monkeypatch.delenv(notify.DAILY_ENV, raising=False)
    mod = importlib.reload(notify)
    assert mod._daily_thread is None or not mod._daily_thread.is_alive()
    monkeypatch.setenv(notify.DAILY_ENV, "1")
    mod = importlib.reload(notify)
    try:
        assert mod._daily_thread is not None and mod._daily_thread.is_alive()
        assert mod.start_daily_thread() is False  # 已活幂等
    finally:
        mod.stop_daily_thread()
        monkeypatch.delenv(notify.DAILY_ENV, raising=False)
        importlib.reload(mod)  # 复位默认关
    left = [t for t in threading.enumerate() if t.name == "xueyuan-daily-report"]
    assert not left  # 无残留线程


def test_daily_loop_runs_and_survives_send_failure(engine, monkeypatch):
    """循环体直测：发送异常不杀循环（次日重试语义），停机事件即退出。"""
    stop = threading.Event()
    calls = []

    def _send():
        calls.append(1)
        if len(calls) == 1:
            raise RuntimeError("send boom")
        stop.set()

    monkeypatch.setattr(notify, "send_daily_report", _send)
    monkeypatch.setattr(notify, "_seconds_until_daily", lambda t: 0.0)
    notify._daily_loop(stop)
    assert len(calls) == 2  # 首轮异常存活→第二轮自停
