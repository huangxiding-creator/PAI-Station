# -*- coding: utf-8 -*-
"""蓝奏优享(ilanzou)/小飞机(feijipan) 共用骨架（unproved/ws 命名空间·免登）

出处：refs_nfd parser/impl/IzTool.java / FjTool.java（均 MIT）。两盘同构：
  ① POST buy/vip/list（固定 uuid 预热，忽略响应）
  ② POST recommend/list?...&shareId= → list[0].fileList[0]{fileName,fileSize(KB),fileId,fileType} + list[0]{fileIds,userId}
  ③ GET file/redirect?downloadId={AES(fileId|userId)}&enable=1&uuid&timestamp={AES(ms)}&auth={AES(fileId|ms)}&shareId= → 302 Location=直链
差异：API 域/路径前缀与 AES 密钥（_crypto.iz_hex / fj_hex）；acw_sc__v2 挑战两盘均可能出。
"""
from __future__ import annotations

import uuid as uuidlib

from ._crypto import acw_sc_v2, iz_hex, fj_hex
from .base import BaseAdapter, FileEntry, PanError, UA


class _IzFjBase(BaseAdapter):
    api_base = ""            # https://api.ilanzou.com | https://api.feijipan.com
    prefix = ""              # /unproved | /ws
    enc = staticmethod(iz_hex)   # 子类覆写
    referer = ""
    domains: tuple[str, ...] = ()

    def __init__(self):
        self._uuid = str(uuidlib.uuid4()).lower()
        self._cookies: dict[str, str] = {}

    def _h(self, extra: dict | None = None) -> dict:
        h = {"User-Agent": UA, "Accept": "application/json, text/plain, */*",
             "Origin": self.referer.rstrip("/"), "Referer": self.referer}
        if self._cookies:
            h["Cookie"] = "; ".join(f"{k}={v}" for k, v in self._cookies.items())
        if extra:
            h.update(extra)
        return h

    def _post_json(self, url: str, headers=None):
        r = self.post(url, headers=self._h(headers or {}))
        body = r.text or ""
        if "var arg1='" in body:
            import re
            m = re.search(r"arg1='([^']+)'", body)
            if m:
                self._cookies["acw_sc__v2"] = acw_sc_v2(m.group(1))
                self._step()
                r = self.post(url, headers=self._h(headers or {}))
        return r

    def parse(self, url: str, pwd: str = "") -> list[FileEntry]:
        share_id = url.rstrip("/").split("/s/")[-1].split("?")[0]
        ts = self.enc(str(_now_ms()))
        # ① vip 预热（固定 uuid 规则）
        self.post(f"{self.api_base}{self.prefix}/buy/vip/list?devType=6&devModel=Chrome"
                  f"&uuid={self._uuid}&extra=2&timestamp={ts}", headers=self._h())
        self._step()
        # ② 列表
        u = (f"{self.api_base}{self.prefix}/recommend/list?devType=6&devModel=Chrome"
             f"&uuid={self._uuid}&extra=2&timestamp={ts}&shareId={share_id}"
             f"&type=0&offset=1&limit=60")
        if pwd:
            u += f"&code={pwd}"
        r = self._post_json(u)
        j = r.json()
        if j.get("code") != 200:
            raise PanError(f"{self.name} list: code={j.get('code')} {j.get('msg')}")
        lst = j.get("list") or []
        if not lst:
            raise PanError(f"{self.name}: list 空")
        share = lst[0]
        files = share.get("fileList") or []
        out = []
        for f in files:
            out.append(FileEntry(
                name=f.get("fileName") or f.get("name") or "",
                size=int(f.get("fileSize", 0)) * 1024,
                is_dir=(int(f.get("fileType", 1)) == 2),
                fid=str(f.get("fileId") or f.get("folderId") or ""),
                extra={"shareId": share_id, "fileIds": share.get("fileIds", ""),
                       "userId": share.get("userId", "")},
            ))
        # 根仅目录 → share/list 下钻一层（IzTool parserDir 同构）
        if out and all(e.is_dir for e in out) or (not out and share.get("folderId")):
            self._step()
            ts3 = self.enc(str(_now_ms()))
            u2 = (f"{self.api_base}{self.prefix}/share/list?devType=6&devModel=Chrome"
                  f"&uuid={self._uuid}&extra=2&timestamp={ts3}&shareId={share_id}"
                  f"&folderId={out[0].fid if out else share.get('folderId', '')}&offset=1&limit=60")
            r2 = self._post_json(u2)
            j2 = r2.json()
            sub = []
            for f in (j2.get("list") or []):
                sub.append(FileEntry(
                    name=f.get("fileName") or f.get("name") or "",
                    size=int(f.get("fileSize", 0)) * 1024,
                    is_dir=(int(f.get("fileType", 1)) == 2),
                    fid=str(f.get("fileId") or f.get("folderId") or ""),
                    extra={"shareId": share_id,
                           "fileIds": f.get("fileId", ""),
                           "userId": f.get("userId", "") or share.get("userId", "")},
                ))
            if sub:
                return sub
        return out

    def direct_url(self, entry: FileEntry) -> str:
        file_id = entry.extra.get("fileIds") or entry.fid
        user_id = entry.extra.get("userId", "")
        ms = _now_ms()
        ts2 = self.enc(str(ms))
        fid_enc = self.enc(f"{file_id}|{user_id}")
        auth = self.enc(f"{file_id}|{ms}")
        u = (f"{self.api_base}{self.prefix}/file/redirect?downloadId={fid_enc}&enable=1"
             f"&devType=6&uuid={self._uuid}&timestamp={ts2}&auth={auth}"
             f"&shareId={entry.extra['shareId']}")
        r = self.get(u, headers=self._h(), allow_redirects=False)
        loc = r.headers.get("Location", "")
        if not loc:
            snippet = (r.text or "")[:200]
            raise PanError(f"{self.name} redirect: HTTP {r.status_code} {snippet}")
        return loc


def _now_ms() -> int:
    import time
    return int(time.time() * 1000)


class ILanzouAdapter(_IzFjBase):
    name = "ilanzou"
    api_base = "https://api.ilanzou.com"
    prefix = "/unproved"
    enc = staticmethod(iz_hex)
    referer = "https://www.ilanzou.com/"
    domains = ("ilanzou.com",)


class FeijipanAdapter(_IzFjBase):
    name = "feijipan"
    api_base = "https://api.feijipan.com"
    prefix = "/ws"
    enc = staticmethod(fj_hex)
    referer = "https://www.feijipan.com/"
    domains = ("feijipan.com",)
