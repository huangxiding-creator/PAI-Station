# -*- coding: utf-8 -*-
"""移动云盘 139·发现层（W2 · 2026-10-30）

配方（r4_operator_disks.md YunX 端点事实 + pansou checkMobile/check_mobile_crypto.go
逐行直译，MIT）：
  AES-128-CBC，key=PVGDwmcvfs1uV3d1（YunX C139Constants.kt 公开常量），
  随机 IV 前置，PKCS7，base64(std)；请求体=再包一层 JSON 字符串字面量。
  POST share-kd-njs.yun.139.com/yun-share/richlifeApp/devapp/IOutLink/getOutLinkInfoV6
  空 Cookie 列目录（YunX 源码注释实锤）；下载 dlFromOutLinkV3 要 authorization=不在发现层。
"""
from __future__ import annotations

import base64
import json
import os
import re

from Crypto.Cipher import AES
from Crypto.Util.Padding import pad, unpad

from .base import BaseDiscovery, DEntry, DResult

KEY = b"PVGDwmcvfs1uV3d1"
API = ("https://share-kd-njs.yun.139.com/yun-share/richlifeApp/"
       "devapp/IOutLink/getOutLinkInfoV6")
DEVICE_INFO = ("||3|12.27.0|chrome|131.0.0.0|"
               "5c7c68368f048245e1ce47f1c0f8f2d0||windows 10|1536X695|zh-CN|||")


def _encrypt(payload: dict) -> str:
    inner = json.dumps(payload, separators=(",", ":"), ensure_ascii=False)
    iv = os.urandom(16)
    c = AES.new(KEY, AES.MODE_CBC, iv)
    return base64.b64encode(iv + c.encrypt(pad(inner.encode("utf-8"), 16))).decode()


def _decrypt(text: str) -> str:
    raw = base64.b64decode(text.strip().strip('"'))
    c = AES.new(KEY, AES.MODE_CBC, raw[:16])
    return unpad(c.decrypt(raw[16:]), 16).decode("utf-8")


class Pan139Discovery(BaseDiscovery):
    name = "139"
    domains = ("caiyun.139.com", "yun.139.com")

    def extract_id(self, url: str) -> str:
        for pat in (r"caiyun\.139\.com/m/i\?[a-zA-Z0-9]+",
                    r"yun\.139\.com/shareweb/#/w/i/([A-Za-z0-9]+)",
                    r"yun\.139\.com/s/([A-Za-z0-9]+)",
                    r"l\.caiyun\.139\.com/l/([A-Za-z0-9]+)"):
            m = re.search(pat, url)
            if m:
                return m.group(1) if m.groups() else m.group(0).split("?")[1]
        return ""

    def discover(self, url: str, pwd: str = "") -> DResult:
        r = self._begin(url)
        link_id = self.extract_id(url)
        if not link_id:
            r.state, r.message = "err:bad_url", "linkID 未解析出"
            return self._end(r)

        payload = {
            "getOutLinkInfoReq": {"account": "", "linkID": link_id,
                                  "passwd": pwd or "", "caSrt": 1, "coSrt": 1,
                                  "srtDr": 0, "bNum": 1, "pCaID": "root", "eNum": 200},
            "commonAccountInfo": {"account": "", "accountType": 1},
        }
        body = json.dumps(_encrypt(payload))          # 双层：密文再作 JSON 字符串
        resp = self.post(API, data=body.encode("utf-8"),
                         headers={"Accept": "application/json",
                                  "Content-Type": "application/json",
                                  "hcy-cool-flag": "1",
                                  "x-deviceinfo": DEVICE_INFO})
        try:
            plain = _decrypt(resp.text)
            j = json.loads(plain)
        except Exception as e:
            r.state = "err:crypto/http"
            r.message = f"HTTP {resp.status_code} 解密失败 {type(e).__name__}: {str(e)[:50]}"
            if resp.status_code == 200 and "resultCode" in (resp.text or "")[:200]:
                # 明文回退（部分出口不解密）： resultCode 直读
                try:
                    j = resp.json()
                except Exception:
                    return self._end(r)
            else:
                return self._end(r)
        rc = str(j.get("resultCode", ""))
        if rc != "0":
            r.state = "err:resultCode"
            r.message = f"resultCode={rc} {str(j.get('desc', ''))[:50]}"
            r.alive = rc not in ("01000101",)      # 01000101=假码/参数坏（端点活）
            return self._end(r)
        r.alive = True
        data = j.get("data") or {}
        r.title = str(data.get("lkName") or data.get("linkName") or "")

        def _parse(d: dict) -> list[DEntry]:
            out = [DEntry(name=str(c.get("caName") or "?"), size=0, is_dir=True,
                          fid=str(c.get("caID") or ""))
                   for c in (d.get("caLst") or [])]
            out += [DEntry(name=str(c.get("coName") or c.get("name") or "?"),
                           size=int(c.get("coSize") or c.get("size") or 0),
                           is_dir=False, fid=str(c.get("coID") or c.get("contentId") or ""))
                    for c in (d.get("coLst") or [])]
            return out

        files = _parse(data)                    # 首响应即根层（实测 data.caLst 直挂）
        r.message = (f"resultCode=0 提取码回吐={data.get('password') or '-'} "
                     f"root={len(files)} 项")
        # 单目录根 → 下钻一层（pCaID=目录caID 另发；空层如实记）
        if len(files) == 1 and files[0].is_dir and files[0].fid:
            self._step()
            payload["getOutLinkInfoReq"]["pCaID"] = files[0].fid
            body = json.dumps(_encrypt(payload))
            resp = self.post(API, data=body.encode("utf-8"),
                             headers={"Accept": "application/json",
                                      "Content-Type": "application/json",
                                      "hcy-cool-flag": "1",
                                      "x-deviceinfo": DEVICE_INFO})
            try:
                sub = _parse(json.loads(_decrypt(resp.text)).get("data") or {})
            except Exception:
                sub = []
            if sub:
                files = sub
                r.message += f" → 下钻 {len(sub)} 子项"
        r.entries = files[:200]
        r.ok = bool(files)
        r.state = "ok" if r.ok else "ok(空)"
        r.file_count = len(r.entries)
        return self._end(r)
