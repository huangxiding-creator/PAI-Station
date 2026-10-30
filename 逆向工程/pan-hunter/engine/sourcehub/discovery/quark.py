# -*- coding: utf-8 -*-
"""夸克网盘·发现层（W2 · 2026-10-30）

配方（r3_big4_disks.md A 级 + pansou checkQuark 逐参实证）：
  ① POST drive-h.quark.cn/1/clouddrive/share/sharepage/token {pwd_id, passcode,
     support_visit_limit_private_share:true} → stoken（零 Cookie）
  ② GET drive-pc.quark.cn/1/clouddrive/share/sharepage/detail?pwd_id=&stoken=&ver=2&pr=ucpro
     → data.list 清单（零 Cookie）
错误语义（上游 msg 直读）：提取码错误 / 分享不存在 / 已失效 / 违规。
"""
from __future__ import annotations

import re

from .base import BaseDiscovery, DEntry, DResult


class QuarkDiscovery(BaseDiscovery):
    name = "quark"
    domains = ("pan.quark.cn/s/",)

    def extract_id(self, url: str) -> str:
        m = re.search(r"pan\.quark\.cn/s/([A-Za-z0-9]+)", url)
        return m.group(1) if m else ""

    @staticmethod
    def _verdict(msg: str) -> str:
        if "提取码" in msg or "密码" in msg:
            return "wall:提取码"
        if ("失效" in msg or "不存在" in msg or "取消" in msg or "违规" in msg
                or "封禁" in msg or "受限" in msg):
            return "dead:失效"
        return ""

    @staticmethod
    def _msg(j: dict) -> str:
        return str(j.get("msg") or j.get("message") or "")

    def discover(self, url: str, pwd: str = "") -> DResult:
        r = self._begin(url)
        pwd_id = self.extract_id(url)
        if not pwd_id:
            r.state, r.message = "err:bad_url", "pwd_id 未解析出"
            return self._end(r)

        resp = self.post(
            "https://drive-h.quark.cn/1/clouddrive/share/sharepage/token",
            params={"pr": "ucpro", "fr": "pc"},
            json_body={"pwd_id": pwd_id, "passcode": pwd or "",
                       "support_visit_limit_private_share": True},
            headers={"Referer": "https://pan.quark.cn/", "Origin": "https://pan.quark.cn",
                     "Content-Type": "application/json;charset=UTF-8"})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"token HTTP {resp.status_code}"
            return self._end(r)
        msg = self._msg(j)
        if (j.get("status") not in (200, "200")) or "stoken" not in (j.get("data") or {}):
            v = self._verdict(msg)
            r.state = v or "err:code"
            r.message = f"token status={j.get('status')} code={j.get('code')} {msg[:60]}"
            r.alive = not v.startswith("dead")
            return self._end(r)
        stoken = j["data"]["stoken"]
        r.alive = True
        self._step()

        resp = self.get(
            "https://drive-pc.quark.cn/1/clouddrive/share/sharepage/detail",
            params={"pwd_id": pwd_id, "stoken": stoken, "pr": "ucpro", "fr": "pc",
                    "pdir_fid": 0, "_page": 1, "_size": 100, "_fetch_banner": 0,
                    "_fetch_share": 0, "_fetch_total": 1,
                    "_sort": "file_type:asc,file_name:asc"},
            headers={"Referer": "https://pan.quark.cn/", "Origin": "https://pan.quark.cn"})
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"detail HTTP {resp.status_code}"
            return self._end(r)
        msg = self._msg(j)
        data = j.get("data") or {}
        lst = data.get("list") or data.get("flist") or data.get("obj_list") or []

        def _ent(it) -> DEntry:
            return DEntry(name=it.get("file_name") or it.get("obj_name") or "?",
                          size=int(it.get("size") or 0),
                          is_dir=bool(it.get("dir")),
                          fid=it.get("fid") or "")

        if lst:
            root = [_ent(it) for it in lst]
            r.title = root[0].name
            # 单目录根 → 下钻一层（pdir_fid=目录fid；空层如实记）
            if len(root) == 1 and root[0].is_dir and root[0].fid:
                self._step()
                resp = self.get(
                    "https://drive-pc.quark.cn/1/clouddrive/share/sharepage/detail",
                    params={"pwd_id": pwd_id, "stoken": stoken, "pr": "ucpro",
                            "fr": "pc", "pdir_fid": root[0].fid, "_page": 1,
                            "_size": 100, "_fetch_banner": 0, "_fetch_share": 0,
                            "_fetch_total": 1, "_sort": "file_type:asc,file_name:asc"},
                    headers={"Referer": "https://pan.quark.cn/"})
                try:
                    j2 = resp.json()
                    children = [_ent(it) for it in (j2.get("data") or {}).get("list") or []]
                except Exception:
                    children = []
                if children:
                    r.entries = children
                    r.file_count = len(children)
                    r.message = f"detail 根1目录→下钻 {len(children)} 子项"
                else:
                    r.entries = root
                    r.file_count = 1
                    r.message = "detail 根1目录（下钻空层，如实记）"
            else:
                r.entries = root
                r.file_count = len(root)
                r.message = f"detail 根层 {len(root)} 项"
            r.ok = True
            r.state = "ok"
        else:
            v = self._verdict(msg)
            r.state = v or ("ok(空)" if j.get("status") in (200, "200") else "err:code")
            r.message = f"detail status={j.get('status')} code={j.get('code')} {msg[:60]}"
            if r.state == "ok(空)":
                r.ok = True
        return self._end(r)
