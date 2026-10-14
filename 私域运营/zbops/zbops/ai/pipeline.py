# -*- coding: utf-8 -*-
"""AI 编排管线（唯一大脑）：规则预筛→意图→RAG→生成→引用校验→护栏→治理。

铁律（ARCHITECTURE §4 裁定1）：LLM 只做理解与生成，
"要不要发/发多少"全部由确定性规则（治理器）决定。
"""
from __future__ import annotations

import re

from . import citation
from .gateway import ModelGateway
from .retriever import Retriever

# 规则预筛（零模型成本）：标准号/疑问句式
STD_Q = re.compile(
    r"(GB|JGJ|JTG|JTS|DB|DL|NB|CECS)[/T]*\s*[\d\.]+")
QUESTION = re.compile(r"[?？]|请问|怎么|如何|什么|为什么|能否|可否|是否")


class Pipeline:
    def __init__(self, gw: ModelGateway, retriever: Retriever,
                 system_prompt: str, max_group_tokens: int = 400):
        self.gw = gw
        self.kb = retriever
        self.system = system_prompt
        self.max_tokens = max_group_tokens

    async def _intent(self, text: str) -> str:
        """T1 分类：engineering / resource / lead / chitchat / sensitive。"""
        if STD_Q.search(text) or QUESTION.search(text):
            return "engineering"
        rsp = await self.gw.t1(
            f'把下面微信群消息分为 engineering/resource/lead/chitchat/sensitive '
            f'之一，只回一个词：\n{text[:200]}')
        label = rsp.strip().lower()
        return label if label in ("engineering", "resource", "lead", "chitchat",
                                  "sensitive") else "chitchat"

    async def answer(self, question: str, ctx: dict):
        """流式产出答案。非工程问题短路返回礼貌话术。"""
        intent = await self._intent(question)
        if intent in ("chitchat", "sensitive"):
            yield "这个问题我先不展开，工程相关问题欢迎随时@我～"
            return

        chunks = self.kb.retrieve(question)
        refs = "\n\n".join(f"[{c['std_no']} {c['clause']}] {c['text'][:400]}"
                           for c in chunks) or "（检索无命中）"
        prompt = (f"检索资料：\n{refs}\n\n群友提问：{question}\n\n"
                  f"基于以上资料回答；无命中时如实说明并建议查阅正式版规范。")

        buf = ""
        async for chunk in self.gw.t2_stream(prompt, self.system,
                                             self.max_tokens):
            buf += chunk
            yield chunk

        # 引用校验（生成后、Guardian 放行前）——失败补发更正声明
        ok, failures = citation.verify(buf, chunks)
        if not ok:
            yield f"\n（更正：上文引用 {failures} 未能溯源，请以现行正式版规范为准）"
