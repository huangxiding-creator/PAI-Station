# -*- coding: utf-8 -*-
"""迅雷网盘·发现层（W2 · 2026-10-30）

配方（r3_big4_disks.md A 级 + pansou checkXunlei 逐参实证）：
  ① captcha/init 舞步：POST xluser-ssl.xunlei.com/v1/shield/captcha/init
     body{action:"get:/drive/v1/share", captcha_sign(九轮md5), device_id,
          package com.xunlei.browser, client_version 1.10.0.2633}
     响应含 url 字段=真验证码墙 → **熔断标记该链「需验证码」，不硬闯**（铁律）
  ② GET api-pan.xunlei.com/drive/v1/share?share_id=&pass_code=&limit=100...
     头 x-client-id/x-device-id/x-captcha-token —— 匿名列表
"""
from __future__ import annotations

import hashlib
import re
import time

from .base import BaseDiscovery, DEntry, DResult

CLIENT_ID = "ZUBzD9J_XPXfn7f7"
CLIENT_VER = "1.10.0.2633"
PACKAGE = "com.xunlei.browser"
DEVICE_ID = "5505bd0cab8c9469b98e5891d9fb3e0d"
#: pansou buildXunleiCaptchaSignature 原盐（engine/pansou/service/check_service.go L1305；
#: 首轮即 content+salt 连拼，九轮 md5 → '1.'+hex。教训：首轮预 md5+短盐系臆造，已废）
SIGN_PARTS = (
    "uWRwO7gPfdPB/0NfPtfQO+71",
    "F93x+qPluYy6jdgNpq+lwdH1ap6WOM+nfz8/V",
    "0HbpxvpXFsBK5CoTKam",
    "dQhzbhzFRcawnsZqRETT9AuPAJ+wTQso82mRv",
    "SAH98AmLZLRa6DB2u68sGhyiDh15guJpXhBzI",
    "unqfo7Z64Rie9RNHMOB",
    "7yxUdFADp3DOBvXdz0DPuKNVT35wqa5z0DEyEvf",
    "RBG",
    "ThTWPG5eC0UBqlbQ+04nZAptqGCdpv9o55A",
)


def _md5(s: str) -> str:
    return hashlib.md5(s.encode()).hexdigest()


def captcha_sign() -> tuple[str, int]:
    """pansou buildXunleiCaptchaSignature 直译（MIT，本地仓逐行核对）。"""
    ts = int(time.time() * 1000)
    content = CLIENT_ID + CLIENT_VER + PACKAGE + DEVICE_ID + str(ts)
    for part in SIGN_PARTS:
        content = _md5(content + part)
    return "1." + content, ts


class XunleiDiscovery(BaseDiscovery):
    name = "xunlei"
    domains = ("xunlei.com/s/", "pan.xunlei.com")

    def extract_id(self, url: str) -> str:
        m = re.search(r"(?:pan\.xunlei\.com|(?:www\.)?xunlei\.com)/s/([A-Za-z0-9]+)", url)
        return m.group(1) if m else ""

    def _headers(self, captcha_token: str = "") -> dict:
        h = {"x-client-id": CLIENT_ID, "x-device-id": DEVICE_ID,
             "x-client-version": CLIENT_VER}
        if captcha_token:
            h["x-captcha-token"] = captcha_token
        return h

    def discover(self, url: str, pwd: str = "") -> DResult:
        r = self._begin(url)
        sid = self.extract_id(url)
        if not sid:
            r.state, r.message = "err:bad_url", "share_id 未解析出"
            return self._end(r)

        # ① captcha/init（真验证码即熔断；meta.timestamp 必须**字符串**——
        #    实测 int 报 400 invalid_argument "meta scheme error，expect string"）
        sign, ts = captcha_sign()
        resp = self.post(
            "https://xluser-ssl.xunlei.com/v1/shield/captcha/init",
            json_body={"action": "get:/drive/v1/share", "captcha_token": "",
                       "client_id": CLIENT_ID, "device_id": DEVICE_ID,
                       "meta": {"timestamp": str(ts), "captcha_sign": sign,
                                "client_version": CLIENT_VER, "package_name": PACKAGE},
                       "redirect_uri": "xlaccsdk01://xunlei.com/callback?state=harbor"},
            headers=self._headers() | {"Accept": "application/json;charset=UTF-8",
                                       "Content-Type": "application/json"})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"captcha/init HTTP {resp.status_code}"
            return self._end(r)
        if j.get("url"):
            r.state = "wall:验证码"
            r.message = f"captcha/init 回 url（真验证码），熔断不硬闯：{(j.get('url') or '')[:50]}"
            r.alive = True
            return self._end(r)
        token = j.get("captcha_token") or ""
        self._step()

        # ② 匿名 share 列表（pansou 同款头族：origin/referer pan.xunlei.com）
        resp = self.get(
            "https://api-pan.xunlei.com/drive/v1/share",
            params={"share_id": sid, "pass_code": pwd or "", "limit": 100,
                    "pass_code_token": "", "page_token": "",
                    "thumbnail_size": "SIZE_SMALL"},
            headers=self._headers(token) | {"Accept": "*/*",
                                            "Origin": "https://pan.xunlei.com",
                                            "Referer": "https://pan.xunlei.com/"})
        if resp.status_code == 404:
            r.state, r.message = "dead:失效", "share HTTP 404"
            return self._end(r)
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"share HTTP {resp.status_code}"
            return self._end(r)
        if resp.status_code != 200 and not j.get("share_name"):
            err = j.get("error")
            if isinstance(err, dict):
                errtxt = f"{err.get('code', '')}:{str(err.get('message', ''))[:50]}"
            else:
                errtxt = str(err or (resp.text or "")[:60])
            r.state = "dead:失效" if resp.status_code == 404 else "err:code"
            r.message = f"share HTTP {resp.status_code} {errtxt[:80]}"
            return self._end(r)
        r.alive = True
        r.title = j.get("share_name") or ""
        r.file_count = int(j.get("file_count") or 0)
        files = j.get("files") or []
        if not files and r.file_count:
            self._step()
            resp = self.get(
                "https://api-pan.xunlei.com/drive/v1/share/files",
                params={"share_id": sid, "parent_file_id": "", "limit": 100,
                        "page_token": "", "thumbnail_size": "SIZE_SMALL"},
                headers=self._headers(token))
            try:
                j2 = resp.json()
                files = j2.get("files") or (j2.get("list") or [])
            except Exception:
                files = []
        r.entries = [DEntry(name=f.get("name") or f.get("file_name") or "?",
                            size=int(f.get("size") or f.get("file_size") or 0),
                            is_dir=(str(f.get("type") or f.get("file_type")) == "folder"
                                    or f.get("dir") is True),
                            fid=str(f.get("id") or f.get("file_id") or ""))
                     for f in files]
        r.ok = bool(r.entries) or r.file_count > 0
        r.state = "ok" if r.ok else "ok(空)"
        r.message = f"share_status={j.get('share_status')} files={len(r.entries)} file_count={r.file_count}"
        return self._end(r)
