# -*- coding: utf-8 -*-
"""M9 授权持久化：opt-in 授权 json 落盘，daemon 重启不丢。

授权是用户明示行为（晨报确认/向导），GrantsStore 只负责让这个
决定在进程重启后仍然有效；撤销同理留痕。
"""
from __future__ import annotations

import json
import os
from pathlib import Path

from paistation.sense.cloud.base import ConnectorRegistry


class GrantsStore:
    """{connector_name: [scopes]} 的 json 落盘；grant/revoke 即时生效并持久。"""

    def __init__(self, path: str | Path):
        self.path = Path(path)
        self._data: dict[str, list[str]] = {}
        if self.path.is_file():
            try:
                self._data = json.loads(self.path.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                self._data = {}  # 坏档→未授权态，安全侧

    def grant(self, registry: ConnectorRegistry, name: str,
              scopes: list[str] | tuple[str, ...]) -> None:
        registry.grant(name, list(scopes))
        cur = self._data.get(name, [])
        self._data[name] = sorted(set(cur) | set(scopes))
        self._flush()

    def revoke(self, registry: ConnectorRegistry, name: str) -> None:
        registry.revoke(name)
        self._data.pop(name, None)
        self._flush()

    def load_into(self, registry: ConnectorRegistry) -> None:
        for name, scopes in self._data.items():
            if registry.get(name) is not None:
                registry.grant(name, scopes)

    def _flush(self) -> None:
        tmp = self.path.with_suffix(".tmp")
        tmp.write_text(json.dumps(self._data, ensure_ascii=False),
                       encoding="utf-8")
        os.replace(tmp, self.path)
