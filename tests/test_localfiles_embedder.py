"""嵌入器探测：两段式 probe——超时=冷加载值得长等，拒绝类秒退。"""
import socket
import urllib.error

import pytest

from paistation.sense.localfiles import embedder as emb


class _Timeout(Exception):
    pass


def _use_posts(monkeypatch, responses):
    """按序回放 _post 结果；responses 元素=返回值或异常类/实例。"""
    calls = []
    queue = list(responses)

    def fake_post(url, payload, timeout):
        calls.append(timeout)
        item = queue.pop(0)
        if isinstance(item, BaseException) or (
                isinstance(item, type) and issubclass(item, BaseException)):
            raise item
        return item

    monkeypatch.setattr(emb, "_post", fake_post)
    return calls


def test_probe_times_out_then_succeeds_on_cold_load(monkeypatch):
    """快段超时 → 长段（150s）重试成功：凌晨冷加载场景。"""
    calls = _use_posts(monkeypatch, [
        socket.timeout("timed out"),            # 1.5s 段超时
        {"embeddings": [[0.1] * 4]},            # 150s 段成功
    ])
    out = emb._probe("http://x/api/embed", {"input": ["probe"]})
    assert out == {"embeddings": [[0.1] * 4]}
    assert calls == [emb.PROBE_TIMEOUT, emb.COLD_LOAD_TIMEOUT]


def test_probe_permanent_error_no_retry(monkeypatch):
    """连接拒绝类毫秒级返回，不吃 150s 长等。"""
    calls = _use_posts(monkeypatch, [
        ConnectionRefusedError("[Errno 111] Connection refused"),
    ])
    with pytest.raises(ConnectionRefusedError):
        emb._probe("http://x/api/embed", {})
    assert calls == [emb.PROBE_TIMEOUT]  # 只有快段


def test_embedder_returns_callable_after_cold_load(monkeypatch):
    """冷加载场景下 make_ollama_embedder 不再误判 None（今晚 04:17 链路的雷）。"""
    vec = [0.0] * 1024
    _use_posts(monkeypatch, [
        urllib.error.URLError(socket.timeout("timed out")),  # probe 快段
        {"embedding": vec},                                  # probe 长段
        {"embedding": vec},                                  # 正式嵌入
    ])
    fn = emb.make_ollama_embedder()
    assert fn is not None
    assert fn("任意文本") == vec


def test_embedder_none_when_service_absent(monkeypatch):
    """服务不在位（拒绝）→ None，keyword-only 降级路径不变。"""
    _use_posts(monkeypatch, [
        ConnectionRefusedError("[Errno 10061] 连接失败"),
    ])
    assert emb.make_ollama_embedder() is None


def test_batch_embedder_survives_cold_load(monkeypatch):
    """批量路同样吃两段式：超时后长等到 embeddings。"""
    vecs = [[0.1] * 4]
    _use_posts(monkeypatch, [
        socket.timeout("timed out"),   # 快段
        {"embeddings": vecs},          # 长段
        {"embeddings": vecs},          # embed_batch 正式调用
    ])
    fn = emb.make_ollama_batch_embedder()
    assert fn is not None
    assert fn(["t"]) == vecs
