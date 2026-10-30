# -*- coding: utf-8 -*-
"""usaspending 腿 — USAspending API (1025 渠道普查纳管令; A级·项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (USAspending API,
免登录API, registry evidence: HTTP 200 direct); 美国联邦支出全透明API,
含联邦工程合同与受援方 — 国际工程对标面。
POST /api/v2/search/spending_by_award/ (关键词+工程类NAICS 541330+
2024以来+合同类ABCD); 关键词filter不被接受→400如实记。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/usaspending_leg.py --campaign EPC-JIAGE
      --queries "civil engineering"
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "usaspending", "source": "USAspending API v2",
        "note": "A级·项目数据·免登录API POST面 (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    body = json.dumps({
        "filters": {
            "keywords": [query],
            "time_period": [{"start_date": "2024-01-01",
                             "end_date": "2026-09-30"}],
            "award_type_codes": ["A", "B", "C", "D"],
        },
        "fields": ["Award ID", "Recipient Name", "Award Amount",
                   "Start Date", "Awarding Agency"],
        "page": 1, "limit": rows, "subawards": False,
    }).encode("utf-8")
    return ("https://api.usaspending.gov/api/v2/search/spending_by_award/",
            None, {"Content-Type": "application/json"}, "POST", body)


def extract(data):
    hits = []
    for r in ((data or {}).get("results") or []):
        if not isinstance(r, dict):
            continue
        meta = []
        if r.get("Award Amount") is not None:
            meta.append("金额 $%s" % r.get("Award Amount"))
        if r.get("Start Date"):
            meta.append(str(r.get("Start Date")))
        if r.get("Awarding Agency"):
            meta.append(str(r.get("Awarding Agency"))[:40])
        hits.append({
            "title": "%s · %s" % (r.get("Recipient Name") or "(未名受援方)",
                                  r.get("Award ID") or ""),
            "url": "https://www.usaspending.gov/award/"
                   + str(r.get("internal_id") or r.get("Award ID") or ""),
            "meta": meta,
            "excerpt": "美国联邦合同 %s | 受援方 %s | 金额 %s | 起始 %s"
                       % (r.get("Award ID"), r.get("Recipient Name"),
                          r.get("Award Amount"), r.get("Start Date")),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
