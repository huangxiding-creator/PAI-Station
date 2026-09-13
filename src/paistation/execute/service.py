"""M4 执行服务：confirmed 任务卡→执行→交付→done（daemon 服务协议）。

闭环纪律：执行失败不误标 done（留给下轮重试，断点缓存保证幂等）；
单卡故障不连坐整批；paused 一键全局暂停。
"""
from __future__ import annotations

import logging

from paistation.execute.deliver import Deliverer

_log = logging.getLogger("paistation.execute.service")


class ExecutionService:
    name = "execute.agent"

    def __init__(self, store, runner, deliverer_root, notifier=None):
        self._store = store
        self._runner = runner
        self._deliverer = Deliverer(root=deliverer_root, notifier=notifier)
        self.started = False

    def start(self) -> None:
        self.started = True

    def stop(self) -> None:
        self.started = False

    def tick(self, paused: bool) -> None:
        if paused:
            return
        for card in self._store.confirmed():
            try:
                output = self._runner.run(card)
                self._deliverer.deliver(card, output)
                self._store.done(card.card_id)
            except Exception as exc:  # noqa: BLE001 - 单卡故障不连坐
                _log.warning("任务卡 %s 执行失败（留下轮重试）: %s",
                             card.card_id, exc)
