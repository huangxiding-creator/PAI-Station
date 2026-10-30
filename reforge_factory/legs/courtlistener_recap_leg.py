# -*- coding: utf-8 -*-
"""courtlistener_recap 腿 — CourtListener+RECAP v4 API (1026 免费钥申领波·重点渠道).

registry: channels_survey_2026 (CourtListener+RECAP(美国判例), A级·通用网研);
v4 search API 匿名面实测 2026-10-26 direct 200 (q=construction count=1,526,866,
38,161B) — 免登录可冒烟; 注册即token (www.courtlistener.com/register) 属
邮箱验证类 → 列用户动作提额 (匿名限流如实)。密钥面:
data/secrets/courtlistener.secret 存在则带 Authorization: Token 头 (运行时读)。

用法: py reforge_factory/legs/courtlistener_recap_leg.py --campaign EPC-OVERSEAS
      --queries "construction contract termination"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "courtlistener_recap", "source": "CourtListener v4 Search API",
        "note": "A级·通用网研·匿名面实测200 (注册即token=用户动作提额, 本腿匿名在役)",
        "rows_default": 8}

SECRET = Path(core.REPO) / "data" / "secrets" / "courtlistener.secret"


def endpoint(query, rows):
    hdrs = {}
    try:
        k = SECRET.read_text(encoding="utf-8").strip().splitlines()
        if k and k[0]:
            hdrs["Authorization"] = "Token " + k[0]
    except OSError:
        pass                                  # 无secret=匿名面 (限流如实)
    return ("https://www.courtlistener.com/api/rest/v4/search/",
            {"q": query, "type": "o", "page_size": str(rows)},
            hdrs, "GET", None)


def extract(data):
    hits = []
    for r in (data or {}).get("results") or []:
        court = r.get("court") or {}
        cname = court.get("short_name") if isinstance(court, dict) else str(court)
        hits.append({
            "title": r.get("caseName", "") or "(无题)",
            "url": "https://www.courtlistener.com" + str(r.get("absolute_url", "")),
            "meta": [m for m in [str(cname or ""),
                                 str(r.get("dateFiled", "") or "")[:10],
                                 r.get("docketNumber", "")] if m],
            "excerpt": str(r.get("snippet", "") or "")[:1400],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
