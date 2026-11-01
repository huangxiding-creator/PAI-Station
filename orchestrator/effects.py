# -*- coding: utf-8 -*-
"""Effects 持久队列：所有副作用先存后做，失败指数退避重试。"""
from __future__ import annotations

import time
from typing import Callable

from store import Store


class Effects:
    """持久副作用队列。同 kind+key 合并，指数退避重试。"""

    def __init__(self, store: Store, max_concurrent: int = 4):
        self.store = store
        self.max_concurrent = max_concurrent
        self._handlers: dict[str, Callable] = {}

    def register(self, kind: str, handler: Callable):
        """注册一个 kind 的处理器。"""
        self._handlers[kind] = handler

    def enqueue(self, kind: str, key: str, payload: dict):
        """入队（同 kind+key 替换 payload，立即到期）。"""
        self.store.enqueue_effect(kind, key, payload)

    def process(self) -> int:
        """处理到期的 Effect。返回处理数。"""
        effects = self.store.pending_effects(self.max_concurrent)
        count = 0
        for eff in effects:
            kind = eff["kind"]
            handler = self._handlers.get(kind)
            if not handler:
                continue
            try:
                handler(eff["payload"])
                self.store.complete_effect(eff["id"])
                count += 1
            except Exception as e:
                # 指数退避: 2s, 4s, 8s... 上限 60s
                attempts = eff.get("attempts", 0)
                backoff = min(2000 * (2 ** attempts), 60000)
                self.store.fail_effect(eff["id"], str(e), backoff)
        return count

    @property
    def pending_count(self) -> int:
        return len(self.store.pending_effects(1000))
