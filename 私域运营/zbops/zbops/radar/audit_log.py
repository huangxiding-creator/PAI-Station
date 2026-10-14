# -*- coding: utf-8 -*-
"""发送审计总线（T-048/REQ-019）：全路径发送落盘(日文件JSON行)，保留≥90天，周报汇总。"""
from __future__ import annotations

import json
import os
import time
from pathlib import Path


def _dir() -> Path:
    return Path(os.environ.get(
        "RE_AUDIT_DIR",
        Path(__file__).resolve().parents[2] / "data" / "audit"))


def record(leg: str, group: str, text: str,
           chat_count: int | None = None, global_count: int | None = None) -> None:
    """发送即记一条（leg∈A/B/cowagent/8440）：摘要前50字+频率计数快照。"""
    d = _dir()
    d.mkdir(parents=True, exist_ok=True)
    entry = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S"), "leg": leg, "group": group,
             "summary": text[:50], "chat_count": chat_count,
             "global_count": global_count}
    with (d / f"audit-{time.strftime('%Y%m%d')}.jsonl").open("a", encoding="utf-8") as f:
        f.write(json.dumps(entry, ensure_ascii=False) + "\n")


def rotate(max_days: int = 90) -> int:
    """删除超龄日志（军团夜间腿日调），返回删除数。"""
    cutoff = time.time() - max_days * 86400
    gone = [f for f in _dir().glob("audit-*.jsonl") if f.stat().st_mtime < cutoff]
    for f in gone:
        f.unlink()
    return len(gone)


def weekly_summary(days: int = 7) -> dict:
    """近 N 天发送量（按日/按腿），供周报。"""
    out = {"total": 0, "by_day": {}, "by_leg": {}}
    for f in sorted(_dir().glob("audit-*.jsonl"))[-days:]:
        for line in f.read_text(encoding="utf-8").splitlines():
            if not line:
                continue
            e = json.loads(line)
            out["total"] += 1
            day = f.stem.replace("audit-", "")
            out["by_day"][day] = out["by_day"].get(day, 0) + 1
            out["by_leg"][e["leg"]] = out["by_leg"].get(e["leg"], 0) + 1
    return out
