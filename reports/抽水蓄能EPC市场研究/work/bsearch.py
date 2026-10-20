# -*- coding: utf-8 -*-
"""Baidu desktop search via curl_cffi chrome impersonation."""
import sys, re, json
from curl_cffi import requests
from html import unescape

def search(q):
    r = requests.get("https://www.baidu.com/s", params={"wd": q, "rn": "20"},
                     impersonate="chrome", timeout=20)
    html = r.text
    out = []
    # result blocks: <h3 class="c-title..."><a href="http://www.baidu.com/link?url=..." ...>title</a>
    for m in re.finditer(r'<h3[^>]*>\s*<a[^>]+href="([^"]+)"[^>]*>(.*?)</a>', html, re.S):
        url, title = m.group(1), re.sub(r'<[^>]+>', '', m.group(2)).strip()
        if title:
            out.append({"title": unescape(title), "url": unescape(url)})
    return out, html

if __name__ == "__main__":
    q = sys.argv[1]
    out, html = search(q)
    print(json.dumps(out, ensure_ascii=False, indent=1)[:4000])
