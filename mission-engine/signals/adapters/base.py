# -*- coding: utf-8 -*-
"""signals/adapters/base.py — 信号源适配器契约（W3.1，PROPOSAL §8）。

新源接入三步（零核心改动，开闭原则）：
  1) signals/adapters/ 下新建 <source>.py，继承 Adapter，覆写三件：
     source_type（源标识）/ discover()（拉原始条目）/ normalize(raw)
  2) signals/adapters/__init__.py 的 ADAPTERS 注册一行
  3) tests/ 加契约测试（discover→normalize→Signal 六字段校验，模板约30行）

normalize 返回：Signal | list[Signal] | None（None=跳过该条，如已知过滤）。
单条 normalize 异常/坏 Signal 由 bus 捕获记 reject 行留痕，不拖垮整源；
discover 整体崩溃记 errors，同样不影响其他源。
"""
from __future__ import annotations

from ..contract import Signal


class Adapter:
    source_type: str = ""       # 子类必须覆写（=Signal.source_type）

    def discover(self) -> list:
        """拉取原始条目列表（各自的取数逻辑：CLI/API/文件/桥接脚本…）。"""
        raise NotImplementedError

    def normalize(self, raw) -> Signal | list[Signal] | None:
        """原始条目 → Signal（六件套齐全，evidence 带稳定唯一键）。"""
        raise NotImplementedError
