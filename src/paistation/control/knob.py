"""C6 METR 旋钮（M4）：人审松紧=任务时程函数，自动指数后退。

无人干预时间越长→人审间隔越长（信任随连续无事故时程指数增长），
上限 12h（一天最多打扰两次）。返回间隔分钟数。
"""
from __future__ import annotations

_BASE_MIN = 10          # 起点：10 分钟
_STEP_HOURS = 4         # 每 4 小时无干预，间隔翻倍
_CAP_MIN = 12 * 60      # 上限：12 小时


def intervention_interval(hours_since_human: float) -> int:
    if hours_since_human < 0:
        return _BASE_MIN
    doublings = int(hours_since_human // _STEP_HOURS)
    return min(_BASE_MIN * (2 ** doublings), _CAP_MIN)
