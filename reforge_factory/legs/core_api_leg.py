# -*- coding: utf-8 -*-
"""core_api 腿 — CORE API v3 (1026 B级免费钥申领波; B级·学术专利·CORE API).

registry: channels_survey_2026 (CORE API, core.ac.uk/services/api,
"注册免费key(匿名可用但限流)"); 实测 2026-10-26 direct 200
(q=construction totalHits=3,039,301) — 匿名面在役, 免key可冒烟;
正式免费key申领 (core.ac.uk/services/api 注册, 邮箱验证类) → 列用户动作提额。
密钥面: data/secrets/core.secret 存在则带 Authorization 头 (运行时读, 永不进仓)。

用法: py reforge_factory/legs/core_api_leg.py --campaign EPC-JIAGE
      --queries "construction cost estimating"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "core_api", "source": "CORE API v3 (学术开放获取聚合)",
        "note": "B级·学术专利·匿名面实测200 (免费key申领=用户动作提额, 本腿匿名在役)",
        "rows_default": 8}

SECRET = REPO_SECRET = Path(core.REPO) / "data" / "secrets" / "core.secret"


def endpoint(query, rows):
    hdrs = {}
    try:
        k = SECRET.read_text(encoding="utf-8").strip().splitlines()
        if k and k[0]:
            hdrs["Authorization"] = "Bearer " + k[0]
    except OSError:
        pass                                  # 无secret=匿名面 (限流如实)
    return ("https://api.core.ac.uk/v3/search/works",
            {"q": query, "limit": str(rows)}, hdrs, "GET", None)


def extract(data):
    hits = []
    for r in (data or {}).get("results") or []:
        auth = ", ".join(str(a.get("name", "")) for a in (r.get("authors") or [])[:4]
                         if a.get("name"))
        hits.append({
            "title": r.get("title", "") or "(无题)",
            "url": r.get("downloadUrl") or r.get("fullTextIdentifier")
                   or ("https://core.ac.uk/works/" + str(r.get("id", ""))),
            "meta": [m for m in [auth,
                                 "year:" + str(r.get("yearPublished", "") or ""),
                                 "doi:" + r.get("doi", "") if r.get("doi") else "",
                                 "citations:" + str(r.get("citationCount", 0))]
                     if m],
            "excerpt": str(r.get("abstract", "") or "")[:1200],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
