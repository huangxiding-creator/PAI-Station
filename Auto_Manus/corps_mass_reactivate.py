# -*- coding: utf-8 -*-
"""corps_mass_reactivate v3 — 全账号批量探活+重登激活（浏览器泄漏根治版）."""
import argparse
import json
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent
sys.path.insert(0, str(ROOT))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

import manus_lib as lib

TSV = ROOT / "Manus账号（全部）260922_明细.tsv"
PROFILES = ROOT / "data" / "profiles_v3"
RESULT = ROOT / "data" / "mass_reactivate_result.json"
ALIVE = ROOT / "data" / "mass_reactivate_alive.json"
PORT_BASE = 9700
HARD_EXCLUDE = ("51817@qq.com",)
DOMAIN_EXCLUDE = ("@midkk.uk",)


def kill_browser_tree(email):
    prefix = email.split("@")[0]
    subprocess.run(
        ["taskkill", "/F", "/T", "/FI", f"WINDOWTITLE eq {prefix}*"],
        capture_output=True, timeout=5,
    )


def safe_close(page, email):
    try:
        page.close()
    except Exception:
        pass
    kill_browser_tree(email)
    time.sleep(1)


def load_tsv():
    accounts = []
    for ln in TSV.read_text(encoding="utf-8").splitlines()[1:]:
        parts = ln.split("|")
        if len(parts) >= 3:
            email, pwd, status = parts[0].strip(), parts[1].strip(), parts[2].strip()
            if email in HARD_EXCLUDE or any(email.endswith(d) for d in DOMAIN_EXCLUDE):
                continue
            accounts.append({"email": email, "pwd": pwd, "tsv_status": status})
    return accounts


def probe_account(acc, idx):
    email, pwd = acc["email"], acc["pwd"]
    prof = PROFILES / email.split("@")[0]
    prof.mkdir(parents=True, exist_ok=True)
    try:
        page = lib.make_page(port=PORT_BASE + (idx % 10), profile=str(prof))
    except Exception as e:
        return {"status": "error", "detail": f"browser_launch: {e}"}
    try:
        sessions = lib.check_login(page, wait_s=15)
        if sessions is not None:
            safe_close(page, email)
            return {"status": "alive", "detail": f"sessions={len(sessions)}"}
        result = lib.login(page, email, pwd, timeout_s=150)
        if result is not None:
            safe_close(page, email)
            return {"status": "activated", "detail": f"relogin_ok sessions={len(result)}"}
        url = page.url or ""
        safe_close(page, email)
        return {"status": "retry_needed", "detail": f"login_failed url={url[:60]}"}
    except Exception as e:
        safe_close(page, email)
        return {"status": "error", "detail": str(e)[:120]}


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--start", type=int, default=0)
    ap.add_argument("--batch", type=int, default=10)
    args = ap.parse_args()

    accounts = load_tsv()
    batch = accounts[args.start:args.start + args.batch]

    results = {}
    if RESULT.exists():
        try:
            results = json.loads(RESULT.read_text(encoding="utf-8"))
        except Exception:
            results = {}

    print(f"[激活v3] 全量 {len(accounts)} | 本批 {args.start}-{args.start + len(batch) - 1}")
    for i, acc in enumerate(batch):
        idx = args.start + i
        print(f"  [{idx + 1}/{len(accounts)}] {acc['email'][:22]}", end="", flush=True)
        r = probe_account(acc, idx)
        results[acc["email"]] = {**r, "tsv_status": acc["tsv_status"], "ts": time.strftime("%H:%M:%S")}
        print(f" {r['status']}", flush=True)
        time.sleep(3)

    RESULT.write_text(json.dumps(results, ensure_ascii=False, indent=1), encoding="utf-8")
    alive_list = [k for k, v in results.items() if v["status"] in ("alive", "activated")]
    if alive_list:
        ALIVE.write_text(json.dumps(alive_list, ensure_ascii=False, indent=1), encoding="utf-8")

    from collections import Counter
    c = Counter(v["status"] for v in results.values())
    usable = c.get("alive", 0) + c.get("activated", 0)
    print(f"\n[累计] {len(results)} 号 | 可用 {usable} | 待重试 {c.get('retry_needed',0)} | 异常 {c.get('error',0)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
