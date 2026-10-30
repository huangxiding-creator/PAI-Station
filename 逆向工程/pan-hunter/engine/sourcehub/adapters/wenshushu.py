# -*- coding: utf-8 -*-
"""文叔叔 adapter（匿名 token 四步链，收件码制）

出处：refs_nfd parser/impl/WsTool.java（MIT）。
链路：POST ap/login/anonymous {dev_info:"{}"} → X-Token（匿名令牌=盘方公开签发，非用户凭据）
      → POST ap/task/mgrtask {tid,password} → ufileid/boxid
      → POST ap/ufile/list {bid,pid,...} → fileList[]{fname,fid}
      → POST ap/dl/sign {consumeCode:0,type:1,ufileid:fid} → data.url（URLDecode）
"""
from __future__ import annotations

from urllib.parse import unquote

from .base import BaseAdapter, FileEntry, PanError

API = "https://www.wenshushu.cn/ap/"
MOBILE_UA = ("Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 "
             "(KHTML, like Gecko) Chrome/111.0.0.0 Mobile Safari/537.36")


class WenshushuAdapter(BaseAdapter):
    name = "wenshushu"
    domains = ("wenshushu.cn",)

    def _h(self, token: str | None = None) -> dict:
        h = {"User-Agent": MOBILE_UA, "sec-ch-ua-platform": "Android",
             "sec-ch-ua-mobile": "?1"}
        if token:
            h["X-Token"] = token
        return h

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        tid = url.rstrip("/").split("/")[-1].split("?")[0]
        r = self.post(API + "login/anonymous", headers=self._h(),
                      json_body={"dev_info": "{}"})
        token = ((r.json().get("data") or {}).get("token")) or ""
        if not token:
            raise PanError("wss: 匿名 token 获取失败")
        self._step()
        r2 = self.post(API + "task/mgrtask", headers=self._h(token),
                       json_body={"tid": tid, "password": pwd or ""})
        d2 = r2.json().get("data") or {}
        pid, bid = d2.get("ufileid"), d2.get("boxid")
        if not (pid or bid):
            raise PanError(f"wss: mgrtask 空 ({str(r2.json())[:160]})")
        self._step()
        r3 = self.post(API + "ufile/list", headers=self._h(token),
                       json_body={"start": 0, "sort": {"name": "asc"}, "bid": bid,
                                  "pid": pid, "type": 1,
                                  "options": {"uploader": "true"}, "size": 50})
        files = ((r3.json().get("data") or {}).get("fileList")) or []
        if not files:
            raise PanError("wss: fileList 空")
        out = []
        for f in files:
            out.append(FileEntry(name=f.get("fname", ""), size=int(f.get("size", 0)),
                                 is_dir=str(f.get("bid", "")) != str(bid),
                                 fid=f.get("fid", ""), extra={"token": token}))
        return out

    def direct_url(self, entry: FileEntry) -> str:
        r = self.post(API + "dl/sign", headers=self._h(entry.extra["token"]),
                      json_body={"consumeCode": 0, "type": 1, "ufileid": entry.fid})
        u = ((r.json().get("data") or {}).get("url")) or ""
        if not u:
            raise PanError("wss: dl/sign url 空（文件失效/需收件码）")
        return unquote(u)
