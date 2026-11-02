# -*- coding: utf-8 -*-
"""weread_leg — 微信读书调研渠道腿（1102 换心: app 域整书通道, 替换旧 web 逐章管线）.

通道升级实录见 逆向工程/weread-apk-reverse/KNOWLEDGE.md:
  旧: web 逐章提取 200+请求/本, 日限 2, 节流 5.5-12s/章 (已被替换)
  新: app 域 chapterdownload 整书一包 2请求/本 (1102 破签之战贯通),
      凭据=模拟器真 app 令牌, 头表=在线 dump 真值, 产物与 web 管线同构

安全纪律 (内建于 scripts/wrapp_channel.py, 违者风控):
  - 日预算 15 本 (单一台账 data/weread/_recon/app_daily_count.json, 观察期后可提 30)
  - 401 令牌过期自动恢复: wrapp_channel.py token (~30s, 唤醒模拟器 app 滚新)
  - soldout 已下架书自动跳过; 402=账号读不了的正常边界
  - 搜索走公共目录免登录, 零账号风险
用法:
  py -X utf8 weread_leg.py search <关键词> [n]
  py -X utf8 weread_leg.py harvest <campaign> --bid <bookId> [--dry]
  py -X utf8 weread_leg.py quota
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
WRAPP = REPO / "scripts" / "wrapp_channel.py"
DAILY = REPO / "data" / "weread" / "_recon" / "app_daily_count.json"
DAILY_BOOKS = 15


def sh(cmd, timeout=1800):
    r = subprocess.run(["py", "-X", "utf8"] + cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       cwd=str(REPO))
    return (r.stdout or "") + (r.stderr or "")


def quota_state():
    today = time.strftime("%Y-%m-%d")
    d = json.loads(DAILY.read_text(encoding="utf-8")) if DAILY.exists() else {}
    return d.get(today, 0), today


def cmd_search(kw: str, n: int):
    out = sh([str(WRAPP), "search", kw, "--pages", "3"])
    lines = [l for l in out.splitlines() if re.match(r"^(HAVE|new )", l)]
    for l in lines[:n]:
        print(l)
    print(f"[weread] 命中 {len(lines)} 本（公共目录搜索, 免登录）")


def cmd_harvest(campaign: str, bid: str, dry: bool):
    used, today = quota_state()
    if used >= DAILY_BOOKS:
        print(f"[weread] 今日预算已尽({used}/{DAILY_BOOKS}本), 明日再战 — 观察期铁律")
        return 2
    if dry:
        print(f"[weread] DRY: app域整书通道将执行 wrapp_channel download {bid} "
              f"(预算 {used}/{DAILY_BOOKS})")
        return 0
    out = sh([str(WRAPP), "download", bid])
    print("[wrapp]", out.strip().splitlines()[-1][:160] if out.strip() else "?")
    if "401" in out:
        print("[weread] 令牌过期, 自动恢复中 …")
        print("[wrapp]", sh([str(WRAPP), "token"]).strip().splitlines()[-1][:100])
        out = sh([str(WRAPP), "download", bid])
        print("[wrapp]", out.strip().splitlines()[-1][:160])
    ok = "✓" in out
    ingested, title = 0, ""
    if ok:
        m = re.search(r"→ (.+)$", out.strip().splitlines()[-1])
        out_dir = Path(m.group(1).split(" |")[0].strip()) if m else None
        if out_dir and out_dir.exists():
            md = sorted(out_dir.glob("*.md"), key=lambda p: p.stat().st_size, reverse=True)
            for c in md[:2]:
                r = sh([str(REPO / "reforge_factory" / "ammo_pool.py"),
                        "ingest", campaign, "--file", str(c), "--engine", "weread"], 600)
                if "[pool]" in r:
                    ingested += 1
                    title = title or out_dir.name
    used_now, _ = quota_state()
    inv = REPO / "ammo_pool" / campaign / "channel_invocations.jsonl"
    inv.parent.mkdir(parents=True, exist_ok=True)
    with inv.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({
            "channel": "weread", "ts": time.strftime("%F %T"),
            "tool": "weread_leg harvest (app域整书通道 wrapp_channel, 日预算15)",
            "queries": f"book:{bid}:{title or '?'}",
            "yield": f"{'ok' if ok else 'fail'} / 入池{ingested}件",
        }, ensure_ascii=False) + "\n")
    print(f"[weread] 收官: {'✓' if ok else '✗'} 入池{ingested}件 今日台账{used_now}/{DAILY_BOOKS}")
    return 0 if ok else 1


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["search", "harvest", "quota"])
    ap.add_argument("kw", nargs="?", default="")
    ap.add_argument("--n", type=int, default=5)
    ap.add_argument("--campaign", default="EPC-LUMPSUM")
    ap.add_argument("--bid", default="")
    ap.add_argument("--dry", action="store_true")
    ns = ap.parse_args()
    if ns.cmd == "quota":
        used, today = quota_state()
        print(f"今日 {used}/{DAILY_BOOKS} 本（app域台账, {today}）")
    elif ns.cmd == "search":
        cmd_search(ns.kw, ns.n)
    elif ns.cmd == "harvest":
        return cmd_harvest(ns.campaign, ns.bid, ns.dry)
    return 0


if __name__ == "__main__":
    sys.exit(main())
