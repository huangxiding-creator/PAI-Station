# -*- coding: utf-8 -*-
"""域2 工作人际驱动：微信好友全量 → entities.db（person 实体 + friend_of 边）。

- 缓存 data/cx/collect_cache/wechat_friends.json（缺则现场拉取；
  必须带 PYTHONUTF8=1，否则重定向下 Python stdout 走 GBK 遇特殊字符即崩）
- 主人锚点 data/cx/owner.json {"wxid": ...}（本地私有，不入库；缺省则只登实体不连边）
- 用法：python tools/cx_contacts.py
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_contacts import (  # noqa: E402
    parse_rion_contacts,
    register_wechat_contacts,
)

CACHE = REPO / "data/cx/collect_cache/wechat_friends.json"
READER = REPO / ".claude/skills/wechat-cli/scripts/reader.sh"
OWNER = REPO / "data/cx/owner.json"


def pull() -> str:
    env = dict(os.environ, PYTHONUTF8="1")
    proc = subprocess.run(
        ["bash", str(READER), "contacts", "--friends-only", "--limit", "5000"],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=300, env=env, cwd=str(REPO),
    )
    if proc.returncode != 0 or not proc.stdout.strip():
        raise SystemExit(f"reader 拉取失败 rc={proc.returncode}: {proc.stderr[-300:]}")
    CACHE.parent.mkdir(parents=True, exist_ok=True)
    CACHE.write_text(proc.stdout, encoding="utf-8")
    return proc.stdout


def main() -> int:
    text = CACHE.read_text(encoding="utf-8") if CACHE.exists() else pull()
    contacts = parse_rion_contacts(text)
    owner_wxid = owner_name = None
    if OWNER.exists():
        try:
            cfg = json.loads(OWNER.read_text(encoding="utf-8"))
            owner_wxid, owner_name = cfg.get("wxid"), cfg.get("name")
        except ValueError:
            print("warn: owner.json 解析失败，本次只登实体不连边")
    store = EntityStore(REPO / "data/cx/entities.db")
    before = store.count()
    stats = register_wechat_contacts(
        store, contacts, owner_wxid=owner_wxid, owner_name=owner_name
    )
    print(f"parsed: {stats['persons']} contacts (cache={CACHE.name})")
    print(f"entities: {before} -> {store.count()} (+{store.count() - before})")
    print("by kind:", json.dumps(store.stats(), ensure_ascii=False))
    print("links:", json.dumps(store.link_stats(), ensure_ascii=False))
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
