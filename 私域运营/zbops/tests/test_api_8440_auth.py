# -*- coding: utf-8 -*-
"""T-075 验证：8440 鉴权与 schema（REQ-005.AC2）。安全网四约束属 T-076。"""
import pytest
from fastapi.testclient import TestClient

from zbops.radar import service_8440
from zbops.radar.auto_responder import PendingMessage


@pytest.fixture()
def client(monkeypatch):
    monkeypatch.setenv("RE_ENQUEUE_KEY", "test-key-123")
    service_8440._BAD_KEYS["n"] = 0
    # 不真发：enqueue 换成入队桩
    queued = []

    def fake(chat_name, text, priority=5):
        queued.append(PendingMessage(chat_name, text, priority))
        return True

    monkeypatch.setattr(service_8440.responder, "enqueue", fake)
    monkeypatch.setattr(service_8440.responder, "queue", queued)
    return TestClient(service_8440.app), queued


def test_no_key_401(client):
    c, _ = client
    assert c.post("/enqueue", json={"group": "g", "text": "t"}).status_code == 401


def test_bad_key_401(client):
    c, _ = client
    r = c.post("/enqueue", json={"group": "g", "text": "t"},
               headers={"X-Api-Key": "wrong"})
    assert r.status_code == 401


def test_good_key_202(client):
    c, queued = client
    r = c.post("/enqueue", json={"group": "g", "text": "t", "priority": 2},
               headers={"X-Api-Key": "test-key-123"})
    assert r.status_code == 200 and r.json()["queued"] is True
    assert queued[0].chat_name == "g" and queued[0].priority == 2


def test_schema_missing_422(client):
    c, _ = client
    r = c.post("/enqueue", json={"group": "g"},
               headers={"X-Api-Key": "test-key-123"})
    assert r.status_code == 422


def test_bruteforce_marks_audit(client, tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    c, _ = client
    for _ in range(10):
        c.post("/enqueue", json={"group": "g", "text": "t"},
               headers={"X-Api-Key": "nope"})
    files = list(tmp_path.glob("audit-*.jsonl"))
    assert files and "__auth_bruteforce__" in files[0].read_text(encoding="utf-8")
