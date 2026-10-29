# -*- coding: utf-8 -*-
"""gdelt_doc_leg — GDELT 2.0 DOC API 轻量采集腿 (1028 P0-3 免费监测腿).

薄壳模式 (照 http_api_leg_core: SPEC{endpoint,extract} + run()):
  源: https://api.gdeltproject.org/api/v2/doc/doc
      ?query=<词>&mode=artlist&maxrecords=N&format=json&sort=hybridrel
  全免费零 key; 频率限制官方在案 → SPEC sleep=3.0 (腿内 >=3s 节流, 任务书钦定);
  网络层: 直连优先→代理兜底 (7895→7890→7891→7893, core.fetch);
  命中 → 散文式 md (过 S2-1 serp_shape 硬门) + 原始JSON落 staging
       → ammo_pool ingest + channel_invocations 只增台账.

用法:
  py reforge_factory/legs/gdelt_doc_leg.py --campaign EPC-TOP50 \
      --queries "China construction" [--rows 10] [--proxy auto] [--no-ingest]
"""
from __future__ import annotations

import sys
import urllib.parse
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
from http_api_leg_core import run  # noqa: E402  共用芯 (fetch/staging/ingest/台账)

BASE = "https://api.gdeltproject.org/api/v2/doc/doc"

SPEC = {
    "engine": "gdelt_doc",
    "source": "GDELT 2.0 DOC API (全球新闻监测)",
    "note": "免费零key; 官方频率限制 → 腿内 sleep=3.0s 节流 (1028 P0-3)",
    "sleep": 3.0,        # 1028 P0-3 钦定 >=3s (GDELT 限频在案)
    "rows_default": 10,
}


def endpoint(query: str, rows: int):
    """GDELT DOC artlist 端点 (hybridrel 相关度排序)."""
    params = {
        "query": query,
        "mode": "artlist",
        "maxrecords": str(max(1, min(rows, 250))),
        "format": "json",
        "sort": "hybridrel",
    }
    return BASE, params, {}, "GET", None


def extract(data):
    """artlist JSON → hits[{title,url,meta[],excerpt}] (缺字段如实空)."""
    arts = (data.get("articles") or []) if isinstance(data, dict) else []
    hits = []
    for a in arts:
        if not isinstance(a, dict):
            continue
        meta = [x for x in (a.get("seendate"), a.get("domain"),
                            a.get("language"), a.get("sourcecountry"))
                if x]
        hits.append({"title": a.get("title") or "(无题)",
                     "url": a.get("url") or "",
                     "meta": meta,
                     "excerpt": ""})   # artlist 面无摘要 — 如实空, 不编造
    return hits


if __name__ == "__main__":
    sys.exit(run(SPEC))
