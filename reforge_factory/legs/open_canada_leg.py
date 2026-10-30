# -*- coding: utf-8 -*-
"""open_canada 腿 — Open Canada 开放数据 API (1026 B级免费钥申领波; B级·工商招投标/项目数据/数据集).

registry: channels_survey_2026 (Open Canada, open.canada.ca, "免key开放数据API");
CKAN package_search 实测 2026-10-26 direct 200 (20,249B)。免key零注册。

用法: py reforge_factory/legs/open_canada_leg.py --campaign EPC-OVERSEAS
      --queries "construction infrastructure"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "open_canada", "source": "Open Canada (open.canada.ca) CKAN",
        "note": "B级·工商招投标/项目数据·免key开放数据API (1026 免费钥波: 免key面直点)",
        "rows_default": 8}


def endpoint(query, rows):
    return ("https://open.canada.ca/data/en/api/3/action/package_search",
            {"q": query, "rows": str(rows)}, {}, "GET", None)


def extract(data):
    hits = []
    res = ((data or {}).get("result") or {})
    for p in res.get("results") or []:
        org = ((p.get("organization") or {}).get("title", ""))
        hits.append({
            "title": p.get("title", "") or p.get("name", ""),
            "url": "https://open.canada.ca/data/en/dataset/" + str(p.get("id", "")),
            "meta": [m for m in [org,
                                 "更新:" + str(p.get("metadata_modified", ""))[:10]]
                     if m],
            "excerpt": str(p.get("notes", "") or "")[:1200],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
