# -*- coding: utf-8 -*-
"""signals/adapters/_template.py — 新源适配器模板（W3.3；复制本文件起步）。

复制→改名 <source>.py → 全文搜 TODO 逐项替换 → 注册 → 测试。
完整五步+计时基线: signals/NEW_SOURCE_GUIDE.md。
本文件不被注册（下划线前缀=非源）。
"""
from __future__ import annotations

from ..contract import Signal
from .base import Adapter

# TODO: 数据源默认路径/端点（绝对路径，站内真身位；勿凭空造）
SOURCE_DEFAULT = None


class TemplateAdapter(Adapter):
    source_type = "template"        # TODO: 源标识（=Signal.source_type，kebab短名）

    def __init__(self):
        pass                        # TODO: 窗口/分页/超时等参数，给默认值

    def discover(self) -> list:
        """TODO: 拉原始条目（读文件/调CLI/HTTP）。整源崩溃由 bus 隔离。"""
        raise NotImplementedError

    def normalize(self, raw) -> Signal | list[Signal] | None:
        """TODO: 原始条目→Signal 六件套。铁则:
        - evidence 必带上游稳定唯一键（ID/指纹），ts 从数据解析非现造
        - 坏条目 raise ValueError（bus 记 reject 留痕）；已知噪音 return None
        - confidence 用上游真实评分映射，无评分则文档写明启发口径
        """
        raise NotImplementedError
