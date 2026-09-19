"""判断层（judgment）：System One 决策模型三原语接入包。

Jev 深度融合（2026-09-19）：低延迟封闭决策替换/前置高频语义判断点。
开关一键关 + 故障跳过 + 熔断三契约见 client 模块 docstring。
"""
from .client import JudgmentClient, Transport, make_task_judge, set_switch, switch_status

__all__ = ["JudgmentClient", "Transport", "make_task_judge",
           "set_switch", "switch_status"]
