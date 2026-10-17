# -*- coding: utf-8 -*-
"""v0.9.13 道具图静态路由单测——白名单+防穿越+长缓存（REQ-003 配套：item_url 公开承载）。"""
from __future__ import annotations

import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from qianwen_engine import config  # noqa: E402

JPEG_MAGIC = b"\xff\xd8\xff\xe0" + b"\x00" * 10   # 最小可判 JPEG 头（路由不解码内容，只按字节透传）


@pytest.fixture()
def client(tmp_path, monkeypatch):
    from fastapi.testclient import TestClient
    from qianwen_engine import app as app_mod

    goods = tmp_path / "static_goods"
    goods.mkdir()
    (goods / "zongbaojun.jpg").write_bytes(JPEG_MAGIC)
    (goods / "second.jpg").write_bytes(JPEG_MAGIC)
    monkeypatch.setattr(config, "GOODS_STATIC_DIR", goods)

    with TestClient(app_mod.app) as c:
        yield c


def test_static_goods_hit(client):
    r = client.get("/static/goods/zongbaojun")
    assert r.status_code == 200
    assert r.headers["content-type"].startswith("image/jpeg")
    assert "max-age" in r.headers.get("cache-control", "")
    assert r.content == JPEG_MAGIC


def test_static_goods_missing_404(client):
    assert client.get("/static/goods/ghost").status_code == 404


@pytest.mark.parametrize("bad", ["has.dot", "..", "a/b", "a b", "", "-lead", "x" * 65])
def test_static_goods_name_gate_404(client, bad):
    assert client.get(f"/static/goods/{bad}").status_code == 404


def test_static_goods_traversal_blocked(client):
    # 编码穿越 attempt：解码后含 ../ 与斜杠，一律在名字门被拒（resolve 双保险不到达）
    for enc in ("%2e%2e%2fconfig", "..%2f..%2fsecrets"):
        assert client.get(f"/static/goods/{enc}").status_code == 404
