# -*- coding: utf-8 -*-
"""KB-FACTORY W7 履约流水线（付费后交付引擎）。

付费触发履约；SLA 目标 30 分钟 / 承诺 2 小时；邮箱 ≤50MB 附件 + 大包网盘双通道。
合规三级：绿直取、黄（文库账号默认 OFF）不代取、红只列代购清单。
数字零造假：全程审计留痕（ledger.jsonl + manifest），缺什么如实标什么。
"""
from .order import Order, OrderInbox
from .sources_local import LocalCorpus
from .sources_registry import registry, advice_for
from .pipeline import run, load_blueprint, BuildResult
from . import deliver as _deliver_module  # 仅确保子模块导入；deliver.deliver() 走模块访问

deliver = _deliver_module  # 包级 `deliver` = 模块（避免与模块内同名函数互相遮蔽）

__all__ = ["Order", "OrderInbox", "LocalCorpus", "registry", "advice_for",
           "run", "load_blueprint", "BuildResult", "deliver"]
