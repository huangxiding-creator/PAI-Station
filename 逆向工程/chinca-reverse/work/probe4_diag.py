# -*- coding: utf-8 -*-
"""Probe 4: diagnose r2 — save body, compare markers; try with full Chrome nav headers."""
import json, os, re, subprocess
import requests

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP = os.path.join(BASE, "captures")

FULL_CHROME_HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.7",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
    "Accept-Encoding": "gzip, deflate, br",
    "Cache-Control": "no-cache",
    "Pragma": "no-cache",
    "sec-ch-ua": '"Google Chrome";v="131", "Chromium";v="131", "Not_A Brand";v="24"',
    "sec-ch-ua-mobile": "?0",
    "sec-ch-ua-platform": '"Windows"',
    "Sec-Fetch-Dest": "document",
    "Sec-Fetch-Mode": "navigate",
    "Sec-Fetch-Site": "none",
    "Sec-Fetch-User": "?1",
    "Upgrade-Insecure-Requests": "1",
    "Connection": "keep-alive",
}

def solve(ch_path):
    p = subprocess.run(["node", os.path.join(BASE, "work", "solver.js"), ch_path, "--det"],
                       capture_output=True, text=True, timeout=60, cwd=os.path.join(BASE, "work"))
    return json.loads(p.stdout.strip().splitlines()[-1])

def attempt(tag, url, nav_headers_on_reload=True):
    s = requests.Session()
    s.headers.update(FULL_CHROME_HEADERS)
    if nav_headers_on_reload:
        s.headers["Sec-Fetch-Site"] = "same-origin"  # reload is same-origin nav
    r1 = s.get(url, timeout=30)
    body1 = r1.text
    ch_path = os.path.join(CAP, f"_p4_{tag}_c1.html")
    with open(ch_path, "w", encoding="utf-8") as f:
        f.write(body1)
    sol = solve(ch_path)
    acw = sol["acw_sc__v2"]
    s.cookies.set("acw_sc__v2", acw, domain=".chinca.org", path="/")
    r2 = s.get(url, timeout=30)
    body2 = r2.text
    with open(os.path.join(CAP, f"_p4_{tag}_c2.html"), "w", encoding="utf-8") as f:
        f.write(body2)
    def markers(b):
        return {
            "len": len(b),
            "arg1": (re.search(r"arg1='([0-9A-Fa-f]+)'", b) or [None, None])[1],
            "has_bb_meta": 'aliyun_waf_bb' in b,
            "has_aa_meta": 'aliyun_waf_aa' in b,
            "has_blob": 'aliyunwaf_c' in b,
            "set_cookie2": r2.headers.get("Set-Cookie", "")[:80] if b is body2 else "",
        }
    return {
        "tag": tag, "arg1_c1": sol["arg1"], "acw": acw,
        "c1": markers(body1), "c2": markers(body2),
        "same_challenge_script": None,
        "passed": "renderData" not in body2,
        "c2_status": r2.status_code,
    }

if __name__ == "__main__":
    print(json.dumps(attempt("nav", "https://www.chinca.org/"), ensure_ascii=False, indent=1))
