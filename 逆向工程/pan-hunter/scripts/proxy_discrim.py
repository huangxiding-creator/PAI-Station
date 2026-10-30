# -*- coding: utf-8 -*-
"""路径判别：被墙源走代理探活——区分 站死 vs 直连被墙 vs CF质询"""
import sys, time
sys.stdout.reconfigure(encoding="utf-8")
from curl_cffi import requests as creq
PROXIES = {"http": "http://127.0.0.1:7892", "https": "http://127.0.0.1:7892"}
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
CASES = [
    ("yiso",    "https://yiso.fun/api/search?name=%E6%B0%91%E6%B3%95%E5%85%B8&from=ali", {"User-Agent": UA, "Referer": "https://yiso.fun/"}),
    ("haisou",  "https://haisou.cc/api/pan/share/search?query=%E6%B0%91%E6%B3%95%E5%85%B8&scope=title&page=1", {"User-Agent": UA}),
    ("funletu", "https://v.funletu.com/search", None),  # POST below
    ("pansearch", "https://www.pansearch.me/search?keyword=%E6%B0%91%E6%B3%95%E5%85%B8", {"User-Agent": UA}),
    ("yunso",   "https://www.yunso.net/api/Core/search2", None),
]
import json as J
for name, url, hdrs in CASES:
    try:
        t0 = time.time()
        if name == "funletu":
            r = creq.post(url, json={"params": {"searchtext": "民法典"}, "page": {"pageSize": 10, "pageIndex": 1}, "order": {"prop": "", "order": ""}},
                          headers={"User-Agent": UA, "Referer": "https://pan.funletu.com/"}, timeout=15, impersonate="chrome124", proxies=PROXIES)
        elif name == "yunso":
            r = creq.post(url, data={"wd": "民法典", "mode": "", "scope_content": "", "stype": "", "uk": "", "page": 1, "limit": 10, "screen_filetype": ""},
                          headers={"User-Agent": UA, "Referer": "https://www.yunso.net/"}, timeout=15, impersonate="chrome124", proxies=PROXIES)
        else:
            r = creq.get(url, headers=hdrs, timeout=15, impersonate="chrome124", proxies=PROXIES)
        ct = r.headers.get("content-type", "")
        print(f"[{name}] proxy+cffi -> {r.status_code} len={len(r.content)} ct={ct[:40]} {time.time()-t0:.1f}s | {r.text[:80].replace(chr(10),' ')}")
    except Exception as e:
        print(f"[{name}] proxy+cffi -> EXC {type(e).__name__}: {str(e)[:70]}")
    time.sleep(2)
