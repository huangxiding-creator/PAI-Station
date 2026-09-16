# -*- coding: utf-8 -*-
"""域2 飞书驱动：会话列表 + 群成员 → entities.db。

- 缓存 data/cx/collect_cache/lark_chats_all.json、lark_members/<chat_id>.json
  （存在即跳过拉取 → 断点续跑）
- lark-cli 经 npm shim（cmd /c）调用；账号安全：每群间 sleep 0.3
- 用法：python tools/cx_feishu.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_feishu import (  # noqa: E402
    parse_lark_chats,
    parse_lark_members,
    register_lark_chats,
    register_lark_members,
)

CACHE = REPO / "data/cx/collect_cache"
MEMBERS_DIR = CACHE / "lark_members"
OWNER_EID = "person/总包君"

LARK = Path(os.path.expanduser("~/AppData/Roaming/npm/lark-cli.cmd"))


def run_lark(*args: str, timeout: int = 120) -> str:
    proc = subprocess.run(
        ["cmd", "/c", str(LARK), *args],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=timeout, cwd=str(REPO),
    )
    if proc.returncode != 0 or not proc.stdout.strip():
        raise RuntimeError(f"lark-cli 失败 rc={proc.returncode}: {proc.stderr[-200:]}")
    return proc.stdout


def main() -> int:
    MEMBERS_DIR.mkdir(parents=True, exist_ok=True)
    chats_cache = CACHE / "lark_chats_all.json"
    text = chats_cache.read_text(encoding="utf-8") if chats_cache.exists() else run_lark(
        "im", "+chat-list", "--types", "p2p,group", "--as", "user", "--page-all"
    )
    if not chats_cache.exists():
        chats_cache.write_text(text, encoding="utf-8")
    p2p, groups = parse_lark_chats(text)

    store = EntityStore(REPO / "data/cx/entities.db")
    org_eids, stats = register_lark_chats(store, p2p, groups, owner_eid=OWNER_EID)
    print(f"feishu p2p: {len(p2p)} (persons new {stats['persons_created']}, "
          f"associate_of new {stats['links']})")
    print(f"feishu groups: {len(groups)} (org new {stats['groups_created']})")

    total = 0
    for g in groups:
        f = MEMBERS_DIR / f"{g['chat_id']}.json"
        try:
            mtext = f.read_text(encoding="utf-8") if f.exists() else run_lark(
                "im", "+chat-members-list", "--chat-id", g["chat_id"],
                "--as", "user", "--page-all",
            )
            if not f.exists():
                f.write_text(mtext, encoding="utf-8")
                time.sleep(0.3)
        except (RuntimeError, subprocess.TimeoutExpired) as exc:
            print(f"  skip {g['name']}: {exc}")
            continue
        mstats = register_lark_members(store, org_eids[g["chat_id"]], parse_lark_members(mtext))
        total += mstats["links"]

    print(f"member_of new: {total}")
    print(f"entities now: {store.count()} | {json.dumps(store.stats(), ensure_ascii=False)}")
    print(f"links: {json.dumps(store.link_stats(), ensure_ascii=False)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
