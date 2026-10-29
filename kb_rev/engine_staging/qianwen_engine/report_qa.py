# -*- coding: utf-8 -*-
"""报告问答检索（v0.9.20 报告对话官 · 1018 用户令 REQ-001/002）。

MVP 章级检索（answer-policy.md 正本）：
- 语料三层取二：chapters(title+desc) + 试读 sample 开头作 no=0 伪章「摘要」
  （sample 文件缺失则不挂——目录报告可无试读）；
- 打分：q 与各章 (title+desc) 的 CJK 2-gram 词面重叠计数（确定性，可单测）；
- 命中门槛：最高分 < RQA_MIN_HITS → hit=False（端点走 no_answer 固定话术，
  不调 LLM——零造假铁律：检索不到就不编）。

纯函数模块：目录经 report_catalog 读取，tests 以 fixtures 目录 + 缓存清零驱动。
"""
from __future__ import annotations

from . import config, report_catalog

# 试读伪章进提示词的正文长度（摘要锚定主题即可，控 token）
_SAMPLE_HEAD_CHARS = 500


def _bigrams(text: str) -> set:
    """压空白后的 2-gram 集合（单字符退化为该字符，空串=空集）。"""
    t = "".join(ch for ch in (text or "") if not ch.isspace())
    if not t:
        return set()
    if len(t) == 1:
        return {t}
    return {t[i:i + 2] for i in range(len(t) - 1)}


def _corpus(sku: str) -> list:
    """检索语料：试读摘要伪章（no=0，文件存在才挂）+ 各章 {no,title,desc}。"""
    d = report_catalog.get_report(sku) or {}
    items = []
    sample = report_catalog.sample_text(sku)
    if sample:
        items.append({"no": 0, "title": "试读摘要", "desc": sample[:_SAMPLE_HEAD_CHARS]})
    for ch in d.get("chapters") or []:
        try:
            no = int(ch.get("id") or 0)
        except (TypeError, ValueError):
            no = 0
        items.append({
            "no": no,
            "title": str(ch.get("title") or ""),
            "desc": str(ch.get("desc") or ""),
        })
    return items


def retrieve(sku: str, q: str) -> tuple:
    """→ (top3_chapters, hit)：按 2-gram 重叠分降序取前 3 章；
    hit=语料非空且最高分 ≥ RQA_MIN_HITS（门槛 ENV 可调，REQ-005）。"""
    qgrams = _bigrams(q)
    scored = []
    for ch in _corpus(sku):
        grams = _bigrams(f"{ch['title']}{ch['desc']}")
        scored.append((len(qgrams & grams), ch))
    scored.sort(key=lambda p: p[0], reverse=True)   # 稳定排序：同分保持章序
    top3 = [ch for _s, ch in scored[:3]]
    best = scored[0][0] if scored else 0
    return top3, bool(top3) and best >= config.RQA_MIN_HITS
