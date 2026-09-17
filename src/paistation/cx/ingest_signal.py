# -*- coding: utf-8 -*-
"""信号流（signal_stream resident）→ 统一事件封套。

数据源：data/signal_stream/events/YYYY-MM-DD.jsonl（live_watch 常驻生产者，
按日追加）。事件类型与入轴策略：

- window.focus  → focus.window   （前台窗口切换：process+title）
- presence.afk  → presence.afk   （离开/回来，idle 秒数）
- session.state → session.lock / session.unlock（锁屏=节律真值）
- clipboard.change → clipboard.change（只记 kind，源流本就无内容）
- browser.url   → browser.url    （域级）
- process.snapshot → 跳过（2 分钟一拍的高频机器负载，画像价值低）

source_id = "<日>#<行号>"：日文件只追加，已有行行号稳定，幂等重跑安全。
"""

from __future__ import annotations

import json
from datetime import datetime
from pathlib import Path
from typing import Any, Iterable

from .events import EventEnvelope

SOURCE = "signal_service"

# 信号流 type → 封套 type（None=不入轴）
_TYPE_MAP: dict[str, str | None] = {
    "window.focus": "focus.window",
    "presence.afk": "presence.afk",
    "session.state": None,  # 按 phase 动态定 lock/unlock
    "clipboard.change": "clipboard.change",
    "browser.url": "browser.url",
    "process.snapshot": None,
}


def _payload(kind: str, evt: dict[str, Any]) -> tuple[str | None, dict[str, Any]]:
    """信号事件 → (封套 type, payload)。未知类型返回 (None, {})。"""
    if kind == "window.focus":
        meta = evt.get("meta") or {}
        return "focus.window", {
            "process": meta.get("process"),
            "title": (evt.get("evidence") or {}).get("prev_title")
            or meta.get("title")
            or evt.get("text"),
        }
    if kind == "presence.afk":
        meta = evt.get("meta") or {}
        return "presence.afk", {
            "phase": meta.get("phase"),
            "idle_s": (evt.get("evidence") or {}).get("idle_s"),
        }
    if kind == "session.state":
        meta = evt.get("meta") or {}
        phase = meta.get("phase") or ("lock" if meta.get("locked") else "unlock")
        return ("session.lock" if phase == "lock" else "session.unlock"), {
            "phase": phase,
        }
    if kind == "clipboard.change":
        meta = evt.get("meta") or {}
        return "clipboard.change", {"kind": meta.get("kind")}
    if kind == "browser.url":
        meta = evt.get("meta") or {}
        return "browser.url", {
            "domain": meta.get("domain") or evt.get("text"),
            "title": (evt.get("evidence") or {}).get("title"),
        }
    return _TYPE_MAP.get(kind), {}


def parse_signal_file(path: Path) -> list[EventEnvelope]:
    """解析一个按日 jsonl 文件；坏行/无 ts 行跳过（毒行常态防御）。"""
    events: list[EventEnvelope] = []
    day = path.stem  # YYYY-MM-DD
    for seq, line in enumerate(path.read_text(encoding="utf-8").splitlines(), 1):
        line = line.strip()
        if not line:
            continue
        try:
            evt = json.loads(line)
        except json.JSONDecodeError:
            continue
        ts = evt.get("ts")
        if not ts:
            continue
        kind = evt.get("type") or ""
        etype, payload = _payload(kind, evt)
        if etype is None:
            continue
        try:
            start = datetime.fromisoformat(ts)
        except ValueError:
            continue
        events.append(
            EventEnvelope(
                source=SOURCE,
                source_id=f"{day}#{seq}",
                start=start,
                type=etype,
                payload=payload,
            )
        )
    return events


def parse_signal_dir(dir_path: Path) -> Iterable[EventEnvelope]:
    for path in sorted(dir_path.glob("*.jsonl")):
        yield from parse_signal_file(path)
