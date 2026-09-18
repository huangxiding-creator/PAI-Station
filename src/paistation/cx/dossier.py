# -*- coding: utf-8 -*-
"""卷宗通道（dossier-first 检索）——金标准升级路径之二。

诊断背景：全局 chunk 检索 hit@8=2%，98% 未命中是"问答词面鸿沟"。
两条升级路径：语义路由（等嵌入回填）/ **卷宗路由（本模块，零依赖可跑）**。
原理：SELF_PROFILE 精炼卷宗（画像/思想地图/覆盖度卡等 curated md）是小而
浓缩的答案池——问题词在卷宗里密度远高于 30 万原始块，路由进去再细查。

卷宗源：SELF_PROFILE/*.md + feishu/*.md + zbzs/*.md（golden_set 排除——
考卷不得泄漏进检索域；data/ 子目录排除——原始 dump 非卷宗）。
检索单元=markdown 节（##/### 标题切分），路由=问题 bigram 频次×标题加成。
"""

from __future__ import annotations

import re
from dataclasses import dataclass, field
from pathlib import Path

TOKEN_RE = re.compile(r"[一-龥]{2,}|[A-Za-z][A-Za-z0-9_-]{2,}|\d{2,}")
_HEADER_RE = re.compile(r"^#{1,3} ", re.M)

# 路由层噪声 bigram（问句套话，不携带领域信号）
_ROUTING_STOP = {
    "什么", "如何", "我的", "自己", "哪些", "哪个", "现在", "主要", "一下",
    "请问", "是否", "多少", "几个", "怎样", "怎么样", "为什么", "还是", "以及",
}


@dataclass
class Section:
    """卷宗检索单元：标题 + 正文（is_hit 兼容 .text 属性）。"""

    text: str
    dossier: str
    header: str = ""
    score: int = 0


@dataclass
class DossierIndex:
    sections: list[Section] = field(default_factory=list)

    def route(self, query: str, k: int = 8) -> list[Section]:
        """问题 → top-k 节（bigram 原始频次 + 标题 3 倍加成）。

        防吸流靠 _split_long 长节切分（巨型 dump 切成 ≤2500 字节），
        不靠频次归一——实测（金标准 100 题，2026-09-18）：raw 62 vs
        频次饱和+密度归一 50。中文卷宗里合法重复就是信号，归一反而
        压制真答案节。经验证保留 raw。
        """
        grams = query_grams(query)
        if not grams:
            return []
        for s in self.sections:
            body = sum(s.text.count(g) for g in grams)
            head = sum(s.header.count(g) for g in grams)
            s.score = body + 3 * head
        ranked = sorted(
            (s for s in self.sections if s.score > 0),
            key=lambda s: -s.score,
        )
        # 同源限位（多样化）：同一卷宗最多占 2 席（实测扫参 1/2/3/4 →
        # 65/65/64/61）——切分后的 dump 兄弟节（"已导入"22 副本）不再
        # 包场 top-k，真画像卡才有席；2 优于 1（多节真画像卡不误伤）
        per_src: dict[str, int] = {}
        picked: list[Section] = []
        for s in ranked:
            n = per_src.get(s.dossier, 0)
            if n >= 2:
                continue
            per_src[s.dossier] = n + 1
            picked.append(s)
            if len(picked) >= k:
                break
        return picked


def query_grams(query: str) -> set[str]:
    """问题 → 路由信号集（CJK run 转 bigram；拉丁/数字整词）。"""
    grams: set[str] = set()
    for t in TOKEN_RE.findall(query):
        if re.fullmatch(r"[一-龥]+", t):
            grams |= {t[i : i + 2] for i in range(len(t) - 1)}
        else:
            grams.add(t.lower())
    return grams - _ROUTING_STOP


def split_sections(md_text: str) -> list[tuple[str, str]]:
    """markdown → [(标题, 节正文原始体)]；无标题正文归首节。

    返回的正文不带标题前缀（前缀由 load_dossiers 统一加），
    与 _split_long 的再切分衔接。
    """
    parts = _HEADER_RE.split(md_text)
    if len(parts) == 1:
        return [("", md_text)] if md_text.strip() else []
    out: list[tuple[str, str]] = []
    if parts[0].strip():
        out.append(("", parts[0]))
    for seg in parts[1:]:  # 每段=标题行+正文（到下一标题为止）
        head, _, body = seg.partition("\n")
        header = head.strip()
        if header or body.strip():
            out.append((header, body))
    return out


_MAX_SECTION = 2500  # 节上限：超长 dump 节按空行再切，防清单吸流


def _split_long(header: str, body: str) -> list[tuple[str, str]]:
    """超长节 → ≤_MAX_SECTION 子节（header 前缀保留，正文按空行拼块）。"""
    if len(body) <= _MAX_SECTION:
        return [(header, body)]
    paras = body.split("\n\n")
    out: list[tuple[str, str]] = []
    buf = ""
    for p in paras:
        if buf and len(buf) + len(p) > _MAX_SECTION:
            out.append((header, buf))
            buf = p
        else:
            buf = f"{buf}\n\n{p}" if buf else p
    if buf:
        out.append((header, buf))
    return out


def load_dossiers(sp_dir: Path) -> DossierIndex:
    """SELF_PROFILE 卷宗 → 节索引（golden_set/data 子目录排除）。"""
    idx = DossierIndex()
    patterns = ["*.md", "feishu/*.md", "zbzs/*.md"]
    for pat in patterns:
        for f in sorted(sp_dir.glob(pat)):
            if not f.is_file():
                continue
            try:
                text = f.read_text(encoding="utf-8")
            except (OSError, UnicodeDecodeError):
                continue
            for header, body in split_sections(text):
                for h2, b2 in _split_long(header, body):
                    text2 = f"# {h2}\n{b2}" if h2 else b2
                    idx.sections.append(
                        Section(text=text2, dossier=f.stem, header=h2)
                    )
    return idx
