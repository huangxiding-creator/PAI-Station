# -*- coding: utf-8 -*-
"""Dify console 会话——自动登录+登陆态持久化（用户 09-17 指令「自己自动登录」）。

实例形态（dify.gcblog.net, Dify 1.16.1 自建）：
  - OAuth device flow 不可用（1.17 服务端才有端点）→ difyctl 暂无原生通道
  - login 密码须 Base64 编码（源码 api/libs/encryption.py：混淆非加密）
  - 会话=三 cookie（access_token 1h / refresh_token 30d / csrf_token）+ X-CSRF-Token 双重提交
  - API 调用带全套 cookie + X-CSRF-Token 头

三级兜底：内存/落盘 cookie 直接用 → 401 则 refresh-token → 再 401 则账号重登。
凭证持久化在 config/dify.secret.ini（gitignored）。

用法：
  python tools/dify_session.py --status              # 验活（whoami）
  python tools/dify_session.py --get /apps?page=1    # 通用 GET
  python tools/dify_session.py --refresh             # 强制刷新会话
"""
import argparse
import base64
import configparser
import json
import sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
CONFIG = ROOT / "config" / "dify.secret.ini"
COOKIE_STORE = ROOT / "tmp" / "dify_session_cookies.json"


class DifySession:
    """Dify console API 会话。http 注入缝供测试（真实形态=下方 _real_http）。"""

    def __init__(self, host, email, password, refresh_token=None,
                 cookie_path=None, http=None):
        self.host = host.rstrip("/")
        self.email = email
        self.password = password
        self.refresh_token = refresh_token
        self.cookie_path = Path(cookie_path) if cookie_path else None
        self.http = http or _real_http()
        self.cookies = self._load_cookies()

    # ── cookie 持久化 ─────────────────────────────────────────────
    def _load_cookies(self):
        if self.cookie_path and self.cookie_path.exists():
            try:
                return json.loads(self.cookie_path.read_text(encoding="utf-8"))
            except (ValueError, OSError):
                pass
        return {}

    def _save_cookies(self):
        if self.cookie_path and self.cookies:
            self.cookie_path.parent.mkdir(parents=True, exist_ok=True)
            self.cookie_path.write_text(
                json.dumps(self.cookies), encoding="utf-8")

    # ── 三级兜底核心 ──────────────────────────────────────────────
    def _login(self):
        body = {"email": self.email,
                "password": base64.b64encode(
                    self.password.encode("utf-8")).decode("ascii"),
                "remember_me": True}
        status, _, cookies = self.http(
            "POST", f"{self.host}/console/api/login", json=body)
        if status != 200 or "access_token" not in cookies:
            raise RuntimeError(f"dify login failed: HTTP {status}")
        self.cookies = cookies
        self.refresh_token = cookies.get("refresh_token", self.refresh_token)
        self._save_cookies()

    def _refresh(self):
        if not self.refresh_token:
            return False
        status, _, cookies = self.http(
            "POST", f"{self.host}/console/api/refresh-token",
            cookies={"refresh_token": self.refresh_token})
        if status != 200 or "access_token" not in cookies:
            return False
        self.cookies = cookies
        self.refresh_token = cookies.get("refresh_token", self.refresh_token)
        self._save_cookies()
        return True

    def _ensure(self):
        if "access_token" not in self.cookies:
            self._login()

    def _csrf(self):
        return self.cookies.get("csrf_token", "")

    # ── 对外 ──────────────────────────────────────────────────────
    def _once(self, method, path, json_body=None):
        status, text, cookies = self.http(
            method, f"{self.host}{path}", json=json_body,
            cookies=self.cookies, csrf=self._csrf())
        if cookies.get("access_token"):  # 响应顺带给新 cookie 则收下
            self.cookies = cookies
            self._save_cookies()
        return status, text

    def call(self, method, path, json_body=None):
        """console API 调用：cookie 双重提交 + CSRF 头；三级兜底=直调→refresh→重登。"""
        self._ensure()
        status, text = self._once(method, path, json_body)
        if status != 401:
            return status, text
        if self._refresh():
            status, text = self._once(method, path, json_body)
            if status != 401:
                return status, text
        self._login()
        return self._once(method, path, json_body)

    def whoami(self):
        return self.call("GET", "/console/api/account/profile")


def _real_http():
    import requests
    s = requests.Session()

    def http(method, url, json=None, cookies=None, csrf=""):
        headers = {"X-CSRF-Token": csrf} if csrf else {}
        r = s.request(method, url, json=json, cookies=cookies,
                      headers=headers, timeout=30)
        jar = {c.name: c.value for c in s.cookies}
        return r.status_code, r.text, jar

    return http


def from_config(config_path=CONFIG):
    cp = configparser.ConfigParser()
    cp.read(config_path, encoding="utf-8")
    d = cp["dify"]
    return DifySession(host=d["host"].strip(), email=d["email"].strip(),
                       password=d["password"].strip(),
                       refresh_token=d.get("refresh_token", "").strip() or None,
                       cookie_path=COOKIE_STORE)


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--get", dest="get_path")
    ap.add_argument("--refresh", action="store_true")
    args = ap.parse_args()
    sess = from_config()
    if args.refresh:
        ok = sess._refresh() or (sess._login() and True)
        print("refreshed" if ok else "refresh failed")
        return 0 if ok else 1
    if args.status:
        status, text = sess.whoami()
        print(f"HTTP {status} {text[:200]}")
        return 0 if status == 200 else 1
    if args.get_path:
        path = args.get_path
        if not path.startswith("/console"):
            path = "/console/api" + (path if path.startswith("/") else "/" + path)
        status, text = sess.call("GET", path)
        print(f"HTTP {status} {text[:400]}")
        return 0 if status == 200 else 1
    ap.print_help()
    return 2


if __name__ == "__main__":
    raise SystemExit(main())
