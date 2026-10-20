# -*- coding: utf-8 -*-
"""curl_cffi fetcher for chapter 7 research (impersonate chrome, TLS-WAF-proof)."""
import sys, io, re
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from curl_cffi import requests as creq

def fetch(url, out):
    try:
        r = creq.get(url, impersonate="chrome", timeout=45, headers={"Referer": "https://www.baidu.com/"})
        html = r.text
        open(out, "w", encoding="utf-8", errors="replace").write(html)
        print("OK", len(html), url)
        return html
    except Exception as e:
        print("FAIL", url, repr(e)[:150])
        return ""

if __name__ == "__main__":
    url, out = sys.argv[1], sys.argv[2]
    fetch(url, out)
