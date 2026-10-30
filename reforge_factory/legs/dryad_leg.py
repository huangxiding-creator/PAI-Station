# -*- coding: utf-8 -*-
"""dryad 腿 — Dryad API (1025 渠道普查纳管令; A级·数据集).

注册表: channels_survey_2026/MASTER_REGISTRY.json (Dryad API,
https://datadryad.org/api/v2, 免登录API, registry evidence: HTTP 200 direct);
同行评审关联研究数据仓库 — 工程/环境交叉研究数据面。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/dryad_leg.py --campaign EPC-JIAGE
      --queries "construction"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "dryad", "source": "Dryad API v2 (search)",
        "note": "A级·数据集·免登录API (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    return ("https://datadryad.org/api/v2/search",
            {"q": query, "per_page": str(rows)}, {}, "GET", None)


def extract(data):
    d = data if isinstance(data, dict) else {}
    emb = d.get("_embedded") or {}
    items = (emb.get("searchResult") or emb.get("datasets")
             or d.get("results") or [])
    hits = []
    for it in (items if isinstance(items, list) else []):
        src = (it.get("_source") or it) if isinstance(it, dict) else {}
        if not src:
            continue
        doi = str(src.get("doi") or "").replace("doi:", "")
        hits.append({
            "title": src.get("title") or "(无题)",
            "url": ("https://datadryad.org/dataset/doi:" + doi) if doi else "",
            "meta": [m for m in [doi,
                                 str(src.get("publicationDate")
                                     or src.get("_publicationDate") or "")[:10]]
                     if m],
            "excerpt": (src.get("abstract") or "")[:1500],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
