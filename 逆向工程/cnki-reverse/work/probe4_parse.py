# -*- coding: utf-8 -*-
"""Probe4: full capture of /search/listresult HTML + structure analysis."""
import requests, urllib.parse, time, io, sys, re, json
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8')

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")
BASE = "https://search.cnki.com.cn"
KW = "国际工程 EPC"

s = requests.Session()
s.headers.update({"User-Agent": UA, "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8"})
s.get(BASE + "/Search/Result?content=" + urllib.parse.quote(KW), timeout=15)
r = s.post(BASE + "/search/listresult",
           data={"Content": KW, "Order": 2, "Page": 1},
           headers={"Referer": BASE + "/Search/Result?content=" + urllib.parse.quote(KW),
                    "Origin": BASE, "X-Requested-With": "XMLHttpRequest"},
           timeout=25)
html = r.text
open("E:/AI-Station/逆向工程/cnki-reverse/captures/C1_listresult_p1.html", "w", encoding="utf-8").write(html)
print("saved p1, len", len(html), "status", r.status_code)

# parse list items
items = re.findall(r'<div class="list-item">(.*?)(?=<div class="list-item">|<div class="page")', html, re.S)
print("list-item count:", len(items))
def g(pat, h):
    m = re.search(pat, h, re.S)
    return m.group(1).strip() if m else ""

rec = []
for it in items:
    title = re.sub(r"<[^>]+>", "", g(r'<p class="tit clearfix">(.*?)</p>', it)).strip()
    href = g(r'<a[^>]+href="([^"]+)"[^>]*target=_blank', it) or g(r'<a[^>]+href="([^"]+)"', it)
    source = re.sub(r"<[^>]+>", "", g(r'<p class="source">(.*?)</p>', it)).strip()
    rec.append({"title": title[:70], "href": href[:100], "source": source[:80]})
for i, x in enumerate(rec[:6]):
    print(i+1, json.dumps(x, ensure_ascii=False))
print("total parsed:", len(rec))
