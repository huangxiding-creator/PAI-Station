# -*- coding: utf-8 -*-
"""People's Daily online search POST client."""
import sys, io, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as creq

url = "http://search.people.cn/search-platform/front/search"
payload = {
    "key": sys.argv[1],
    "page": 1,
    "limit": 20,
    "hasTitle": True,
    "hasContent": True,
    "isFuzzy": True,
    "type": 0,
    "sortType": 2,   # 2 = relevance
    "startTime": 0,
    "endTime": 0,
}
try:
    r = creq.post(url, json=payload, impersonate="chrome", timeout=45,
                  headers={"Referer": "http://search.people.cn/s/?keyword="})
    open("rm1.json", "w", encoding="utf-8").write(r.text)
    d = r.json()
    data = d.get("data") or {}
    recs = data.get("records") or []
    print("total:", data.get("total"))
    import re
    for rec in recs:
        t = re.sub(r"<[^>]+>", "", str(rec.get("title", "")))
        print(t[:70], "||", rec.get("url", ""))
except Exception as e:
    print("FAIL", repr(e)[:200])
