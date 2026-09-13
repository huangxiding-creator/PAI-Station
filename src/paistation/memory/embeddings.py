"""M2.1 嵌入后端（02 卷）：HashingEmbedder 兜底 + OnnxBgeM3 升级位。

架构裁决：向量层是增强不是依赖——HashingEmbedder 零依赖确定性哈希
（N 维 bag-of-ngrams 归一化），保证检索管线在任何机器可跑；bge-m3
ONNX int8 模型在位时自动升级（ModelManager 同款双根扫描）。
水位线增量：`changed_since(watermark)` 语义由 VecIndex 维护（mtime
游标），全量重建只在模型换代时发生。
"""
from __future__ import annotations

import hashlib
import logging
import os

import numpy as np

_log = logging.getLogger("paistation.memory.embeddings")

BGE_M3_DIR = "bge-m3-onnx"


class HashingEmbedder:
    """确定性 ngram 哈希嵌入（零依赖兜底；中文 bigram+英文词袋）。"""

    def __init__(self, dim: int = 256):
        self._dim = dim

    @property
    def dim(self) -> int:
        return self._dim

    def _tokens(self, text: str) -> list[str]:
        out: list[str] = []
        buf = ""
        for ch in text:
            if "一" <= ch <= "鿿":
                if buf:
                    out.append(buf.lower())
                    buf = ""
                out.append(ch)
            elif ch.isalnum():
                buf += ch
            else:
                if buf:
                    out.append(buf.lower())
                    buf = ""
        if buf:
            out.append(buf.lower())
        return ([t for t in out if not ("一" <= t[0] <= "鿿")]
                + [out[i] + out[i + 1] for i in range(len(out) - 1)
                   if "一" <= out[i][0] <= "鿿"
                   and "一" <= out[i + 1][0] <= "鿿"])

    def embed(self, texts: list[str]) -> np.ndarray:
        vecs = np.zeros((len(texts), self._dim), dtype=np.float32)
        for i, text in enumerate(texts):
            for tok in self._tokens(text):
                h = int.from_bytes(
                    hashlib.blake2b(tok.encode("utf-8"),
                                    digest_size=8).digest(), "little")
                vecs[i, h % self._dim] += 1.0
        norms = np.linalg.norm(vecs, axis=1, keepdims=True)
        norms[norms == 0] = 1.0
        return vecs / norms


def find_bge_m3(roots: tuple[str, ...] = ("models",)) -> str | None:
    """bge-m3 ONNX 目录就绪判定（model.onnx+tokenizer.json）。"""
    for root in roots:
        appdata = os.path.expandvars(r"%APPDATA%\PAI-Station\models")
        for r in (root, appdata):
            d = os.path.join(r, BGE_M3_DIR)
            if (os.path.isfile(os.path.join(d, "model.onnx"))
                    and os.path.isfile(os.path.join(d, "tokenizer.json"))):
                return d
    return None


class OnnxBgeM3:
    """bge-m3 ONNX 推理（升级位；tokenizers 包 + onnxruntime）。

    模型获取：scripts/fetch_bge_m3.py（hf-mirror 下载 model.onnx+
    tokenizer.json 到 models/bge-m3-onnx/）。语义质量显著优于
    HashingEmbedder，代价 ~600MB 内存与首次加载秒级延迟。
    """

    def __init__(self, model_dir: str, dim: int = 1024):
        import onnxruntime as ort

        self._dim = dim
        self._session = ort.InferenceSession(
            os.path.join(model_dir, "model.onnx"),
            providers=["CPUExecutionProvider"])
        from tokenizers import Tokenizer
        self._tok = Tokenizer.from_file(
            os.path.join(model_dir, "tokenizer.json"))

    @property
    def dim(self) -> int:
        return self._dim

    def embed(self, texts: list[str]) -> np.ndarray:
        enc = self._tok.encode_batch(texts)
        ids = np.zeros((len(texts), 256), dtype=np.int64)
        mask = np.zeros((len(texts), 256), dtype=np.int64)
        for i, e in enumerate(enc):
            t = e.ids[:256]
            ids[i, :len(t)] = t
            mask[i, :len(t)] = 1
        out = self._session.run(None, {"input_ids": ids, "attention_mask": mask})
        vecs = np.asarray(out[0], dtype=np.float32)[:, 0, :]  # CLS
        norms = np.linalg.norm(vecs, axis=1, keepdims=True)
        norms[norms == 0] = 1.0
        return (vecs / norms).astype(np.float32)


def make_embedder(roots: tuple[str, ...] = ("models",)) -> HashingEmbedder | OnnxBgeM3:
    """工厂：bge-m3 在位用之，否则 hashing 兜底（降级矩阵）。"""
    d = find_bge_m3(roots)
    if d:
        try:
            return OnnxBgeM3(d)
        except Exception as exc:  # noqa: BLE001 - 模型坏不阻塞检索
            _log.warning("bge-m3 加载失败退 hashing: %s", exc)
    return HashingEmbedder()
