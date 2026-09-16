# -*- coding: utf-8 -*-
"""域2 群成员驱动：微信群 → org 实体 + member_of 边。

- 群列表来自 sessions（contacts --groups-only 返回空，实测坑）
- 每群 members 缓存 data/cx/collect_cache/wechat_group_members/<chatroom_id>.json，
  存在即跳过拉取 → 断点续跑
- 用法：python tools/cx_groups.py
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

# 群名/昵称常含 emoji，Windows 控制台 GBK 编码 print 即崩
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_contacts import (  # noqa: E402
    parse_rion_contact_rows,
    parse_rion_group_sessions,
    register_group_members,
    register_wechat_groups,
    run_reader,
)

CACHE = REPO / "data/cx/collect_cache"
MEMBERS_DIR = CACHE / "wechat_group_members"


def main() -> int:
    MEMBERS_DIR.mkdir(parents=True, exist_ok=True)
    sess_cache = CACHE / "wechat_sessions.json"
    sess_text = sess_cache.read_text(encoding="utf-8") if sess_cache.exists() else run_reader(
        "sessions", "--limit", "2000", timeout=300
    )
    if not sess_cache.exists():
        sess_cache.write_text(sess_text, encoding="utf-8")
    groups = parse_rion_group_sessions(sess_text)

    store = EntityStore(REPO / "data/cx/entities.db")
    eids, created = register_wechat_groups(store, groups)
    print(f"groups: {len(groups)} (org new: {created})")

    total_links = 0
    done = 0
    for g in groups:
        f = MEMBERS_DIR / f"{g['chatroom_id']}.json"
        try:
            text = f.read_text(encoding="utf-8") if f.exists() else run_reader(
                "members", g["chatroom_id"], "--limit", "500"
            )
            if not f.exists():
                f.write_text(text, encoding="utf-8")
                time.sleep(0.15)  # 本地读虽无风险，保持温和
        except (RuntimeError, subprocess.TimeoutExpired) as exc:
            print(f"  skip {g['name']}: {exc}")
            continue
        try:
            rows = json.loads(text).get("data", {}).get("members", [])
        except ValueError:
            continue
        members = parse_rion_contact_rows(rows)
        stats = register_group_members(store, eids[g["chatroom_id"]], members)
        total_links += stats["links"]
        done += 1
        if done % 20 == 0:
            print(f"  ...{done}/{len(groups)} groups")

    print(f"member_of new links: {total_links}")
    print(f"entities now: {store.count()} | {json.dumps(store.stats(), ensure_ascii=False)}")
    print(f"links: {json.dumps(store.link_stats(), ensure_ascii=False)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
