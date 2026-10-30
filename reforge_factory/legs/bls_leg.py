# -*- coding: utf-8 -*-
"""bls 腿 — BLS Public Data API (1025 渠道普查纳管令; A级·标准定额/项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (BLS Public Data API,
免登录API(注册key提额), registry evidence: HTTP 403 probe/官方no-key文档);
美国劳工统计局, PPI建材/就业/CPI, 造价通胀底座。
本腿查询词=BLS序列ID (每词一序列, 如 WPSFD4=最终需求PPI; 序列号错→API报错如实记)。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/bls_leg.py --campaign EPC-JIAGE
      --queries WPSFD4 CUUR0000SA0
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "bls", "source": "BLS Public Data API v2",
        "note": "A级·标准定额/项目数据·免登录API (registry: 403 probe+官方no-key文档)",
        "rows_default": 12}


def endpoint(query, rows):
    sid = query.strip().split()[0]
    return ("https://api.bls.gov/publicAPI/v2/timeseries/data/",
            {"seriesid": sid, "startyear": "2018", "endyear": "2026"},
            {}, "GET", None)


def extract(data):
    hits = []
    for s in (((data or {}).get("Results") or {}).get("series") or []):
        sid = s.get("seriesID", "")
        for d in (s.get("data") or []):
            if not str(d.get("period", "")).startswith("M"):
                continue                      # 只取月度点, 防半年度/年度混杂
            hits.append({
                "title": "BLS %s · %s-%s = %s" % (sid, d.get("year"),
                                                  d.get("period"), d.get("value")),
                "url": "https://data.bls.gov/timeseries/" + sid,
                "meta": [m for m in [d.get("periodName") or "",
                                     "最新" if d.get("latest") == "true" else ""]
                         if m],
                "excerpt": "美国劳工统计局序列 %s %s年%s月值 = %s (%s)"
                           % (sid, d.get("year"), d.get("period", "M??"),
                              d.get("value"), d.get("periodName", "")),
            })
    if not hits and isinstance(data, dict) and data.get("message"):
        print("    BLS API 消息如实: %s" % "; ".join(
            str(x) for x in data["message"][:2]))
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
