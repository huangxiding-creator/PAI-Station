# -*- coding: utf-8 -*-
"""Probe 1: fetch fresh challenge pages x3 (independent sessions), dump headers+body for diffing."""
import json, os, sys, time
import requests

CAP = os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "captures")
os.makedirs(CAP, exist_ok=True)

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

URLS = ["https://www.chinca.org/", "http://www.chinca.org/", "https://www.chinca.org/index.html"]

def probe(tag, url, extra_headers=None):
    s = requests.Session()
    s.headers.update({
        "User-Agent": UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1",
    })
    if extra_headers:
        s.headers.update(extra_headers)
    try:
        r = s.get(url, timeout=30, allow_redirects=True)
    except Exception as e:
        return {"tag": tag, "url": url, "error": repr(e)}
    body = r.text
    with open(os.path.join(CAP, f"challenge_{tag}.html"), "w", encoding="utf-8", errors="replace") as f:
        f.write(body)
    meta = {
        "tag": tag, "url": url, "final_url": r.url, "status": r.status_code,
        "history": [(h.status_code, h.headers.get("Location")) for h in r.history],
        "resp_headers": dict(r.headers),
        "len": len(body),
        "has_renderData": "renderData" in body,
        "has_arg1": "arg1" in body,
        "has_acw": "acw" in body.lower(),
        "title_snip": body[:200].replace("\n", " "),
        "set_cookies": r.headers.get("Set-Cookie", ""),
    }
    # extract arg1 if present
    import re
    m = re.search(r"var arg1='([0-9A-Fa-f]+)'", body)
    if m:
        meta["arg1"] = m.group(1)
    return meta

results = []
results.append(probe("h1", "https://www.chinca.org/"))
time.sleep(2)
results.append(probe("h2", "https://www.chinca.org/"))
time.sleep(2)
results.append(probe("h3", "https://www.chinca.org/news/"))
for m in results:
    print(json.dumps(m, ensure_ascii=False, indent=1)[:1200])
    print("-" * 60)
with open(os.path.join(CAP, "probe1_meta.json"), "w", encoding="utf-8") as f:
    json.dump(results, f, ensure_ascii=False, indent=1)
print("DONE")
