# -*- coding: utf-8 -*-
"""wikidata 腿 — Wikidata API 渠道接入弹药池 (1025 渠道普查纳管令; A级·标准定额/数据集).

注册表: channels_survey_2026/MASTER_REGISTRY.json (Wikidata API, 免登录API+SPARQL,
registry evidence: HTTP 200 via proxy); 结构化知识库, 工程机构/项目/标准号实体
事实源 — 标准号/机构实体核对面。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/wikidata_leg.py --campaign EPC-JIAGE
      --queries "中华人民共和国住房和城乡建设部"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "wikidata", "source": "Wikidata API (wbsearchentities)",
        "note": "A级·标准定额·免登录API (registry: HTTP 200 via proxy)"}


def endpoint(query, rows):
    return ("https://www.wikidata.org/w/api.php",
            {"action": "wbsearchentities", "search": query,
             "language": "zh", "uselang": "zh", "limit": str(rows),
             "format": "json"},
            {}, "GET", None)


def extract(data):
    hits = []
    for s in ((data or {}).get("search") or []):
        qid = s.get("id") or ""
        desc = s.get("description") or ""
        hits.append({
            "title": "%s (%s)" % (s.get("label") or "(无label)", qid),
            "url": s.get("concepturi") or s.get("url") or
                   ("https://www.wikidata.org/wiki/" + qid),
            "meta": [m for m in [desc,
                                 (s.get("match") or {}).get("type", "")]
                     if m],
            "excerpt": "Wikidata 概念实体 %s: %s" % (qid, desc),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
