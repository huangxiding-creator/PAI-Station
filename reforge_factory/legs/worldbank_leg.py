# -*- coding: utf-8 -*-
"""worldbank 腿 — World Bank Open Data API (1025 渠道普查纳管令; A级·项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (World Bank Open Data API,
免登录API, registry evidence: HTTP 200 direct); 世行 14000+ 指标, 基建投资/
能源/城市专题 — 宏观与行业景气底座。
本腿查询词=指标代码 (如 NV.IND.MANF.CD 制造业增加值; 默认国别 CHN, 代码错→
API返回 message 如实记)。引擎调用+staging+ingest骨架照 last30days_leg.py 模式
(纯HTTP零浏览器, 共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/worldbank_leg.py --campaign EPC-JIAGE
      --queries NV.IND.MANF.CD
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "worldbank", "source": "World Bank Open Data API",
        "note": "A级·项目数据·免登录API (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    code = query.strip().split()[0]
    return ("https://api.worldbank.org/v2/country/CHN/indicator/" + code,
            {"format": "json", "per_page": str(rows), "date": "2014:2026"},
            {}, "GET", None)


def extract(data):
    if not (isinstance(data, list) and len(data) == 2
            and isinstance(data[1], list)):
        if isinstance(data, list) and data and isinstance(data[0], dict):
            print("    世界银行API消息如实: %s" % str(
                data[0].get("message"))[:160])
        return []
    hits = []
    for d in data[1]:
        if not isinstance(d, dict):
            continue
        ind = d.get("indicator") or {}
        hits.append({
            "title": "%s · %s年 = %s" % (ind.get("value") or ind.get("id", ""),
                                         d.get("date"), d.get("value")),
            "url": "https://data.worldbank.org/indicator/" + str(ind.get("id") or ""),
            "meta": [m for m in [str(d.get("date") or ""),
                                 (d.get("country") or {}).get("value", "")]
                     if m],
            "excerpt": "世界银行指标 %s (%s) %s 年值 = %s, 国别=%s"
                       % (ind.get("value", ""), ind.get("id", ""),
                          d.get("date"), d.get("value"),
                          (d.get("country") or {}).get("value", "")),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
