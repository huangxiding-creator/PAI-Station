# -*- coding: utf-8 -*-
import sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
from urllib.parse import quote

body = open("E:/AI-Station/逆向工程/enr-reverse/captures/p6_sohu_876711130.html", encoding="utf-8").read()
m = re.search(r'<article[^>]*>(.*?)</article>', body, re.S)
txt = m.group(1) if m else ""
txt = re.sub(r"<[^>]+>", "\n", txt)
lines = [l.strip() for l in txt.split("\n") if l.strip()]
print("sohu article lines:", len(lines))
for l in lines[:30]: print("  ", l[:100])

print("\n=== sogou weixin ===")
s = cr.Session(impersonate="chrome", timeout=20)
r = s.get("https://weixin.sogou.com/weixin?type=2&query=" + quote("ENR 国际承包商250强 完整榜单"))
open("E:/AI-Station/逆向工程/enr-reverse/captures/p6_wxsogou.html", "w", encoding="utf-8", errors="replace").write(r.text)
print("status", r.status_code, "size", len(r.text))
for m in re.finditer(r'<h3[^>]*>.*?<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', r.text, re.S):
    t = re.sub(r"<[^>]+>", "", m.group(2)).strip()
    if t: print("  wx:", t[:60], "|", m.group(1)[:95])
