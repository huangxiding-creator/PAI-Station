# -*- coding: utf-8 -*-
"""奶牛快传 adapter（取件码制免登两步）

出处：refs_nfd parser/impl/CowTool.java（MIT）+ Mikubill/cowtransfer-uploader（MIT）端点事实。
链路：GET core/api/transfer/share?uniqueUrl={key} → data{guid,zipDownload,firstFile.id}
      → GET core/api/transfer/share/download?transferGuid={guid}&fileId={fid} → data.downloadUrl
"""
from __future__ import annotations

from .base import BaseAdapter, FileEntry, PanError

API = "https://cowtransfer.com/core/api/transfer/share"


class CowtransferAdapter(BaseAdapter):
    name = "cow"
    domains = ("cowtransfer.com",)

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        key = url.rstrip("/").split("/s/")[-1].split("?")[0]
        r = self.get(f"{API}?uniqueUrl={key}")
        j = r.json()
        if (j.get("message") != "success" or "data" not in j) and pwd:
            # 收件码制：先 check 换会话再重拉（cowtransfer-uploader 端点事实）
            self._step()
            r = self.get(f"{API}/check?uniqueUrl={key}&code={pwd}")
            jchk = r.json()
            self._step()
            r = self.get(f"{API}?uniqueUrl={key}")
            j = r.json()
            if j.get("message") != "success":
                raise PanError(f"cow share/check: {str(jchk)[:120]} | {str(j)[:120]}")
        if j.get("message") != "success" or "data" not in j:
            raise PanError(f"cow share: {str(j)[:160]}")
        d = j["data"]
        if d.get("zipDownload"):
            ff = d.get("firstFolder") or {}
            name = ff.get("title", "cow_folder")
            raise PanError(f"cow: 目录打包件（title={name}），单件门请选非目录分享")
        first = d.get("firstFile") or {}
        info = d.get("fileInfo") or {}
        name = first.get("title") or first.get("name") or info.get("title") or "cow_file"
        size = int(info.get("size") or 0)
        return [FileEntry(name=name, size=size, fid=str(first.get("id", "")),
                          extra={"guid": d.get("guid", ""), "key": key})]

    def direct_url(self, entry: FileEntry) -> str:
        u = f"{API}/download?transferGuid={entry.extra['guid']}&fileId={entry.fid}"
        r = self.get(u)
        j = r.json()
        if j.get("message") != "success":
            raise PanError(f"cow download: {str(j)[:160]}")
        dl = ((j.get("data") or {}).get("downloadUrl")) or ""
        if not dl:
            raise PanError("cow: downloadUrl 空")
        return dl
