# -*- coding: utf-8 -*-
"""UC 网盘 adapter（免登三步链）

出处：refs_nfd parser/impl/UcTool.java（MIT）端点事实 + R4 实测（假码 41006=端点活无登录墙）。
链路：POST share/sharepage/token {pwd_id,passcode} → stoken
      → GET transfer_share/detail?pwd_id&passcode&stoken&pdir_fid=0... → list[]
      → POST file/download {fids,pwd_id,stoken,fids_token} → data[0].download_url
直链下载头：Referer https://fast.uc.cn/（UcTool buildDownloadHeaders）。
"""
from __future__ import annotations

from urllib.parse import quote

from .base import BaseAdapter, FileEntry, PanError

API = "https://pc-api.uc.cn/1/clouddrive"
H = {"Origin": "https://drive.uc.cn", "Referer": "https://drive.uc.cn/"}


class UcAdapter(BaseAdapter):
    name = "uc"
    domains = ("drive.uc.cn/s/", "fast.uc.cn/s/")
    dl_headers = {"User-Agent": BaseAdapter.dl_headers["User-Agent"],
                  "Referer": "https://fast.uc.cn/"}

    def __init__(self):
        # 匿名 cookie 引导：先访分享页收 ctoken/UDRIVE_TRANSFER_SESS（盘方公开签发，非用户凭据）
        # 实测（10-31）：无此 cookie 时 dl-uf-zb.pds.uc.cn 回调 403 require login；有则直链放行
        from curl_cffi import requests as creq
        self._sess = creq.Session(impersonate=self.impersonate if hasattr(self, "impersonate") else "chrome124",
                                  timeout=25)
        self._booted: set[str] = set()

    def _bootstrap(self, share_url: str):
        host = share_url.split("/s/")[0]
        if host in self._booted:
            return
        try:
            self._sess.get(share_url, headers={"User-Agent": self.dl_headers["User-Agent"]})
        except Exception:
            pass
        self._booted.add(host)

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        self._bootstrap(url if url.startswith("http") else "https://drive.uc.cn/s/" + url)
        return self._parse_inner(url, pwd)

    def _req(self, method, url, *, headers=None, json_body=None, data=None,
             allow_redirects=True, timeout=25, proxies=None):
        h = {"User-Agent": self.dl_headers["User-Agent"],
             "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}
        if headers:
            h.update(headers)
        kw = dict(headers=h, timeout=timeout, impersonate="chrome124",
                  allow_redirects=allow_redirects)
        if json_body is not None:
            kw["json"] = json_body
        if data is not None:
            kw["data"] = data
        return self._sess.request(method.upper(), url, **kw)

    def _parse_inner(self, url: str, pwd: str = "") -> list[FileEntry]:
        key = url.rstrip("/").split("/s/")[-1].split("?")[0]
        r = self.post(f"{API}/share/sharepage/token?entry=ft&fr=pc&pr=UCBrowser",
                      headers=H, json_body={"share_for_transfer": True,
                                            "pwd_id": key, "passcode": pwd or ""})
        j = r.json()
        if j.get("code") != 0:
            raise PanError(f"UC token: code={j.get('code')} {j.get('message')}")
        stoken = j["data"]["stoken"]
        # 根目录→子目录自动下钻（影视分享常为「日期文件夹」结构，最多 3 层）
        out: list[FileEntry] = []
        dir_fid = "0"
        for _ in range(4):
            self._step()
            r2 = self.get(
                f"{API}/transfer_share/detail?pwd_id={quote(key)}&passcode={quote(pwd or '')}"
                f"&stoken={quote(stoken)}&entry=ft&pdir_fid={dir_fid}&fetch_file_list=1"
                f"&_page=1&_size=50&_fetch_total=1&_fetch_share=1"
                f"&_sort=file_type:asc,file_name:asc&fr=pc&pr=UCBrowser", headers=H)
            j2 = r2.json()
            if j2.get("code") != 0:
                raise PanError(f"UC detail: code={j2.get('code')} {j2.get('message')}")
            out = [FileEntry(
                name=it.get("file_name") or it.get("name") or "",
                size=int(it.get("size", 0)),
                is_dir=not it.get("file", True),
                fid=it.get("fid", ""),
                extra={"pwd_id": key, "stoken": stoken,
                       "share_fid_token": it.get("share_fid_token", "")},
            ) for it in j2.get("data", {}).get("list", [])]
            files = [e for e in out if not e.is_dir]
            dirs = [e for e in out if e.is_dir]
            if files or not dirs:
                return out
            dir_fid = dirs[0].fid      # 无文件仅有目录 → 进第一个目录
        return out

    def direct_url(self, entry: FileEntry) -> str:
        body = {"fids": [entry.fid], "pwd_id": entry.extra["pwd_id"],
                "stoken": entry.extra["stoken"]}
        if entry.extra.get("share_fid_token"):
            body["fids_token"] = [entry.extra["share_fid_token"]]
        r = self.post(f"{API}/file/download?entry=ft&fr=pc&pr=UCBrowser",
                      headers=H, json_body=body)
        j = r.json()
        if j.get("code") != 0:
            raise PanError(f"UC download: code={j.get('code')} {j.get('message')}")
        data = j.get("data") or []
        if not data or not data[0].get("download_url"):
            raise PanError("UC: download_url 空")
        return data[0]["download_url"]
