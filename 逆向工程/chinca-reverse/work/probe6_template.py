# -*- coding: utf-8 -*-
"""Probe 6: what does the server actually verify? Template/random-body tests against live gate."""
import json, os, random, re
import requests

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CHROME_R1 = "439554356d56edc507dffafa018b62584488d8806e4d2d295c"  # Chrome fixture body (arg1=5df6...322)
CHROME_R2 = "a688d0d56ff56807538084b545ea34415d9c28fd6461457112"

UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

def attempt(tag, body_fn):
    s = requests.Session()
    s.headers.update({
        "User-Agent": UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
        "Accept-Encoding": "gzip, deflate, br",
        "Upgrade-Insecure-Requests": "1",
    })
    r1 = s.get("https://www.chinca.org/", timeout=30)
    if "renderData" not in r1.text:
        return {"tag": tag, "no_challenge": True, "len": len(r1.text)}
    m = re.search(r"arg1='([0-9A-Fa-f]+)'", r1.text)
    live_arg1 = m.group(1)
    acw = body_fn(live_arg1)
    s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
    r2 = s.get("https://www.chinca.org/", timeout=30)
    passed = ("renderData" not in r2.text) and r2.status_code == 200
    return {"tag": tag, "live_arg1": live_arg1, "acw": acw,
            "r2_len": len(r2.text), "passed": passed,
            "title": (re.search(r"<title>(.*?)</title>", r2.text, re.S) or [None, "?"])[1][:50]}

def rh(n):
    return "".join(random.choice("0123456789abcdef") for _ in range(n))

tests = [
    ("chrome_r1_template", lambda a: "1234cf0d46-" + CHROME_R1),
    ("rand50", lambda a: "1234cf0d46-" + rh(50)),
    ("chrome_r2_template", lambda a: "1234cf0d46-" + CHROME_R2),
]
for tag, fn in tests:
    print(json.dumps(attempt(tag, fn), ensure_ascii=False))
