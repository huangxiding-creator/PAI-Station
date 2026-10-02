# -*- coding: utf-8 -*-
"""chapters_full.py — 付费正文全集契约产腿（B 线转工单#1，2026-09-28）
契约：data/xueyuan/content/reports/<slug>/chapters_full.json
形状对齐 B 线试点站位件（js-shuiwang-2026 实测）：[{title, html, id}]，
全部章带 html 正文（服务端付费下发真源；与包内 chapters.json 同切章、同键序）。
纪律：不重切不重解析——构建路径直接复用 build_one 已算好的章数据；
本模块只做纯函数（tags/一致性校验）+落盘，编排（mammoth 补产）在 batch_up。
"""
from __future__ import annotations

import json
import re
from pathlib import Path

from batch_meta import CITY2PROV

XY_CONTENT = Path("E:/AI-Station/data/xueyuan/content")

_TOPIC_PAT = ("商机研究", "商机挖掘", "商机汇总", "商机报告")
_DOMAIN_PAT = ("水网工程", "水利工程", "水务工程")


def make_tags(title: str, province: str, industry: str, owner_type: str) -> list:
    """从标题/省份/行业聚合 3-5 个 tag（hot_words 用）；推断不出就少给/留空，不编造"""
    tags: list = []
    city = next((c for c in CITY2PROV if c and c in title), "")
    if city and city != province:
        tags.append(city)
    if province:
        tags.append(province)
    if industry:
        tags.append(industry)
    tags.append(next((t for t in _TOPIC_PAT if t in title), ""))
    domain = next((t for t in _DOMAIN_PAT if t in title and t != industry), "")
    if domain:
        tags.append(domain)
    tags = [t for t in tags if t]           # 去空保序去重，封顶 5
    seen, out = set(), []
    for t in tags:
        if t not in seen:
            seen.add(t)
            out.append(t)
    return out[:5]


def full_payload(chapters: list) -> list:
    """[{title,html,id}]——与包内 chapters.json 同键序（试点站位件形状）"""
    return [{"title": c["title"], "html": c["html"], "id": c["id"]} for c in chapters]


def write_full(slug: str, chapters: list, out_root: Path | None = None) -> Path:
    dst = (out_root or XY_CONTENT / "reports") / slug / "chapters_full.json"
    dst.parent.mkdir(parents=True, exist_ok=True)
    dst.write_text(json.dumps(full_payload(chapters), ensure_ascii=False, indent=1),
                   encoding="utf-8")
    return dst


def packed_match(chapters: list, packed: list) -> bool:
    """补产章数据与包内 chapters.json 的 id/标题序列必须逐项一致（docx 未变旁证）"""
    return ([c["id"] for c in chapters] == [p["id"] for p in packed]
            and [c["title"] for c in chapters] == [p["title"] for p in packed])
