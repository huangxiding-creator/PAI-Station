"""结构感知分块（P2）：标题切界 + 段落贪心装包 ≈500 字符。

reor 实证「结构剥离+500 字符」是 markdown/文本语料起步正解；
ragflow 的按类型模板留给 P3 金标准驱动再细化。
"""
from __future__ import annotations

import re

CHUNKER_VER = "1"
TARGET_CHARS = 500
MAX_CHARS = 900  # 单段超长（表格/日志）硬顶再切

_HEADING = re.compile(r"^(#{1,6}\s|\*\*|[一二三四五六七八九十]+[、.．])")


def _split_paragraphs(text: str) -> list[str]:
    para = [p.strip() for p in re.split(r"\n\s*\n", text) if p.strip()]
    # 超长段按句读再切（中英文句号/问叹号）
    out = []
    for p in para:
        if len(p) <= MAX_CHARS:
            out.append(p)
            continue
        sents = re.split(r"(?<=[。！？.!?])\s*", p)
        buf = ""
        for s in sents:
            if buf and len(buf) + len(s) > MAX_CHARS:
                out.append(buf)
                buf = s
            else:
                buf += s
        if buf:
            out.append(buf)
    return out


def chunk_text(text: str, target: int = TARGET_CHARS) -> list[str]:
    """→ chunk 列表；标题行开新块，段落贪心装包。"""
    paras = _split_paragraphs(text)
    if not paras:
        return []
    chunks: list[str] = []
    buf = ""
    for p in paras:
        starts_new = bool(_HEADING.match(p)) and buf
        if starts_new or len(buf) + len(p) + 1 > target:
            if buf:
                chunks.append(buf)
            buf = p
        else:
            buf = f"{buf}\n{p}" if buf else p
    if buf:
        chunks.append(buf)
    return chunks
