# -*- coding: utf-8 -*-
"""域2 企微会议驱动：会议详情 → 参与人实体 + 会议事件入主时间轴。

- 缓存 data/cx/collect_cache/wecom_meeting_details.json（driver 外拉好或手动）
- 主人企微 userid 读 data/cx/owner.json 的 wecom_userid
- 用法：python tools/cx_wecom.py [--pull]  （--pull 强制重拉列表+详情）
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_wecom import (  # noqa: E402
    collect_wecom_events,
    parse_wecom_meeting_details,
    register_wecom_attendees,
)
from paistation.cx.timeline import TimelineStore  # noqa: E402

CACHE = REPO / "data/cx/collect_cache"
WECOM = Path(os.path.expanduser("~/AppData/Roaming/npm/wecom-cli.cmd"))
OWNER = REPO / "data/cx/owner.json"


def run_wecom(*args: str, timeout: int = 120) -> str:
    proc = subprocess.run(
        ["cmd", "/c", str(WECOM), *args],
        capture_output=True, text=True, encoding="utf-8", errors="replace",
        creationflags=0x08000000, timeout=timeout, cwd=str(REPO),
    )
    if proc.returncode != 0 or not proc.stdout.strip():
        detail = proc.stdout[-200:] + proc.stderr[-200:]
        raise RuntimeError(f"wecom-cli rc={proc.returncode}: {detail}")
    if '"code": 400097' in proc.stdout or "频控" in proc.stdout:
        raise RuntimeError(f"wecom-cli 频控 400097: {proc.stdout[:120]}")
    return proc.stdout


def pull_details() -> str:
    """翻页拉会议列表 → 每批 10 拉详情 → 存缓存。

    账号安全（企微 get 有频控 400097）：批间 sleep 15s；遇频控立即熔断，
    保留已获批次写回缓存（断点续跑：已缓存的 meeting_id 不再重拉）。
    """
    import time

    cache = CACHE / "wecom_meeting_details.json"
    batches: list[dict] = []
    have: set[str] = set()
    if cache.exists():
        try:
            batches = json.loads(cache.read_text(encoding="utf-8"))
            for b in batches:
                for m in b.get("meetings") or []:
                    have.add(m.get("meeting_id"))
        except ValueError:
            batches = []

    meetings, cursor, page = [], None, 0
    while page < 20:
        args = ["meeting", "list", "--begin-time", "2024-01-01 00:00:00",
                "--end-time", "2026-12-31 23:59:59", "--limit", "100"]
        if cursor:
            args += ["--cursor", cursor]
        d = json.loads(run_wecom(*args))
        meetings += d.get("created_meetings") or []
        meetings += d.get("attended_meetings") or []
        if not d.get("has_more"):
            break
        cursor = d.get("next_cursor")
        page += 1
    ids = [m["meeting_id"] for m in meetings if m.get("meeting_id")]
    todo = [i for i in ids if i not in have]
    print(f"list {len(ids)} meetings, {len(have)} cached, {len(todo)} to fetch")

    hit_limit = False
    for i in range(0, len(todo), 10):
        try:
            out = run_wecom(
                "meeting", "get", "--meeting-ids",
                json.dumps(todo[i:i + 10], ensure_ascii=False),
            )
        except RuntimeError as exc:
            if "400097" in str(exc) or "频控" in str(exc):
                print(f"频控熔断：{len(todo) - i} 场留待冷却后续跑")
                hit_limit = True
                break
            raise
        try:
            batches.append(json.loads(out))
        except ValueError:
            continue
        cache.write_text(json.dumps(batches, ensure_ascii=False), encoding="utf-8")
        time.sleep(15)
    if hit_limit:
        raise SystemExit(2)  # 非零退出但缓存已保存，续跑用
    return cache.read_text(encoding="utf-8")


def main() -> int:
    cache = CACHE / "wecom_meeting_details.json"
    text = cache.read_text(encoding="utf-8") if (cache.exists() and "--pull" not in sys.argv) else pull_details()
    meetings = parse_wecom_meeting_details(text)

    owner_userid = None
    if OWNER.exists():
        try:
            owner_userid = json.loads(OWNER.read_text(encoding="utf-8")).get("wecom_userid")
        except ValueError:
            pass

    estore = EntityStore(REPO / "data/cx/entities.db")
    stats = register_wecom_attendees(estore, meetings, owner_userid=owner_userid)
    print(f"wecom meetings: {len(meetings)} | attendees persons new: "
          f"{stats['persons_created']}, associate_of new: {stats['links']}")

    evs = collect_wecom_events(meetings, owner_userid=owner_userid)
    tstore = TimelineStore(REPO / "data/cx/timeline.db")
    ins, skip = tstore.ingest(evs)
    print(f"timeline meeting.attend: inserted {ins}, skipped {skip}")
    print(f"entities now: {estore.count()} | {json.dumps(estore.stats(), ensure_ascii=False)}")
    print(f"links: {json.dumps(estore.link_stats(), ensure_ascii=False)}")
    estore.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
