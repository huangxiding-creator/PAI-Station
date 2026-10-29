# -*- coding: utf-8 -*-
"""Probe3: cheap variants to bypass openresty 403 on listresult."""
import requests, urllib.parse, time, io, sys, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
BASE = "https://search.cnki.com.cn"
KW = urllib.parse.quote("国际工程 EPC")

def sess():
    s = requests.Session()
    s.headers.update({"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"})
    r = s.get(BASE + f"/Search/Result?content={KW}", timeout=15)
    return s, r

REF = {"Referer": BASE + f"/Search/Result?content={KW}", "Origin": BASE,
       "X-Requested-With": "XMLHttpRequest",
       "Accept": "application/json, text/javascript, */*; q=0.01"}

cases = [
    ("post_min",  "POST", "/api/search/listresult", {"Content": "国际工程 EPC", "Order": 2, "Page": 1}, True),
    ("post_min_lower", "POST", "/search/listresult", {"Content": "国际工程 EPC", "Order": 2, "Page": 1}, True),
    ("post_articletype", "POST", "/api/search/listresult", {"ArticleType": 0, "Content": "国际工程 EPC", "Order": 2, "Page": 1, "ParamIsNullOrEmpty": False, "Islegal": False}, True),
    ("post_theme", "POST", "/api/search/listresult", {"Theme": "国际工程 EPC", "Order": 2, "Page": 1}, True),
    ("get_query", "GET", "/api/search/listresult", {"Content": "国际工程 EPC", "Order": 2, "Page": 1}, False),
]
for name, method, path, params, form in cases:
    s, _ = sess()
    try:
        if method == "POST":
            r = s.post(BASE + path, data=params, headers=REF, timeout=20)
        else:
            r = s.get(BASE + path, params=params, headers=REF, timeout=20)
        head = r.text[:200].replace("\n", " ") if r.status_code != 200 else r.text[:200].replace("\n", " ")
        print(f"{name}: {r.status_code} len={len(r.content)} :: {head[:180]}")
    except Exception as e:
        print(f"{name}: ERR {e!r}")
    time.sleep(1.0)
