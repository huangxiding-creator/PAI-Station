# -*- coding: utf-8 -*-
"""P5: 中文引擎源发现 — ENR 国际承包商250强 榜单转载源"""
import sys, io, json, re, time
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as cr
from urllib.parse import quote

s = cr.Session(impersonate="chrome", timeout=20)
Q = quote("ENR 国际承包商250强 榜单")
ENGINES = [
    ("bing", f"https://cn.bing.com/search?q={Q}&count=20"),
    ("sogou", f"https://www.sogou.com/web?query={Q}"),
    ("so360", f"https://www.so.com/s?q={Q}"),
]
def strip(t): return re.sub(r"<[^>]+>", "", t).strip()
for name, u in ENGINES:
    try:
        r = s.get(u)
        body = r.text
        print(f"\n===== {name} status={r.status_code} size={len(body)} =====")
        open(f"E:/AI-Station/逆向工程/enr-reverse/captures/p5_{name}.html", "w", encoding="utf-8", errors="replace").write(body)
        # 提取结果链接(各引擎通用 h3/h2 内 a)
        for m in re.finditer(r'<h[23][^>]*>\s*<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', body, re.S):
            href, title = m.group(1), strip(m.group(2))
            if title and len(title) > 6:
                print(f"  {title[:60]} | {href[:110]}")
    except Exception as e:
        print(f"{name} ERR {type(e).__name__}: {str(e)[:100]}")
    time.sleep(1.5)
