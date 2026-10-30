# -*- coding: utf-8 -*-
"""115 网盘 adapter（官方免登 skip_login_downurl 端点）

出处：refs_nfd parser/impl/P115Tool.java（MIT）。R4 实测：假码 snap 返回 errno 990002=端点活无登录墙。
链路：GET share/snap?share_code&receive_code&cid= → data.list[0].fid
      → POST share/skip_login_downurl form{share_code,receive_code,file_id} → data.url.url
注意：API UA 与下载 UA 必须一致（P115Tool 类注释）。
"""
from __future__ import annotations

from .base import BaseAdapter, FileEntry, PanError

API = "https://115cdn.com/webapi"
H = {"Accept": "application/json, text/plain, */*", "Origin": "https://115cdn.com",
     "Referer": "https://115cdn.com"}


class Pan115Adapter(BaseAdapter):
    name = "115"
    domains = ("115.com/s/", "anxia.com/s/")

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        key = url.split("/s/")[-1].split("?")[0]
        r = self.get(f"{API}/share/snap?share_code={key}&offset=0&limit=20"
                     f"&receive_code={pwd or ''}&cid=", headers=H)
        j = r.json()
        if not j.get("state"):
            raise PanError(f"115 snap: errno={j.get('errno')} {j.get('error')}")
        out = []
        for it in (j.get("data") or {}).get("list", []):
            out.append(FileEntry(
                name=it.get("n", ""), size=int(it.get("s", 0)),
                # fc 枚举实测：1=文件 0=目录（swhyiia3wzi dump 佐证）；cid 是目录归属非类型
                is_dir=(int(it.get("fc", 1)) == 0),
                fid=str(it.get("fid", "")),
                extra={"share_code": key, "receive_code": pwd or "",
                       "cid": it.get("cid", "")},
            ))
        return out

    def direct_url(self, entry: FileEntry) -> str:
        r = self.post(f"{API}/share/skip_login_downurl", headers={
            **H, "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
            data={"share_code": entry.extra["share_code"],
                  "receive_code": entry.extra["receive_code"],
                  "file_id": entry.fid})
        j = r.json()
        if not j.get("state"):
            raise PanError(f"115 downurl: errno={j.get('errno')} {j.get('error')}")
        u = ((j.get("data") or {}).get("url") or {}).get("url")
        if not u:
            raise PanError("115: url.url 空")
        return u
