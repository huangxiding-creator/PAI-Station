# -*- coding: utf-8 -*-
"""flows.jsonl 聚合: 端点表 / UA 集 / 凭据字段 / 场景对照"""
import json, sys, re
from collections import Counter, defaultdict
from urllib.parse import urlsplit, parse_qsl

FLOWS = r"E:\AI-Station\逆向工程\baidu-netdisk\captures\flows.jsonl"

rows = []
with open(FLOWS, encoding="utf-8") as f:
    for line in f:
        line = line.strip()
        if not line:
            continue
        try:
            rows.append(json.loads(line))
        except Exception as e:
            print("BADLINE:", repr(e), line[:100], file=sys.stderr)

print(f"TOTAL_FLOWS={len(rows)}")
print("\n== HOSTS ==")
for h, c in Counter(r.get("host") for r in rows).most_common():
    print(f"{c:5d}  {h}")

print("\n== ENDPOINTS (host+method+path) ==")
ep = Counter()
ep_meta = {}
for r in rows:
    key = (r.get("host"), r.get("method"), (r.get("path") or "").split("?")[0])
    ep[key] += 1
    q = (r.get("path") or "")
    qs = q.split("?", 1)[1] if "?" in q else ""
    qkeys = tuple(sorted({k for k, _ in parse_qsl(qs, keep_blank_values=True)}))
    st = r.get("status")
    m = ep_meta.setdefault(key, {"qkeys": set(), "status": Counter(), "ua": set(), "qsample": ""})
    m["qkeys"].update(qkeys)
    m["status"][st] += 1
    if qs and not m["qsample"]:
        m["qsample"] = qs[:300]
    ua = (r.get("req_headers") or {}).get("User-Agent")
    if isinstance(ua, list):
        ua = ua[0] if ua else None
    if ua:
        m["ua"].add(ua)
for (h, meth, path), c in ep.most_common(80):
    m = ep_meta[(h, meth, path)]
    sts = ",".join(f"{k}:{v}" for k, v in m["status"].most_common())
    uas = " || ".join(sorted(m["ua"]))
    print(f"\n{c:4d}x {meth} {h}{path}  [{sts}]")
    print(f"     qkeys: {','.join(sorted(m['qkeys']))[:400]}")
    if uas:
        print(f"     UA: {uas[:220]}")
    if m["qsample"]:
        print(f"     qsample: {m['qsample'][:260]}")

print("\n== DISTINCT UAs ==")
uac = Counter()
for r in rows:
    ua = (r.get("req_headers") or {}).get("User-Agent")
    if isinstance(ua, list):
        ua = ua[0] if ua else None
    if ua:
        uac[ua] += 1
for ua, c in uac.most_common():
    print(f"{c:5d}  {ua}")

print("\n== MASKED (credential) markers seen ==")
mk = Counter()
for r in rows:
    for k, v in (r.get("req_headers") or {}).items():
        if isinstance(v, str) and v.startswith("<MASKED"):
            mk[f"header:{k}"] += 1
    q = r.get("path") or ""
    for mm in re.finditer(r"<MASKED ([A-Za-z0-9_\-]+) len=(\d+) head8=([^\s>]+)>", q):
        mk[f"query:{mm.group(1)}(len{mm.group(2)},h8={mm.group(3)})"] += 1
    for mm in re.finditer(r"<MASKED ([A-Za-z0-9_\-]+) len=(\d+) head8=([^\s>]+)>", r.get("req_body") or ""):
        mk[f"body:{mm.group(1)}(len{mm.group(2)},h8={mm.group(3)})"] += 1
for k, c in mk.most_common(50):
    print(f"{c:5d}  {k}")

print("\n== resp content-type (top) ==")
ct = Counter()
for r in rows:
    b = r.get("resp_body") or ""
    ct["json" if b.lstrip()[:1] in ("{", "[") else "other/empty"] += 1
print(dict(ct))
