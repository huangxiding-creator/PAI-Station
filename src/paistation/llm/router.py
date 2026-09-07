"""Kahneman 双系统路由（提案 4.2 / 第 3 章）：低置信度自动升级深思考。

系统 1 = fast()；置信度 < upgrade_confidence（默认 0.7，严格小于）
→ 系统 2 = deep()（thinking 开关）。路由路径全程可审计。
"""
from paistation.llm.zhipu_client import ZhipuClient


class Router:
    """fast→deep 升级路由。client 需实现 fast()/deep() 契约。"""

    def __init__(self, client: ZhipuClient, upgrade_confidence: float = 0.7):
        if not 0.5 <= upgrade_confidence <= 0.9:  # 与附录 C.1 取值域一致
            raise ValueError(f"upgrade_confidence 越界：{upgrade_confidence}（0.5-0.9）")
        self._client = client
        self._threshold = upgrade_confidence

    def route(self, prompt: str, context: str = "") -> dict:
        """返回 {text, path, confidence, usage, upgraded}。"""
        first = self._client.fast(prompt, context)
        path = ["fast"]
        result: dict = first
        if first["confidence"] < self._threshold:
            result = self._client.deep(prompt)
            path.append("deep")
        return {"text": result["text"], "path": path,
                "confidence": result.get("confidence"),
                "usage": first.get("usage", {}),
                "upgraded": len(path) > 1}
