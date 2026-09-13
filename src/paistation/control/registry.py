"""C1 动作注册表：agent 可执行动作的法定清单（不在册=不可执行）。

path 四级：read（读）/write（写）/spend（花钱）/irreversible（不可逆）——
风控分级的依据。reversible+rollback=失败回滚钩子（SWE-agent 律）。
"""
from __future__ import annotations

from collections.abc import Callable
from dataclasses import dataclass, field

PATH_LEVELS = ("read", "write", "spend", "irreversible")


@dataclass
class ActionSpec:
    name: str
    path: str                                    # read/write/spend/irreversible
    reversible: bool = True
    description: str = ""
    rollback: Callable[[dict], None] | None = None
    handler: Callable[[dict], object] | None = None
    cost_estimate: dict = field(default_factory=dict)   # {token/sec/yuan}

    def __post_init__(self):
        if self.path not in PATH_LEVELS:
            raise ValueError(f"path 必须是 {PATH_LEVELS}：{self.path}")


class Registry:
    def __init__(self):
        self._specs: dict[str, ActionSpec] = {}

    def register(self, spec: ActionSpec) -> None:
        self._specs[spec.name] = spec

    def get(self, name: str) -> ActionSpec:
        return self._specs[name]

    def list(self, path: str | None = None) -> list[ActionSpec]:
        specs = list(self._specs.values())
        if path:
            specs = [s for s in specs if s.path == path]
        return sorted(specs, key=lambda s: s.name)
