# -*- coding: utf-8 -*-
"""指纹矩阵：不同 impersonate 目标 × HTTP 版本 对 CF 墙源"""
import sys, time
sys.stdout.reconfigure(encoding="utf-8")
from curl_cffi import requests as creq

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
CASES = [
    ("yiso", "https://yiso.fun/api/search?name=%E6%B0%91%E6%B3%95%E5%85%B8&from=ali", {"User-Agent": UA, "Referer": "https://yiso.fun/"}),
    ("haisou", "https://haisou.cc/api/pan/share/search?query=%E6%B0%91%E6%B3%95%E5%85%B8&scope=title&page=1", {"User-Agent": UA, "Referer": "https://haisou.cc/"}),
]
TARGETS = [("chrome124", None), ("chrome131", None), ("safari17_0", None), ("chrome124", "v1")]
for name, url, hdrs in CASES:
    for imp, hv in TARGETS:
        kw = dict(headers=hdrs, timeout=12, impersonate=imp)
        if hv: kw["http_version"] = hv
        tag = f"{imp}" + (f"+{hv}" if hv else "")
        try:
            t0 = time.time()
            r = creq.get(url, **kw)
            body = r.text[:60].replace("\n", " ")
            print(f"[{name}] {tag:16s} -> {r.status_code} len={len(r.content)} {time.time()-t0:.1f}s | {body}")
        except Exception as e:
            print(f"[{name}] {tag:16s} -> EXC {type(e).__name__}: {str(e)[:70]}")
        time.sleep(2)
