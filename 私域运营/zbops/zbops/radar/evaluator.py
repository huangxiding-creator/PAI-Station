# -*- coding: utf-8 -*-
"""商机评估引擎：对检测到的信号进行价值评分和优先级排序。"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Optional

from .detector import Signal, SignalType


@dataclass
class Opportunity:
    signal: Signal
    priority: str          # high / medium / low
    score: float           # 0-100
    est_value_yuan: int    # 预估合同价值（元）
    recommended_action: str
    reason: str


# 行业平均合同规模（万元，用于快速估算）
INDUSTRY_AVG_VALUE = {
    "水利": 800,    # 水利项目平均 800 万
    "交通": 3000,   # 交通基建平均 3000 万
    "房建": 2000,   # 房建项目平均 2000 万
    "能源": 5000,   # 能源项目平均 5000 万
    "": 1000,       # 未知行业
}

# 省份市场系数（工程活跃度）
PROVINCE_FACTOR = {
    "广东": 1.3, "江苏": 1.3, "浙江": 1.2, "山东": 1.2, "四川": 1.1,
    "湖北": 1.1, "河南": 1.1, "福建": 1.0, "安徽": 1.0, "湖南": 1.0,
    "江西": 0.9, "广西": 0.9, "云南": 0.9, "贵州": 0.9, "重庆": 1.0,
    "default": 1.0,
}


class OpportunityEvaluator:
    """评估信号价值：类型权重 × 行业规模 × 省份系数 × 置信度 → 优先级。"""

    def evaluate(self, signal: Signal) -> Opportunity:
        # 基础分（按信号类型）
        base = {
            SignalType.PROJECT: 70,
            SignalType.PURCHASE: 60,
            SignalType.HELP: 40,
            SignalType.COMPETITOR: 20,
        }[signal.type]

        # 行业规模加成
        industry_avg = INDUSTRY_AVG_VALUE.get(signal.industry, 1000)
        industry_bonus = min(20, industry_avg / 250)  # 最多+20

        # 省份系数
        prov_factor = PROVINCE_FACTOR.get(signal.province,
                                          PROVINCE_FACTOR["default"])

        # 置信度调整
        confidence_factor = signal.confidence

        # 综合评分
        score = (base + industry_bonus) * prov_factor * confidence_factor
        score = min(100, max(0, score))

        # 预估价值
        est_value = int(industry_avg * 10000 * prov_factor * confidence_factor)

        # 优先级
        if score >= 70:
            priority = "high"
        elif score >= 45:
            priority = "medium"
        else:
            priority = "low"

        # 建议行动
        action = self._recommend(signal, priority)

        reason = (f"{signal.type.value} | {signal.industry or '未知行业'} | "
                  f"{signal.province or '未知省份'} | 置信度{signal.confidence:.0%} | "
                  f"关键词: {', '.join(signal.keywords[:3])}")

        return Opportunity(signal=signal, priority=priority, score=score,
                          est_value_yuan=est_value,
                          recommended_action=action, reason=reason)

    def _recommend(self, sig: Signal, priority: str) -> str:
        if sig.type == SignalType.PROJECT and priority == "high":
            return "立即推送告警给主理人，匹配相关行业报告"
        if sig.type == SignalType.PROJECT:
            return "记录台账，下次相关话题时主动提供内容"
        if sig.type == SignalType.HELP:
            return "AI 自动回答，附带智库内容推荐"
        if sig.type == SignalType.PURCHASE:
            return "推送告警（有采购意向），主理人跟进"
        if sig.type == SignalType.COMPETITOR:
            return "记录竞争情报，更新竞品动态"
        return "仅记录，不行动"
