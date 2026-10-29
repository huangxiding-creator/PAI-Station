# -*- coding: utf-8 -*-
"""Probe 5: TLS hypothesis — curl_cffi (Chrome impersonation) + solved cookie replay."""
import json, os, subprocess
from curl_cffi import requests as creq

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP = os.path.join(BASE, "captures")

def solve(ch_path):
    p = subprocess.run(["node", os.path.join(BASE, "work", "solver.js"), ch_path],
                       capture_output=True, text=True, timeout=60, cwd=os.path.join(BASE, "work"))
    return json.loads(p.stdout.strip().splitlines()[-1])

def attempt(tag, url, impersonate="chrome131"):
    s = creq.Session(impersonate=impersonate)
    r1 = s.get(url, timeout=30)
    body1 = r1.text
    if "renderData" not in body1:
        return {"tag": tag, "stage": "no-challenge", "len": len(body1)}
    ch_path = os.path.join(CAP, f"_p5_{tag}_c1.html")
    with open(ch_path, "w", encoding="utf-8") as f:
        f.write(body1)
    sol = solve(ch_path)
    acw = sol["acw_sc__v2"]
    s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
    r2 = s.get(url, timeout=30)
    body2 = r2.text
    passed = ("renderData" not in body2) and r2.status_code == 200
    out = {"tag": tag, "imp": impersonate, "arg1": sol["arg1"], "acw": acw,
           "r2_len": len(body2), "passed": passed,
           "r2_setcookie": r2.headers.get("set-cookie", "")[:100]}
    if passed:
        with open(os.path.join(CAP, f"_p5_{tag}_passed.html"), "w", encoding="utf-8") as f:
            f.write(body2)
    return out

if __name__ == "__main__":
    for imp in ["chrome131", "chrome124", "safari17_0"]:
        print(json.dumps(attempt(f"tls-{imp}", "https://www.chinca.org/", imp), ensure_ascii=False))
