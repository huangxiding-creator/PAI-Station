# -*- coding: utf-8 -*-
"""Fetch a peoples.com.cn article and dump clean text."""
import sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as creq

url, out = sys.argv[1], sys.argv[2]
r = creq.get(url, impersonate="chrome", timeout=45)
h = r.text
open(out, "w", encoding="utf-8", errors="replace").write(h)
# title
m = re.search(r"<title>(.*?)</title>", h, re.S)
print("TITLE:", m.group(1).strip() if m else "?")
# body: rm articles use <p> in div.rm_txt_con
body = ""
mb = re.search(r'class="rm_txt_con[^"]*"[^>]*>(.*?)</div>', h, re.S)
if not mb:
    mb = re.search(r'<div[^>]*class="show_text[^"]*"[^>]*>(.*?)</div>', h, re.S)
if mb:
    paras = re.findall(r"<p[^>]*>(.*?)</p>", mb.group(1), re.S)
    body = "\n".join(re.sub(r"<[^>]+>", "", p).strip() for p in paras)
else:
    # fallback: all <p>
    paras = re.findall(r"<p[^>]*>(.*?)</p>", h, re.S)
    body = "\n".join(re.sub(r"<[^>]+>", "", p).strip() for p in paras if len(p) > 30)
print(body[:6000])
