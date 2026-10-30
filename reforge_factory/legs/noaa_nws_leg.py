# -*- coding: utf-8 -*-
"""noaa_nws 腿 — NOAA National Weather Service API (1026 免费钥申领波·重点渠道 NOAA).

registry 关联: channels_survey_2026 A级 noaa_ncei (NCEI 检索面
/access/services/search/v1/data 实测 400 "Invalid search options" 疑停用/改版,
如实记); 本腿=NOAA 官方 api.weather.gov 免key面 (alerts/active?area=XX),
实测 2026-10-26 direct 200。查询词=美国州代码 (TX/CA/NY...), 面价=现势气象
警报 (工程户外作业风险面)。免key (限速内), 提额需邮箱申领 key → 用户动作可选。

用法: py reforge_factory/legs/noaa_nws_leg.py --campaign EPC-OVERSEAS --queries TX
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "noaa_nws", "source": "NOAA NWS api.weather.gov",
        "note": "1026 免费钥申领波重点: NOAA 免key面 (ncei 检索面400停用疑如实, 本腿走 NWS 官方面)",
        "rows_default": 8}


def endpoint(query, rows):
    area = "".join(c for c in query.strip().upper() if c.isalpha())[:2] or "TX"
    return ("https://api.weather.gov/alerts/active",
            {"area": area}, {"Accept": "application/geo+json"}, "GET", None)


def extract(data):
    hits = []
    for f in (data or {}).get("features") or []:
        p = f.get("properties") or {}
        aid = p.get("id", "")
        hits.append({
            "title": "%s · %s" % (p.get("event", ""), str(p.get("areaDesc", ""))[:60]),
            "url": "https://api.weather.gov/alerts/" + str(aid.split("=")[-1])
                   if "=" in str(aid) else "https://api.weather.gov/alerts/active",
            "meta": [m for m in ["severity:" + str(p.get("severity", "")),
                                 "certainty:" + str(p.get("certainty", "")),
                                 "生效:" + str(p.get("onset", p.get("effective", "")))[:16],
                                 "area:" + str(p.get("areaDesc", ""))[:40]]
                     if m],
            "excerpt": str(p.get("headline", "") or "")[:600],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
