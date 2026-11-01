# -*- coding: utf-8 -*-
"""WeChat Source：微信 Claw 桥消息 → Trigger。

从微信 Claw 桥接收用户消息，转为 Trigger 进入 Eval。
"""
from __future__ import annotations

import json
from pathlib import Path

from domain import Trigger

# Claw 桥的消息落盘位置
CLAW_INBOX = Path(r"E:\AI-Station\data\claw\inbox.jsonl")


def poll() -> list[Trigger]:
    """读取 Claw 桥新消息，转为 Trigger。"""
    if not CLAW_INBOX.exists():
        return []

    state_file = CLAW_INBOX.parent / "inbox_state.json"
    state = {}
    if state_file.exists():
        state = json.loads(state_file.read_text(encoding="utf-8"))
    last_ts = state.get("last_ts", 0)

    triggers = []
    max_ts = last_ts
    for line in CLAW_INBOX.read_text(encoding="utf-8").splitlines():
        if not line.strip():
            continue
        try:
            msg = json.loads(line)
        except json.JSONDecodeError:
            continue
        ts = msg.get("ts", 0)
        if ts <= last_ts:
            continue
        max_ts = max(max_ts, ts)
        triggers.append(Trigger(
            source="wechat",
            actor=msg.get("from", "user"),
            thread_id=f"wx_{msg.get('chat_id', 'unknown')[:12]}",
            content=msg.get("text", ""),
            metadata={
                "chat_id": msg.get("chat_id", ""),
                "sender_name": msg.get("sender_name", ""),
                "msg_type": msg.get("type", "text"),
            },
            is_human=True,
        ))

    if max_ts > last_ts:
        state["last_ts"] = max_ts
        state_file.write_text(json.dumps(state), encoding="utf-8")

    return triggers
