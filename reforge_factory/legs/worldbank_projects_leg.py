# -*- coding: utf-8 -*-
"""worldbank_projects 腿 — 世界银行项目与运营 API (1025 渠道普查纳管令; A级·项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (World Bank Projects &
Operations API, 免登录API, registry evidence: HTTP 200 direct); 世行贷款项目级
档案, 国际工程行业一手项目流 — EPC 海外对标/项目流面。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/worldbank_projects_leg.py --campaign EPC-JIAGE
      --queries "highway construction"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "worldbank_projects", "source": "World Bank Projects & Operations API",
        "note": "A级·项目数据·免登录API (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    return ("https://search.worldbank.org/api/v2/projects",
            {"format": "json", "q": query, "rows": str(rows)},
            {}, "GET", None)


def extract(data):
    prj = (data or {}).get("projects") if isinstance(data, dict) else None
    if isinstance(prj, dict):                    # 有时为 id→对象 映射
        prj = list(prj.values())
    hits = []
    for p in (prj if isinstance(prj, list) else []):
        if not isinstance(p, dict):
            continue
        hits.append({
            "title": p.get("project_name") or p.get("id") or "(无题)",
            "url": p.get("url") or "",
            "meta": [m for m in [str(p.get("id") or ""), p.get("status") or "",
                                 p.get("countryshortname") or "",
                                 str(p.get("board_approval_date") or "")[:10]]
                     if m],
            "excerpt": (p.get("goal") or p.get("impagency")
                        or p.get("project_name") or "")[:1500],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
