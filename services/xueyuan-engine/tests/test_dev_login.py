# -*- coding: utf-8 -*-
"""XY_DEV_LOGIN 双闸单测——dev 路径 login 换 token（照抄 QW_DEV_LOGIN 的 code→dev openid 模式）。

Phase 8 升级：端点挂 /api/v1 前缀（API_DESIGN §一 Base URL 契约）；回包含
uid/expires_in/pay_configured（P0-1），session_key 服务端留存绝不回传。
"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))


@pytest.fixture()
def dev_env(tmp_path, monkeypatch):
    from xueyuan_engine import config, store

    monkeypatch.setattr(config, "DATA_DIR", tmp_path)
    monkeypatch.setattr(config, "DB_PATH", tmp_path / "t.sqlite")
    monkeypatch.setattr(config, "ENGINE_TOKEN_FILE", tmp_path / "hmac.key")
    monkeypatch.setattr(config, "VIRTUAL_PAY_FILE", tmp_path / "vp.secret")
    monkeypatch.setenv("XY_DEV_LOGIN", "1")
    store._init_done = False
    yield
    store._init_done = False


def test_dev_login_issues_verifiable_token(dev_env):
    from fastapi.testclient import TestClient

    from xueyuan_engine import wechat
    from xueyuan_engine.app import app

    with TestClient(app) as c:
        r = c.post("/api/v1/auth/login", json={"code": "t1"})
        assert r.status_code == 200
        d = r.json()
        assert d["token"] and d["expires_in"] == 2592000
        assert d["uid"].startswith("u") and d["pay_configured"] is False
        assert wechat.verify_token(d["token"]) == "dev-t1"
        assert "session_key" not in d  # session_key 仅服务端留存，绝不下发


def test_dev_login_distinct_codes(dev_env):
    from fastapi.testclient import TestClient

    from xueyuan_engine import wechat
    from xueyuan_engine.app import app

    with TestClient(app) as c:
        t1 = c.post("/api/v1/auth/login", json={"code": "ua"}).json()["token"]
        t2 = c.post("/api/v1/auth/login", json={"code": "ub"}).json()["token"]
        assert wechat.verify_token(t1) == "dev-ua"
        assert wechat.verify_token(t2) == "dev-ub"


def test_garbled_token_rejected():
    from xueyuan_engine import wechat

    assert wechat.verify_token("deadbeef.0000") is None
    assert wechat.verify_token("") is None
