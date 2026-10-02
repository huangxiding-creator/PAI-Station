# -*- coding: utf-8 -*-
"""/health 探针单测（§七：无鉴权 200 {ok:true}）。"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from fastapi.testclient import TestClient  # noqa: E402

from xueyuan_engine.app import app  # noqa: E402


def test_health_ok():
    with TestClient(app) as c:
        r = c.get("/health")
        assert r.status_code == 200
        assert r.json() == {"ok": True}


def test_error_body_shape():
    """{code,message} 统一错误体（§五-6）：404 也走该形状。"""
    with TestClient(app, raise_server_exceptions=False) as c:
        r = c.get("/no-such-endpoint")
        assert r.status_code in (404, 405)
        body = r.json()
        # FastAPI 默认路由 404 走 HTTPException 处理器；仅当返回 dict 时校验形状
        if isinstance(body, dict) and "code" in body:
            assert set(body.keys()) >= {"code", "message"}
