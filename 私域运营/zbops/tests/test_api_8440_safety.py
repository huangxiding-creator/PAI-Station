# -*- coding: utf-8 -*-
"""T-076 验证：8440 入队四约束（REQ-005.AC1）——日3/全局20/冷却/熔断 超限 429。
含裁判移交的 dedup_key 语义（REQ-012.AC2 / API_DESIGN §1）。"""
import time

import pytest
from fastapi.testclient import TestClient

from zbops.radar import service_8440
from zbops.radar.auto_responder import (CHAT_COOLDOWN, MAX_GLOBAL_DAILY,
                                        MAX_PER_CHAT_DAILY, responder)

KEY = {"X-Api-Key": "test-key-123"}


@pytest.fixture()
def client(monkeypatch):
    monkeypatch.setenv("RE_ENQUEUE_KEY", "test-key-123")
    monkeypatch.delenv("RE_CALLBACK_AUTOSTART", raising=False)
    service_8440._BAD["n"] = 0
    responder.queue.clear()
    responder._sent_hashes.clear()
    responder._dedup_keys.clear()
    responder._chat_daily.clear()
    responder._chat_last_sent.clear()
    responder._sent_today = 0
    responder._risk_detected = False
    responder._sent_date = time.strftime("%Y-%m-%d")  # 阻断跨日重置清掉测试态
    return TestClient(service_8440.app)


def _post(c, group="g@chatroom", text="t", **kw):
    return c.post("/enqueue", json={"group": group, "text": text, **kw}, headers=KEY)


def test_per_chat_daily_3(client):
    responder._chat_daily["g@chatroom"] = MAX_PER_CHAT_DAILY
    r = _post(client)
    assert r.status_code == 429 and r.json()["queued"] is False
    assert not responder.queue  # 被安全网拦截，未入队


def test_global_daily_20(client):
    responder._sent_today = MAX_GLOBAL_DAILY
    assert _post(client).status_code == 429


def test_cooldown_window(client):
    responder._chat_last_sent["g@chatroom"] = time.time()
    assert _post(client).status_code == 429


def test_risk_breaker(client):
    responder._risk_detected = True
    assert _post(client).status_code == 429


def test_dedup_key_idempotent(client):
    assert _post(client, text="内容A", dedup_key="report-42").status_code == 202
    # 同群同 dedup_key：幂等丢弃（即使正文不同）——API 级幂等（入队时生效）
    assert _post(client, text="完全不同的正文", dedup_key="report-42").status_code == 429
    # 无 dedup_key 时回到正文 md5 语义：发送史级去重（发送时记账），入队重复不拦
    assert _post(client, text="内容A").status_code == 202
    assert _post(client, text="内容A").status_code == 202  # 未发送过，md5 尚未记账
    import hashlib
    responder._sent_hashes.add(hashlib.md5("内容A".encode()).hexdigest())
    assert _post(client, text="内容A").status_code == 429  # 发送史命中


def test_send_side_cooldown_requeue():
    """裁判 NIT 复核：入队侧冷却被队列积压绕过时，发送侧压回队尾。"""
    responder.queue.clear()
    responder._chat_daily.clear()
    responder._chat_last_sent.clear()
    responder._sent_today = 0
    responder._risk_detected = False
    assert responder.enqueue("g1", "msg1", priority=1)
    responder._chat_last_sent["g1"] = time.time()          # 模拟刚发过
    import asyncio
    asyncio.run(responder._process_one())
    assert len(responder.queue) == 1 and responder.queue[0].text == "msg1"  # 压回未发
    assert responder._sent_today == 0                      # 未消耗全局额度
