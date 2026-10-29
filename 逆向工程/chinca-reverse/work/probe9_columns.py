# -*- coding: utf-8 -*-
"""Probe 9: column list pages + article detail DOM contract (one solved session)."""
import io, json, os, re, subprocess, sys
import requests
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')

BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
CAP = os.path.join(BASE, "captures")
UA = ("Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 "
      "(KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36")

COLS = [
    ("notice", "https://www.chinca.org/CICA/Notice/List"),
    ("industry", "https://www.chinca.org/CICA/Industrynews/List"),
    ("member", "https://www.chinca.org/CICA/Memberdynamics/List"),
    ("coc", "https://www.chinca.org/CICA/COCNews/List"),
    ("intl", "https://www.chinca.org/CICA/InternationalContractors/List"),
    ("stats", "https://www.chinca.org/CICA/StatisticalAnalysis/List/Sa"),
    ("research", "https://www.chinca.org/CICA/reserrch/List"),
    ("project", "https://www.chinca.org/CICA/Projectinfo/List"),
]

def solve(ch_path):
    p = subprocess.run(["node", os.path.join(BASE, "work", "solver.js"), ch_path],
                       capture_output=True, text=True, timeout=90, cwd=os.path.join(BASE, "work"))
    return json.loads(p.stdout.strip().splitlines()[-1])

s = requests.Session()
s.headers.update({
    "User-Agent": UA,
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "zh-CN,zh;q=0.9,en;q=0.8",
    "Accept-Encoding": "gzip, deflate, br",
    "Upgrade-Insecure-Requests": "1",
})
r = s.get("https://www.chinca.org/", timeout=30)
if "renderData" in r.text:
    ch = os.path.join(CAP, "_p9_challenge.html")
    open(ch, "w", encoding="utf-8").write(r.text)
    sol = solve(ch)
    s.cookies.set("acw_sc__v2", sol["acw_sc__v2"], domain=".chinca.org", path="/")
    r2 = s.get("https://www.chinca.org/", timeout=30)
    print("gate:", "PASS" if "renderData" not in r2.text else "FAIL")

for tag, url in COLS:
    try:
        rr = s.get(url, timeout=30)
    except Exception as e:
        print(tag, url, "ERR", e); continue
    body = rr.text
    gated = "renderData" in body
    with open(os.path.join(CAP, f"_p9_col_{tag}.html"), "w", encoding="utf-8") as f:
        f.write(body)
    items = re.findall(r'<a[^>]+href="(/CICA/info/\d+)"[^>]*>(.*?)</a>', body, re.S)
    dates = re.findall(r'(20\d{2}-\d{2}-\d{2})', body)
    title_tag = (re.search(r'<title>(.*?)</title>', body, re.S) or [None, "?"])[1]
    print(f"{tag:10s} status={rr.status_code} gated={gated} len={len(body)} items={len(items)} dates={len(dates)} title={title_tag[:30]}")
    if items:
        t0 = re.sub(r'<[^>]+>', '', items[0][1]).strip()[:40]
        print(f"           first: {items[0][0]} | {t0}")

# article detail
art = "https://www.chinca.org/CICA/info/26102016045611"
rr = s.get(art, timeout=30)
with open(os.path.join(CAP, "_p9_article.html"), "w", encoding="utf-8") as f:
    f.write(rr.text)
print("article:", rr.status_code, len(rr.text), "gated:", "renderData" in rr.text)
mt = re.search(r'<title>(.*?)</title>', rr.text, re.S)
print("article title:", mt and mt.group(1))
