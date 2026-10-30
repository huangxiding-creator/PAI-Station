# -*- coding: utf-8 -*-
"""nasa_images 腿 — NASA Image and Video Library API (1026 免费钥申领波·重点渠道 NASA).

registry 关联: channels_survey_2026 B级 nasa_firms (FIRMS MAP_KEY 需申领=用户动作);
本腿=NASA 免key官方 API images-api.nasa.gov (api.nasa.gov 家族免注册面),
实测 2026-10-26 direct 200 (q=wildfire 5,843B)。FIRMS MAP_KEY 申领表单
(firms.modaps.eosdis.nasa.gov/api/map_key/) 属邮箱回执类 → 列用户动作不硬闯。

用法: py reforge_factory/legs/nasa_images_leg.py --campaign EPC-OVERSEAS
      --queries "construction site satellite"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "nasa_images", "source": "NASA Image and Video Library API",
        "note": "1026 免费钥申领波重点: NASA 免key面 (FIRMS MAP_KEY 申领=用户动作)",
        "rows_default": 8}


def endpoint(query, rows):
    return ("https://images-api.nasa.gov/search",
            {"q": query, "media_type": "image", "page_size": str(rows)},
            {}, "GET", None)


def extract(data):
    hits = []
    for it in (((data or {}).get("collection") or {}).get("items") or []):
        d = ((it.get("data") or [{}])[0])
        link = next((l.get("href") for l in (it.get("links") or [])
                     if l.get("href")), "")
        nid = d.get("nasa_id", "")
        hits.append({
            "title": d.get("title", "") or nid,
            "url": link or ("https://images.nasa.gov/details/" + str(nid)),
            "meta": [m for m in [str(d.get("date_created", ""))[:10],
                                 d.get("center", ""),
                                 "photographer:" + d.get("secondary_creator", "") if d.get("secondary_creator") else ""]
                     if m],
            "excerpt": str(d.get("description", ""))[:1200],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
