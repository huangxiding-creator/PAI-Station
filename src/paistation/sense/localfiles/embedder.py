"""嵌入器（P2）：Ollama bge-m3 探测 → callable；缺席即 None 降级。

调研铁律：主流默认 embedding 全英语向，中文场景必须 bge-m3 级
（ragflow TEI+bge-m3 全链路范式）。Ollama 未装/未起 → 返回 None，
上层自动 keyword-only，检索永不因此 502。
"""
from __future__ import annotations

import json
import logging
import urllib.request

_log = logging.getLogger("paistation.sense.localfiles.embedder")

DEFAULT_MODEL = "bge-m3"
DEFAULT_ENDPOINT = "http://127.0.0.1:11434/api/embeddings"
PROBE_TIMEOUT = 1.5
EMBED_TIMEOUT = 30.0


def _post(url: str, payload: dict, timeout: float) -> dict:
    req = urllib.request.Request(
        url, data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return json.loads(resp.read().decode("utf-8"))


def make_ollama_embedder(endpoint: str = DEFAULT_ENDPOINT,
                         model: str = DEFAULT_MODEL):
    """→ callable(text)->list[float]；服务不在位返回 None。"""
    try:
        out = _post(endpoint, {"model": model, "prompt": "probe"}, PROBE_TIMEOUT)
        if not out.get("embedding"):
            return None
    except Exception as exc:
        _log.info("嵌入服务不在位（keyword-only 降级）: %s", exc)
        return None

    def embed(text: str) -> list[float]:
        out = _post(endpoint, {"model": model, "prompt": text}, EMBED_TIMEOUT)
        vec = out.get("embedding") or []
        if not vec:
            raise RuntimeError("嵌入返回为空")
        return vec

    return embed


def ollama_embedder_version(model: str = DEFAULT_MODEL) -> str:
    return f"ollama:{model}"
