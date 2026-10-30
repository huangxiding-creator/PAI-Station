# -*- coding: utf-8 -*-
"""123 云盘 adapter（免登列表 + v2 分享直链，encode123 签名）

出处：refs_nfd parser/impl/Ye2Tool.java（MIT）+ OpenList drivers/123_share（AGPL，仅端点事实）。
链路：GET b/api/share/get?shareKey&SharePwd&ParentFileId=0 → data.InfoList[]
      → POST b/api/v2/share/download/info + encode123 查询签名
        body{ShareKey,FileID,S3keyFlag,Size,Etag} → data.downloadPath + dispatchList[0].prefix
零登录纪律：无 Authorization 位（OpenList 123_share 同口径=AccessToken 非必填）；
若上游对该分享要求登录（code!=0 且提示登录/会员），如实抛 PanError——不降标准、不注凭据。
"""
from __future__ import annotations

import time
from urllib.parse import quote

from ._crypto import encode123
from .base import BaseAdapter, FileEntry, PanError

API = "https://api.123278.com"
SHARE_ORGIN = "https://www.123pan.com"


class Pan123Adapter(BaseAdapter):
    name = "123"
    domains = ("123pan.com/s/", "123pan.cn/s/", ".share.123pan.cn", "123865.com", "123957.com")

    def _referer(self, key: str, pwd: str) -> dict:
        ref = f"{SHARE_ORGIN}/s/{key}"
        if pwd:
            ref += f"?pwd={quote(pwd)}"
        return {"Origin": SHARE_ORGIN, "Referer": ref,
                "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36"}

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        key = url.split("/s/")[-1].split("?")[0].strip("/")
        parent = "0"
        out: list[FileEntry] = []
        # 根仅目录 → 下钻（合集型分享，最多 3 层）
        for _ in range(4):
            r = self.get(
                f"{API}/b/api/share/get?limit=100&next=1&orderBy=share_id&orderDirection=desc"
                f"&shareKey={quote(key)}&SharePwd={quote(pwd or '')}&ParentFileId={parent}&Page=1",
                headers=self._referer(key, pwd))
            j = r.json()
            if j.get("code") != 0:
                raise PanError(f"123 share/get: code={j.get('code')} {j.get('message')}")
            info = (j.get("data") or {}).get("InfoList") or []
            out = [FileEntry(
                name=it.get("FileName", ""), size=int(it.get("Size", 0)),
                is_dir=(int(it.get("Type", 0)) == 1),
                fid=str(it.get("FileId", "")),
                extra={"shareKey": key, "S3KeyFlag": it.get("S3KeyFlag", ""),
                       "Etag": it.get("Etag", ""), "Size": int(it.get("Size", 0))},
            ) for it in info]
            files = [e for e in out if not e.is_dir]
            dirs = [e for e in out if e.is_dir]
            if files or not dirs:
                return out
            parent = dirs[0].fid
            self._step()
        return out

    def direct_url(self, entry: FileEntry) -> str:
        path = "/b/api/v2/share/download/info"
        ts = int(time.time() * 1000)
        u = f"{API}{path}{encode123(path, 'web', '3', ts)}"
        body = {"ShareKey": entry.extra["shareKey"], "FileID": int(entry.fid or 0),
                "S3keyFlag": entry.extra.get("S3KeyFlag", ""),
                "Size": entry.extra.get("Size", 0), "Etag": entry.extra.get("Etag", "")}
        r = self.post(u, headers={**self._referer(entry.extra["shareKey"], ""),
                                  "App-Version": "3", "platform": "web",
                                  "Content-Type": "application/json;charset=UTF-8",
                                  "Accept": "*/*"}, json_body=body)
        j = r.json()
        if j.get("code") != 0:
            raise PanError(f"123 download_info: code={j.get('code')} {j.get('message')}")
        data = j.get("data") or {}
        dp = data.get("downloadPath") or ""
        if not dp:
            raise PanError("123: downloadPath 空")
        dispatch = (data.get("dispatchList") or [{}])
        prefix = (dispatch[0] or {}).get("prefix", "") if dispatch else ""
        if prefix:
            return prefix.rstrip("/") + (dp if dp.startswith("/") else "/" + dp)
        return dp
