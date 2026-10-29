# -*- coding: utf-8 -*-
"""W1 复测两发: multifile(裸编码重试) + filediff(补齐身份参数仍不带rand) · 2026-10-29"""
import json, re, sys, time
import requests

sys.stdout.reconfigure(encoding="utf-8")

CRED_PATH = r"E:\AI-Station\data\secrets\bdn_credentials.json"
OUT = r"E:\AI-Station\逆向工程\baidu-netdisk\analysis\W1_LIVENESS_RAW.jsonl"
RISK = {31119, 31329, 20012, 31034}

with open(CRED_PATH, "r", encoding="utf-8") as f:
    cred = json.load(f)
H = {
    "Cookie": "BDUSS=%s; STOKEN=%s" % (cred["bduss"], cred["stoken"]),
    "User-Agent": cred["ua_native"],
    "Referer": "https://pan.baidu.com/disk/main",
    "Accept-Encoding": "identity",
}
print("[cred] BDUSS=%s STOKEN=%s" % (cred["bduss"][:8] + "***", cred["stoken"][:8] + "***"), flush=True)

log = []
def shoot(tag, method, url, body=None):
    rec = {"n": 8 if tag.startswith("multifile") else 9, "tag": tag, "method": method, "url": url, "date": "2026-10-29"}
    try:
        if method == "GET":
            r = requests.get(url, headers=H, timeout=20)
        else:
            h = dict(H); h["Content-Type"] = "application/x-www-form-urlencoded"
            r = requests.post(url, headers=h, data=body, timeout=20)
        m = re.search(r'"errno"\s*:\s*(-?\d+)', r.text[:300])
        rec["http"] = r.status_code
        rec["errno"] = int(m.group(1)) if m else None
        rec["head80"] = r.text[:80].replace("\n", " ")
    except Exception as e:
        rec["http"] = "EXC"; rec["errno"] = None
        rec["head80"] = repr(e)[:80]
    log.append(rec)
    print(json.dumps(rec, ensure_ascii=False), flush=True)
    if rec["errno"] in RISK:
        print("[HALT] risk errno %s" % rec["errno"], flush=True)
        log[-1]["halt"] = True
    time.sleep(1.6)

shoot("xpan-multifile-metas-retry", "GET",
      "https://pan.baidu.com/rest/2.0/xpan/multifile?method=metas&fsids=%5B341179797843843%5D&dlink=0")
shoot("filediff-post-fullparams", "POST",
      "https://pan.baidu.com/api/filediff?block_list=1&clienttype=8&channel=00000000000000000000000040000001&version=8.2.5.103&deviceid=152236194638317114&dname=%e6%83%a0%e6%99%ae",
      body="cursor=&action=manual")

with open(OUT, "a", encoding="utf-8") as f:
    for rec in log:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
print("[done] total shots now 9/12", flush=True)
