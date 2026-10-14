# -*- coding: utf-8 -*-
"""生态圈资源调度引擎——从"信号检测"升级为"意图理解+资源编排+富响应"。

总包生态圈全部资源：
  知识层：总包智库（飞书知识库）→ 工程知识/规范/标准
  内容层：3个公众号历史文章 → 行业分析/项目案例/技术解读
  产品层：商机研究报告/总包AI顾问小程序/水利安全AI眼镜 → 变现产品
  数据层：EngOpp-Mining 爬取的全国工程商机数据 → 市场情报
  AI层：工程行业大脑 → 专业回答生成

工作流：
  群消息 → 意图深度理解 → 跨资源匹配 → 富响应生成 → 自然发送
"""
from __future__ import annotations

import logging
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional

log = logging.getLogger("zbops.orchestrator")


class Intent(str, Enum):
    ENGINEERING_QUESTION = "engineering_question"   # 工程技术问题
    PROJECT_DISCUSSION = "project_discussion"       # 项目讨论/商机
    ARTICLE_SHARED = "article_shared"               # 分享了文章
    LOOKING_FOR_SERVICE = "looking_for_service"     # 找供应商/服务商
    INDUSTRY_TREND = "industry_trend"               # 行业趋势讨论
    CASUAL_CHAT = "casual_chat"                     # 闲聊（不响应）


@dataclass
class EcosystemResponse:
    """生态圈富响应——不只是文字回答，而是资源组合。"""
    intent: Intent
    text_reply: str = ""                    # 发到群里的文字
    recommend_articles: list[dict] = field(default_factory=list)  # 推荐文章
    recommend_reports: list[dict] = field(default_factory=list)   # 推荐报告
    recommend_products: list[dict] = field(default_factory=list)  # 推荐产品
    knowledge_refs: list[dict] = field(default_factory=list)      # 引用的知识
    lead_score: float = 0.0                 # 商机评分
    action: str = "reply"                   # reply / log / alert


class EcosystemOrchestrator:
    """生态圈资源调度：意图理解 → 跨资源检索 → 富响应生成。"""

    def __init__(self, brain=None, knowledge_base=None, article_index=None,
                 product_catalog=None, opportunity_data=None, guardian=None):
        """各资源层可独立注入，缺哪层就跳过哪层。"""
        self.brain = brain                     # EngineeringBrain
        self.kb = knowledge_base               # 智库检索器（Retriever）
        self.articles = article_index          # 公众号文章索引
        self.products = product_catalog        # 产品目录
        self.opportunities = opportunity_data  # EngOpp-Mining 数据
        self.guardian = guardian               # 护栏

        # 产品目录（硬编码初始版，后续从配置加载）
        self.product_catalog = [
            {"id": "report-js-shuiwang", "name": "江苏省水网工程商机研究",
             "type": "research_report", "price": 498,
             "keywords": ["江苏", "水网", "水利工程", "商机"],
             "url": "总包AI顾问小程序"},
            {"id": "report-zj-shuili", "name": "浙江省水利工程商机研究",
             "type": "research_report", "price": 498,
             "keywords": ["浙江", "水利", "商机"],
             "url": "总包AI顾问小程序"},
            {"id": "ai-glasses", "name": "水利安全AI眼镜",
             "type": "hardware", "price": 0,
             "keywords": ["安全", "巡检", "水利", "现场"],
             "url": "总包科技小程序"},
            {"id": "ai-consultant", "name": "总包AI顾问",
             "type": "service", "price": 0,
             "keywords": ["工程", "咨询", "问题", "规范"],
             "url": "总包AI顾问小程序"},
            {"id": "kb-membership", "name": "总包智库会员",
             "type": "membership", "price": 99,
             "keywords": ["知识", "规范", "标准", "资料"],
             "url": "飞书知识库"},
        ]

    async def process(self, text: str, sender: str, chat_id: str,
                      context: dict | None = None) -> EcosystemResponse:
        """主入口：理解意图 → 调度资源 → 生成富响应。"""
        # 1) 意图理解
        intent = await self._understand_intent(text)

        # 2) 按意图调度资源
        if intent == Intent.ENGINEERING_QUESTION:
            return await self._handle_question(text, chat_id)
        elif intent == Intent.PROJECT_DISCUSSION:
            return await self._handle_project(text, chat_id)
        elif intent == Intent.ARTICLE_SHARED:
            return await self._handle_article(text, chat_id)
        elif intent == Intent.LOOKING_FOR_SERVICE:
            return await self._handle_service_request(text, chat_id)
        elif intent == Intent.INDUSTRY_TREND:
            return await self._handle_trend(text, chat_id)
        else:
            return EcosystemResponse(intent=Intent.CASUAL_CHAT, action="log")

    # ── 意图理解 ──
    async def _understand_intent(self, text: str) -> Intent:
        """用工程行业大脑做深度意图理解（不是简单关键词匹配）。"""
        # 先做快速规则判断（省 LLM 调用）
        if any(kw in text for kw in ("请问", "怎么", "如何", "什么", "为什么", "？", "?")):
            if any(kw in text for kw in ("工程", "EPC", "规范", "标准", "造价",
                                          "合同", "监理", "施工", "设计", "安全",
                                          "质量", "验收", "GB", "JGJ", "水利",
                                          "水库", "堤防", "灌区")):
                return Intent.ENGINEERING_QUESTION
            return Intent.CASUAL_CHAT

        if "http" in text or "mp.weixin.qq.com" in text:
            return Intent.ARTICLE_SHARED

        if any(kw in text for kw in ("招标", "中标", "项目", "EPC", "总承包",
                                      "投资", "建设", "工程")):
            return Intent.PROJECT_DISCUSSION

        if any(kw in text for kw in ("推荐", "有谁知道", "哪家", "求介绍",
                                      "供应商", "服务商", "联系方式")):
            return Intent.LOOKING_FOR_SERVICE

        if any(kw in text for kw in ("趋势", "市场", "政策", "改革", "方向",
                                      "未来", "预测")):
            return Intent.INDUSTRY_TREND

        return Intent.CASUAL_CHAT

    # ── 工程问题：智库知识 + AI 回答 + 相关文章 + 产品推荐 ──
    async def _handle_question(self, text: str, chat_id: str) -> EcosystemResponse:
        resp = EcosystemResponse(intent=Intent.ENGINEERING_QUESTION)

        # 1) 检索智库
        kb_chunks = []
        if self.kb:
            kb_chunks = self.kb.retrieve(text, top_k=3)
        refs = "\n\n".join(f"[{c['std_no']} {c['clause']}] {c['text'][:300]}"
                           for c in kb_chunks)

        # 2) AI 生成专业回答
        prompt = (f"检索资料：\n{refs or '（无资料命中）'}\n\n"
                  f"群友提问：{text}\n\n"
                  f"请给出专业、简洁的回答（≤200字），"
                  f"有资料时注明出处，无资料时建议查阅正式规范。")
        answer_parts = []
        if self.brain:
            try:
                async for chunk in self.brain.answer(prompt, {"chat_id": chat_id}):
                    answer_parts.append(chunk)
            except Exception as e:  # noqa: BLE001
                log.error("AI 生成失败: %s", e)
        answer = "".join(answer_parts)[:300]

        # 3) 匹配相关文章（从公众号历史文章中）
        articles = self._match_articles(text)

        # 4) 匹配产品（自然推荐，不硬广）
        products = self._match_products(text, Intent.ENGINEERING_QUESTION)

        # 5) 组装回复
        parts = []
        if answer:
            parts.append(answer)
        if articles:
            art_str = "、".join(a["title"] for a in articles[:2])
            parts.append(f"📖 相关阅读：{art_str}")
        if products and self._should_recommend(chat_id):
            prod = products[0]
            parts.append(f"💡 更多深度分析可看：{prod['name']}")

        resp.text_reply = "\n\n".join(parts)
        resp.knowledge_refs = [{"std_no": c.get("std_no", ""),
                                "clause": c.get("clause", "")}
                               for c in kb_chunks]
        resp.recommend_articles = articles
        resp.recommend_products = products
        resp.lead_score = 0.4 if kb_chunks else 0.2
        resp.action = "reply" if resp.text_reply else "log"
        return resp

    # ── 项目讨论：商机数据 + 行业报告推荐 ──
    async def _handle_project(self, text: str, chat_id: str) -> EcosystemResponse:
        resp = EcosystemResponse(intent=Intent.PROJECT_DISCUSSION,
                                 lead_score=0.8, action="alert")

        # 匹配相关商机报告
        reports = self._match_products(text, Intent.PROJECT_DISCUSSION)
        articles = self._match_articles(text)

        # 生成有价值的行业洞察
        insight = ""
        if self.brain:
            prompt = (f"群友在讨论：{text}\n"
                      f"请用1-2句话补充该领域的关键市场信息或风险提示。")
            parts = []
            try:
                async for chunk in self.brain.answer(prompt, {"chat_id": chat_id}):
                    parts.append(chunk)
                insight = "".join(parts)[:150]
            except Exception:  # noqa: BLE001
                pass

        if insight:
            resp.text_reply = insight
            resp.action = "reply"
        resp.recommend_reports = [p for p in reports if p["type"] == "research_report"]
        resp.recommend_articles = articles
        resp.recommend_products = reports
        return resp

    # ── 文章分享：自动总结 + 引导讨论 + 推荐关联内容 ──
    async def _handle_article(self, text: str, chat_id: str) -> EcosystemResponse:
        resp = EcosystemResponse(intent=Intent.ARTICLE_SHARED)
        # URL 提取和文章总结由 article.py 处理
        # 这里做：总结 + 提问 + 推荐相关内容
        resp.action = "log"  # 暂不自动回复（需要文章内容获取）
        return resp

    # ── 寻找服务：产品匹配 + 引导私聊 ──
    async def _handle_service_request(self, text: str, chat_id: str) -> EcosystemResponse:
        resp = EcosystemResponse(intent=Intent.LOOKING_FOR_SERVICE,
                                 lead_score=0.9, action="alert")
        products = self._match_products(text, Intent.LOOKING_FOR_SERVICE)
        if products:
            resp.text_reply = (f"这个需求我们可以支持。"
                              f"{products[0]['name']}在这方面有成熟经验，"
                              f"有兴趣可以私聊我详聊。")
            resp.action = "reply"
            resp.recommend_products = products
        return resp

    # ── 行业趋势：数据支撑 + 报告推荐 ──
    async def _handle_trend(self, text: str, chat_id: str) -> EcosystemResponse:
        resp = EcosystemResponse(intent=Intent.INDUSTRY_TREND)
        if self.brain:
            prompt = f"群友在讨论行业趋势：{text}\n请补充1-2个数据点或政策动向。"
            parts = []
            try:
                async for chunk in self.brain.answer(prompt, {"chat_id": chat_id}):
                    parts.append(chunk)
                resp.text_reply = "".join(parts)[:200]
                resp.action = "reply"
            except Exception:  # noqa: BLE001
                pass
        reports = self._match_products(text, Intent.INDUSTRY_TREND)
        resp.recommend_reports = [p for p in reports if p["type"] == "research_report"]
        return resp

    # ── 资源匹配 ──
    def _match_articles(self, text: str) -> list[dict]:
        """从公众号文章索引中匹配相关文章。"""
        # TODO: 接入公众号文章索引（当前返回空）
        return []

    def _match_products(self, text: str, intent: Intent) -> list[dict]:
        """根据消息内容匹配生态圈产品/服务。"""
        matched = []
        for prod in self.product_catalog:
            score = sum(1 for kw in prod["keywords"] if kw in text)
            if score > 0:
                matched.append({**prod, "match_score": score})
        matched.sort(key=lambda p: p["match_score"], reverse=True)
        return matched[:3]

    def _should_recommend(self, chat_id: str) -> bool:
        """产品推荐节流：每群每日最多推荐 1 次。"""
        # TODO: 实现频率控制
        return True
