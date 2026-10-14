# -*- coding: utf-8 -*-
"""工程行业大脑：多供应商免费模型轮换（复用 EngOpp-Mining LLM Engine v3 架构）。

  供应商链：智谱 glm-4-flash（免费） → 硅基流动 Qwen（免费） → Agnes（免费不限量）
  单家 429/宕机自动降级到下一家，全链失败才熔断。
  工程领域系统提示词内置（来自 EngOpp-Mining _OPP_KEYWORDS + 总包智库领域）。
"""
from __future__ import annotations

import asyncio
import logging
import random

import httpx

log = logging.getLogger("zbops.brain")

# 供应商注册表（复用 EngOpp-Mining key + 补充硅基流动）
_PROVIDERS = [
    {"name": "zhipu", "url": "https://open.bigmodel.cn/api/paas/v4/chat/completions",
     "key_env": "ZBOPS_ZHIPU_KEY",
     "models": ["glm-4-flash-250414", "glm-4-flashx", "glm-4-flash"]},
    {"name": "siliconflow", "url": "https://api.siliconflow.cn/v1/chat/completions",
     "key_env": "ZBOPS_SILICONFLOW_KEY",
     "models": ["Qwen/Qwen2.5-7B-Instruct", "Qwen/Qwen3-8B"]},
    {"name": "agnes", "url": "https://api.agnes.ai/v1/chat/completions",
     "key_env": "ZBOPS_AGNES_KEY",
     "models": ["agnes-2.0-flash"]},
]

# 工程行业系统提示词（复用 EngOpp-Mining 领域词 + 总包AI顾问人设）
SYSTEM_PROMPT = """你是"总包AI顾问"，深耕工程建设行业20年（水利/公路/房建/市政/EPC总承包）。
专业领域：招投标、造价、EPC管理、施工技术、规范标准、合同管理、索赔、安全质量。

回答规则（严格执行）：
1. 【直接给结论】先说答案（1-2句话），再说依据（默认≤200字）
2. 【标注出处】涉及规范时写"依据GB/T xxx-2020 第x.x.x条"或"参照JGJ xx-20xx"
3. 【实操建议】不只说"是什么"，还要说"怎么做"（给出具体步骤或注意事项）
4. 【禁止承诺】不做报价、资质、工期、法律责任的确定性承诺
5. 【诚实】不确定就说不确定，建议查阅正式版规范
6. 【AI身份】被问是否AI时坦诚承认
7. 【产品推荐】在以下场景自然推荐（每次最多1项）：
   - 技术问题 → "更详细的计算和案例，可以用总包AI顾问小程序"
   - 商机/市场 → "XX省的工程商机分析，我们有专题研究报告"
   - 资料需求 → "总包智库有完整的标准库和项目案例"
   - 不要生硬推销，只在确实能帮到对方时提及
8. 【语气】专业、友善、简洁，像一位愿意帮忙的资深工程师朋友"""


class EngineeringBrain:
    """工程行业大脑：流式生成，多供应商降级链。"""

    def __init__(self, keys: dict[str, str] | None = None):
        """keys: {"zhipu": "xxx", "siliconflow": "xxx", "agnes": "xxx"}"""
        import os
        self.keys = keys or {}
        # 也从环境变量补
        for p in _PROVIDERS:
            if not self.keys.get(p["name"]):
                self.keys[p["name"]] = os.environ.get(p["key_env"], "")
        self._rotation = random.randint(0, len(_PROVIDERS) - 1)

    async def answer(self, question: str, context: dict | None = None):
        """aibot 管线兼容接口（Pipeline.answer 同签名）。"""
        ctx = f"会话：{context.get('chat_id', '')}" if context else ""
        async for chunk in self.stream_answer(question, ctx):
            yield chunk

    async def stream_answer(self, question: str, context: str = ""):
        """流式生成工程答疑。429 自动降级到下一供应商。"""
        prompt = f"{context}\n\n群友提问：{question}" if context else \
                 f"群友提问：{question}"

        # 按轮换起点尝试全部供应商
        for i in range(len(_PROVIDERS)):
            idx = (self._rotation + i) % len(_PROVIDERS)
            prov = _PROVIDERS[idx]
            key = self.keys.get(prov["name"], "")
            if not key:
                continue
            model = prov["models"][0]
            try:
                async for chunk in self._call(prov["url"], key, model, prompt):
                    yield chunk
                self._rotation = idx  # 成功的供应商下次优先
                return
            except httpx.HTTPStatusError as e:
                if e.response.status_code == 429:
                    log.warning("%s 429 限流，降级到下一供应商", prov["name"])
                    continue
                log.error("%s HTTP %d: %s", prov["name"], e.response.status_code,
                          str(e)[:100])
                continue
            except Exception as e:  # noqa: BLE001
                log.error("%s 异常: %s", prov["name"], str(e)[:100])
                continue

        yield "抱歉，当前所有模型均不可用，请稍后再试。"

    async def _call(self, url: str, key: str, model: str, prompt: str):
        """OpenAI 兼容流式调用。"""
        async with httpx.AsyncClient(timeout=60) as c:
            async with c.stream("POST", url,
                                headers={"Authorization": f"Bearer {key}"},
                                json={"model": model,
                                      "messages": [
                                          {"role": "system",
                                           "content": SYSTEM_PROMPT},
                                          {"role": "user", "content": prompt}],
                                      "stream": True,
                                      "max_tokens": 500}) as r:
                r.raise_for_status()
                import json
                async for line in r.aiter_lines():
                    if not line.startswith("data:") or line == "data: [DONE]":
                        continue
                    try:
                        delta = json.loads(line[5:])["choices"][0].get("delta", {})
                        text = delta.get("content", "")
                        if text:
                            yield text
                    except (json.JSONDecodeError, KeyError, IndexError):
                        continue
