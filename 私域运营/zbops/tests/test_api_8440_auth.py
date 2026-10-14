# -*- coding: utf-8 -*-
"""T-075 验证：8440 鉴权与 schema（REQ-005.AC2）。真实 enqueue（不 mock 集成点）。"""
from pathlib import Path

import pytest
from fastapi.testclient import TestClient

from zbops.radar import service_8440
from zbops.radar.auto_responder import responder


@pytest.fixture()
def client(monkeypatch):
    monkeypatch.setenv("RE_ENQUEUE_KEY", "test-key-123")
    monkeypatch.delenv("RE_CALLBACK_AUTOSTART", raising=False)
    service_8440._BAD["n"] = 0
    responder.queue.clear()
    responder._sent_hashes.clear()
    responder._chat_daily.clear()
    responder._chat_last_sent.clear()
    responder._sent_today = 0
    responder._risk_detected = False
    return TestClient(service_8440.app)


def test_no_key_401(client):
    assert client.post("/enqueue", json={"group": "g", "text": "t"}).status_code == 401


def test_bad_key_401(client):
    r = client.post("/enqueue", json={"group": "g", "text": "t"},
                    headers={"X-Api-Key": "wrong"})
    assert r.status_code == 401


def test_good_key_202_queued_real(client):
    r = client.post("/enqueue",
                    json={"group": "g@chatroom", "text": "t", "priority": 2},
                    headers={"X-Api-Key": "test-key-123"})
    assert r.status_code == 202, r.text
    assert r.json() == {"queued": True, "position": 1}
    assert responder.queue and responder.queue[-1].chat_name == "g@chatroom"
    assert responder.queue[-1].metadata.get("source") == "manual"  # 字段透传


def test_risk_breaker_429(client):
    responder._risk_detected = True
    r = client.post("/enqueue", json={"group": "g", "text": "t"},
                    headers={"X-Api-Key": "test-key-123"})
    assert r.status_code == 429 and r.json()["queued"] is False


def test_schema_missing_422(client):
    r = client.post("/enqueue", json={"group": "g"},
                    headers={"X-Api-Key": "test-key-123"})
    assert r.status_code == 422


def test_bruteforce_marks_audit_once(client, tmp_path, monkeypatch):
    monkeypatch.setenv("RE_AUDIT_DIR", str(tmp_path))
    for _ in range(12):
        client.post("/enqueue", json={"group": "g", "text": "t"},
                    headers={"X-Api-Key": "nope"})
    lines = list(tmp_path.glob("audit-*.jsonl"))[0].read_text(encoding="utf-8").splitlines()
    marks = [x for x in lines if "__auth_bruteforce__" in x]
    assert len(marks) == 1  # 只在过阈那一刻记一次


def test_deploy_script_exists():
    ps1 = Path(__file__).resolve().parents[3] / "revenue-engine" / "deploy" \
        / "register_callback_task.ps1"
    assert ps1.exists() and "schtasks" in ps1.read_text(encoding="utf-8")
