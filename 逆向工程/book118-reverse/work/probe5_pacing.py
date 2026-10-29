# -*- coding: utf-8 -*-
"""probe5: SafeLine 468 触发规律 — 礼貌节流(8s)+PHPSESSID 复用下 .shtm 连打 4 发。"""
import ssl
import time
import urllib.error
import urllib.request
from http.cookiejar import CookieJar
from pathlib import Path

CAP = Path(r"E:/AI-Station/逆向工程/book118-reverse/captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/139.0.0.0 Safari/537.36")
ctx = ssl.create_default_context()
jar = CookieJar()
op = urllib.request.build_opener(
    urllib.request.ProxyHandler({}),
    urllib.request.HTTPSHandler(context=ctx),
    urllib.request.HTTPCookieProcessor(jar))

DOCS = ["2026/0722/5011203143013244", "2022/1214/6115103231005025",
        "2017/0418/100821230", "2026/1016/7136131123011161"]

for i, d in enumerate(DOCS):
    u = f"https://max.book118.com/html/{d}.shtm"
    req = urllib.request.Request(u, headers={
        "User-Agent": UA, "Referer": "https://max.book118.com/",
        "Accept": "text/html,application/xhtml+xml,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9", "Connection": "close"})
    t0 = time.monotonic()
    try:
        with op.open(req, timeout=30) as r:
            b = r.read()
            print(f"[{i}] {d} -> {r.status} {len(b)}B {int((time.monotonic()-t0)*1000)}ms "
                  f"cookies={[c.name for c in jar]}")
    except urllib.error.HTTPError as e:
        print(f"[{i}] {d} -> HTTP {e.code} {len(e.read())}B cookies={[c.name for c in jar]}")
    if i < len(DOCS) - 1:
        time.sleep(8.0)
print("done")
