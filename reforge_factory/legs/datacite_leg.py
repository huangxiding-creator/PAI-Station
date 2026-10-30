# -*- coding: utf-8 -*-
"""datacite 腿 — DataCite API 渠道接入弹药池 (1025 渠道普查纳管令; A级·数据集标签).

注册表: channels_survey_2026/MASTER_REGISTRY.json (DataCite API, 免登录API,
registry evidence: HTTP 200 direct); 数据集DOI元数据注册库, 数万仓库索引。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core; 引擎名=channel_matrix SURVEY_ALIASES 渠道 id)。

用法: py reforge_factory/legs/datacite_leg.py --campaign EPC-JIAGE
      --queries "construction cost estimation"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "datacite", "source": "DataCite API",
        "note": "A级·数据集·免登录API (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    return ("https://api.datacite.org/dois",
            {"query": query, "page[size]": str(rows)}, {}, "GET", None)


def extract(data):
    hits = []
    for it in ((data or {}).get("data") or []):
        a = it.get("attributes") or {}
        title = next((t.get("title") for t in (a.get("titles") or [])
                      if t.get("title")), "") or a.get("doi", "DOI")
        desc = next((d.get("description") for d in (a.get("descriptions") or [])
                     if d.get("description")), "")
        hits.append({
            "title": title,
            "url": a.get("url") or ("https://doi.org/" + a.get("doi", "")),
            "meta": [m for m in [a.get("publisher"),
                                 str(a.get("publicationYear") or ""),
                                 (a.get("types") or {}).get("resourceTypeGeneral", "")]
                     if m],
            "excerpt": desc,
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
