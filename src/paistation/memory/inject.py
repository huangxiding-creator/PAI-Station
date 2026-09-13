"""M2.5 上下文注入器：检索→pack 组装（M4 execute/agent 的记忆接口）。

M4 的 agent 网关拿任务卡后调 build(query) 得到 markdown 上下文包，
拼进 system 消息——"硬盘即记忆，按需检索注入"的注入端。
空结果回空串：宁可无上下文，不可编上下文。
"""
from __future__ import annotations

from paistation.memory.hybrid import HybridRetriever
from paistation.memory.layers import LayeredLoader


class ContextInjector:
    def __init__(self, retriever: HybridRetriever,
                 loader: LayeredLoader | None = None):
        self._retriever = retriever
        self._loader = loader or LayeredLoader()

    def build(self, query: str, k: int = 8, budget_tokens: int = 4000) -> str:
        """query→命中集→预算内上下文包；零命中回空串。"""
        hits = self._retriever.retrieve(query, k=k, budget_tokens=budget_tokens)
        if not hits:
            return ""
        return self._loader.pack(hits, budget_tokens=budget_tokens)
