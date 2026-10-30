# -*- coding: utf-8 -*-
"""百度网盘·发现层（W2 · 2026-10-30）

配方（r3_big4_disks.md A 级 + pansou checkBaidu 逐参实证）：
  ① GET pan.baidu.com/s/1{surl} 页面预热——零凭据匿名 Cookie（BAIDUDID 族）入会话罐；
     实测无此步则 share/list 一律 errno=9019（首轮跑批 9 链实证）
  ② 有码链：POST /share/verify?surl=&pwd=（form pwd/vcode 空）→ randsk
     → 会话罐注入 Cookie BDCLND={randsk}（分享码派生 cookie=公开面，非用户凭据）
  ③ GET /share/list?web=1&...&shorturl={surl}&root=1&clienttype=0
  errno 谱：0=活；-9/-12=码错；-7/105/115/117/145=失效；8001=验证码触发→熔断
"""
from __future__ import annotations

import random
import re
import time

from curl_cffi import requests as creq

from .base import IMPERSONATE, UA, BaseDiscovery, DEntry, DResult

_ERRNO_DEAD = {-7, 105, 115, 117, 145, -21}   # -21=分享已被取消（实测 show_msg「来晚啦」）
_ERRNO_PWD = {-9, -12}


class BaiduDiscovery(BaseDiscovery):
    name = "baidu"
    domains = ("pan.baidu.com/s/", "pan.baidu.com/share/init")

    def extract_id(self, url: str) -> str:
        m = (re.search(r"pan\.baidu\.com/s/(?:1)?([A-Za-z0-9_-]+)", url)
             or re.search(r"[?&]surl=([A-Za-z0-9_-]+)", url))
        return m.group(1) if m else ""

    def discover(self, url: str, pwd: str = "") -> DResult:
        r = self._begin(url)
        surl = self.extract_id(url)
        if not surl:
            r.state, r.message = "err:bad_url", "surl 未解析出"
            return self._end(r)

        sess = creq.Session()                       # 匿名 Cookie 罐（零凭据）
        h = {"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"}

        # ① 分享页预热（收匿名 Cookie；404=链死）
        page = f"https://pan.baidu.com/s/1{surl}"
        self._spend(page)
        resp = sess.get(page, headers=h, impersonate=IMPERSONATE, timeout=20,
                        allow_redirects=True)
        if resp.status_code == 404:
            r.state, r.message = "dead:失效", "分享页 HTTP 404"
            return self._end(r)
        time.sleep(random.uniform(0.8, 1.5))

        # ② 有码链 verify（零 Cookie 表单 → randsk）
        if pwd:
            vurl = "https://pan.baidu.com/share/verify"
            self._spend(vurl)
            resp = sess.post(vurl, params={"surl": surl, "pwd": pwd},
                             data={"pwd": pwd, "vcode": "", "vcode_str": ""},
                             headers={**h, "Referer": page,
                                      "Content-Type": "application/x-www-form-urlencoded"},
                             impersonate=IMPERSONATE, timeout=20)
            try:
                j = resp.json()
            except Exception:
                r.state, r.message = "err:http", f"verify HTTP {resp.status_code}"
                return self._end(r)
            errno = j.get("errno")
            if errno == 8001:
                r.state, r.message = "wall:验证码", "verify errno=8001（软门，熔断不硬闯）"
                r.alive = True
                return self._end(r)
            if errno in _ERRNO_PWD:
                r.state, r.message = "wall:提取码", f"verify errno={errno}（码错）"
                return self._end(r)
            if errno in _ERRNO_DEAD:
                r.state, r.message = "dead:失效", f"verify errno={errno}"
                return self._end(r)
            if errno != 0:
                r.state, r.message = "err:errno", f"verify errno={errno}"
                return self._end(r)
            randsk = j.get("randsk") or ""
            if randsk:
                sess.cookies.set("BDCLND", randsk)
            time.sleep(random.uniform(0.8, 1.5))

        # ③ share/list（会话 Cookie：匿名族[+BDCLND]）
        lurl = "https://pan.baidu.com/share/list"
        self._spend(lurl)
        resp = sess.get(lurl, params={"web": 1, "page": 1, "num": 100,
                                      "order": "time", "desc": 1, "showempty": 0,
                                      "shorturl": surl, "root": 1, "clienttype": 0},
                        headers=h, impersonate=IMPERSONATE, timeout=20)
        try:
            j = resp.json()
        except Exception:
            r.state, r.message = "err:http", f"list HTTP {resp.status_code}"
            return self._end(r)
        errno = j.get("errno")
        if errno == 0:
            lst = j.get("list") or []
            r.entries = [DEntry(name=(it.get("server_filename")
                                       or it.get("path", "?").rsplit("/", 1)[-1]),
                                size=int(it.get("size") or 0),
                                is_dir=bool(int(it.get("isdir") or 0)),
                                fid=str(it.get("fs_id") or it.get("path") or ""))
                         for it in lst]
            r.ok = True
            r.alive = True
            r.file_count = len(r.entries)
            r.state = "ok"
            r.message = f"errno=0 root {r.file_count} 项"
        elif errno == 8001:
            r.state, r.message = "wall:验证码", f"list errno=8001（软门）"
            r.alive = True
        elif errno in _ERRNO_PWD:
            r.state, r.message = "wall:提取码", f"list errno={errno}（需码未带/码错）"
            r.alive = True
        elif errno in _ERRNO_DEAD:
            r.state, r.message = "dead:失效", \
                f"errno={errno} {str(j.get('show_msg') or '')[:40]}".rstrip()
        elif errno == 9019:
            r.state, r.message = "err:errno", "list errno=9019（反爬拦截，本链弃）"
        else:
            r.state, r.message = "err:errno", f"list errno={errno}"
        return self._end(r)
