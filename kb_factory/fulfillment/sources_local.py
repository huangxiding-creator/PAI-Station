# -*- coding: utf-8 -*-
"""W7 本地绿源适配器（v1 真实可交付的底气）。

扫自产研报 PDF 与自有知识件 .md 建索引（标题/路径/大小/哈希惰性），
按标题关键词 match(query, limit)。路径可用环境变量 KB_LOCAL_CORPUS 覆盖
（os.pathsep 分隔多目录）；扫不到任何文件 → available=False。
"""
import hashlib
import os
import re
import time
from dataclasses import dataclass, field
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
ENV_KEY = "KB_LOCAL_CORPUS"

# 默认语料：09 发布 下自产研报 PDF（递归）+ mosaico 水利安全知识件
DEFAULT_CORPUS_DIRS = [
    REPO_ROOT / "09 发布",
    REPO_ROOT / "mosaico-water-safety" / "assets" / "knowledge",
]
SCAN_EXTS = {".pdf", ".md"}
SKIP_DIRS = {"_credentials", "outbox", "inbox", "done", "failed", "samples", "__pycache__"}

# 槽位标题清洗：去扩展名、去 _core_001 型尾缀、去编号前缀
_TAIL_NUM = re.compile(r"[_\-](?:core|field|guide)[_\-]?\d+$")
_HEAD_NUM = re.compile(r"^\d+[._\-、]\s*")
_SEG_SPLIT = re.compile(r"[\s·、，,;；/|/\\_\-()（）\[\]【】]+")


@dataclass
class LocalItem:
    """一条本地绿源文件（哈希惰性计算并缓存）。"""
    title: str                 # 文件名去扩展名
    path: str                  # 绝对路径
    size_bytes: int
    ext: str                   # pdf/md
    _sha: str | None = field(default=None, repr=False)

    def sha256(self) -> str:
        if self._sha is None:
            h = hashlib.sha256()
            with open(self.path, "rb") as f:
                for chunk in iter(lambda: f.read(1 << 20), b""):
                    h.update(chunk)
            self._sha = h.hexdigest()
        return self._sha


def _clean_title(t: str) -> str:
    t = _HEAD_NUM.sub("", t.strip())
    t = _TAIL_NUM.sub("", t)
    return t.strip()


def _score(query: str, title: str) -> int:
    """标题关键词打分：全词包含 > 多段命中 > 单段命中；零命中不算匹配。"""
    q = _clean_title(query)
    t = title
    if not q:
        return 0
    if q in t:
        return 100
    segs = [s for s in _SEG_SPLIT.split(q) if len(s) >= 2]
    if not segs:                       # 整词就是一个短 CJK 词
        return 100 if q in t else 0
    hit = sum(1 for s in segs if s in t)
    if hit == 0:
        return 0
    return hit * 10 + (5 if hit == len(segs) else 0)  # 全段命中加分


class LocalCorpus:
    """本地绿源索引。roots=None 时：env KB_LOCAL_CORPUS → 默认两处。"""

    def __init__(self, roots: list | None = None):
        if roots is None:
            env = os.environ.get(ENV_KEY, "").strip()
            roots = [p for p in env.split(os.pathsep) if p.strip()] if env else \
                [str(p) for p in DEFAULT_CORPUS_DIRS]
        self.roots = [str(r) for r in roots]
        self._items: list[LocalItem] = []
        self._available = False
        self.scan_ms = 0

    def scan(self) -> bool:
        """递归扫描 .pdf/.md 建索引（跳过凭据/产线目录）。"""
        t0 = time.perf_counter()
        items: list[LocalItem] = []
        for root in self.roots:
            r = Path(root)
            if not r.is_dir():
                continue
            for dirpath, dirnames, filenames in os.walk(r):
                dirnames[:] = [d for d in dirnames
                               if d not in SKIP_DIRS and not d.startswith(".")]
                for fn in filenames:
                    ext = os.path.splitext(fn)[1].lower()
                    if ext not in SCAN_EXTS:
                        continue
                    p = Path(dirpath) / fn
                    try:
                        size = p.stat().st_size
                    except OSError:
                        continue
                    items.append(LocalItem(title=_clean_title(os.path.splitext(fn)[0]),
                                           path=str(p), size_bytes=size, ext=ext.lstrip(".")))
        items.sort(key=lambda x: x.title)  # 确定性
        self._items = items
        self._available = bool(items)
        self.scan_ms = round((time.perf_counter() - t0) * 1000, 1)
        return self._available

    @property
    def available(self) -> bool:
        return self._available

    def size(self) -> int:
        return len(self._items)

    def items(self) -> list:
        return list(self._items)

    def match(self, query: str, limit: int = 5) -> list:
        """按标题关键词匹配，返回得分>0 的前 limit 条（分降序、标题序确定性）。"""
        ranked = []
        for it in self._items:
            s = _score(query, it.title)
            if s > 0:
                ranked.append((-s, it.title, it))
        ranked.sort(key=lambda x: (x[0], x[1]))
        return [x[2] for x in ranked[:limit]]
