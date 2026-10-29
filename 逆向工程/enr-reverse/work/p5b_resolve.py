# -*- coding: utf-8 -*-
"""P5b: 解析搜狗跳转 + 追查2025版"""
import sys, io, json, re, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
from urllib.parse import quote

s = cr.Session(impersonate="chrome", timeout=20)
# 1) 解析 p5 已存搜狗页里的 /link 跳转
body = open("E:/AI-Station/逆向工程/enr-reverse/captures/p5_sogou.html", encoding="utf-8").read()
links = re.findall(r'href="(/link\?url=[^"]+)"[^>]*>(.*?)</a>', body)
seen = set()
print("=== 解析跳转 ===")
for href, title in links:
    t = re.sub(r"<[^>]+>", "", title).strip()
    if len(t) < 8 or href in seen: continue
    seen.add(href)
    try:
        r = s.get("https://www.sogou.com" + href.replace("&amp;", "&"))
        m = re.search(r'window\.location\.replace\("([^"]+)"\)', r.text) or re.search(r'URL=\'?([^\'">]+)', r.text)
        real = m.group(1) if m else "?"
        print(f"  {t[:46]} => {real[:120]}")
    except Exception as e:
        print(f"  {t[:46]} => ERR {str(e)[:60]}")
    time.sleep(0.8)
# 2) 2025 版查询
print("\n=== 2025版查询 ===")
for q in ["ENR 250强 2025 国际承包商 完整榜单", "2025 ENR Top 250 International Contractors 名单"]:
    r = s.get(f"https://www.sogou.com/web?query={quote(q)}")
    for m in re.finditer(r'<h[23][^>]*>\s*<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', r.text, re.S):
        t = re.sub(r"<[^>]+>", "", m.group(2)).strip()
        if len(t) > 8: print(f"  {t[:56]} | {m.group(1)[:100]}")
    time.sleep(1.5)
