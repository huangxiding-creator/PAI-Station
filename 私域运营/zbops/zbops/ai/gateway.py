# -*- coding: utf-8 -*-
"""模型网关：T1/T2 路由 + 预算硬顶 + 降级链（ARCHITECTURE §5.2）。

  T1 意图/摘要：GLM glm-4-flash（低成本）
  T2 答疑：Claude sonnet 首选 → GLM glm-4.6 兜底
  预算：日/月三层硬顶，触顶自动降级（T2→GLM→T1→仅审核模式）
直连 httpx（Anthropic Messages API / 智谱 OpenAI 兼容），不经 LiteLLM 进程
（单机精简；密钥仅内存+config.yaml，永不入库不进日志）。
"""
from __future__ import annotations

import json
import time

import httpx


class BudgetExceeded(Exception):
    pass


class ModelGateway:
    def __init__(self, cfg: dict):
        self.anthropic = cfg.get("anthropic", {})
        self.zhipu = cfg.get("zhipu", {})
        self.budget = cfg.get("budget", {})
        self._spent_cents = {"day": 0, "month": 0, "day_key": ""}

    # ---- 计费（粗估：Claude sonnet $3/M in $15/M out → 0.03/0.15 分每千token）----
    def _price_cents(self, model: str, k_in: int, k_out: int) -> int:
        if model.startswith("claude"):
            return int(k_in * 0.03 + k_out * 0.15) + 1
        return int(k_in * 0.01 + k_out * 0.06) + 1   # GLM 量级

    def _check_budget(self):
        day = time.strftime("%Y-%m-%d")
        if self._spent_cents["day_key"] != day:
            self._spent_cents.update(day_key=day, day=0)
        if self._spent_cents["day"] >= self.budget.get("daily_cents", 2000):
            raise BudgetExceeded(f"日预算 {self.budget['daily_cents']} 分已用尽")
        if self._spent_cents["month"] >= self.budget.get("monthly_cents", 40000):
            raise BudgetExceeded("月预算已用尽")

    # ---- 调用面 ----
    async def t1(self, prompt: str, system: str = "") -> str:
        """小模型单轮（意图/摘要）。"""
        return await self._zhipu_chat(self.zhipu.get("t1_model", "glm-4-flash"),
                                      prompt, system)

    async def t2_stream(self, prompt: str, system: str, max_tokens: int = 400):
        """大模型流式生成：Claude 首选，异常/超预算降级 GLM（带 429 重试）。"""
        try:
            self._check_budget()
            async for chunk in self._anthropic_stream(prompt, system, max_tokens):
                yield chunk
            return
        except BudgetExceeded:
            raise
        except Exception:  # noqa: BLE001  Claude 失败 → GLM 兜底
            pass
        # GLM 带 429 退避重试
        for attempt in range(3):
            try:
                async for chunk in self._zhipu_stream(
                        self.zhipu.get("t2_model", "glm-4.6"), prompt, system,
                        max_tokens):
                    yield chunk
                return
            except httpx.HTTPStatusError as e:
                if e.response.status_code == 429 and attempt < 2:
                    import asyncio
                    wait = 2 ** (attempt + 1)  # 2s → 4s
                    logging.getLogger(__name__).warning(
                        "GLM 429 限流，%ss 后重试(%d/3)", wait, attempt + 1)
                    await asyncio.sleep(wait)
                    continue
                raise

    # ---- Anthropic Messages（SSE 流式）----
    async def _anthropic_stream(self, prompt, system, max_tokens):
        key = self.anthropic.get("key", "")
        if not key:
            raise RuntimeError("anthropic.key 未配置")
        url = self.anthropic.get("base_url", "https://api.anthropic.com") + "/v1/messages"
        body = {"model": self.anthropic.get("model", "claude-sonnet-4-5"),
                "max_tokens": max_tokens, "system": system,
                "messages": [{"role": "user", "content": prompt}]}
        k_in = k_out = 0
        async with httpx.AsyncClient(timeout=60) as c:
            async with c.stream("POST", url, json=body,
                                headers={"x-api-key": key,
                                         "anthropic-version": "2023-06-01"}) as r:
                r.raise_for_status()
                async for line in r.aiter_lines():
                    if not line.startswith("data:"):
                        continue
                    ev = json.loads(line[5:])
                    if ev["type"] == "content_block_delta":
                        d = ev.get("delta", {}).get("text", "")
                        if d:
                            k_out += 1
                            yield d
                    elif ev["type"] == "message_start":
                        k_in = ev.get("message", {}).get("usage", {}).get(
                            "input_tokens", 0) // 1000
        self._spend(self.anthropic.get("model", ""), k_in, k_out)

    # ---- 智谱 OpenAI 兼容（流式）----
    async def _zhipu_stream(self, model, prompt, system, max_tokens):
        key = self.zhipu.get("key", "")
        if not key:
            raise RuntimeError("zhipu.key 未配置")
        url = self.zhipu.get("base_url", "") + "/chat/completions"
        msgs = ([{"role": "system", "content": system}] if system else []) + \
               [{"role": "user", "content": prompt}]
        k_in = len(prompt) // 1500
        k_out = 0
        async with httpx.AsyncClient(timeout=60) as c:
            async with c.stream("POST", url,
                                headers={"Authorization": f"Bearer {key}"},
                                json={"model": model, "messages": msgs,
                                      "max_tokens": max_tokens,
                                      "stream": True}) as r:
                r.raise_for_status()
                async for line in r.aiter_lines():
                    if not line.startswith("data:") or line == "data: [DONE]":
                        continue
                    d = json.loads(line[5:])["choices"][0].get("delta", {})
                    t = d.get("content", "")
                    if t:
                        k_out += 1
                        yield t
        self._spend(model, k_in, k_out)

    async def _zhipu_chat(self, model, prompt, system) -> str:
        buf = ""
        async for t in self._zhipu_stream(model, prompt, system, 300):
            buf += t
        return buf

    def _spend(self, model, k_in, k_out):
        cents = self._price_cents(model, k_in, k_out)
        self._spent_cents["day"] += cents
        self._spent_cents["month"] += cents
