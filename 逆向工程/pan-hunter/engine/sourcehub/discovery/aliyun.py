# -*- coding: utf-8 -*-
"""阿里云盘/alipan·发现层（W2 · 2026-10-30）

配方（r3_big4_disks.md A 级 + pansou checkAliyun + go-aliyundrive/boxplayer 链路）：
  ① POST api.aliyundrive.com/adrive/v3/share_link/get_share_by_anonymous?share_id=
     头 origin/referer=https://www.alipan.com —— 全匿名零 Cookie
  ② POST /v2/share_link/get_share_token {share_id, pass_code} —— 匿名 share_token
  ③ POST /adrive/v3/file/list 头 x-share-token —— 分享文件清单（无需用户 token）
下载面（GetDownloadUrl 需 OAuth）不在发现层，不打。
"""
from __future__ import annotations

import re

from .base import BaseDiscovery, DEntry, DResult

_HOSTS = ("https://api.aliyundrive.com", "https://api.alipan.com")
_H = {"Origin": "https://www.alipan.com", "Referer": "https://www.alipan.com/",
      "x-canary": "client=web,app=share,tag=v3,version=3.4.0",
      "Content-Type": "application/json;charset=UTF-8"}


class AliyunDiscovery(BaseDiscovery):
    name = "aliyun"
    domains = ("alipan.com/s/", "aliyundrive.com/s/")

    def extract_id(self, url: str) -> str:
        m = re.search(r"(?:alipan|aliyundrive)\.com/s/([A-Za-z0-9]+)", url)
        return m.group(1) if m else ""

    def _post(self, host: str, path: str, *, params=None, json_body=None):
        last = None
        for h in (host, _HOSTS[1] if host == _HOSTS[0] else _HOSTS[0]):
            try:
                return self.post(h + path, params=params, json_body=json_body, headers=_H)
            except Exception as e:                      # DNS/TLS 层失败 → 换域名重试一发
                last = e
                continue
        raise last

    def discover(self, url: str, pwd: str = "") -> DResult:
        r = self._begin(url)
        sid = self.extract_id(url)
        if not sid:
            r.state, r.message = "err:bad_url", "share_id 未解析出"
            return self._end(r)

        # ① 分享元信息（匿名；share_id 双入 query+body——实测仅 query 报
        #    InvalidParameter.ShareId，首轮跑批 9 链实证）
        resp = self._post(_HOSTS[0], "/adrive/v3/share_link/get_share_by_anonymous",
                          params={"share_id": sid}, json_body={"share_id": sid})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"anonymous HTTP {resp.status_code}"
            return self._end(r)
        code = j.get("code")
        if code:
            msg = f"{code}:{j.get('message', '')[:60]}"
            if "NotExist" in code or "NotFound" in code or "expired" in code:
                r.state, r.message = "dead:失效", msg
            else:
                r.state, r.message = "err:code", msg
            return self._end(r)
        r.alive = True
        r.title = j.get("share_name") or ""
        r.file_count = int(j.get("file_count") or 0)
        info_file_id = j.get("file_id") or ""      # ①步元信息首对象（root 回退用）
        has_pwd = bool(j.get("has_pwd"))
        if has_pwd and not pwd:
            r.state, r.message = "wall:提取码", "has_pwd=true 且未提供提取码"
            return self._end(r)
        self._step()

        # ② 匿名 share_token
        resp = self._post(_HOSTS[0], "/v2/share_link/get_share_token",
                          json_body={"share_id": sid, **({"pass_code": pwd} if pwd else {})})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"share_token HTTP {resp.status_code}"
            return self._end(r)
        if "share_token" not in j:
            msg = f"{j.get('code', '')}:{j.get('message', '')[:60]}"
            r.state = ("wall:提取码" if "assword" in msg or "passcode" in msg.lower()
                       else "err:code")
            r.message = f"share_token {msg}"
            return self._end(r)
        stoken = j["share_token"]
        self._step()

        # ③ 文件清单（x-share-token 匿名头）
        body = {"share_id": sid, "parent_file_id": "root", "limit": 100,
                "image_thumbnail_process": "image/resize,w_256/format,jpeg",
                "image_url_process": "image/resize,w_1920/format,jpeg",
                "video_thumbnail_process": "video/snapshot,mtime,f_jpg,w_480",
                "fields": "*", "order_by": "name", "order_direction": "ASC"}
        resp = self.post(_HOSTS[0] + "/adrive/v3/file/list", json_body=body,
                         headers={**_H, "x-share-token": stoken})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"file/list HTTP {resp.status_code}"
            return self._end(r)
        items = j.get("items") or []
        if not items:                                    # root 口径退避：分享首对象 id（来自①步）
            first_fid = info_file_id
            if first_fid:
                self._step()
                body["parent_file_id"] = first_fid
                resp = self.post(_HOSTS[0] + "/adrive/v3/file/list", json_body=body,
                                 headers={**_H, "x-share-token": stoken})
                try:
                    j = resp.json()
                    items = j.get("items") or []
                except Exception:
                    items = []
        if items is not None and (items or not j.get("code")):
            r.entries = [DEntry(name=it.get("name") or "?",
                                size=int(it.get("size") or 0),
                                is_dir=(it.get("type") == "folder"),
                                fid=it.get("file_id") or "")
                         for it in items]
            r.ok = bool(r.entries) or r.file_count > 0
            r.state = "ok" if r.ok else "ok(空)"
            r.message = f"list {len(r.entries)} 项 / file_count={r.file_count}"
        else:
            r.state, r.message = "err:code", f"{j.get('code', '')}:{j.get('message', '')[:60]}"
        if not r.file_count:
            r.file_count = len(r.entries)
        return self._end(r)
