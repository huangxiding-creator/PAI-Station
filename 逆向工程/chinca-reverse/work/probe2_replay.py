# -*- coding: utf-8 -*-
"""Probe 2: full pass-the-gate test — fresh session, solve challenge in Node, replay cookie, check real content."""
import json, os, re, subprocess, sys, tempfile
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

def solve_node(challenge_html_path, arg1=None):
    cmd = ["node", os.path.join(BASE, "work", "solver.js"), challenge_html_path]
    if arg1:
        cmd.append(arg1)
    p = subprocess.run(cmd, capture_output=True, text=True, timeout=60,
                       cwd=os.path.join(BASE, "work"))
    if p.returncode != 0:
        return {"error": p.stderr[:500]}
    return json.loads(p.stdout.strip().splitlines()[-1])

def attempt(tag, url, tail_mode=None):
    """tail_mode: None=solver output; 'random'=replace tail 10 chars with random hex"""
    s = requests.Session()
    s.headers.update(headers())
    r1 = s.get(url, timeout=30)
    body1 = r1.text
    if "renderData" not in body1:
        return {"tag": tag, "stage": "no-challenge", "status": r1.status_code, "len": len(body1),
                "title": re.search(r"<title>(.*?)</title>", body1, re.S).group(1)[:60] if "<title>" in body1 else body1[:80]}
    ch_path = os.path.join(CAP, f"replay_{tag}_challenge.html")
    with open(ch_path, "w", encoding="utf-8") as f:
        f.write(body1)
    sol = solve_node(ch_path)
    if not sol.get("acw_sc__v2"):
        return {"tag": tag, "stage": "solve-failed", "sol": sol}
    acw = sol["acw_sc__v2"]
    if tail_mode == "random":
        import random
        acw = acw[:-10] + "".join(random.choice("0123456789abcdef") for _ in range(10))
    s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
    r2 = s.get(url, timeout=30)
    body2 = r2.text
    passed = ("renderData" not in body2) and r2.status_code == 200
    result = {
        "tag": tag, "url": url, "tail_mode": tail_mode,
        "arg1": sol["arg1"], "acw": acw,
        "r2_status": r2.status_code, "r2_len": len(body2), "passed": passed,
        "title": (re.search(r"<title>(.*?)</title>", body2, re.S) or [None, ""])[1][:80],
    }
    if passed:
        with open(os.path.join(CAP, f"replay_{tag}_passed.html"), "w", encoding="utf-8") as f:
            f.write(body2)
    return result

if __name__ == "__main__":
    print(json.dumps(attempt("t1", "https://www.chinca.org/"), ensure_ascii=False))
    print(json.dumps(attempt("t2", "https://www.chinca.org/", tail_mode="random"), ensure_ascii=False))
    print(json.dumps(attempt("t3", "https://www.chinca.org/news/"), ensure_ascii=False))
