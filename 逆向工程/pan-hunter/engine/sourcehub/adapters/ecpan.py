# -*- coding: utf-8 -*-
"""亿方云(ecpan.cn/移动云空间) adapter（免登两步）

出处：refs_nfd parser/impl/EcTool.java（MIT）。
链路：GET drive/fileextoverrid.do?extractionCode&data= → var.chainFileInfo{cloudpFile.groupId,shareId,cloudpFileList}
      → POST drive/sharedownload.do {extCodeFlag:0,isIp:0,shareId,groupId,fileIdList} → var.downloadUrl
"""
from __future__ import annotations

from urllib.parse import quote

from .base import BaseAdapter, FileEntry, PanError

BASE = "https://www.ecpan.cn"
CHAIN_TPL = quote("https://www.ecpan.cn/web/#/yunpanProxy?path=%2F%23%2Fdrive%2Foutside", safe="")


class EcpanAdapter(BaseAdapter):
    name = "ecpan"
    domains = ("ecpan.cn",)

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        m = None
        import re
        m = re.search(r"[?&]data=([^&\s]+)", url)
        if not m:
            raise PanError("ecpan: 链接缺 data 参数")
        data_key = m.group(1)
        r = self.get(f"{BASE}/drive/fileextoverrid.do?extractionCode={quote(pwd or '')}"
                     f"&chainUrlTemplate={CHAIN_TPL}&parentId=-1&data={quote(data_key, safe='')}")
        j = r.json()
        info = ((j.get("var") or {}).get("chainFileInfo")) or {}
        if info.get("errMesg"):
            raise PanError(f"ecpan: {info['errMesg']}")
        if not info.get("cloudpFile"):
            raise PanError("ecpan: cloudpFile 缺失")
        out = []
        for f in info.get("cloudpFileList") or []:
            out.append(FileEntry(
                name=str(f.get("fileName") or f.get("name") or ""),
                size=int(f.get("fileSize", 0)),
                # 实测 fileType 枚举：2=文件（v01.mp4）；目录判定用 fileCount>0 兜底
                is_dir=(int(f.get("fileType", 2)) == 1) or (int(f.get("fileCount", 0)) > 0 and not f.get("fileName", "").count(".")),
                fid=str(f.get("appFileId") or f.get("fileId") or ""),
                extra={"shareId": info.get("shareId", ""),
                       "groupId": (info.get("cloudpFile") or {}).get("groupId", ""),
                       "raw": f},
            ))
        return out

    def direct_url(self, entry: FileEntry) -> str:
        body = {"extCodeFlag": 0, "isIp": 0, "shareId": entry.extra["shareId"],
                "groupId": entry.extra["groupId"],
                "fileIdList": [entry.extra["raw"]]}
        r = self.post(f"{BASE}/drive/sharedownload.do", json_body=body)
        j = r.json()
        u = ((j.get("var") or {}).get("downloadUrl")) or ""
        if not u:
            raise PanError(f"ecpan: downloadUrl 空 ({str(j)[:160]})")
        return u
