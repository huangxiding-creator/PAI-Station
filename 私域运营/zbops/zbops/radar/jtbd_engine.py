# -*- coding: utf-8 -*-
"""JTBD 需求-行动引擎：不只识别需求，而是完整地帮用户把"工作"做完。

JTBD 核心思想：用户不是"买产品"，而是"雇用产品来完成一件事"。
群友不是在"问问题"，而是在"完成一项工作任务"。

六大 JTBD（工程行业群友的底层任务）：
  J1 解决技术问题    "我需要现在就知道这个技术方案怎么选"
  J2 寻找合作方      "我需要找到能做这个项目的可靠伙伴"
  J3 掌握商机情报    "我需要知道我所在区域有哪些即将启动的项目"
  J4 把控行业风向    "我需要判断这个行业的政策走向和市场变化"
  J5 获取知识资源    "我需要拿到这个领域的标准/模板/工具"
  J6 建立专业声望    "我需要通过分享见解来建立行业影响力"

对每个 JTBD，系统有一套完整的"行动链"（不是推荐，是替用户把事做完）。
"""
from __future__ import annotations

import logging
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional

log = logging.getLogger("zbops.jtbd")


class Job(str, Enum):
    SOLVE_TECHNICAL = "solve_technical"         # J1 解决技术问题
    FIND_PARTNER = "find_partner"               # J2 寻找合作方
    MARKET_INTEL = "market_intel"               # J3 掌握商机情报
    TREND_ANALYSIS = "trend_analysis"           # J4 把控行业风向
    GET_RESOURCES = "get_resources"             # J5 获取知识资源
    BUILD_REPUTATION = "build_reputation"       # J6 建立专业声望
    NO_JOB = "no_job"                           # 无明确任务


@dataclass
class Action:
    """一个具体的执行动作。"""
    type: str            # reply / alert / share_article / share_report /
                         # generate_poster / create_lead / follow_up / notify_owner
    content: str = ""    # 动作内容（文本/URL/参数）
    priority: int = 5    # 1=立即执行 5=普通 9=低优先级
    metadata: dict = field(default_factory=dict)


@dataclass
class JTBDResult:
    """JTBD 分析结果：用户要完成什么工作 + 系统要执行的行动链。"""
    job: Job
    confidence: float
    user_context: dict = field(default_factory=dict)  # 省份/行业/角色/历史
    actions: list[Action] = field(default_factory=list)
    monetization_potential: float = 0.0  # 变现潜力 0-1


class JTBDEngine:
    """JTBD 需求-行动引擎。"""

    def __init__(self, brain=None, kb=None, guardian=None, store=None,
                 product_catalog=None):
        self.brain = brain
        self.kb = kb
        self.guardian = guardian
        self.store = store
        self.products = product_catalog or self._default_products()

    def _default_products(self) -> list[dict]:
        return [
            {"name": "总包AI顾问", "type": "mini_program", "price": 0,
             "job_match": [Job.SOLVE_TECHNICAL, Job.GET_RESOURCES],
             "keywords": ["工程", "问题", "规范", "标准", "造价", "合同"],
             "value_prop": "AI 秒答工程问题，附规范出处"},
            {"name": "商机研究报告", "type": "report", "price": 498,
             "job_match": [Job.MARKET_INTEL, Job.TREND_ANALYSIS],
             "keywords": ["商机", "市场", "招标", "投资", "趋势"],
             "value_prop": "省份×行业的工程商机全景分析"},
            {"name": "总包智库会员", "type": "membership", "price": 99,
             "job_match": [Job.GET_RESOURCES, Job.SOLVE_TECHNICAL],
             "keywords": ["知识", "资料", "模板", "标准", "规范"],
             "value_prop": "飞书知识库+全量标准+项目案例"},
            {"name": "水利安全AI眼镜", "type": "hardware", "price": 0,
             "job_match": [Job.SOLVE_TECHNICAL],
             "keywords": ["安全", "巡检", "水利", "现场", "隐患"],
             "value_prop": "AI 识别现场安全隐患"},
        ]

    async def analyze_and_act(self, text: str, sender: str,
                             chat_id: str, chat_name: str = "",
                             context: dict | None = None) -> JTBDResult:
        """主入口：分析 JTBD → 生成行动链 → 执行。"""
        # 1) JTBD 识别
        job, confidence = self._identify_job(text)

        if job == Job.NO_JOB:
            return JTBDResult(job=job, confidence=confidence)

        # 2) 提取用户上下文
        user_ctx = self._extract_context(text, sender, chat_name)

        # 3) 生成行动链（每个 JTBD 一套专属动作）
        result = JTBDResult(job=job, confidence=confidence,
                           user_context=user_ctx)

        if job == Job.SOLVE_TECHNICAL:
            result = await self._act_solve_technical(text, result)
        elif job == Job.FIND_PARTNER:
            result = await self._act_find_partner(text, result)
        elif job == Job.MARKET_INTEL:
            result = await self._act_market_intel(text, result)
        elif job == Job.TREND_ANALYSIS:
            result = await self._act_trend_analysis(text, result)
        elif job == Job.GET_RESOURCES:
            result = await self._act_get_resources(text, result)
        elif job == Job.BUILD_REPUTATION:
            result = await self._act_build_reputation(text, result)

        # 4) 变现潜力评估
        result.monetization_potential = self._assess_monetization(job, text)

        return result

    # ══════════ JTBD 识别 ══════════

    def _identify_job(self, text: str) -> tuple[Job, float]:
        """识别用户在尝试完成什么"工作"（按价值优先级+精准度排序）。"""
        # 前置过滤：新闻/早报/链接转发 → 不当作需求
        if self._is_news_or_share(text):
            return Job.BUILD_REPUTATION, 0.5

        # J2 寻找合作方（需组合信号：动作词+对象词）
        partner_actions = ["求推荐", "求介绍", "有谁知道", "哪家好",
                          "怎么联系", "求合作", "帮忙找", "谁能做"]
        partner_objects = ["设计院", "施工单位", "供应商", "服务商",
                          "监理", "造价", "咨询公司", "团队", "公司",
                          "工作", "岗位", "人才", "工程师", "项目经理"]
        has_action = any(kw in text for kw in partner_actions)
        has_object = any(kw in text for kw in partner_objects)
        if has_action and has_object:
            return Job.FIND_PARTNER, 0.95
        if has_action and any(kw in text for kw in ["推荐", "联系", "介绍"]):
            return Job.FIND_PARTNER, 0.7

        # J1 解决技术问题（需疑问标记+具体工程关键词，排除管理泛问）
        question_marks = ["?", "？", "怎么", "如何", "请问", "什么",
                         "为什么", "多少"]
        tech_domains = ["EPC", "总承包", "规范", "标准", "GB", "JGJ",
                       "造价", "定额", "索赔", "变更", "签证",
                       "验收", "施工方案", "监理", "工期延误",
                       "投标", "招标", "概算", "预算", "结算",
                       "水库", "堤防", "灌区", "泵站", "河道",
                       "高速公路", "桥梁", "隧道"]
        # 排除泛管理问题（不是具体工程问题）
        mgmt_only = ["会前", "会后", "跟进", "准备", "拿出方案",
                    "有没有准备", "有没有跟进"]
        if any(kw in text for kw in mgmt_only) and \
           not any(kw in text for kw in tech_domains[:10]):
            return Job.NO_JOB, 0.0

        has_question = any(kw in text for kw in question_marks)
        has_tech = any(kw in text for kw in tech_domains)
        if has_question and has_tech and len(text) > 12:
            return Job.SOLVE_TECHNICAL, 0.85

        # J3 商机情报（需项目关键词+规模/时间信号）
        intel_project = ["EPC总承包", "工程总承包", "PPP项目", "BOT项目",
                        "水库", "灌区", "堤防", "高速公路", "抽水蓄能",
                        "新能源项目", "河道治理", "污水处理"]
        intel_timing = ["招标", "中标", "立项", "开工", "投资",
                       "预算", "批复", "可研"]
        has_project = any(kw in text for kw in intel_project)
        has_timing = any(kw in text for kw in intel_timing)
        if has_project and has_timing:
            return Job.MARKET_INTEL, 0.8
        if has_timing and any(kw in text for kw in ["工程", "项目"]):
            return Job.MARKET_INTEL, 0.6

        # J5 获取知识资源
        if any(kw in text for kw in ["求资料", "求模板", "哪里下载",
                                     "有没有", "分享一下"]):
            return Job.GET_RESOURCES, 0.7

        # J4 行业风向
        trend_words = ["趋势", "政策", "改革", "未来", "方向", "市场预测"]
        if any(kw in text for kw in trend_words) and len(text) > 20:
            return Job.TREND_ANALYSIS, 0.6

        return Job.NO_JOB, 0.0

    def _is_news_or_share(self, text: str) -> bool:
        """检测是否为新闻/分享/文档/欢迎/误发（不应触发需求响应）。"""
        import re

        # 文件分享（.docx/.pdf/.xlsx 等）
        if re.search(r'\.(docx?|pdf|xlsx?|pptx?|zip|rar)\b', text, re.I):
            return True

        # 欢迎消息
        welcome = ["欢迎", "加入", "进群", "新手", "群规", "公告",
                  "庆祝", "[庆祝]", "[玫瑰]", "[鼓掌]"]
        if sum(1 for w in welcome if w in text) >= 2:
            return True

        # 误发/道歉消息
        if any(kw in text for kw in ["不好意思", "发错", "带到这个群",
                                     "发部门群", "撤回"]):
            return True

        # 纯表情/贴图
        clean = re.sub(r'\[[^\]]*\]', '', text).strip()
        if len(clean) < 5:
            return True

        # 新闻/早报
        news_markers = [
            "早报", "晚报", "日报", "新闻", "快讯", "头条",
            "2024年", "2025年", "2026年",
            "http", "mp.weixin.qq.com",
        ]
        marker_count = sum(1 for m in news_markers if m in text)
        if marker_count >= 2:
            return True

        # 以年份/日期开头（新闻格式）
        if re.match(r'^\d{4}年\d{1,2}月\d{1,2}日', text):
            return True

        # 短文本且主要是 URL
        url_count = text.count("http")
        if url_count > 0 and len(text.replace("http", "").strip()) < 30:
            return True

        return False

    def _extract_context(self, text: str, sender: str,
                        chat_name: str) -> dict:
        provinces = ["北京", "天津", "河北", "江苏", "浙江", "安徽", "福建",
                    "江西", "山东", "河南", "湖北", "湖南", "广东", "广西",
                    "海南", "重庆", "四川", "贵州", "云南", "陕西", "甘肃"]
        industries = {"水利": ["水库", "灌区", "堤防", "防洪", "泵站"],
                     "交通": ["公路", "桥梁", "隧道", "高速"],
                     "房建": ["房建", "建筑", "安置房", "医院"],
                     "能源": ["电力", "光伏", "风电", "抽蓄"]}
        return {
            "sender": sender,
            "chat_name": chat_name,
            "province": next((p for p in provinces if p in text), ""),
            "industry": next((ind for ind, kws in industries.items()
                            if any(k in text for k in kws)), ""),
        }

    # ══════════ J1: 解决技术问题 ══════════

    async def _act_solve_technical(self, text: str,
                                  result: JTBDResult) -> JTBDResult:
        """行动链：智库检索 → AI 专业回答 → 推荐深度报告 → 引导小程序。"""
        # 1) 检索智库
        kb_refs = ""
        if self.kb:
            chunks = self.kb.retrieve(text, top_k=3)
            kb_refs = "\n".join(f"[{c['std_no']} {c['clause']}]"
                               f" {c['text'][:200]}" for c in chunks)

        # 2) AI 生成专业回答
        answer = ""
        if self.brain:
            prompt = (f"检索资料：\n{kb_refs or '（无命中）'}\n\n"
                     f"群友提问：{text}\n\n"
                     f"给出专业简洁的回答（≤200字），"
                     f"有资料注明出处，无资料建议查规范。")
            parts = []
            try:
                async for chunk in self.brain.answer(
                        text, {"chat_id": "jtbd", "sender": ""}):
                    parts.append(chunk)
                answer = "".join(parts)[:300]
            except Exception as e:  # noqa: BLE001
                log.error("J1 AI 生成失败: %s", e)

        # 3) 组装行动链
        if answer:
            result.actions.append(Action(
                type="reply", content=answer, priority=1))

        # 4) 匹配产品
        matched = [p for p in self.products
                  if Job.SOLVE_TECHNICAL in p["job_match"]
                  and any(kw in text for kw in p["keywords"])]
        if matched:
            result.actions.append(Action(
                type="reply",
                content=f"[Tip] 更深入的解答和计算工具，可以用{matched[0]['name']}，"
                       f"{matched[0]['value_prop']}。",
                priority=3))

        # 5) 创建线索
        result.actions.append(Action(
            type="create_lead", priority=2,
            content=text[:100],
            metadata={"job": "solve_technical",
                     "sender": result.user_context.get("sender", ""),
                     "products": [p["name"] for p in matched]}))

        return result

    # ══════════ J2: 寻找合作方 ══════════

    async def _act_find_partner(self, text: str,
                               result: JTBDResult) -> JTBDResult:
        """行动链：理解需求 → 匹配生态圈伙伴 → 热情引荐 → 通知主理人。"""
        # 立即通知主理人（有明确合作需求）
        result.actions.append(Action(
            type="notify_owner", priority=1,
            content=f"[合作需求] {result.user_context.get('sender','')} "
                   f"在{result.user_context.get('chat_name','')}群寻求：{text[:80]}",
            metadata={"province": result.user_context.get("province", ""),
                     "industry": result.user_context.get("industry", "")}))

        # 群内简短回应（不推销，先建立连接）
        result.actions.append(Action(
            type="reply", priority=2,
            content="这个需求我们了解一些，我来帮您对接。"
                   "方便的话可以私聊我具体说说要求。"))

        # 创建高价值线索
        result.actions.append(Action(
            type="create_lead", priority=1,
            content=text[:100],
            metadata={"job": "find_partner", "priority": "high"}))

        return result

    # ══════════ J3: 掌握商机情报 ══════════

    async def _act_market_intel(self, text: str,
                               result: JTBDResult) -> JTBDResult:
        """行动链：匹配商机报告 → 分享市场数据 → 推荐购买。"""
        province = result.user_context.get("province", "")
        industry = result.user_context.get("industry", "")

        # 匹配报告
        reports = [p for p in self.products if p["type"] == "report"]
        if province:
            reports = [r for r in reports if province in str(r)]

        if reports:
            report = reports[0]
            result.actions.append(Action(
                type="reply", priority=2,
                content=f"📊 {province}{industry}领域的项目动态，"
                       f"我们有一份详细的商机分析报告（{report['name']}），"
                       f"覆盖了该区域的主要项目和投资方向。"
                       f"有兴趣可以私聊获取。"))

        result.actions.append(Action(
            type="create_lead", priority=2,
            content=text[:100],
            metadata={"job": "market_intel", "province": province,
                     "industry": industry}))

        result.monetization_potential = 0.8  # 报告购买意向
        return result

    # ══════════ J4: 行业风向 ══════════

    async def _act_trend_analysis(self, text: str,
                                 result: JTBDResult) -> JTBDResult:
        """行动链：AI 分析趋势 → 分享相关政策 → 推荐研究报告。"""
        if self.brain:
            parts = []
            try:
                async for chunk in self.brain.answer(
                        f"分析行业趋势：{text}，给出1-2个关键数据或政策点。",
                        {"chat_id": "jtbd"}):
                    parts.append(chunk)
                if parts:
                    result.actions.append(Action(
                        type="reply", priority=2,
                        content="".join(parts)[:200]))
            except Exception:  # noqa: BLE001
                pass

        result.actions.append(Action(
            type="create_lead", priority=5,
            content=text[:100],
            metadata={"job": "trend_analysis"}))
        return result

    # ══════════ J5: 获取知识资源 ══════════

    async def _act_get_resources(self, text: str,
                                result: JTBDResult) -> JTBDResult:
        """行动链：智库检索 → 分享资源链接 → 推荐会员。"""
        # 检索智库
        if self.kb:
            chunks = self.kb.retrieve(text, top_k=3)
            if chunks:
                result.actions.append(Action(
                    type="reply", priority=2,
                    content=f"📎 相关资料：{chunks[0]['title']} "
                           f"({chunks[0]['std_no']} {chunks[0]['clause']})"))

        # 推荐智库会员
        result.actions.append(Action(
            type="reply", priority=4,
            content="📚 总包智库有更完整的标准库和项目案例，"
                   "感兴趣可以了解下会员服务。"))
        return result

    # ══════════ J6: 建立专业声望 ══════════

    async def _act_build_reputation(self, text: str,
                                   result: JTBDResult) -> JTBDResult:
        """行动链：总结文章 → 引导讨论 → 推荐相关内容。"""
        # 文章总结由 article.py 处理，这里只做推荐
        result.actions.append(Action(
            type="create_lead", priority=7,
            content=text[:100],
            metadata={"job": "build_reputation",
                     "sender": result.user_context.get("sender", "")}))
        return result

    # ══════════ 变现评估 ══════════

    def _assess_monetization(self, job: Job, text: str) -> float:
        """评估该交互的变现潜力。"""
        base = {
            Job.FIND_PARTNER: 0.9,      # 直接合作意向
            Job.MARKET_INTEL: 0.7,      # 报告购买意向
            Job.SOLVE_TECHNICAL: 0.4,   # 小程序/智库引导
            Job.GET_RESOURCES: 0.5,     # 智库会员
            Job.TREND_ANALYSIS: 0.3,    # 报告推荐
            Job.BUILD_REPUTATION: 0.1,  # 长期培育
            Job.NO_JOB: 0.0,
        }
        return base.get(job, 0.0)
