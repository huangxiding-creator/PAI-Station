# -*- coding: utf-8 -*-
"""微信群聊元数据入轴驱动（关系维时间层，纯元数据零内容纪律）。

流程：sessions 全量 → 筛群 → 逐群 wechat-cli history 拉全史（缓存到
data/cx/chat_hist_cache/，gitignored，不出本机）→ 按日聚合 → timeline。

用法：
    python tools/cx_chat_ingest.py                # 全量（缓存命中秒级，缺啥补啥）
    python tools/cx_chat_ingest.py --refresh      # 强制重拉所有群
    python tools/cx_chat_ingest.py --limit 5      # 只跑前 5 群（试跑）
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.ingest_chat import SOURCE, load_history_file  # noqa: E402
from paistation.cx.ingest_sources import CREATE_NO_WINDOW  # noqa: E402
from paistation.cx.timeline import TimelineStore  # noqa: E402

WECHAT_CLI = REPO / "vendor" / "wechat-cli" / ".venv" / "Scripts" / "wechat-cli.exe"
CACHE_DIR = REPO / "data" / "cx" / "chat_hist_cache"
SESSIONS_CACHE = REPO / "data" / "local_index" / "wx_sessions_all.json"
TIMELINE_DB = REPO / "data" / "cx" / "timeline.db"


def fetch_sessions(refresh: bool) -> list[dict]:
    """全量会话列表（群清单真源=sessions）。"""
    if SESSIONS_CACHE.exists() and not refresh:
        doc = json.loads(SESSIONS_CACHE.read_text(encoding="utf-8"))
    else:
        proc = subprocess.run(
            [str(WECHAT_CLI), "sessions", "--limit", "5000"],
            capture_output=True, text=True, encoding="utf-8", errors="replace",
            creationflags=CREATE_NO_WINDOW, timeout=120,
        )
        SESSIONS_CACHE.parent.mkdir(parents=True, exist_ok=True)
        SESSIONS_CACHE.write_text(proc.stdout or "", encoding="utf-8")
        doc = json.loads(proc.stdout or "[]")
    rows = doc if isinstance(doc, list) else doc.get("sessions", [])
    return [s for s in rows if s.get("is_group") and s.get("username")]


def fetch_group_history(group_user: str, refresh: bool) -> Path:
    """单群全史 → 缓存文件（stdout 直落文件，避开管道截断）。"""
    cache = CACHE_DIR / f"{group_user.replace('@', '_')}.json"
    if cache.exists() and not refresh:
        return cache
    cache.parent.mkdir(parents=True, exist_ok=True)
    with open(cache, "wb") as fh:
        subprocess.run(
            [str(WECHAT_CLI), "history", group_user,
             "--limit", "200000", "--format", "json"],
            stdout=fh, stderr=subprocess.DEVNULL,
            creationflags=CREATE_NO_WINDOW, timeout=300,
        )
    return cache


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--refresh", action="store_true", help="强制重拉（默认走缓存）")
    ap.add_argument("--limit", type=int, default=0, help="只跑前 N 群")
    args = ap.parse_args()

    groups = fetch_sessions(refresh=args.refresh)
    if args.limit:
        groups = groups[: args.limit]
    print(f"群清单：{len(groups)} 个")

    store = TimelineStore(TIMELINE_DB)
    total_ins = total_skip = total_events = 0
    for i, g in enumerate(groups, 1):
        user, name = g["username"], g.get("chat") or user
        try:
            cache = fetch_group_history(user, args.refresh)
        except subprocess.TimeoutExpired:
            print(f"[{i}/{len(groups)}] {name[:20]} 拉取超时，跳过")
            continue
        events = load_history_file(cache)
        if not events and cache.stat().st_size < 40:
            print(f"[{i}/{len(groups)}] {name[:20]} 空史")
            continue
        inserted, skipped = store.ingest(events)
        total_ins += inserted
        total_skip += skipped
        total_events += len(events)
        if i % 20 == 0 or i == len(groups):
            print(f"[{i}/{len(groups)}] 累计事件 {total_events}，"
                  f"新插 {total_ins}，跳过 {total_skip}")

    print(f"完成：{len(groups)} 群 → 事件 {total_events}，"
          f"新插 {total_ins}，幂等跳过 {total_skip}")
    print(f"timeline {SOURCE} 存量: {store.count(SOURCE)}")
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
