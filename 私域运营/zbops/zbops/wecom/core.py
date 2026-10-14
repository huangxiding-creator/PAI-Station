# -*- coding: utf-8 -*-
"""wecom-core：企业微信服务端 API 统一客户端。

职责（ARCHITECTURE §5.1）：
  - access_token 按应用缓存（7200s，提前 300s 刷新，进程内单点持有）
  - 统一错误码映射（45009 限频 / 40014 token失效自动重取 / 81013 ip白名单）
  - 临时素材上传
"""
from __future__ import annotations

import time

import httpx

BASE = "https://qyapi.weixin.qq.com/cgi-bin"


class WeComError(Exception):
    def __init__(self, errcode: int, errmsg: str):
        super().__init__(f"[{errcode}] {errmsg}")
        self.errcode = errcode
        self.errmsg = errmsg


class WeComClient:
    """单应用客户端。多应用（自建应用/智能机器人）各建一个实例。"""

    def __init__(self, corp_id: str, secret: str, name: str = "default"):
        self.corp_id = corp_id
        self.secret = secret
        self.name = name
        self._token: str = ""
        self._token_expire: float = 0
        self._http = httpx.Client(timeout=15)

    # ---- token ----
    def token(self, force: bool = False) -> str:
        if not force and self._token and time.time() < self._token_expire:
            return self._token
        r = self._http.get(f"{BASE}/gettoken",
                           params={"corpid": self.corp_id, "corpsecret": self.secret})
        data = r.json()
        if data.get("errcode"):
            raise WeComError(data["errcode"], data.get("errmsg", ""))
        self._token = data["access_token"]
        self._token_expire = time.time() + data.get("expires_in", 7200) - 300
        return self._token

    # ---- 通用调用 ----
    def call(self, method: str, path: str, *, params=None, json_body=None,
             retry_on_token: bool = True) -> dict:
        params = dict(params or {})
        params["access_token"] = self.token()
        r = self._http.request(method, f"{BASE}{path}", params=params, json=json_body)
        data = r.json()
        code = data.get("errcode", 0)
        if code == 40014 and retry_on_token:      # token 失效：强刷一次重试
            self.token(force=True)
            return self.call(method, path, params={k: v for k, v in params.items()
                                                   if k != "access_token"},
                             json_body=json_body, retry_on_token=False)
        if code:
            raise WeComError(code, data.get("errmsg", ""))
        return data

    # ---- 常用封装 ----
    def userid_from_open_userid(self, open_userid: str) -> str:
        """智能机器人 from.userid 密文→明文（需自建应用对接过，见官方文档101521）。"""
        return self.call("POST", "/user/openuserid_to_userid",
                         params={}, json_body={"open_userid_list": [open_userid]})

    def upload_media(self, filepath: str, media_type: str = "image") -> str:
        with open(filepath, "rb") as f:
            params = {"access_token": self.token(), "type": media_type}
            r = self._http.post(f"{BASE}/media/upload", params=params,
                                files={"media": f})
        data = r.json()
        if data.get("errcode"):
            raise WeComError(data["errcode"], data.get("errmsg", ""))
        return data["media_id"]

    def close(self):
        self._http.close()
