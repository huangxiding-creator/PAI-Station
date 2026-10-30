# -*- coding: utf-8 -*-
"""nist 腿 — NIST Technical Series Publications (1025 渠道普查纳管令; A级·标准定额).

注册表: channels_survey_2026/MASTER_REGISTRY.json (NIST Technical Series
Publications, 免登录PDF直下, registry evidence: 200 direct x2); 美国标准技术
研究院出版物, 计量/建筑/火灾工程 PDF 免费直下 (nvlpubs)。
本腿走 publications 搜索页 HTML 面 (官方无公开JSON检索API — 如实, 命中行=
标题+链接, 全文PDF按需再取)。引擎调用+staging+ingest骨架照 last30days_leg.py
模式 (纯HTTP零浏览器, 共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/nist_leg.py --campaign EPC-JIAGE
      --queries "fire resistance"
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "nist", "source": "NIST Technical Series Publications",
        "note": "A级·标准定额·免登录PDF直下/搜索页HTML面 (官方无公开JSON检索API)"}


def endpoint(query, rows):
    return ("https://www.nist.gov/publications/search",
            {"keywords": query}, {}, "GET", None)


def extract(data):
    if not isinstance(data, str):
        return []
    hits, seen = [], set()
    for m in re.finditer(r'href="(/publications/[^"]+)"[^>]*>\s*([^<]{6,160})', data):
        url, title = "https://www.nist.gov" + m.group(1), m.group(2).strip()
        if url in seen:
            continue
        seen.add(url)
        hits.append({"title": title, "url": url,
                     "meta": ["NIST 出版物检索命中"],
                     "excerpt": "NIST 技术系列出版物检索命中: " + title})
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
