# -*- coding: utf-8 -*-
"""信号检测器：从群消息中识别四类商业信号。

四类信号：
  1. project  —— 项目信号：提及具体工程项目/EPC/招标/采购
  2. help     —— 求助信号：工程问题/技术疑问/规范查询
  3. competitor —— 竞品信号：竞争对手被提及
  4. purchase —— 采购信号：寻找供应商/设计院/合作方
"""
from __future__ import annotations

import re
from dataclasses import dataclass, field
from enum import Enum
from typing import Optional


class SignalType(str, Enum):
    PROJECT = "project"
    HELP = "help"
    COMPETITOR = "competitor"
    PURCHASE = "purchase"


@dataclass
class Signal:
    type: SignalType
    text: str                    # 触发文本
    sender: str                  # 发送者
    chat_id: str                 # 群 ID
    ts: str                      # 时间戳
    confidence: float = 0.0      # 置信度 0-1
    keywords: list[str] = field(default_factory=list)
    province: str = ""           # 识别到的省份
    industry: str = ""           # 识别到的行业


class SignalDetector:
    """基于规则词库 + 正则的信号检测器（零 LLM 成本，毫秒级响应）。"""

    # ── 项目信号词库 ──
    PROJECT_WORDS = {
        "high": [
            "EPC总承包", "EPC项目", "工程总承包", "施工总承包", "PMC项目",
            "代建项目", "BT项目", "BOT项目", "PPP项目", "特许经营",
        ],
        "medium": [
            "招标", "中标", "采购", "公开招标", "邀请招标", "竞争性磋商",
            "询价采购", "单一来源", "比选", "竞谈", "磋商",
            "初步设计", "可研报告", "施工图设计", "施工准备",
            "项目建议书", "规划许可", "开工报告", "竣工验收",
        ],
        "low": [
            "水库", "灌区", "堤防", "防洪", "排涝", "泵站", "闸门",
            "河道治理", "供水", "污水处理", "水资源", "水土保持",
            "公路", "桥梁", "隧道", "高速公路", "市政道路",
            "房建", "安置房", "学校", "医院", "产业园",
            "电力", "新能源", "光伏", "风电", "抽水蓄能",
        ],
    }

    # ── 求助信号词库 ──
    HELP_WORDS = {
        "high": [
            "请问", "怎么处理", "怎么办", "求助", "有没有", "谁能帮",
            "请教", "求指导", "推荐一下", "怎么解决",
        ],
        "medium": [
            "规范", "标准", "GB", "JGJ", "JTG", "DB", "CECS",
            "造价", "定额", "预算", "结算", "审计",
            "合同", "索赔", "变更", "签证", "工期",
            "质量", "安全", "验收", "检测",
        ],
        "context": [
            "EPC", "总承包", "项目管理", "施工管理", "设计院",
            "监理", "造价咨询", "招标代理",
        ],
    }

    # ── 采购信号词库 ──
    PURCHASE_WORDS = [
        "有谁知道", "推荐", "有没有做", "哪家好", "哪里有", "需要找",
        "求介绍", "求推荐", "联系不上", "怎么联系", "联系方式",
        "供应商", "服务商", "设计单位", "施工单位", "监理单位",
    ]

    # ── 竞品信号 ──
    COMPETITOR_WORDS = [
        # 添加已知竞品名称
    ]

    # ── 省份映射 ──
    PROVINCES = [
        "北京", "天津", "河北", "山西", "内蒙古", "辽宁", "吉林", "黑龙江",
        "上海", "江苏", "浙江", "安徽", "福建", "江西", "山东", "河南",
        "湖北", "湖南", "广东", "广西", "海南", "重庆", "四川", "贵州",
        "云南", "西藏", "陕西", "甘肃", "青海", "宁夏", "新疆",
    ]

    def detect(self, text: str, sender: str = "", chat_id: str = "",
               ts: str = "") -> list[Signal]:
        """检测一条消息中的所有信号（同类型只保留最高置信度）。"""
        # 前置过滤：太短或纯表情/数字的消息不检测
        if len(text) < 12:
            return []
        import re
        clean = re.sub(r'\[[^\]]*\]|\d+', '', text)  # 去掉[表情]和纯数字
        if len(clean.strip()) < 8:
            return []

        signals = []
        text_lower = text.lower()

        # 项目信号：只认 medium 以上权重（避免纯数字/品牌名误触发）
        best_proj = None
        for level in ("high", "medium"):
            words = self.PROJECT_WORDS[level]
            weight = {"high": 0.9, "medium": 0.7}[level]
            for w in words:
                if w in text:
                    sig = Signal(
                        type=SignalType.PROJECT, text=text[:200],
                        sender=sender, chat_id=chat_id, ts=ts,
                        confidence=weight, keywords=[w],
                        province=self._find_province(text),
                        industry=self._find_industry(text),
                    )
                    if best_proj is None or weight > best_proj.confidence:
                        best_proj = sig
                    break
        if best_proj:
            # 补充同级别的其他关键词
            all_kws = [w for ws in self.PROJECT_WORDS.values() for w in ws
                       if w in text]
            best_proj.keywords = list(dict.fromkeys(all_kws))[:5]
            signals.append(best_proj)

        # 求助信号
        help_score = 0
        help_kws = []
        for level, words in self.HELP_WORDS.items():
            weight = {"high": 0.8, "medium": 0.5, "context": 0.3}[level]
            for w in words:
                if w in text_lower or w in text:
                    help_score = max(help_score, weight)
                    help_kws.append(w)
        if help_score > 0:
            signals.append(Signal(
                type=SignalType.HELP, text=text[:200],
                sender=sender, chat_id=chat_id, ts=ts,
                confidence=help_score, keywords=help_kws[:5],
            ))

        # 采购信号
        for w in self.PURCHASE_WORDS:
            if w in text:
                signals.append(Signal(
                    type=SignalType.PURCHASE, text=text[:200],
                    sender=sender, chat_id=chat_id, ts=ts,
                    confidence=0.8, keywords=[w],
                ))
                break

        return signals

    def _find_province(self, text: str) -> str:
        for p in self.PROVINCES:
            if p in text:
                return p
        return ""

    def _find_industry(self, text: str) -> str:
        industries = {
            "水利": ["水库", "灌区", "堤防", "防洪", "泵站", "河道", "水资源",
                    "水土保持", "供水", "污水"],
            "交通": ["公路", "桥梁", "隧道", "高速", "市政道路", "交通"],
            "房建": ["房建", "安置房", "学校", "医院", "产业园", "建筑"],
            "能源": ["电力", "新能源", "光伏", "风电", "抽水蓄能", "电网"],
        }
        for ind, kws in industries.items():
            if any(k in text for k in kws):
                return ind
        return ""
