# -*- coding: utf-8 -*-
"""Fetch rm article, print title + paragraphs containing key figures."""
import sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as creq

KEYS = ["投资", "亿", "装机", "千瓦", "造价", "水头", "机组", "年", "移民", "征地", "利息", "亿元"]
url = sys.argv[1]
try:
    r = creq.get(url, impersonate="chrome", timeout=45)
    h = r.text
except Exception as e:
    print("FAIL", url, repr(e)[:120]); sys.exit()
m = re.search(r"<title>(.*?)</title>", h, re.S)
title = m.group(1).strip() if m else "?"
print("=" * 8, title[:70], "||", url)
i = max(h.find('rm_txt'), h.find('show_text'), h.find('article-content'))
if i < 0:
    i = h.find('<body')
seg = h[i:i + 20000]
paras = [re.sub(r"<[^>]+>", "", p).strip() for p in re.findall(r"<p[^>]*>(.*?)</p>", seg, re.S)]
for t in paras:
    if len(t) > 20 and any(k in t for k in KEYS):
        print(t[:400])
