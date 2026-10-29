# -*- coding: utf-8 -*-
"""signals/adapters — 适配器注册表（W3.1；W3.2 七源全集在册）。

新源=新增 <source>.py 文件+此处注册一行（bus/contract 零改动，开闭原则）。
七源: viaim耳机 / wechat_insight群聊·朋友圈JTBD(桥) / moments朋友圈(深读) /
demand_ledger需求台账 / topic_radar雷达原始 / revision_flywheel反馈飞轮 /
refund_score退款评分(引擎API)。
新源接入指南+计时基线: signals/NEW_SOURCE_GUIDE.md。
"""
from __future__ import annotations

from .base import Adapter
from .viaim import ViaimAdapter
from .wechat_insight import WechatInsightAdapter
from .moments import MomentsAdapter
from .demand_ledger import DemandLedgerAdapter
from .topic_radar import TopicRadarAdapter
from .revision_flywheel import RevisionFlywheelAdapter
from .refund_score import RefundScoreAdapter

ADAPTERS: dict[str, type[Adapter]] = {
    "viaim": ViaimAdapter,                     # W3.2a 讯飞录音（记录/概述/说话人可深挖）
    "wechat_insight": WechatInsightAdapter,    # W3.2b 群聊JTBD（topic-signals桥）
    "moments": MomentsAdapter,                 # W3.2  朋友圈深读（sensing face=moments）
    "demand_ledger": DemandLedgerAdapter,      # W3.2  需求台账聚合（dl_* 幂等键）
    "topic_radar": TopicRadarAdapter,          # W3.2  雷达原始（ask/comments/sph+intent）
    "revision_flywheel": RevisionFlywheelAdapter,  # W3.2 反馈改版回执（sku+rev）
    "refund_score": RefundScoreAdapter,        # W3.2  买家评分（引擎pending API）
}


def build(name: str) -> Adapter:
    """按名实例化适配器（未注册即 KeyError，由 CLI 层转错误行）。"""
    try:
        return ADAPTERS[name]()
    except KeyError:
        raise KeyError(f"适配器未注册: {name}") from None
