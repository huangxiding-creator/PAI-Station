# -*- coding: utf-8 -*-
"""P1: curl_cffi chrome 指纹直探 enr.com — 最便宜路径先行"""
import sys, io, json, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cffi_requests

TARGETS = [
    "https://www.enr.com/",
    "https://enr.com/",
    "https://www.enr.com/top-lists/top-600-sourcebook",
    "https://www.enr.com/rankings",
]
IMPS = ["chrome"]  # 最新chrome指纹
MARKERS = ["Just a moment", "cf-chl", "challenge-platform", "turnstile",
           "challenges.cloudflare.com", "cf_clearance", "__cf_bm", "Attention Required"]

def probe(imp):
    out = []
    s = cffi_requests.Session(impersonate=imp, timeout=25)
    for url in TARGETS:
        t0 = time.time()
        try:
            r = s.get(url, allow_redirects=True)
            body = r.text or ""
            hits = [m for m in MARKERS if m.lower() in body.lower()]
            rec = dict(url=url, imp=imp, status=r.status_code,
                       final=str(r.url), http=r.http_version,
                       server=r.headers.get("server"), cf_mitigated=r.headers.get("cf-mitigated"),
                       size=len(r.content), markers=hits, elapsed=round(time.time()-t0, 1),
                       setcookies=[c.split(";")[0][:60] for c in r.headers.get_list("set-cookie")] if hasattr(r.headers, "get_list") else "n/a")
            # 保存前两个样本
            fn = url.replace("https://", "").replace("http://", "").replace("/", "_").replace(".", "-")[:70]
            if r.status_code == 403 or hits:
                open(f"E:/AI-Station/逆向工程/enr-reverse/captures/p1_{fn}_{imp}.html", "w", encoding="utf-8", errors="replace").write(body)
        except Exception as e:
            rec = dict(url=url, imp=imp, error=f"{type(e).__name__}: {e}", elapsed=round(time.time()-t0, 1))
        out.append(rec); print(json.dumps(rec, ensure_ascii=False))
        time.sleep(1.2)
    return out

allout = []
for imp in IMPS:
    allout += probe(imp)
json.dump(allout, open("E:/AI-Station/逆向工程/enr-reverse/work/p1_out.json", "w", encoding="utf-8"), ensure_ascii=False, indent=1)
print("DONE")
