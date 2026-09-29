# -*- coding: utf-8 -*-
"""metaso_kb 单测——全部 monkeypatch 传输层，零真实调用。"""
from __future__ import annotations

import sys
import time
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import metaso_kb                      # noqa: E402


# ── 引用拆分 ───────────────────────────────────────────────
def test_split_citations_basic():
    text = "焊工持证[[钢箱梁施工†12]]。预热按评定[[桩基工程†5]]执行[[钢箱梁施工†12]]。"
    body, cites = metaso_kb.split_citations(text)
    assert body == "焊工持证[1]。预热按评定[2]执行[1]。"
    assert cites == [
        {"source": "钢箱梁施工", "loc": "12", "n": 1},
        {"source": "桩基工程", "loc": "5", "n": 2},
    ]


def test_split_citations_none():
    body, cites = metaso_kb.split_citations("无引用文本")
    assert body == "无引用文本" and cites == []


# ── 介绍页判据（K1 移植） ──────────────────────────────────
def test_looks_like_intro():
    intro = "这是知识库介绍页，请订阅开通后使用知识库服务"
    assert metaso_kb._looks_like_intro(intro) is True
    good = "回答" + "内容" * 200
    assert metaso_kb._looks_like_intro(good) is False


# ── ask 全链（mock 传输） ──────────────────────────────────
class _FakeResp:
    def __init__(self, status_code=200, text="", chunks=None):
        self.status_code = status_code
        self._text = text
        self._chunks = chunks or []

    def iter_lines(self):
        yield from self._chunks

    def json(self):
        import json
        return json.loads(self._text)

    @property
    def text(self):
        return self._text


def _mock_transport(monkeypatch, answer_text="标准答案" * 60, http_status=200):
    calls = {"chat": 0, "full": 0}

    def fake_post(url, **kw):
        calls["chat"] += 1
        if http_status != 200:
            return _FakeResp(status_code=http_status, text="{}")
        chunk = ('data:{"data":{"id":"2104386684190437377"},"type":"conversation_init"}')
        return _FakeResp(chunks=[chunk.encode()])

    def fake_get(url, **kw):
        calls["full"] += 1
        payload = ("{\"data\":{\"activePathMessages\":[{\"content\":{\"stages\":["
                   "{\"texts\":[{\"text\":\"思考摘要\"}]},"
                   "{\"texts\":[{\"text\":" + _json_str(answer_text) + "}]}]}}]}}")
        return _FakeResp(text=payload)

    monkeypatch.setattr(metaso_kb.cr, "post", fake_post)
    monkeypatch.setattr(metaso_kb.cr, "get", fake_get)
    monkeypatch.setattr(metaso_kb.kb_session, "get_session",
                        lambda force_refresh=False: {"cookie": "tid=x; uid=y", "token": "tok"})
    return calls


def _json_str(s: str) -> str:
    import json
    return json.dumps(s, ensure_ascii=False)


def test_ask_happy_path(monkeypatch):
    calls = _mock_transport(monkeypatch, answer_text="答案内容[[书†1]]" + "好" * 100)
    # 护栏重置
    metaso_kb._points_used_today = 0
    metaso_kb._today_str = time.strftime("%Y-%m-%d")
    metaso_kb._breaker_open_until = 0
    metaso_kb._fail_streak = 0
    result = metaso_kb.ask("桩基硬岩怎么处理？", sleep=lambda s: None)
    assert result.cid == "2104386684190437377"
    assert "[1]" in result.answer and "答案内容" in result.answer
    assert result.citations[0]["source"] == "书"
    assert calls["chat"] == 1 and calls["full"] >= 1


def test_ask_daily_cap(monkeypatch):
    metaso_kb._points_used_today = metaso_kb.config.KB_DAILY_POINT_CAP
    metaso_kb._today_str = time.strftime("%Y-%m-%d")
    with pytest.raises(metaso_kb.DailyCapExceeded):
        metaso_kb.ask("超顶问题", sleep=lambda s: None)


def test_ask_circuit_open(monkeypatch):
    metaso_kb._breaker_open_until = time.time() + 60
    metaso_kb._points_used_today = 0
    try:
        with pytest.raises(metaso_kb.CircuitOpen):
            metaso_kb.ask("熔断中", sleep=lambda s: None)
    finally:
        metaso_kb._breaker_open_until = 0


def test_ask_http_error_records_failure(monkeypatch):
    _mock_transport(monkeypatch, http_status=500)
    metaso_kb._points_used_today = 0
    metaso_kb._today_str = time.strftime("%Y-%m-%d")
    metaso_kb._fail_streak = 0
    metaso_kb._breaker_open_until = 0
    with pytest.raises(metaso_kb.EngineError):
        metaso_kb.ask("会炸的问题", sleep=lambda s: None)
    assert metaso_kb._fail_streak == 1
