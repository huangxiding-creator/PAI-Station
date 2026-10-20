# -*- coding: utf-8 -*-
"""Fetch URL with curl_cffi chrome impersonation, print text-extracted content."""
import sys, re
from curl_cffi import requests
from html import unescape

def textify(html):
    html = re.sub(r'<script.*?</script>', ' ', html, flags=re.S|re.I)
    html = re.sub(r'<style.*?</style>', ' ', html, flags=re.S|re.I)
    txt = re.sub(r'<[^>]+>', ' ', html)
    txt = unescape(txt)
    txt = re.sub(r'\s+', ' ', txt)
    return txt

if __name__ == "__main__":
    url = sys.argv[1]
    maxlen = int(sys.argv[2]) if len(sys.argv) > 2 else 6000
    r = requests.get(url, impersonate="chrome", timeout=25)
    print("STATUS", r.status_code, "FINAL_URL", r.url[:150])
    print(textify(r.text)[:maxlen])
