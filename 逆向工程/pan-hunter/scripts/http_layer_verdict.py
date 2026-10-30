# -*- coding: utf-8 -*-
"""HTTP 层定案矩阵：{requests, curl_cffi} x {直连, 代理} 对两个墙源 + 两个变体"""
import sys, time
sys.stdout.reconfigure(encoding="utf-8")
PROXIES = {"http": "http://127.0.0.1:7892", "https": "http://127.0.0.1:7892"}
UA = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

def show(tag, res):
    if isinstance(res, Exception):
        print(f"  {tag:28s} -> EXC {type(res).__name__}: {str(res)[:60]}")
    else:
        print(f"  {tag:28s} -> {res[0]} len={res[1]}")

def try_req(url, hdrs, proxies=None, data=None):
    import requests
    r = requests.post(url, data=data, headers=hdrs, proxies=proxies, timeout=12) if data else requests.get(url, headers=hdrs, proxies=proxies, timeout=12)
    return (r.status_code, len(r.content))

def try_cffi(url, hdrs, proxies=None, data=None, **kw):
    from curl_cffi import requests as creq
    if data:
        r = creq.post(url, data=data, headers=hdrs, proxies=proxies, timeout=12, impersonate="chrome124", **kw)
    else:
        r = creq.get(url, headers=hdrs, proxies=proxies, timeout=12, impersonate="chrome124", **kw)
    return (r.status_code, len(r.content))

yunso = ("https://www.yunso.net/api/Core/search2", {"User-Agent": UA, "Referer": "https://www.yunso.net/"}, {"wd": "民法典", "page": 1, "limit": 10})
pans = ("https://www.pansearch.me/search?keyword=%E6%B0%91%E6%B3%95%E5%85%B8", {"User-Agent": UA}, None)
for name, (url, hdrs, data) in [("yunso", yunso), ("pansearch", pans)]:
    print(f"[{name}]")
    for tag, fn, px in [("requests+直连", try_req, None), ("requests+代理", try_req, PROXIES),
                        ("curl_cffi+直连", try_cffi, None), ("curl_cffi+代理", try_cffi, PROXIES)]:
        try: show(tag, fn(url, hdrs, px, data))
        except Exception as e: show(tag, e)
        time.sleep(2)

print("[haisou 变体]")
from curl_cffi import requests as creq
try:
    r = creq.get("https://haisou.cc/api/pan/share/search?query=%E6%B0%91%E6%B3%95%E5%85%B8&scope=title&page=1",
                 headers={"User-Agent": UA}, timeout=12, impersonate="chrome124", proxies=PROXIES, http_version="v1")
    print(f"  proxy+cffi+http1.1          -> {r.status_code} len={len(r.content)} | {r.text[:60]}")
except Exception as e: print(f"  proxy+cffi+http1.1          -> EXC {type(e).__name__}: {str(e)[:60]}")
time.sleep(2)
try:
    r = creq.post("https://v.funletu.com/search", json={"params": {"searchtext": "民法典"}, "page": {"pageSize": 10, "pageIndex": 1}, "order": {"prop": "", "order": ""}},
                  headers={"User-Agent": UA, "Referer": "https://pan.funletu.com/"}, timeout=12, impersonate="chrome124", proxies=PROXIES, verify=False)
    print(f"  funletu proxy+cffi+noVerify -> {r.status_code} len={len(r.content)} | {r.text[:60]}")
except Exception as e: print(f"  funletu proxy+cffi+noVerify -> EXC {type(e).__name__}: {str(e)[:60]}")
