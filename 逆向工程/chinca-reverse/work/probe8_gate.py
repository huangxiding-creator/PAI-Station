# -*- coding: utf-8 -*-
"""Probe 8: LIVE gate test with realm-aligned Node solver."""
import json, os, re, subprocess
import requests

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP = os.path.join(BASE, "captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

def solve(ch_path):
    p = subprocess.run(["node", os.path.join(BASE, "work", "solver.js"), ch_path],
                       capture_output=True, text=True, timeout=90, cwd=os.path.join(BASE, "work"))
    if p.returncode != 0:
        return {"error": p.stderr[:400]}
    return json.loads(p.stdout.strip().splitlines()[-1])

def attempt(tag, url):
    s = requests.Session()
    s.headers.update({
        "User-Agent": UA,
        "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
        "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
        "Accept-Encoding": "gzip, deflate, br",
        "Connection": "keep-alive",
        "Upgrade-Insecure-Requests": "1",
    })
    r1 = s.get(url, timeout=30)
    if "renderData" not in r1.text:
        return {"tag": tag, "stage": "no-challenge", "len": len(r1.text)}
    ch_path = os.path.join(CAP, f"_p8_{tag}_c1.html")
    with open(ch_path, "w", encoding="utf-8") as f:
        f.write(r1.text)
    sol = solve(ch_path)
    if not sol.get("acw_sc__v2"):
        return {"tag": tag, "stage": "solve-failed", "sol": sol}
    s.cookies.set("acw_sc__v2", sol["acw_sc__v2"], domain=".chinca.org", path="/")
    r2 = s.get(url, timeout=30)
    passed = ("renderData" not in r2.text) and r2.status_code == 200
    out = {"tag": tag, "arg1": sol["arg1"], "acw": sol["acw_sc__v2"],
           "r2_len": len(r2.text), "passed": passed,
           "title": (re.search(r"<title>(.*?)</title>", r2.text, re.S) or [None, "?"])[1][:60]}
    if passed:
        with open(os.path.join(CAP, f"_p8_{tag}_passed.html"), "w", encoding="utf-8") as f:
            f.write(r2.text)
    return out

if __name__ == "__main__":
    print(json.dumps(attempt("g1", "https://www.chinca.org/"), ensure_ascii=False))
    print(json.dumps(attempt("g2", "https://www.chinca.org/"), ensure_ascii=False))
    print(json.dumps(attempt("g3", "https://www.chinca.org/news/"), ensure_ascii=False))
