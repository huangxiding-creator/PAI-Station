# -*- coding: utf-8 -*-
"""weread_leg — 微信读书调研渠道腿 (1102 用户令接入, 逆向仓 wrapp 复刻驱动).

能力链: 搜书(scripts/weread_search.py 节流内建) → 书元信息(wrapp info)
→ 章节提取(wrapp download 试读/已购面) → 入池(engine=weread) → 挂树.

账号安全铁律 (weread-download skill 在案, 违者风控):
  - 每日提取 ≤2 本 (书间冷却 600s)
  - 章节节流 5.5-12s 随机 + 每 12 章阅读间歇 90-180s
  - 搜索日限 8 次/间隔 ≥25s (weread_search 内建 pace_guard)
  - 只读接口, 不碰支付/写操作
用法:
  py -X utf8 weread_leg.py search <关键词> [n]     # 搜书出书单
  py -X utf8 weread_leg.py harvest <campaign> --bid <bookId> [--dry]
      # 提取可见章节入池(当日配额管理在 data/weread/_recon/harvest_pace.json)
"""
from __future__ import annotations

import argparse
import json
import random
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r"E:\AI-Station")
WR = REPO / "逆向工程" / "weread-apk-reverse" / "replica"
RECON = REPO / "data" / "weread" / "_recon"
PACE = RECON / "harvest_pace.json"
DAILY_BOOKS = 2
COOLDOWN_S = 600


def sh(cmd, timeout=300):
    r = subprocess.run(cmd, capture_output=True, text=True,
                       encoding="utf-8", errors="replace", timeout=timeout,
                       cwd=str(REPO))
    return (r.stdout or "") + (r.stderr or "")


def quota_left() -> int:
    today = time.strftime("%Y-%m-%d")
    st = {"date": today, "books": []}
    if PACE.exists():
        try:
            d = json.loads(PACE.read_text(encoding="utf-8"))
            if d.get("date") == today:
                st = d
        except Exception:  # noqa: BLE001
            pass
    return DAILY_BOOKS - len(st.get("books", []))


def take_quota(bid: str, title: str):
    st = {"date": time.strftime("%Y-%m-%d"),
          "books": json.loads(PACE.read_text(encoding="utf-8")).get("books", [])
          } if PACE.exists() else {"date": time.strftime("%Y-%m-%d"), "books": []}
    if st.get("date") != time.strftime("%Y-%m-%d"):
        st = {"date": time.strftime("%Y-%m-%d"), "books": []}
    st["books"].append({"bid": bid, "title": title, "ts": time.strftime("%F %T")})
    PACE.parent.mkdir(parents=True, exist_ok=True)
    PACE.write_text(json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")


def cmd_search(kw: str, n: int):
    out = sh(["py", "-X", "utf8", str(REPO / "scripts" / "weread_search.py"), kw, str(n)])
    print(out)


def book_info(bid: str) -> dict:
    out = sh(["py", "-X", "utf8", str(WR / "wrapp_client.py"), "info", bid])
    m = re.search(r"HTTP (\d+) (.+)$", out.strip().splitlines()[-1] if out.strip() else "")
    try:
        return json.loads(m.group(2)) if m and m.group(1) == "200" else {}
    except Exception:  # noqa: BLE001
        return {}


def cmd_harvest(campaign: str, bid: str, dry: bool):
    if quota_left() <= 0:
        print(f"[weread] 今日提取配额已尽({DAILY_BOOKS}本), 明日再提 — 账号安全铁律")
        return 2
    if dry:
        print("[weread] DRY (web通道 weread_batch, 含内建节流)")
        return 0
    # web 通道整书提取 (APP 接口 wrapp 401 弃用; weread_batch 内建账号节流+book.json幂等)
    out = sh(["py", "-X", "utf8", str(REPO / "scripts" / "weread_batch.py"),
              "--book-id", bid, "--no-docx"], 1800)
    tail = out.strip().splitlines()[-1][:120] if out.strip() else "?"
    print("[weread] batch:", tail)
    # 产物定位: data/weread/{书名}/
    base = REPO / "data" / "weread"
    cands = sorted([p for p in base.rglob("*.md") if p.stat().st_mtime > time.time() - 3600],
                   key=lambda p: p.stat().st_mtime, reverse=True) if base.exists() else []
    ingested = 0
    title = ""
    for c in cands[:2]:
        r = sh(["py", "-X", "utf8", str(REPO / "reforge_factory" / "ammo_pool.py"),
                "ingest", campaign, "--file", str(c), "--engine", "weread"])
        if "[pool]" in r:
            ingested += 1
            title = title or c.parent.name
    take_quota(bid, title or bid)
    inv = REPO / "ammo_pool" / campaign / "channel_invocations.jsonl"
    inv.parent.mkdir(parents=True, exist_ok=True)
    with inv.open("a", encoding="utf-8") as fh:
        fh.write(json.dumps({"channel": "weread", "ts": time.strftime("%F %T"),
                             "tool": "weread_leg harvest (web通道 weread_batch, 账号铁律节流)",
                             "queries": f"book:{bid}:{title or '?'}",
                             "yield": f"batch {'ok' if ingested else 'fail'} / 入池{ingested}件"},
                            ensure_ascii=False) + "\n")
    print(f"[weread] 收官: 入池{ingested}件 剩余额度{quota_left()}本")
    return 0


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
        print(f"今日剩余额度: {quota_left()} 本")
    elif ns.cmd == "search":
        cmd_search(ns.kw, ns.n)
    elif ns.cmd == "harvest":
        return cmd_harvest(ns.campaign, ns.bid, ns.dry)
    return 0


if __name__ == "__main__":
    sys.exit(main())
