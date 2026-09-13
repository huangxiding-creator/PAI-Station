"""M2.6 云感知连接器契约（FR15）：注册表+opt-in 授权门+水位线。

"只要用户能够提供，就应该能够实现感知"——新云源=写一个
CloudConnector 子类+register()，框架负责安全（限速四件套）、
授权（opt-in 可撤）、增量（水位线）与事件入流，连接器只管
平台协议本身。
"""
from __future__ import annotations

import json
import os
from pathlib import Path


class CloudConnector:
    """连接器协议：子类实现 login_flow/test_session/collect 三件。

    collect(since_watermark) -> (events, new_watermark)：
    events 为精简事件 dict（type/text/evidence/meta 可选），ts/source/
    speaker 由 CloudSensingService 统一补齐；new_watermark 为本次见到
    的最大游标（时间戳/token），故障时必须原样返回 since_watermark。
    """

    name = "base"
    scopes: tuple[str, ...] = ()

    def login_flow(self) -> bool:
        raise NotImplementedError

    def test_session(self) -> bool:
        raise NotImplementedError

    def collect(self, since_watermark):
        raise NotImplementedError


class ConnectorRegistry:
    """opt-in 授权门：用户明示授权全部 scopes 后连接器才参与采集。"""

    def __init__(self):
        self._connectors: dict[str, CloudConnector] = {}
        self._grants: dict[str, set[str]] = {}

    def register(self, connector: CloudConnector) -> None:
        self._connectors[connector.name] = connector

    def get(self, name: str) -> CloudConnector | None:
        return self._connectors.get(name)

    def all(self) -> list[CloudConnector]:
        return list(self._connectors.values())

    def grant(self, name: str, scopes: list[str] | tuple[str, ...]) -> None:
        if name not in self._connectors:
            raise KeyError(name)
        self._grants.setdefault(name, set()).update(scopes)

    def revoke(self, name: str) -> None:
        self._grants.pop(name, None)

    def is_enabled(self, connector: CloudConnector) -> bool:
        required = set(connector.scopes)
        if not required:
            return False  # 无声明作用域的云连接器没有存在意义
        return required <= self._grants.get(connector.name, set())


class WatermarkStore:
    """{connector_name: 游标} 的 json 落盘；原子写，重开可续。"""

    def __init__(self, path: str | Path):
        self._path = Path(path)
        self._data: dict = {}
        if self._path.is_file():
            try:
                self._data = json.loads(self._path.read_text(encoding="utf-8"))
            except (OSError, ValueError):
                self._data = {}  # 坏档→从零开始，不致命

    def get(self, name: str, default=None):
        return self._data.get(name, default)

    def set(self, name: str, value) -> None:
        self._data[name] = value
        tmp = self._path.with_suffix(".tmp")
        tmp.write_text(json.dumps(self._data, ensure_ascii=False),
                       encoding="utf-8")
        os.replace(tmp, self._path)
