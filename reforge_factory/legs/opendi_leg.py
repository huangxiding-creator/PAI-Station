# -*- coding: utf-8 -*-
"""opendi 腿 — Open Contracting Data Registry (1025 渠道普查纳管令; A级·工商招投标/项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (Open Contracting Data
Registry, data.open-contracting.org, 数据集+免登录, registry evidence:
HTTP 200 via proxy); 全球公共采购开放数据注册表, OCDS 工程招标结构化 —
国际招投标一手目录面。引擎调用+staging+ingest骨架照 last30days_leg.py 模式
(纯HTTP零浏览器, 共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/opendi_leg.py --campaign EPC-JIAGE
      --queries "infrastructure"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "opendi", "source": "Open Contracting Data Registry API v1",
        "note": "A级·工商招投标·数据集免登录 (registry: HTTP 200 via proxy)"}


def endpoint(query, rows):
    return ("https://api.data.open-contracting.org/v1/datasets/",
            {"keyword": query, "limit": str(rows)}, {}, "GET", None)


def extract(data):
    items = (data or {}).get("results") if isinstance(data, dict) else data
    if not isinstance(items, list):
        items = []
    hits = []
    for it in items:
        if not isinstance(it, dict):
            continue
        src = it.get("source") or {}
        pub = src.get("publisher") or {}
        pub_name = pub.get("name") if isinstance(pub, dict) else str(pub)
        hits.append({
            "title": src.get("name") or str(it.get("id") or "(无题)"),
            "url": src.get("url") or "",
            "meta": [m for m in [str(it.get("id") or ""), pub_name or ""]
                     if m],
            "excerpt": "OCDS 公共采购数据集 %s · 发布方 %s"
                       % (src.get("name", ""), pub_name or "(未署)"),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
