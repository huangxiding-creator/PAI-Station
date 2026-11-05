# -*- coding: utf-8 -*-
"""_exit_health — 逐美国出口体检: NBLM 302 的 redirect_url 是否带 unsupported.
用法: py -3 -X utf8 _exit_health.py [候选逗号分隔, 默认 01,03,04,05]
"""
import json
import subprocess
import sys
import time
import urllib.request
from urllib.parse import quote

sys.path.insert(0, r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2")
import sched_nblm_run as base  # noqa: E402

PORT = 48899


def req(path, method="GET", body=None):
    r = urllib.request.Request(
        "http://127.0.0.1:" + str(PORT) + path, method=method,
        headers={"Authorization": "Bearer " + base.CLASH_SECRET,
                 "Content-Type": "application/json"},
        data=json.dumps(body).encode() if body else None)
    with urllib.request.urlopen(r, timeout=8) as resp:
        raw = resp.read().decode("utf-8", "replace")
        return json.loads(raw) if raw.strip() else {}


def probe():
    r = subprocess.run(
        ["curl", "-s", "-m", "15", "-x", "http://127.0.0.1:7895", "-o", "NUL",
         "-w", "%{http_code}|%{redirect_url}",
         "https://notebooklm.google.com"],
        capture_output=True, text=True, timeout=25)
    return r.stdout.strip()


def main() -> int:
    cands = (sys.argv[1] if len(sys.argv) > 1 else "01,03,04,05").split(",")
    px = req("/proxies")
    gname = ginfo = None
    for name, info in px.get("proxies", {}).items():
        if info.get("all") and "美国节点" in name:
            gname, ginfo = name, info
            break
    members = [m for m in ginfo["all"] if "美国" in m]
    print(f"[grp] {gname} 当前: {ginfo.get('now')}")
    for c in cands:
        tgt = next((m for m in members if m.endswith("0" + c.lstrip("0"))
                    or f" {c} " in f" {m} " or m.endswith(c)), None)
        if not tgt:
            tgt = next((m for m in members if c in m), None)
        if not tgt:
            print(f"[{c}] 无匹配节点")
            continue
        req("/proxies/" + quote(gname), "PUT", {"name": tgt})
        time.sleep(3)
        p1 = probe()
        time.sleep(2)
        p2 = probe()
        bad = "unsupported" in p1 or "unsupported" in p2
        print(f"[{tgt}] {p1[:90]}")
        print(f"        {p2[:90]}  => {'✗ 区域闸' if bad else '✓ 干净'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
