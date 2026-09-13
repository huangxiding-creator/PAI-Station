"""M4.1 执行代理（09 卷缝合）：多供应商网关+断点缓存+记忆注入。

"不被任何上游卡脖子"是生死架构（Anthropic 封杀 OpenClaw 用户实证）：
网关按优先级 failover，单供应商故障不连坐。断点=runs/{card_id}.json，
done 即缓存（幂等重跑不打网关）。密钥纪律：api_key 只从配置/环境来，
错误信息绝不携带。
"""
from __future__ import annotations

import json
import logging
import urllib.error
import urllib.request
from datetime import datetime
from pathlib import Path

_log = logging.getLogger("paistation.execute.agent")

SYSTEM_PROMPT = (
    "你是 PAI-Station 个人 AI 工作站的执行代理，替用户完成已确认的任务。"
    "产出直接可用的 markdown 成果（结论先行、证据带出处、行动项带截止）。"
)


class ProviderError(RuntimeError):
    pass


class OpenAiCompatProvider:
    """OpenAI 兼容 chat/completions（GLM/DeepSeek/Kimi/本地 vLLM 皆此形状）。"""

    def __init__(self, name: str, base_url: str, api_key: str, model: str,
                 timeout: float = 120.0):
        self.name = name
        self._url = base_url.rstrip("/") + "/chat/completions"
        self._key = api_key
        self.model = model
        self._timeout = timeout

    def chat(self, messages: list[dict], temperature: float = 0.3,
             max_tokens: int = 4096) -> str:
        body = json.dumps({"model": self.model, "messages": messages,
                           "temperature": temperature,
                           "max_tokens": max_tokens}).encode("utf-8")
        req = urllib.request.Request(
            self._url, data=body, method="POST",
            headers={"Content-Type": "application/json",
                     "Authorization": f"Bearer {self._key}"})
        try:
            with urllib.request.urlopen(req, timeout=self._timeout) as resp:
                payload = json.loads(resp.read().decode("utf-8"))
        except urllib.error.HTTPError as exc:
            raise ProviderError(f"{self.name} HTTP {exc.code}") from None
        except (urllib.error.URLError, TimeoutError, OSError) as exc:
            # 密钥在请求头不在 URL——错误只报类型，零泄露面
            raise ProviderError(
                f"{self.name} 请求失败: {type(exc).__name__}") from None
        except (ValueError, UnicodeDecodeError):
            raise ProviderError(f"{self.name} 响应非 JSON") from None
        try:
            return payload["choices"][0]["message"]["content"]
        except (KeyError, IndexError, TypeError):
            raise ProviderError(f"{self.name} 响应缺 choices") from None


class LlmGateway:
    """按注册序 failover 的多供应商网关。chat 返回 (text, provider_name)。"""

    def __init__(self, providers: list):
        self._providers = list(providers)

    @classmethod
    def from_config(cls, cfg: dict) -> "LlmGateway":
        providers = []
        for c in cfg.get("providers", []):
            if c.get("type") == "openai-compat":
                providers.append(OpenAiCompatProvider(
                    name=c["name"], base_url=c["base_url"],
                    api_key=c.get("api_key", ""), model=c.get("model", ""),
                    timeout=float(c.get("timeout", 120))))
        return cls(providers)

    def chat(self, messages: list[dict], **kw) -> tuple[str, str]:
        last: ProviderError | None = None
        for p in self._providers:
            try:
                return p.chat(messages, **kw), p.name
            except ProviderError as exc:
                _log.warning("供应商 %s 失败，切换下一个: %s", p.name, exc)
                last = exc
        raise last or ProviderError("无可用供应商")


class AgentRunner:
    """任务卡→prompt（含记忆注入）→网关→断点落盘。"""

    def __init__(self, gateway, injector=None, runs_dir: str | Path | None = None):
        self._gateway = gateway
        self._injector = injector
        self._runs = Path(runs_dir) if runs_dir else None
        if self._runs:
            self._runs.mkdir(parents=True, exist_ok=True)

    def _ck_path(self, card_id: str) -> Path | None:
        return (self._runs / f"{card_id}.json") if self._runs else None

    def _save(self, card_id: str, state: dict) -> None:
        p = self._ck_path(card_id)
        if p:
            p.write_text(json.dumps(state, ensure_ascii=False, indent=1),
                         encoding="utf-8")

    def run(self, card) -> str:
        p = self._ck_path(card.card_id)
        if p and p.is_file():  # 断点缓存：done 即幂等返回
            try:
                ck = json.loads(p.read_text(encoding="utf-8"))
                if ck.get("status") == "done":
                    return ck["output"]
            except (OSError, ValueError):
                pass
        pack = ""
        if self._injector:
            try:
                pack = self._injector.build(card.title, k=5, budget_tokens=3000)
            except Exception as exc:  # noqa: BLE001 - 检索故障不阻塞执行
                _log.warning("记忆注入失败（裸跑）: %s", exc)
        system = SYSTEM_PROMPT + (f"\n\n## 相关记忆（硬盘检索注入）\n{pack}"
                                  if pack else "")
        user = (f"任务：{card.title}\n"
                f"截止：{card.deadline or '未定'}\n"
                f"证据事件时间：{card.evidence.get('ts', '')}\n"
                "请产出可交付成果（markdown 全文）。")
        self._save(card.card_id, {"card_id": card.card_id,
                                  "status": "running",
                                  "ts": datetime.now().isoformat()})
        text, provider = self._gateway.chat(
            [{"role": "system", "content": system},
             {"role": "user", "content": user}])
        self._save(card.card_id, {"card_id": card.card_id, "status": "done",
                                  "provider": provider, "output": text,
                                  "ts": datetime.now().isoformat()})
        return text
