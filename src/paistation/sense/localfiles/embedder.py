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
COLD_LOAD_TIMEOUT = 150.0  # 模型冷加载实测 ~78s：probe 超时值得等
EMBED_TIMEOUT = 30.0


def _post(url: str, payload: dict, timeout: float) -> dict:
    req = urllib.request.Request(
        url, data=json.dumps(payload).encode("utf-8"),
        headers={"Content-Type": "application/json"}, method="POST")
    with urllib.request.urlopen(req, timeout=timeout) as resp:
        return json.loads(resp.read().decode("utf-8"))


def _probe(url: str, payload: dict) -> dict:
    """两段式探测：快失败（1.5s）识别服务不在位；超时=模型冷加载中
    ——凌晨首跑实测 78s 加载，值得长等（否则批量回填任务必然误判
    拒跑）。连接拒绝类错误毫秒级返回不吃长超时。"""
    try:
        return _post(url, payload, PROBE_TIMEOUT)
    except Exception as first:
        if "timed out" not in str(first).lower() and "timeout" not in str(first).lower():
            raise  # 永久错误（拒绝/404）不重试
        _log.info("探测超时（疑模型冷加载 ~78s），长等待重试")
        return _post(url, payload, COLD_LOAD_TIMEOUT)


def make_ollama_embedder(endpoint: str = DEFAULT_ENDPOINT,
                         model: str = DEFAULT_MODEL):
    """→ callable(text)->list[float]；服务不在位返回 None。"""
    try:
        out = _probe(endpoint, {"model": model, "prompt": "probe"})
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


def make_ollama_batch_embedder(
        endpoint: str = DEFAULT_ENDPOINT.replace("/embeddings", "/embed"),
        model: str = DEFAULT_MODEL):
    """批量嵌入器：callable(texts)->list[vec]，走 /api/embed 一次推理。

    回填专用——单条老接口逐次 HTTP+推理启动开销，实测 1 块/s；
    批量 128/片摊薄后 30 块/s（RTX 3000 实测，batch>128 无增益）。
    服务不在位返回 None（上层回退逐条）。
    """
    try:
        out = _probe(endpoint, {"model": model, "input": ["probe"]})
        if not out.get("embeddings"):
            return None
    except Exception as exc:
        _log.info("批量嵌入服务不在位: %s", exc)
        return None

    def embed_batch(texts: list[str]) -> list[list[float]]:
        out = _post(endpoint, {"model": model, "input": texts},
                    max(EMBED_TIMEOUT, 8.0 * len(texts)))
        vecs = out.get("embeddings") or []
        if len(vecs) != len(texts):
            raise RuntimeError(f"批量返回数不符 {len(vecs)}!={len(texts)}")
        return vecs

    return embed_batch
