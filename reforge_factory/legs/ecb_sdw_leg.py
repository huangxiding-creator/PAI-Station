# -*- coding: utf-8 -*-
"""ecb_sdw 腿 — ECB数据门户 SDW API (1026 B级免费钥申领波·重点渠道; A级·项目数据).

registry: channels_survey_2026 (ECB数据门户(SDW), data.ecb.europa.eu);
SDW Data Portal API v2 (data-api.ecb.europa.eu), 免key官方API — 实测
2026-10-26 direct 200 (EXR/D.USD.EUR.SP00.A jsondata 3,064B)。查询词=SDW
序列键 (如 EXR/D.USD.EUR.SP00.A 汇率, ICP/M.U2.N.000000.4.ANR HICP年率);
无 '/' 时用缺省序列。免key零注册面永久免费, 无用户动作。

用法: py reforge_factory/legs/ecb_sdw_leg.py --campaign EPC-OVERSEAS
      --queries EXR/D.USD.EUR.SP00.A
"""
from __future__ import annotations

import csv
import io
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "ecb_sdw", "source": "ECB SDW Data Portal API",
        "note": "A级·项目数据·免key官方API (1026 免费钥申领波重点: ECB=免费)",
        "rows_default": 12}


def endpoint(query, rows):
    key = query.strip() or "EXR/D.USD.EUR.SP00.A"
    if "/" not in key:
        key = "EXR/D.USD.EUR.SP00.A"
    return ("https://data-api.ecb.europa.eu/service/data/" + key,
            {"lastNObservations": str(rows), "format": "csvdata"},
            {}, "GET", None)


def extract(data):
    hits = []
    text = data if isinstance(data, str) else ""
    for row in csv.DictReader(io.StringIO(text)):
        date = row.get("TIME_PERIOD", "")
        val = row.get("OBS_VALUE", "")
        if not date or not val:
            continue
        ser = row.get("KEY", "") or row.get("SERIES_KEY", "")
        hits.append({
            "title": "ECB %s · %s = %s" % (ser, date, val),
            "url": "https://data.ecb.europa.eu/data/datasets/" + ser.split("/")[0] if ser else "https://data.ecb.europa.eu/",
            "meta": [m for m in [row.get("TITLE", ""), row.get("UNIT", "")] if m],
            "excerpt": "欧洲央行 SDW 序列 %s 于 %s 观测值 = %s (%s, %s)"
                       % (ser, date, val, row.get("TITLE", ""), row.get("UNIT", "")),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
