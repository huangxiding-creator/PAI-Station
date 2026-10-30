# -*- coding: utf-8 -*-
"""xorsoft 腿 — xorsoft web search 独立索引 (1025 渠道普查纳管令; A级·通用网研).

注册表: channels_survey_2026/MASTER_REGISTRY.json (xorsoft web search
search.xorsoft.dev, 免登录站点(未实测), evidence: HN=5分/3评 2026-10-02
Algolia实测); CommonCrawl 语料自建 web 搜索引擎 — 大厂SE之外的独立索引补充源。
端点形态未知 (registry 如实标注未实测) → 本腿按 /search?q= 先探, HTML/JSON
双面解析, 失败如实记零伪造。引擎调用+staging+ingest骨架照 last30days_leg.py
模式 (纯HTTP零浏览器, 共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/xorsoft_leg.py --campaign EPC-JIAGE
      --queries "construction cost"
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "xorsoft", "source": "xorsoft web search (独立索引)",
        "note": "A级·通用网研·免登录站点 (registry标注未实测; 端点形态未知, 如实探)"}


def endpoint(query, rows):
    return ("https://search.xorsoft.dev/search", {"q": query}, {}, "GET", None)


def extract(data):
    if isinstance(data, list):                    # JSON 结果面
        return [{"title": str(d.get("title") or d.get("url") or "(无题)"),
                 "url": str(d.get("url") or ""),
                 "meta": [str(d.get("host") or "")],
                 "excerpt": str(d.get("snippet") or d.get("description") or "")[:1200]}
                for d in data if isinstance(d, dict)]
    if isinstance(data, str):                     # HTML 面: 外链抽取
        hits, seen = [], set()
        for m in re.finditer(r'href="(https?://(?!search\.xorsoft[^"]*)[^"]+)"'
                             r'[^>]*>\s*([^<]{4,140})', data):
            url, title = m.group(1), m.group(2).strip()
            if url in seen:
                continue
            seen.add(url)
            hits.append({"title": title or url[:60], "url": url,
                         "meta": ["独立索引命中"],
                         "excerpt": "xorsoft 独立索引命中: " + (title or url)[:120]})
        return hits
    return []


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
