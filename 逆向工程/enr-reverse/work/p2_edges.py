# -*- coding: utf-8 -*-
"""P2: 免挑战边门端点盘点 (robots/sitemap/rss/api) + Wayback 原文镜像通道"""
import sys, io, json, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cr

s = cr.Session(impersonate="chrome", timeout=25)
EDGES = [
    "https://www.enr.com/robots.txt",
    "https://www.enr.com/sitemap.xml",
    "https://www.enr.com/rss",
    "https://www.enr.com/feed",
    "https://www.enr.com/cdn-cgi/challenge-platform/h/b/orchestrate/chl_page/v1?ray=deadbeef00000000",
]
out=[]
for u in EDGES:
    t0=time.time()
    try:
        r = s.get(u)
        body = r.text or ""
        jam = "challenge" if ("Just a moment" in body or "cf-mitigated" in str(r.headers)) else "clean"
        rec = dict(url=u, status=r.status_code, jam=jam, size=len(r.content), ctype=r.headers.get("content-type","")[:40], elapsed=round(time.time()-t0,1), head=body[:180].replace("\n"," "))
        if u.endswith("robots.txt") and r.status_code==200:
            open("E:/AI-Station/逆向工程/enr-reverse/captures/p2_robots.txt","w",encoding="utf-8",errors="replace").write(body)
        if "sitemap" in u and r.status_code==200:
            open("E:/AI-Station/逆向工程/enr-reverse/captures/p2_sitemap.xml","w",encoding="utf-8",errors="replace").write(body[:200000])
    except Exception as e:
        rec = dict(url=u, error=f"{type(e).__name__}: {str(e)[:120]}", elapsed=round(time.time()-t0,1))
    out.append(rec); print(json.dumps(rec, ensure_ascii=False)[:400]); time.sleep(1)

# Wayback 可用性
for u in ["http://archive.org/wayback/available?url=www.enr.com/top-lists/top-250-international-contractors",
          "https://web.archive.org/cdx/search/cdx?url=enr.com/top-lists/top-250-international-contractors*&output=json&limit=15&filter=statuscode:200&collapse=urlkey"]:
    t0=time.time()
    try:
        r = s.get(u, timeout=40)
        rec = dict(url=u[:110], status=r.status_code, size=len(r.content), elapsed=round(time.time()-t0,1), head=(r.text or "")[:300].replace("\n"," "))
    except Exception as e:
        rec = dict(url=u[:110], error=f"{type(e).__name__}: {str(e)[:120]}", elapsed=round(time.time()-t0,1))
    out.append(rec); print(json.dumps(rec, ensure_ascii=False)[:400])
json.dump(out, open("E:/AI-Station/逆向工程/enr-reverse/work/p2_out.json","w",encoding="utf-8"), ensure_ascii=False, indent=1)
print("DONE")
