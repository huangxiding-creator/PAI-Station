"""微信读书书库 → 秘塔「工程大脑」目录同步上传（2026-09-14）。

复用 waytoagi-sync 的生产级 MetasoClient（登录自愈/页内 fetch/幂等契约），
仅换目标 cfid 与台账。格式政策（2026-09-12 用户定）：秘塔只传 md。

用法:
  python scripts/weread_to_metaso.py --smoke     # 冒烟 1 本
  python scripts/weread_to_metaso.py             # 全量（断点续跑）
"""
import argparse
import glob
import json
import os
import random
import sys
import time
from pathlib import Path

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(
    os.path.abspath(__file__))), "src"))
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

SKILL_SCRIPTS = Path(__file__).resolve().parent.parent / ".claude" / "skills" / \
    "waytoagi-sync" / "scripts"
sys.path.insert(0, str(SKILL_SCRIPTS))
import upload_metaso as um  # noqa: E402

ROOT = Path(__file__).resolve().parent.parent
BOOKS = ROOT / "data" / "weread"
LEDGER = BOOKS / "_recon" / "metaso_books_ledger.jsonl"

# 用户指定上传目录（2026-09-14）：
# https://metaso.cn/subject-v2/8673582927558737920/manage?cfid=2099435326868860928
TARGET_CFID = "2099435326868860928"
# SUBJECT_ID 与 waytoagi 同库，无需改；仅重定向 TARGET_CFID（reconnect/刷新
# 页 URL 也引用它，模块级补丁一处生效）
um.TARGET_CFID = TARGET_CFID


def log(msg):
    print(f"[{time.strftime('%H:%M:%S')}] {msg}", flush=True)


def load_ledger():
    done = set()
    if LEDGER.exists():
        for line in LEDGER.read_text(encoding="utf-8").splitlines():
            try:
                rec = json.loads(line)
                if rec.get("status") == "ok":
                    done.add(rec["path"])
            except Exception:
                pass
    return done


def append_ledger(rec):
    LEDGER.parent.mkdir(parents=True, exist_ok=True)
    with open(LEDGER, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")


def iter_jobs():
    for path in sorted(glob.glob(str(BOOKS / "*" / "*.md"))):
        p = Path(path)
        if p.parent.name.startswith("_"):
            continue
        yield str(p), p.name


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--smoke", action="store_true", help="只传第一本")
    args = ap.parse_args()

    jobs = list(iter_jobs())
    if args.smoke:
        jobs = jobs[:1]
    done = load_ledger()
    jobs = [(p, n) for p, n in jobs if p not in done]
    log(f"待上传 {len(jobs)} 本（台账跳过）")
    if not jobs:
        return 0

    cli = um.MetasoClient()
    cli.ensure_browser()
    if not cli.ensure_login():
        return 1
    cli.tab.get(f"https://metaso.cn/subject-v2/{um.SUBJECT_ID}/manage?cfid={TARGET_CFID}")
    time.sleep(2)

    ok = fail = 0
    consec = 0
    t0 = time.time()
    for i, (path, fname) in enumerate(jobs, 1):
        good, info = False, "unknown"
        for attempt in range(4):
            try:
                content = Path(path).read_text(encoding="utf-8", errors="replace")
                good, info = cli.upload_md(TARGET_CFID,
                                           um.safe_fname(Path(fname).stem, ".md"),
                                           content)
                break
            except Exception as exc:
                info = f"conn:{type(exc).__name__}"
                log(f"  ⚡ {info} @ {fname[:30]}，自愈 {attempt + 1}/4")
                time.sleep(5 + attempt * 15)
                if not cli.reconnect():
                    time.sleep(60)
        append_ledger({"path": path, "fname": fname,
                       "status": "ok" if good else "fail", "info": info,
                       "ts": time.strftime("%Y-%m-%d %H:%M:%S")})
        if good:
            ok += 1
            consec = 0
            log(f"  ✓ [{i}/{len(jobs)}] {fname[:44]}（{info}）")
        else:
            fail += 1
            consec += 1
            log(f"  ✗ [{i}/{len(jobs)}] {fname[:44]}: {info}")
            if consec >= 5:
                log("⏸️ 连续 5 次失败熔断（重跑续传）")
                break
        time.sleep(random.uniform(2, 4))
    log(f"🏁 完成：ok={ok} fail={fail} / {len(jobs)}，用时 {int(time.time() - t0)}s")
    return 0 if fail == 0 else 2


if __name__ == "__main__":
    sys.exit(main())
