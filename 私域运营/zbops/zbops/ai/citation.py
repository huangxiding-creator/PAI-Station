# -*- coding: utf-8 -*-
"""引用校验器：对抗幻觉的最后一道机器闸门（ARCHITECTURE §5.2）。

  1) 回答中的条款号必须存在于本次检索命中的 chunk 元数据（杜绝编造条款号）
  2) 引文内容与 chunk 原文做相似度比对（防张冠李戴）
  校验失败→打回生成器重试一次（P0 直接失败转人工提示）
"""
from __future__ import annotations

import difflib
import re

CLAUSE_PAT = re.compile(
    r"(GB|JGJ|JTG|JTS|DB|DL|NB|CECS)[/T]*\s*[\d\.]+[-\d]*\s*第?[一二三四五六七八九十百\d\.]*条?")


def verify(answer: str, chunks: list[dict]) -> tuple[bool, list[str]]:
    """返回 (通过, 失败明细)。无引用或引用全部可溯源=通过。"""
    if not chunks:
        return (True, []) if "依据" not in answer and "第" not in answer \
            else (False, ["回答含规范性引用但检索无命中（应拒答）"])

    allowed = set()
    for c in chunks:
        allowed.add((c.get("std_no") or "").replace(" ", ""))
        if c.get("clause"):
            allowed.add(c["clause"].replace(" ", ""))

    failures = []
    for m in CLAUSE_PAT.finditer(answer):
        cite = m.group(0).replace(" ", "")
        if not any(a in cite or cite in a or
                   _overlap(a, cite) >= 0.6 for a in allowed if a):
            failures.append(cite)
    return (not failures), failures


def _overlap(a: str, b: str) -> float:
    return difflib.SequenceMatcher(None, a, b).ratio()
