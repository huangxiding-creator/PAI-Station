# -*- coding: utf-8 -*-
"""W0 HTTP 层定案证据：requests(裸) vs curl_cffi(impersonate=chrome) 对 CF 墙源对照"""
import sys, time
sys.stdout.reconfigure(encoding="utf-8")

def req_probe(url, headers):
    import requests
    try:
        t0 = time.time()
        r = requests.get(url, headers=headers, timeout=15)
        return f"{r.status_code} len={len(r.content)} {time.time()-t0:.1f}s"
    except Exception as e:
        return f"EXC {type(e).__name__}: {str(e)[:80]}"

def cffi_probe(url, headers):
    from curl_cffi import requests as creq
    try:
        t0 = time.time()
        r = creq.get(url, headers=headers, timeout=15, impersonate="chrome")
        return f"{r.status_code} len={len(r.content)} {time.time()-t0:.1f}s"
    except Exception as e:
        return f"EXC {type(e).__name__}: {str(e)[:80]}"

UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"
CASES = [
    ("yiso(CF-403墙)", "https://yiso.fun/api/search?name=%E6%B0%91%E6%B3%95%E5%85%B8&from=ali",
     {"User-Agent": UA, "Referer": "https://yiso.fun/"}),
    ("haisou(TLS-reset墙)", "https://haisou.cc/api/pan/share/search?query=%E6%B0%91%E6%B3%95%E5%85%B8&scope=title&page=1",
     {"User-Agent": UA, "Referer": "https://haisou.cc/"}),
]
for name, url, hdrs in CASES:
    print(f"[{name}] requests : {req_probe(url, hdrs)}")
    print(f"[{name}] curl_cffi: {cffi_probe(url, hdrs)}")
    time.sleep(2)
