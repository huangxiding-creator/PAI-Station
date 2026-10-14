# -*- coding: utf-8 -*-
"""雷达中间件：接入 aibot 消息管道，串联信号检测→评估→行动。

复用已有组件：
  - SignalDetector / OpportunityEvaluator（radar/）
  - EngineeringBrain（ai/brain.py）→ LLM 生成
  - ActionGateway（guardian/gateway.py）→ 护栏
  - Store（data/store.py）→ 台账
"""
from __future__ import annotations

import logging
import re
import time

log = logging.getLogger("zbops.radar")


class RadarMiddleware:
    """消息中间件：检测信号→评估→决定是否行动。"""

    def __init__(self, brain=None, guardian=None, store=None):
        from .detector import SignalDetector
        from .evaluator import OpportunityEvaluator
        self.detector = SignalDetector()
        self.evaluator = OpportunityEvaluator()
        self.brain = brain          # EngineeringBrain 实例
        self.guardian = guardian    # ActionGateway 实例
        self.store = store          # Store 实例

    async def process(self, text: str, sender: str, chat_id: str,
                      ts: str = "") -> dict:
        """处理一条群消息，返回行动建议。

        返回: {
          "action": "reply" | "alert" | "log_only" | "ignore",
          "reply_text": str,      # 若 action=reply，要回复的文本
          "alert": dict,          # 若 action=alert，告警内容
          "opportunities": list,  # 检测到的商机列表
        }
        """
        # 1) 信号检测
        signals = self.detector.detect(text, sender, chat_id, ts)
        if not signals:
            return {"action": "ignore", "opportunities": []}

        # 2) 评估每个信号
        opportunities = [self.evaluator.evaluate(s) for s in signals]
        high_ops = [o for o in opportunities if o.priority == "high"]

        # 3) 决定行动
        if any(s.type == "help" for s in signals):
            return await self._handle_help(text, chat_id, opportunities)

        if high_ops:
            return self._handle_high_value(high_ops, opportunities)

        return {"action": "log_only", "opportunities": opportunities}

    async def _handle_help(self, text: str, chat_id: str,
                          opportunities: list) -> dict:
        """处理求助信号：AI 生成回答。"""
        if not self.brain:
            return {"action": "log_only", "opportunities": opportunities}

        # 检查护栏频率
        if self.guardian:
            p = self.guardian.permit("wecom_aibot", chat_id, "reply", text[:50])
            if not p.ok:
                log.warning("护栏拒绝: %s", p.reason)
                return {"action": "log_only", "opportunities": opportunities}

        # 用工程行业大脑生成回答
        reply_parts = []
        try:
            async for chunk in self.brain.answer(text, {
                "chat_id": chat_id, "sender": "", "chat_type": "group"
            }):
                reply_parts.append(chunk)
        except Exception as e:  # noqa: BLE001
            log.error("AI 生成失败: %s", e)
            return {"action": "log_only", "opportunities": opportunities}

        reply_text = "".join(reply_parts)
        if reply_text:
            return {
                "action": "reply",
                "reply_text": reply_text[:500],
                "opportunities": opportunities,
            }
        return {"action": "log_only", "opportunities": opportunities}

    def _handle_high_value(self, high_ops: list, all_ops: list) -> dict:
        """处理高价值商机：生成告警。"""
        top = high_ops[0]
        alert = {
            "title": f"[商机] {top.signal.industry or '工程'}行业信号",
            "province": top.signal.province,
            "est_value": f"预估 {top.est_value_yuan / 10000:.0f} 万",
            "text": top.signal.text[:100],
            "keywords": top.signal.keywords,
            "recommendation": top.recommended_action,
        }
        return {"action": "alert", "alert": alert, "opportunities": all_ops}
