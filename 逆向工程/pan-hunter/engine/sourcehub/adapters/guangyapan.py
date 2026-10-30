# -*- coding: utf-8 -*-
"""光鸭云盘 adapter（匿名 share-token 三步链 · W1 转正裁决对象）

出处：ByLsPro/JxPan 未加密源码.js GuangyaPanParser（Apache-2.0）。
关键事实：get_share_access_token / get_share_page_files_list / get_share_download_url
三端点均不携 Authorization（JxPan 仅在「转存后」get_res_download_url 用 Bearer）——匿名态可用性
即本 adapter 的裁决使命（任务书 §3）。W1-10-31 实测结论见 analysis/W1_GREEN_GATES.md。
链路：POST nd.bizuserres.s/v1/get_share_access_token {shareId,code} → data.accessToken
      → POST get_share_page_files_list {accessToken,parentId:'',page:1,pageSize:50,...} → data.list[]
      → POST get_share_download_url {fileId,accessToken} → data(str|{signedURL,url,downloadUrl})
"""
from __future__ import annotations

import re

from .base import BaseAdapter, FileEntry, PanError, UA

API = "https://api.guangyapan.com"
H = {"Accept": "application/json, text/plain, */*", "Content-Type": "application/json",
     "Origin": "https://www.guangyapan.com", "Referer": "https://www.guangyapan.com/",
     "User-Agent": UA}


class GuangyapanAdapter(BaseAdapter):
    name = "guangya"
    domains = ("guangyapan.com",)

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        m = re.search(r"/s/([^?]+)(?:\?.*?code=([^&]+))?", url)
        if not m:
            raise PanError("guangya: 无法解析分享链")
        share_id = m.group(1)
        code = pwd or (m.group(2) or "")
        r = self.post(f"{API}/nd.bizuserres.s/v1/get_share_access_token", headers=H,
                      json_body={"shareId": share_id, "code": code})
        j = r.json()
        if j.get("msg") != "success":
            raise PanError(f"guangya token: {str(j)[:160]}（匿名态路由证据）")
        token = (j.get("data") or {}).get("accessToken") if isinstance(j.get("data"), dict) else j.get("data")
        if not token:
            raise PanError("guangya: accessToken 空")
        self._step()
        parent = ""
        out: list[FileEntry] = []
        # 根仅目录时自动下钻（共享资源库型分享多层目录，实测最深 3-4 层）
        for _ in range(5):
            r2 = self.post(f"{API}/nd.bizuserres.s/v1/get_share_page_files_list", headers=H,
                           json_body={"accessToken": token, "parentId": parent, "page": 1,
                                      "pageSize": 50, "orderBy": 0, "sortType": 0})
            j2 = r2.json()
            if j2.get("msg") != "success":
                raise PanError(f"guangya list: {str(j2)[:160]}")
            files = ((j2.get("data") or {}).get("list")) or []
            out = []
            for f in files:
                is_dir = f.get("resType") == 2 or f.get("fileType") == 0 or f.get("type") == 0
                out.append(FileEntry(name=f.get("fileName") or "", size=int(f.get("fileSize", 0)),
                                     is_dir=bool(is_dir), fid=str(f.get("fileId", "")),
                                     extra={"accessToken": token}))
            files_only = [e for e in out if not e.is_dir]
            dirs = [e for e in out if e.is_dir]
            if files_only or not dirs:
                return out
            parent = dirs[0].fid
            self._step()
        return out

    def direct_url(self, entry: FileEntry) -> str:
        r = self.post(f"{API}/nd.bizuserres.s/v1/get_share_download_url", headers=H,
                      json_body={"fileId": entry.fid, "accessToken": entry.extra["accessToken"]})
        j = r.json()
        if j.get("msg") != "success":
            raise PanError(f"guangya dl: {str(j)[:160]}")
        d = j.get("data")
        if isinstance(d, str):
            u = d
        elif isinstance(d, dict):
            u = d.get("signedURL") or d.get("url") or d.get("downloadUrl") or ""
        else:
            u = ""
        if not u:
            raise PanError("guangya: 直链空")
        return u
