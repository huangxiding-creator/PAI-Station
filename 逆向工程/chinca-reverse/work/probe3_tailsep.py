# -*- coding: utf-8 -*-
"""Probe 3: which cookie parts does the server validate? Variants: det-tail / random-tail / random-seps / no-arg1-bind."""
import json, os, random, re, string, sys
import requests

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP = os.path.join(BASE, "captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

def headers():
    return {
        "User-Agent": UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1",
    }

def rh(n=10):
    return "".join(random.choice("0123456789abcdef") for _ in range(n))

def attempt(tag, url, acw=None, transform=None):
    s = requests.Session()
    s.headers.update(headers())
    r1 = s.get(url, timeout=30)
    body1 = r1.text
    if "renderData" not in body1:
        return {"tag": tag, "stage": "no-challenge", "len": len(body1)}
    ch_path = os.path.join(CAP, f"_p3_{tag}_challenge.html")
    with open(ch_path, "w", encoding="utf-8") as f:
        f.write(body1)
    if acw is None:
        import subprocess
        p = subprocess.run(["node", os.path.join(BASE, "work", "solver.js"), ch_path, "--det"],
                           capture_output=True, text=True, timeout=60, cwd=os.path.join(BASE, "work"))
        sol = json.loads(p.stdout.strip().splitlines()[-1])
        acw = sol["acw_sc__v2"]
    if transform:
        acw = transform(acw)
    s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
    r2 = s.get(url, timeout=30)
    body2 = r2.text
    passed = ("renderData" not in body2) and r2.status_code == 200
    return {"tag": tag, "acw": acw, "r2_len": len(body2), "passed": passed,
            "title": (re.search(r"<title>(.*?)</title>", body2, re.S) or [None, "?"])[1][:60]}

if __name__ == "__main__":
    # 1. det solver output as-is
    print(json.dumps(attempt("det", "https://www.chinca.org/"), ensure_ascii=False))
    # 2. random tail (last 10)
    print(json.dumps(attempt("rndtail", "https://www.chinca.org/", transform=lambda a: a[:-10] + rh(10)), ensure_ascii=False))
    # 3. random seps: body chars at sep positions (after each 6-char group) replaced
    def rnd_seps(a):
        pfx, body = a.split("-", 1)
        stable, tail = body[:-10], body[-10:]
        out = []
        for i, ch in enumerate(stable):
            # sep positions empirically: idx 6,7,14,15,22,23,30,31 and last two (43,44)
            if i in (6, 7, 14, 15, 22, 23, 30, 31, 43, 44):
                out.append(random.choice("0123456789abcdef"))
            else:
                out.append(ch)
        return pfx + "-" + "".join(out) + tail
    print(json.dumps(attempt("rndseps", "https://www.chinca.org/", transform=rnd_seps), ensure_ascii=False))
    # 4. random BOTH tail and seps
    print(json.dumps(attempt("rndboth", "https://www.chinca.org/",
                             transform=lambda a: rnd_seps(a[:-10] + rh(10))), ensure_ascii=False))
