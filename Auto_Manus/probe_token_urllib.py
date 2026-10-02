# -*- coding: utf-8 -*-
"""纯 urllib + 存档 token 探 API (无 cookie/无浏览器) — 0922 深夜.

判据: GetAvailableCredits 只读无害端点.
200 = API 腿可全脱浏览器; 401/403 = token 过期或缺 cookie.
"""
import glob
import json
import sys
import urllib.error
import urllib.request
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def call(tok: dict, path: str, method: str = "POST", body: str = "{}",
         limit: int = 200):
    data = body.encode("utf-8") if body else None
    headers = {"Authorization": tok["authorization"],
               "x-client-id": tok.get("client_id", ""),
               "x-client-type": "web", "Origin": "https://manus.im"}
    if data:
        headers["Content-Type"] = "application/json"
    req = urllib.request.Request(
        "https://api.manus.im" + path, data=data, method=method, headers=headers)
    op = urllib.request.build_opener(urllib.request.ProxyHandler(
        {"https": "http://127.0.0.1:7890"}))
    try:
        r = op.open(req, timeout=15)
        return r.status, r.read().decode("utf-8", "replace")[:limit]
    except urllib.error.HTTPError as e:
        return e.code, e.read().decode("utf-8", "replace")[:limit]
    except Exception as e:
        return -1, f"{type(e).__name__}: {e}"[:limit]


SETTINGS_CANDIDATES = (
    ("POST", "/user.v1.UserService/GetUserSettings"),
    ("POST", "/user.v1.UserService/UserSettings"),
    ("GET", "/api/chat/getUserSettings"),
    ("GET", "/api/chat/getUserV2"),
    ("GET", "/api/chat/getUserNotificationSettings"),
    ("POST", "/user.v1.UserService/GetNotificationSettings"),
    ("POST", "/notify.v1.NotificationService/GetSettings"),
    ("GET", "/api/chat/getUserInfo"),
    ("POST", "/user.v1.UserService/GetProfile"),
)


def main():
    files = sorted(glob.glob("data/tokens/*.json"))
    tf = files[0]
    email = Path(tf).stem.replace("_at_", "@")
    tok = json.loads(Path(tf).read_text(encoding="utf-8"))
    st, text = call(tok, "/user.v1.UserService/UserInfo", limit=3000)
    print(f"[full UserInfo] {st}")
    print(text)
    print("\n[candidates]")
    for method, path in SETTINGS_CANDIDATES:
        st, text = call(tok, path, method, body="{}" if method == "POST" else None)
        mark = "<== 命中" if st == 200 else ""
        print(f"  {method} {path} -> {st} {text[:100]} {mark}")


if __name__ == "__main__":
    main()
