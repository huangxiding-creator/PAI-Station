"""M2.6 首个示例连接器：飞书云文档（FR15）。

复用 channels/feishu 的平台经验：自建应用拿 app_id/app_secret，
用户扫码授权换 user_access_token，凭 token 列云空间文档变更。
transport 可注入（测试用假件，不打真平台）；登录态入 DPAPI vault。
"""
from __future__ import annotations

import json
import logging
import urllib.error
import urllib.parse
import urllib.request

from paistation.sense.cloud.base import CloudConnector

_log = logging.getLogger("paistation.sense.cloud.feishu")

VAULT_KEY = "feishu"
BASE = "https://open.feishu.cn/open-apis"


class UrllibTransport:
    """标准库 HTTP 薄壳：返回 (status, parsed_json_or_None)，异常不抛。"""

    def __init__(self, timeout: float = 15.0):
        self._timeout = timeout

    def request(self, method: str, url: str, *, headers=None, params=None,
                json_body=None) -> tuple[int, dict | list | None]:
        if params:
            url = url + "?" + urllib.parse.urlencode(params)
        data = None
        hdrs = {"Content-Type": "application/json; charset=utf-8"}
        hdrs.update(headers or {})
        if json_body is not None:
            data = json.dumps(json_body).encode("utf-8")
        req = urllib.request.Request(url, data=data, method=method,
                                     headers=hdrs)
        try:
            with urllib.request.urlopen(req, timeout=self._timeout) as resp:
                return resp.status, self._parse(resp.read())
        except urllib.error.HTTPError as exc:
            return exc.code, self._parse(exc.read())
        except (urllib.error.URLError, TimeoutError, OSError) as exc:
            _log.warning("请求失败 %s %s: %s", method, url, exc)
            return 0, None

    @staticmethod
    def _parse(raw: bytes):
        if not raw:
            return None
        try:
            return json.loads(raw.decode("utf-8"))
        except (ValueError, UnicodeDecodeError):
            return None


class FeishuDocsConnector(CloudConnector):
    name = "feishu.docs"
    scopes = ("cloud.docs.read",)
    MAX_PAGES = 20          # 单次采集分页护栏

    def __init__(self, vault, transport=None, app_id: str = "",
                 app_secret: str = ""):
        self._vault = vault
        self._http = transport or UrllibTransport()
        self._app_id = app_id
        self._app_secret = app_secret

    # ---- 登录（人工触点：扫码授权）----

    def login_flow(self) -> bool:
        """app 配置齐→打印授权 URL 等用户回贴 code→换 token 入 vault。"""
        if not (self._app_id and self._app_secret):
            return False  # 未配置不装模作样
        print("请在浏览器打开并授权：")
        print(f"  {BASE}/authen/v1/authorize?app_id={self._app_id}"
              f"&redirect_uri=http://localhost:9333/oauth")
        code = input("授权后粘贴 code: ").strip()
        if not code:
            return False
        status, body = self._http.request(
            "POST", f"{BASE}/authen/v1/oauth/user_access_token",
            json_body={"grant_type": "authorization_code", "client_id": self._app_id,
                       "client_secret": self._app_secret, "code": code,
                       "redirect_uri": "http://localhost:9333/oauth"})
        if status != 200 or not body:
            return False
        data = body.get("data") or {}
        token = data.get("user_access_token") or data.get("access_token")
        if not token:
            return False
        self._vault.save(VAULT_KEY, {
            "user_access_token": token,
            "refresh_token": data.get("refresh_token", ""),
            "app_id": self._app_id,
        })
        return True

    def test_session(self) -> bool:
        session = self._vault.load(VAULT_KEY)
        if not session or not session.get("user_access_token"):
            return False
        status, _ = self._http.request(
            "GET", f"{BASE}/authen/v1/user_info",
            headers=self._auth(session))
        return status == 200

    # ---- 采集（水位线增量）----

    def collect(self, since_watermark):
        session = self._vault.load(VAULT_KEY)
        if not session or not session.get("user_access_token"):
            return [], since_watermark  # 未登录不动水位线
        since = int(since_watermark or 0)
        events: list[dict] = []
        new_wm = since
        page_token: str | None = None
        for _ in range(self.MAX_PAGES):
            params = {"page_size": 50}
            if page_token:
                params["page_token"] = page_token
            status, body = self._http.request(
                "GET", f"{BASE}/drive/v1/files",
                headers=self._auth(session), params=params)
            if status != 200 or not isinstance(body, dict):
                return [], since_watermark  # 故障：水位线原地踏步
            data = body.get("data") or {}
            for f in data.get("files") or []:
                mt = int(f.get("modified_time") or 0)
                if mt <= since:
                    continue  # 水位线以下不重报
                events.append({
                    "type": "cloud.doc.change",
                    "text": f"飞书文档《{f.get('name', '未命名')}》有更新",
                    "evidence": {"doc_token": f.get("token", ""),
                                 "doc_type": f.get("type", ""),
                                 "modified_time": mt},
                })
                new_wm = max(new_wm, mt)
            if not data.get("has_more"):
                break
            page_token = data.get("page_token")
            if not page_token:
                break
        return events, new_wm

    @staticmethod
    def _auth(session: dict) -> dict:
        return {"Authorization": f"Bearer {session['user_access_token']}"}
