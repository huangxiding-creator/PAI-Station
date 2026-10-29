# -*- coding: utf-8 -*-
"""BDPAN-FACTORY W1 只读活性普查 · 2026-10-29
铁律: 只读 / 总预算<=12发 / 间隔>=1.5s / 凭据掩码 / 全程不带 rand&rand2(测签名必要性)
风控熔断: 遇 errno 31119/31329/20012/31034 立即全线停止
"""
import json, re, sys, time
import requests

sys.stdout.reconfigure(encoding="utf-8")

CRED_PATH = r"E:\AI-Station\data\secrets\bdn_credentials.json"
OUT_JSONL = r"E:\AI-Station\逆向工程\baidu-netdisk\analysis\W1_LIVENESS_RAW.jsonl"
RISK_CODES = {31119, 31329, 20012, 31034}
DATE = "2026-10-29"

with open(CRED_PATH, "r", encoding="utf-8") as f:
    cred = json.load(f)
BDUSS, STOKEN, UA = cred["bduss"], cred["stoken"], cred["ua_native"]
mask = lambda v: v[:8] + "***MASKED***"

BASE_HEADERS = {
    "Cookie": "BDUSS=%s; STOKEN=%s" % (BDUSS, STOKEN),
    "User-Agent": UA,
    "Referer": "https://pan.baidu.com/disk/main",
}

print("[cred] BDUSS=%s STOKEN=%s UA=%s" % (mask(BDUSS), mask(STOKEN), UA), flush=True)

log = []
halted = False
shot_count = 0

def shoot(tag, method, url, body=None):
    global halted, shot_count
    if halted or shot_count >= 12:
        return None
    shot_count += 1
    h = dict(BASE_HEADERS)
    rec = {"n": shot_count, "tag": tag, "method": method, "url": url, "date": DATE}
    try:
        if method == "GET":
            r = requests.get(url, headers=h, timeout=15)
        else:
            h["Content-Type"] = "application/x-www-form-urlencoded"
            r = requests.post(url, headers=h, data=body if body is not None else "", timeout=15)
        head = r.text[:200]
        m = re.search(r'"errno"\s*:\s*(-?\d+)', head)
        rec["http"] = r.status_code
        rec["errno"] = int(m.group(1)) if m else None
        rec["head80"] = r.text[:80].replace("\n", " ")
    except Exception as e:
        rec["http"] = "EXC"
        rec["errno"] = None
        rec["head80"] = repr(e)[:80]
    log.append(rec)
    print(json.dumps(rec, ensure_ascii=False), flush=True)
    if rec["errno"] in RISK_CODES:
        halted = True
        print("[HALT] risk-control errno %s encountered, all remaining shots aborted" % rec["errno"], flush=True)
    time.sleep(1.6)
    return rec

# 1. 配额 GET(官方文档形态)
r1 = shoot("quota-get", "GET", "https://pan.baidu.com/api/quota?checkfree=1&checkexpire=1")
# 2. 配额 POST(8.2.5 抓包形态) — 仅当 GET 失败才算第二发
if r1 is None or r1.get("errno") != 0:
    shoot("quota-post", "POST", "https://pan.baidu.com/api/quota?checkfree=1&checkexpire=1", body="")

# 3. xpan 搜索(全盘口径, 无 rand)
shoot("xpan-search", "GET",
      "https://pan.baidu.com/rest/2.0/xpan/file?method=search&key=AI&recursion=1&num=5")
# 4. xpan 元信息(任务书指定 legacy multifile 形态, fsid=抓包样本)
shoot("xpan-multifile-metas", "GET",
      "https://pan.baidu.com/rest/2.0/xpan/multifile?method=metas&fsids=%5B341179797843843%5D&dlink=0")
# 5. 分享记录(任务书形态: xpan/share?method=record)
shoot("xpan-share-record", "GET",
      "https://pan.baidu.com/rest/2.0/xpan/share?method=record")
# 6. 分享记录(蓝本形态: share/record, prepare.go:783-801 实证)
shoot("share-record-blueprint", "GET",
      "https://pan.baidu.com/share/record?page=1&desc=1&order=time")
# 7. 回收站列表(蓝本 prepare.go:824-836)
shoot("recycle-list", "GET",
      "https://pan.baidu.com/api/recycle/list?num=100&page=1")
# 8. filediff 增量(8.2.5 实测形态=POST+body cursor, CAPTURE_INVENTORY §六)
shoot("filediff-post", "POST",
      "https://pan.baidu.com/api/filediff?clienttype=8", body="cursor=&action=manual")

with open(OUT_JSONL, "w", encoding="utf-8") as f:
    for rec in log:
        f.write(json.dumps(rec, ensure_ascii=False) + "\n")
print("[done] shots=%d halted=%s raw=%s" % (shot_count, halted, OUT_JSONL), flush=True)
