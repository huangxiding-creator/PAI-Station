"""框架提取器（PROPOSAL_V2.md 5.2①）：只提框架，不读内容。

万维钢"读书抓三点"的管线化——用 3 小时兑现别人 3000 小时的目录学。
输入：目录页文本（章/节编号式）或 Markdown 标题层级；输出：节点列表。
"""
from __future__ import annotations

import re

# 中式编号：第一章 / 第1章 / 一、 / 1. / 1.1 / 1.1.1
_CH = re.compile(r"^第[一二三四五六七八九十百\d]+章[、.\s]*(.+)$")
_CN = re.compile(r"^[一二三四五六七八九十]+、\s*(.+)$")
_NUM = re.compile(r"^(\d+(?:\.\d)*)[、.\s]+(.+)$")
_MD = re.compile(r"^(#{1,6})\s+(.+)$")


def _mk(node_id: str, title: str, level: str) -> dict:
    return {"id": node_id, "title": title.strip(), "level": level,
            "frequency": 0.0}


def parse_toc(text: str) -> list[dict]:
    """目录文本 → 章/节两级节点（无法识别任何结构时返回空表）。"""
    nodes: list[dict] = []
    ch = sec = 0
    for raw_line in (text or "").splitlines():
        line = raw_line.strip().lstrip("-*•").strip()
        if not line:
            continue
        m = _MD.match(line)
        if m:
            depth = len(m.group(1))
            title = m.group(2).strip()
            if depth == 1:
                ch += 1
                sec = 0
                nodes.append(_mk(f"ch{ch}", title, "章"))
            else:
                sec += 1
                nodes.append(_mk(f"ch{max(ch, 1)}.s{sec}", title, "节"))
            continue
        m = _CH.match(line) or _CN.match(line)
        if m:
            ch += 1
            sec = 0
            nodes.append(_mk(f"ch{ch}", m.group(1), "章"))
            continue
        m = _NUM.match(line)
        if m:
            numbering = m.group(1)
            title = m.group(2)
            depth = numbering.count(".") + 1
            if depth == 1:
                ch += 1
                sec = 0
                nodes.append(_mk(f"ch{ch}", title, "章"))
            else:
                sec += 1
                nodes.append(_mk(f"ch{max(ch, 1)}.s{sec}", title, "节"))
    return nodes
