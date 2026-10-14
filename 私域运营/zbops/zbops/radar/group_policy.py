# -*- coding: utf-8 -*-
"""群策略引擎：根据群归属（自有/他人）自动调整行为力度。

自有群（群名含"总包"）：
  → 主动服务：AI 答疑、内容推荐、产品介绍、文章总结
  → 频率：每群每日可多次互动
  → 目标：服务好群友，建立专业形象

他人群：
  → 被动监听：只记录商机、检测需求
  → 频率：不在群内发言（除非被直接@）
  → 目标：挖掘商机，不引起群主注意，不被踢
  → 行动：私下通知主理人跟进
"""
from __future__ import annotations

import logging
from dataclasses import dataclass
from enum import Enum

log = logging.getLogger("zbops.policy")


class GroupOwnership(str, Enum):
    OWNED = "owned"           # 自有群（我们自己建的）
    PARTNER = "partner"       # 合作群（友好关系）
    FOREIGN = "foreign"       # 他人群（需谨慎）


class AggressionLevel(str, Enum):
    ACTIVE = "active"         # 主动服务（自有群）
    MODERATE = "moderate"     # 适度参与（合作群）
    PASSIVE = "passive"       # 只听不说（他人群）


@dataclass
class GroupPolicy:
    ownership: GroupOwnership
    aggression: AggressionLevel
    can_reply: bool = False
    can_promote: bool = False
    can_share_articles: bool = False
    max_replies_per_day: int = 0
    alert_owner_on_signal: bool = True
    reason: str = ""


class GroupPolicyEngine:
    """根据群名和配置判断群归属，返回对应的行为策略。"""

    # 自有群关键词（群名包含即认为自有）
    OWNED_KEYWORDS = ["总包"]

    # 合作群关键词（有合作关系的群）
    PARTNER_KEYWORDS = []  # 后续从配置加载

    def __init__(self, custom_owned: list[str] | None = None,
                 custom_partner: list[str] | None = None):
        self.owned_kws = self.OWNED_KEYWORDS + (custom_owned or [])
        self.partner_kws = self.PARTNER_KEYWORDS + (custom_partner or [])

    def classify(self, group_name: str) -> GroupPolicy:
        """根据群名判断归属并返回行为策略。"""
        if any(kw in group_name for kw in self.owned_kws):
            return GroupPolicy(
                ownership=GroupOwnership.OWNED,
                aggression=AggressionLevel.ACTIVE,
                can_reply=True,
                can_promote=True,
                can_share_articles=True,
                max_replies_per_day=20,
                reason=f"自有群（含'{self.owned_kws[0]}'）")

        if any(kw in group_name for kw in self.partner_kws):
            return GroupPolicy(
                ownership=GroupOwnership.PARTNER,
                aggression=AggressionLevel.MODERATE,
                can_reply=True,
                can_promote=False,
                can_share_articles=True,
                max_replies_per_day=5,
                reason="合作群")

        # 默认：他人群——只听不说
        return GroupPolicy(
            ownership=GroupOwnership.FOREIGN,
            aggression=AggressionLevel.PASSIVE,
            can_reply=False,
            can_promote=False,
            can_share_articles=False,
            max_replies_per_day=0,
            alert_owner_on_signal=True,
            reason="他人群保守模式不发言")


# 将策略集成到 JTBD 引擎的行动过滤中
def filter_actions_by_policy(actions: list, policy: GroupPolicy) -> list:
    """根据群策略过滤行动链。"""
    if policy.aggression == AggressionLevel.ACTIVE:
        return actions  # 自有群：全部执行

    if policy.aggression == AggressionLevel.MODERATE:
        # 合作群：去掉产品推广，保留回答和线索
        return [a for a in actions
                if a.type not in ("reply",) or "总包" not in a.content
                or "智库" not in a.content]

    # 他人群：只保留告警和线索，去掉群内回复
    return [a for a in actions if a.type in ("notify_owner", "create_lead")]
