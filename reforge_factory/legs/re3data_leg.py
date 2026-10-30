# -*- coding: utf-8 -*-
"""re3data 腿 — re3data API 渠道接入弹药池 (1025 渠道普查纳管令; A级·数据集标签).

注册表: channels_survey_2026/MASTER_REGISTRY.json (re3data API, 免登录API,
registry evidence: HTTP 200 direct); 全球研究数据仓库注册目录, 按学科定位工程
数据仓库。响应=XML (beta API), extract 走 xml.etree 解析。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/re3data_leg.py --campaign EPC-JIAGE
      --queries "civil engineering"
"""
from __future__ import annotations

import sys
import xml.etree.ElementTree as ET
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "re3data", "source": "re3data API",
        "note": "A级·数据集·免登录API/响应XML (registry: HTTP 200 direct)"}


def endpoint(query, rows):
    return ("https://www.re3data.org/api/beta/repositories",
            {"query": query}, {"Accept": "application/xml"}, "GET", None)


def extract(data):
    if not isinstance(data, str):
        return []
    root = ET.fromstring(data)
    hits = []
    for rep in root.iter("repository"):
        name = (rep.findtext("name") or "").strip()
        desc = (rep.findtext("description") or "").strip()
        link = ""
        lnode = rep.find("link")
        if lnode is not None:
            link = (lnode.get("href") or "").strip()
        hits.append({"title": name or "(未名仓库)", "url": link,
                     "meta": [(rep.findtext("id") or "").strip()],
                     "excerpt": desc})
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
