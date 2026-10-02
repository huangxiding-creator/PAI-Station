# -*- coding: utf-8 -*-
"""wechat.get_access_token 助手单测（T-P2-02 配套）：缓存免重取/过期刷新/
errcode 自拒不含凭据/无 secret 拒绝。零真实外呼（cr 全程 monkeypatch）。"""
from __future__ import annotations

import sys
import time
from pathlib import Path
from types import SimpleNamespace

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))

from xueyuan_engine import wechat  # noqa: E402


@pytest.fixture(autouse=True)
def _clean_cache():
    wechat._reset_token_cache()
    yield
    wechat._reset_token_cache()


def _fake_cr(payload, counter):
    def fake_get(url, **kw):
        counter.append(url)
        return SimpleNamespace(status_code=200, json=lambda: payload)
    return SimpleNamespace(get=fake_get)


def test_token_fetch_and_cache(engine, monkeypatch):
    counter: list = []
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"access_token": "tok-abc", "expires_in": 7200}, counter))
    assert wechat.get_access_token() == "tok-abc"
    assert wechat.get_access_token() == "tok-abc"
    assert len(counter) == 1  # 缓存命中：两次调用只打一次微信


def test_token_refresh_on_expiry(engine, monkeypatch):
    counter: list = []
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"access_token": "tok-1", "expires_in": 7200}, counter))
    assert wechat.get_access_token() == "tok-1"
    # 逼临近过期（裕量 300s 内）→ 下次调用重取
    wechat._token_cache["expires_at"] = time.time() + 100
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"access_token": "tok-2", "expires_in": 7200}, counter))
    assert wechat.get_access_token() == "tok-2"
    assert len(counter) == 2


def test_token_force_refresh(engine, monkeypatch):
    counter: list = []
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"access_token": "tok-1", "expires_in": 7200}, counter))
    wechat.get_access_token()
    wechat.get_access_token(force_refresh=True)  # 强刷绕过缓存
    assert len(counter) == 2


def test_token_errcode_raises_without_secret_leak(engine, monkeypatch):
    # 回包带诱饵凭据值：errcode 路径的异常只含 errcode/errmsg，凭据绝不进异常
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"errcode": 40013, "errmsg": "invalid appid",
         "access_token": "SEKRET-TOKEN-XYZ"}, []))
    with pytest.raises(RuntimeError) as ei:
        wechat.get_access_token()
    assert "40013" in str(ei.value)
    assert "SEKRET-TOKEN-XYZ" not in str(ei.value)


def test_token_requires_appsecret(engine, monkeypatch):
    from xueyuan_engine import config

    monkeypatch.setattr(config, "MP_SECRET_FILE", engine.tmp / "nope.secret")
    with pytest.raises(RuntimeError, match="appsecret 未配置"):
        wechat.get_access_token()


def test_token_reset_clears(engine, monkeypatch):
    monkeypatch.setattr(wechat, "cr", _fake_cr(
        {"access_token": "tok-1", "expires_in": 7200}, []))
    wechat.get_access_token()
    wechat._reset_token_cache()
    assert wechat._token_cache == {"token": "", "expires_at": 0.0}  # 只存内存可清
