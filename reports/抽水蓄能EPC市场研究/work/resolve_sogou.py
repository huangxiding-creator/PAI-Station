# -*- coding: utf-8 -*-
"""Resolve sogou weixin redirect links to real mp.weixin.qq.com URLs."""
import sys, re, time
from curl_cffi import requests

def resolve(link_url):
    try:
        r = requests.get(link_url, impersonate="chrome", timeout=20,
                         headers={"Referer": "https://weixin.sogou.com/"})
        html = r.text
        m = re.search(r"url \+= '([^']+)'\s*;\s*window\.location", html)
        # sogou obfuscated: multiple url+='...' lines then location.href = url
        parts = re.findall(r"url \+= '([^']+)'", html)
        if parts:
            return "".join(parts)
        m2 = re.search(r'(https?://mp\.weixin\.qq\.com/s[^"\']+)', html)
        if m2:
            return m2.group(1)
        if "antispider" in r.url or "antispider" in html[:2000]:
            return "ANTISPIDER"
        return "NO_MATCH:" + r.url[:120]
    except Exception as e:
        return "ERR:" + str(e)[:100]

if __name__ == "__main__":
    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        print(resolve(line))
        time.sleep(1.5)
