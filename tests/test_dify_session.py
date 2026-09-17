# -*- coding: utf-8 -*-
"""dify_session 测试：三级兜底链（fake http，零真网）。"""
import base64
import json

import pytest

from tools.dify_session import DifySession

COOKIES = {"access_token": "at1", "refresh_token": "rt1", "csrf_token": "csrf1"}


class FakeHttp:
    """脚本化响应序列；记录调用供断言。"""

    def __init__(self, script):
        self.script = list(script)  # [(status, text, cookies), ...]
        self.calls = []            # (method, url, json, cookies, csrf)

    def __call__(self, method, url, json=None, cookies=None, csrf=""):
        self.calls.append((method, url, json, dict(cookies or {}), csrf))
        status, text, out = self.script.pop(0)
        return status, text, dict(out)


def _sess(tmp_path, script, refresh=None):
    fake = FakeHttp(script)
    return (DifySession("https://d.x", "u@x.com", "pw", refresh_token=refresh,
                        cookie_path=tmp_path / "ck.json", http=fake), fake)


def test_first_use_logs_in_and_persists(tmp_path):
    sess, http = _sess(tmp_path, [(200, '{"result":"success"}', COOKIES),
                                  (200, '{"name":"gcblog"}', {})])
    status, text = sess.whoami()
    assert status == 200 and "gcblog" in text
    login = http.calls[0]
    assert login[0] == "POST" and login[1].endswith("/console/api/login")
    assert login[2]["password"] == base64.b64encode(b"pw").decode()  # b64 非明文
    assert login[2]["remember_me"] is True
    # 落盘持久化 + 第二次 API 调用带 cookie 双重提交 + CSRF 头
    saved = json.loads((tmp_path / "ck.json").read_text(encoding="utf-8"))
    assert saved["access_token"] == "at1"
    api = http.calls[1]
    assert api[4] == "csrf1" and api[3]["access_token"] == "at1"


def test_cookies_reloaded_no_relogin(tmp_path):
    (tmp_path / "ck.json").write_text(json.dumps(COOKIES), encoding="utf-8")
    sess, http = _sess(tmp_path, [(200, "ok", {})])
    sess.whoami()
    assert len(http.calls) == 1  # 登陆态持久化=冷启动零重登
    assert http.calls[0][0] == "GET"


def test_401_refresh_recovers(tmp_path):
    (tmp_path / "ck.json").write_text(json.dumps(COOKIES), encoding="utf-8")
    new = {"access_token": "at2", "refresh_token": "rt2", "csrf_token": "csrf2"}
    sess, http = _sess(tmp_path, [(401, "expired", {}),
                                  (200, '{"result":"success"}', new),
                                  (200, "ok", {})], refresh="rt1")
    status, _ = sess.whoami()
    assert status == 200
    assert [c[0] for c in http.calls] == ["GET", "POST", "GET"]
    assert http.calls[1][1].endswith("/console/api/refresh-token")
    assert http.calls[2][3]["access_token"] == "at2"  # 新 cookie 生效
    assert json.loads((tmp_path / "ck.json").read_text(encoding="utf-8"))["csrf_token"] == "csrf2"


def test_401_refresh_dead_relogin(tmp_path):
    (tmp_path / "ck.json").write_text(json.dumps(COOKIES), encoding="utf-8")
    sess, http = _sess(tmp_path, [(401, "expired", {}),
                                  (401, "refresh dead", {}),
                                  (200, "ok", COOKIES),
                                  (200, "ok", {})], refresh="rt1")
    status, _ = sess.whoami()
    assert status == 200
    assert [c[1].rsplit("/", 1)[-1] for c in http.calls] == [
        "profile", "refresh-token", "login", "profile"]  # 全链兜底到底


def test_relogin_when_no_refresh_token(tmp_path):
    (tmp_path / "ck.json").write_text(json.dumps(COOKIES), encoding="utf-8")
    sess, http = _sess(tmp_path, [(401, "expired", {}),
                                  (200, "ok", COOKIES),
                                  (200, "ok", {})])
    status, _ = sess.whoami()
    assert status == 200 and http.calls[1][1].endswith("/login")
