# -*- coding: utf-8 -*-
"""Outbox：有序消息投递。同 Ticket 同 Channel 保序。"""
from __future__ import annotations

import subprocess
from pathlib import Path

from store import Store

# 企微通知脚本（已 在役）
WECOM_NOTIFY = Path(r"E:\AI-Station\tools\notify_approval_wecom.py")


class Outbox:
    """消息投递队列。同 Ticket 的消息按序发送。"""

    def __init__(self, store: Store):
        self.store = store

    def queue(self, ticket_id: str, channel: str, purpose: str, content: str) -> str:
        """入队一条消息。"""
        return self.store.queue_message(ticket_id, channel, purpose, content)

    def flush(self) -> int:
        """发送 pending 消息。返回发送数。"""
        messages = self.store.pending_messages()
        count = 0
        for msg in messages:
            channel = msg["channel"]
            content = msg["content"]
            try:
                if channel == "wecom":
                    self._send_wecom(content)
                elif channel == "console":
                    print(f"[outbox:{channel}] {content}")
                # 其他 channel 可以在这里扩展
                self.store.mark_sent(msg["id"])
                count += 1
            except Exception:
                # 失败留在 pending，下次 flush 重试
                pass
        return count

    def _send_wecom(self, content: str):
        """通过企微通知脚本发送。"""
        if WECOM_NOTIFY.exists():
            subprocess.run(
                ["py", str(WECOM_NOTIFY), "--text", content],
                capture_output=True, timeout=30,
                cwd=str(WECOM_NOTIFY.parent))
