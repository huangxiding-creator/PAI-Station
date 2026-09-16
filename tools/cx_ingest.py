# -*- coding: utf-8 -*-
"""CX 主时间轴采集驱动：activities/git/recent/power → data/cx/timeline.db。

用法：
    python tools/cx_ingest.py                       # 全源
    python tools/cx_ingest.py --sources git,activities
    python tools/cx_ingest.py --refresh             # 强制重采 recent/power
"""
from __future__ import annotations

import argparse
import json
import os
import subprocess
import sys
from collections import Counter
from pathlib import Path

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.events import EventEnvelope  # noqa: E402
from paistation.cx.ingest_sources import (  # noqa: E402
    CREATE_NO_WINDOW,
    collect_git_events,
    find_git_repos,
    parse_activities_jsonl,
    parse_power_json,
    parse_recent_json,
)
from paistation.cx.timeline import TimelineStore  # noqa: E402

ACTIVITIES_JSONL = REPO / "SELF_PROFILE/data/activity_20260916/activities.jsonl"
CACHE_DIR = REPO / "data/cx/collect_cache"

_PS_RECENT = (
    "$sh=New-Object -ComObject WScript.Shell; "
    "Get-ChildItem \"$env:APPDATA\\Microsoft\\Windows\\Recent\\*.lnk\" | "
    "Sort-Object LastWriteTime | ForEach-Object { "
    "[pscustomobject]@{ name=$_.Name; "
    "target=$sh.CreateShortcut($_.FullName).TargetPath; "
    "last=$_.LastWriteTime } } | ConvertTo-Json -Depth 3"
)

_PS_POWER = (
    "Get-WinEvent -FilterHashtable @{LogName='System'; Id=7001,7002,42,1074} "
    "-MaxEvents 4000 -ErrorAction SilentlyContinue | "
    "Select-Object RecordId, TimeCreated, Id, ProviderName | ConvertTo-Json -Depth 3"
)


def _ps_collect(script: str, cache: Path, refresh: bool) -> str:
    """PowerShell 采集 → 缓存文件 → 文本。"""
    if cache.exists() and not refresh:
        return cache.read_text(encoding="utf-8-sig")
    proc = subprocess.run(
        ["powershell", "-NoProfile", "-Command", script],
        capture_output=True,
        text=True,
        encoding="utf-8",
        errors="replace",
        creationflags=CREATE_NO_WINDOW,
        timeout=180,
    )
    text = proc.stdout or "[]"
    cache.parent.mkdir(parents=True, exist_ok=True)
    cache.write_text(text, encoding="utf-8")
    return text


def load_events(sources: list[str], refresh: bool) -> dict[str, list[EventEnvelope]]:
    out: dict[str, list[EventEnvelope]] = {}
    if "activities" in sources:
        if ACTIVITIES_JSONL.exists():
            out["activities"] = parse_activities_jsonl(
                ACTIVITIES_JSONL.read_text(encoding="utf-8")
            )
    if "git" in sources:
        repos = find_git_repos(["E:/", "D:/"])
        out["git"] = collect_git_events(repos)
    if "recent" in sources:
        text = _ps_collect(_PS_RECENT, CACHE_DIR / "recent_full.json", refresh)
        out["recent"] = parse_recent_json(text)
    if "power" in sources:
        text = _ps_collect(_PS_POWER, CACHE_DIR / "power_events.json", refresh)
        out["power"] = parse_power_json(text)
    return out


def main() -> int:
    ap = argparse.ArgumentParser(description="CX 主时间轴采集")
    ap.add_argument("--db", default=str(REPO / "data/cx/timeline.db"))
    ap.add_argument("--sources", default="activities,git,recent,power")
    ap.add_argument("--refresh", action="store_true", help="重采 PowerShell 源")
    args = ap.parse_args()

    store = TimelineStore(args.db)
    before = store.count()
    for name, events in load_events(args.sources.split(","), args.refresh).items():
        inserted, skipped = store.ingest(events)
        print(f"[{name}] parsed={len(events)} inserted={inserted} skipped={skipped}")

    total = store.count()
    lo, hi = store.span()
    print(f"\ntotal events: {before} -> {total} (+{total - before})")
    print(f"span: {lo} -> {hi}")
    print("by source:", json.dumps(store.stats(), ensure_ascii=False))

    top_repos = Counter()
    for row in store.query(source="git", limit=100000):
        top_repos[row["payload"].get("repo", "?")] += 1
    if top_repos:
        print("top repos by commits:", top_repos.most_common(10))
    store.close()
    return 0


if __name__ == "__main__":
    os.environ.setdefault("PYTHONUTF8", "1")
    raise SystemExit(main())
