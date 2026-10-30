# -*- coding: utf-8 -*-
"""zenodo 腿 — Zenodo API 渠道接入弹药池 (1025 渠道普查纳管令; A级·数据集标签).

注册表: channels_survey_2026/MASTER_REGISTRY.json (Zenodo API, 免登录API,
registry evidence: 301→200); CERN开放仓库, Horizon欧盟项目工程数据集+DOI沉淀。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/zenodo_leg.py --campaign EPC-JIAGE
      --queries "construction cost index"
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "zenodo", "source": "Zenodo API",
        "note": "A级·数据集·免登录API (registry: 301→200 实证)"}


def endpoint(query, rows):
    return ("https://zenodo.org/api/records",
            {"q": query, "size": str(rows)}, {}, "GET", None)


def extract(data):
    hits = []
    for it in ((((data or {}).get("hits") or {}).get("hits")) or []):
        m = it.get("metadata") or {}
        links = it.get("links") or {}
        hits.append({
            "title": m.get("title") or "(无题)",
            "url": (links.get("self_html") or links.get("latest_html")
                    or links.get("html") or ""),
            "meta": [m for m in [m.get("publication_date") or "",
                                 (m.get("resource_type") or {}).get("type", ""),
                                 (m.get("creators") or [{}])[0].get("name", "")]
                     if m],
            "excerpt": re.sub(r"<[^>]+>", " ", m.get("description") or "")[:1500],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
