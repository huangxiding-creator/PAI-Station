# -*- coding: utf-8 -*-
"""signals — Signal 契约+总线（W3.1）。

公开面四件：Signal / ContractError / SignalBus / Adapter。
SignalBus 懒加载——避免 `py -m signals.bus` 双重导入 RuntimeWarning。
"""
from __future__ import annotations

from .contract import Signal, ContractError
from .adapters.base import Adapter

__all__ = ["Signal", "ContractError", "SignalBus", "Adapter"]


def __getattr__(name: str):
    if name == "SignalBus":
        from .bus import SignalBus
        return SignalBus
    raise AttributeError(f"module 'signals' has no attribute {name!r}")
