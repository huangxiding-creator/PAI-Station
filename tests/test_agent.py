"""M4.1 执行代理：多供应商网关（failover）+断点续跑+上下文注入。"""
import json

import pytest

from paistation.execute.agent import (
    AgentRunner, LlmGateway, OpenAiCompatProvider, ProviderError)
from paistation.memory.hybrid import FtsRoute
from paistation.memory.index import FileIndexer
from paistation.memory.inject import ContextInjector


class OkProvider:
    def __init__(self, name="ok", text="网关结果"):
        self.name, self.text = name, text
        self.calls = 0

    def chat(self, messages, **kw):
        self.calls += 1
        return self.text


class BoomProvider:
    def __init__(self, name="boom"):
        self.name = name

    def chat(self, messages, **kw):
        raise ProviderError("上游断供")


# ---- 多供应商网关 ----

def test_gateway_failover_to_next_provider():
    gw = LlmGateway(providers=[BoomProvider(), OkProvider(text="备胎命中")])
    text, provider = gw.chat([{"role": "user", "content": "hi"}])
    assert text == "备胎命中"
    assert provider == "ok"


def test_gateway_all_fail_raises():
    gw = LlmGateway(providers=[BoomProvider(), BoomProvider()])
    with pytest.raises(ProviderError):
        gw.chat([{"role": "user", "content": "hi"}])


def test_gateway_from_config_builds_openai_compat():
    gw = LlmGateway.from_config({"providers": [
        {"type": "openai-compat", "name": "glm", "base_url": "https://x/v1",
         "api_key": "k", "model": "glm-5"},
    ]})
    p = gw._providers[0]
    assert isinstance(p, OpenAiCompatProvider)
    assert p.name == "glm" and p.model == "glm-5"


def test_openai_compat_no_key_leak_in_error():
    p = OpenAiCompatProvider("glm", base_url="http://127.0.0.1:1/v1",
                             api_key="SECRET", model="m")
    with pytest.raises(ProviderError) as ei:
        p.chat([{"role": "user", "content": "x"}])
    assert "SECRET" not in str(ei.value)      # 密钥绝不进错误信息


# ---- AgentRunner：断点+缓存+注入 ----

def _card():
    from paistation.proactive.taskcards import extract_task_cards
    return extract_task_cards([{"ts": "2026-09-13T10:00:00",
                                "type": "voice.transcript", "source": "mic",
                                "text": "请帮我调研一下腾讯办公助手的定价策略。",
                                "speaker": "user", "evidence": {},
                                "meta": {}}])[0]


def test_runner_checkpoint_and_idempotent(tmp_path):
    prov = OkProvider(text="调研报告：腾讯会议企业版每账号每年 680 元。")
    runner = AgentRunner(gateway=LlmGateway([prov]), runs_dir=tmp_path)
    card = _card()
    out1 = runner.run(card)
    assert "680" in out1
    ck = json.loads((tmp_path / f"{card.card_id}.json").read_text(encoding="utf-8"))
    assert ck["status"] == "done" and ck["provider"] == "ok"
    calls_before = prov.calls
    out2 = runner.run(card)                   # 断点缓存：不再打网关
    assert out2 == out1 and prov.calls == calls_before


def test_runner_injects_context_pack(tmp_path):
    from paistation.memory.embeddings import HashingEmbedder
    from paistation.memory.hybrid import HybridRetriever, VecRoute
    corpus = tmp_path / "docs"
    corpus.mkdir()
    (corpus / "定价.md").write_text("腾讯会议企业版定价每账号每年680元",
                                    encoding="utf-8")
    fts = FtsRoute(db_path=tmp_path / "fts.db")
    vec = VecRoute(db_path=tmp_path / "vec.db", embedder=HashingEmbedder(dim=256))
    FileIndexer(routes=[fts, vec]).scan(corpus)
    injector = ContextInjector(retriever=HybridRetriever(routes={"vec": vec, "fts": fts}))

    seen = {}

    class Spy(OkProvider):
        def chat(self, messages, **kw):
            seen["prompt"] = "\n".join(m["content"] for m in messages)
            return super().chat(messages, **kw)

    runner = AgentRunner(gateway=LlmGateway([Spy(text="ok")]),
                         injector=injector, runs_dir=tmp_path / "runs")
    runner.run(_card())
    assert "腾讯会议企业版定价" in seen["prompt"]   # 记忆已注入执行上下文
