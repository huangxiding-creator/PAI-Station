"""语义缓存（第 26 章兵器五）：近重复命中，本地零依赖。

匹配判定：token 集 Jaccard 相似度 ≥ 阈值（中文二元 + 英文词；
短文本上 SimHash 海明距离信噪比不足——一词之差 16 位 vs 无关 33 位，
实测无法单阈值切分，故 SimHash 仅作指纹工具，匹配用确定性 Jaccard）。
容量上限 LRU 淘汰；get 返回副本（不可回写内部状态）。
"""
import hashlib
import re
import threading
from collections import OrderedDict

_CJK = re.compile(r"[一-鿿]+")
_WORD = re.compile(r"[a-z0-9_]+")


def _tokens(text: str) -> frozenset:
    """英文按词、中文按二元（bigram）——整句单 token 会让一词之差翻转全部位。"""
    tokens = _WORD.findall(text)
    for run in _CJK.findall(text):
        tokens += [run[i:i + 2] for i in range(len(run) - 1)] or [run]
    return frozenset(tokens)


def jaccard(a: frozenset, b: frozenset) -> float:
    if not a and not b:
        return 1.0
    if not a or not b:
        return 0.0
    return len(a & b) / len(a | b)


def simhash(text: str) -> int:
    """64 位 SimHash 指纹（长文本近重复/挥霍日志去重用）。"""
    votes = [0] * 64
    for token in _tokens(text.lower()):
        digest = hashlib.md5(token.encode("utf-8")).digest()
        h = int.from_bytes(digest[:8], "big")
        for i in range(64):
            votes[i] += 1 if (h >> i) & 1 else -1
    return sum(1 << i for i in range(64) if votes[i] > 0)


def hamming(a: int, b: int) -> int:
    return bin(a ^ b).count("1")


class SemanticCache:
    """prompt → result 的近重复缓存（线程安全）。"""

    def __init__(self, capacity: int = 512, threshold: float = 0.6):
        self._capacity = capacity
        self._threshold = threshold
        self._lock = threading.Lock()
        self._entries: OrderedDict[frozenset, dict] = OrderedDict()
        self.stats = {"hits": 0, "misses": 0, "entries": 0}

    def get(self, prompt: str) -> dict | None:
        sig = _tokens(prompt.lower())
        with self._lock:
            best_key, best_sim = None, 0.0
            for key in self._entries:
                sim = jaccard(sig, key)
                if sim > best_sim:
                    best_key, best_sim = key, sim
            if best_key is not None and best_sim >= self._threshold:
                self._entries.move_to_end(best_key)
                self.stats["hits"] += 1
                self.stats["entries"] = len(self._entries)
                return dict(self._entries[best_key])
        self.stats["misses"] += 1
        return None

    def put(self, prompt: str, result: dict) -> None:
        key = _tokens(prompt.lower())
        with self._lock:
            self._entries[key] = dict(result)
            self._entries.move_to_end(key)
            while len(self._entries) > self._capacity:
                self._entries.popitem(last=False)
            self.stats["entries"] = len(self._entries)
