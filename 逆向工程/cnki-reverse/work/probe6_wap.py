# -*- coding: utf-8 -*-
"""Probe6: check wap touch detail page for longer abstract."""
import requests, re, io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')
UA = ("Mozilla/5.0 (iPhone; CPU iPhone OS 16_6 like Mac OS X) AppleWebKit/605.1.15 "
      "(KHTML, like Gecko) Version/16.6 Mobile/15E148 Safari/604.1")
s = requests.Session(); s.headers.update({"User-Agent": UA})
cands = [
    "https://wap.cnki.net/touch/web/Article/ArticleDetail?dbname=CJFDLAST2026&filename=CWJC202620004",
    "https://wap.cnki.net/touch/web/Journal/Article/ArticleDetail?dbname=CJFDLAST2026&filename=CWJC202620004",
]
for u in cands:
    try:
        r = s.get(u, timeout=15, allow_redirects=False)
        print(r.status_code, len(r.content), r.headers.get("Location", "")[:80], u[25:80])
        if r.status_code == 200 and len(r.content) > 5000:
            t = re.sub(r"<[^>]+>", " ", r.text); t = re.sub(r"\s+", " ", t)
            i = t.find("摘要")
            print("abs:", t[i:i+400] if i > 0 else "not found")
    except Exception as e:
        print("ERR", repr(e)[:120])
