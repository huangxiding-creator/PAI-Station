# -*- coding: utf-8 -*-
"""Manus API 层 — token 捕获 + 通用调用 + 端点函数族 (CLI 化地基).

认证契约 (2026-09-22 实证): api.manus.im 全端点 = authorization header
(Bearer JWT, len≈354, 登录后任意页面请求可拦截) + x-client-id + cookie;
纯 cookie 不够 (403 Session is private). token 与 session 同生命周期,
每次登录后 capture 刷新, 落盘 data/tokens/ 不进任何日志.

通用调用: api_call(page, method, path, token, body) — 浏览器内同步 XHR
(带登录态), 返回 (status, body_str). 大响应 (3MB) 实测可跨 bridge 返回.
"""
from __future__ import annotations

import json
import time
from pathlib import Path

API_BASE = "https://api.manus.im"
TOKEN_DIR = Path("data/tokens")

_JS_CALL = """
function() {
  var method = arguments[0];
  var url = arguments[1];
  var body = arguments[2];
  var token = arguments[3];
  var clientId = arguments[4];
  try {
    var xhr = new XMLHttpRequest();
    xhr.open(method, url, false);
    xhr.withCredentials = true;
    xhr.setRequestHeader('accept', 'application/json');
    if (token) xhr.setRequestHeader('authorization', token);
    if (clientId) xhr.setRequestHeader('x-client-id', clientId);
    xhr.setRequestHeader('x-client-type', 'web');
    xhr.setRequestHeader('x-client-locale', 'zh-CN');
    if (body) {
      xhr.setRequestHeader('Content-Type', 'application/json');
      xhr.send(body);
    } else {
      xhr.send(null);
    }
    return xhr.status + '|' + xhr.responseText;
  } catch (e) { return 'EXC|' + e.message; }
}
"""


def capture_token(page, timeout_s: int = 20) -> dict:
    """拦截登录态页面的任意 api.manus.im 请求, 提取 authorization.

    返回 {'authorization': ..., 'client_id': ...}; 失败抛 RuntimeError.
    token 只落盘 data/tokens/<email>.json, 绝不打印.
    """
    page.listen.start("api.manus.im")
    page.refresh()
    deadline = time.time() + timeout_s
    token = client_id = None
    while time.time() < deadline and not token:
        try:
            packet = page.listen.wait(timeout=2)
        except Exception:
            continue
        if not packet or packet.is_failed:
            continue
        try:
            h = packet.request.headers or {}
            token = h.get("authorization") or h.get("Authorization")
            if token:
                client_id = h.get("x-client-id", "")
        except Exception:
            continue
    page.listen.stop()
    if not token:
        raise RuntimeError("token 捕获失败 (页面无 api 请求?)")
    return {"authorization": token, "client_id": client_id}


def save_token(email: str, tok: dict):
    TOKEN_DIR.mkdir(parents=True, exist_ok=True)
    safe = email.replace("@", "_at_").replace("/", "_")
    (TOKEN_DIR / f"{safe}.json").write_text(
        json.dumps(tok, ensure_ascii=False), encoding="utf-8")


def load_token(email: str) -> dict | None:
    safe = email.replace("@", "_at_").replace("/", "_")
    p = TOKEN_DIR / f"{safe}.json"
    if p.is_file():
        try:
            return json.loads(p.read_text(encoding="utf-8"))
        except Exception:
            return None
    return None


def api_call(page, method: str, path: str, tok: dict,
             body: dict | None = None, timeout_note: str = ""):
    """通用调用 → (status:int, body:str). path 以 / 开头.

    页面刷新窗口内 run_js 会 ContextLost — 等 doc_loaded 后重试 (≤3 次).
    """
    body_str = json.dumps(body, ensure_ascii=False) if body is not None else ""
    raw = None
    for attempt in range(3):
        try:
            raw = page.run_js(_JS_CALL, method, API_BASE + path, body_str,
                              tok.get("authorization"),
                              tok.get("client_id") or "")
            break
        except Exception:
            if attempt == 2:
                return -2, "run_js failed (context lost x3)"
            time.sleep(2)
            try:
                page.wait.doc_loaded(timeout=10)
            except Exception:
                pass
    if not isinstance(raw, str) or "|" not in raw:
        return -1, str(raw)[:300]
    status, _, text = raw.partition("|")
    try:
        return int(status), text
    except ValueError:
        return -1, text[:300]


# ---------------------------------------------------------------- 读端点族
def list_sessions(page, tok: dict) -> list:
    st, text = api_call(page, "GET", "/session.v1.SessionService/ListSessions",
                        tok, body={})
    # ListSessions 是 POST (probe: req={}); 若 GET 405 则改 POST
    if st in (405, -1):
        st, text = api_call(page, "POST",
                            "/session.v1.SessionService/ListSessions",
                            tok, body={})
    if st != 200:
        raise RuntimeError(f"ListSessions {st}: {text[:120]}")
    d = json.loads(text)
    # 响应可能是 protojson: {'sessions': [...]}
    return d.get("sessions", [])


def get_session_v2(page, tok: dict, sid: str):
    return api_call(page, "GET",
                    f"/api/chat/getSessionV2?sessionId={sid}&type=private", tok)


def get_files(page, tok: dict, sid: str):
    return api_call(page, "GET",
                    f"/api/chat/getSessionFilesV2?sessionId={sid}", tok)


def get_outline(page, tok: dict, sid: str):
    return api_call(page, "GET",
                    f"/api/chat/getSessionOutline?sessionId={sid}", tok)


def get_credits(page, tok: dict):
    return api_call(page, "POST",
                    "/user.v1.UserService/GetAvailableCredits", tok, body={})


def user_info(page, tok: dict):
    return api_call(page, "POST", "/user.v1.UserService/UserInfo", tok, body={})
