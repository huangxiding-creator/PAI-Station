# -*- coding: utf-8 -*-
"""hf_datasets 腿 — HuggingFace Datasets API (1025 渠道普查纳管令; A级·数据集).

注册表: channels_survey_2026/MASTER_REGISTRY.json (HuggingFace Datasets API,
免登录API(部分下载需登录), registry evidence: HTTP 200 via proxy);
数据集托管+行业语料, 工程中文语料渐增 — 语料/数据集情报面。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/hf_datasets_leg.py --campaign EPC-JIAGE
      --queries "construction cost"
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "hf_datasets", "source": "HuggingFace Datasets API",
        "note": "A级·数据集·免登录API (registry: HTTP 200 via proxy)"}


def endpoint(query, rows):
    return ("https://huggingface.co/api/datasets",
            {"search": query, "limit": str(rows)}, {}, "GET", None)


def extract(data):
    hits = []
    for d in (data if isinstance(data, list) else []):
        if not isinstance(d, dict):
            continue
        meta = []
        if d.get("likes") is not None:
            meta.append("likes=%s" % d.get("likes"))
        if d.get("downloads") is not None:
            meta.append("downloads=%s" % d.get("downloads"))
        if d.get("lastModified"):
            meta.append("更新 " + str(d.get("lastModified"))[:10])
        desc = str(d.get("description") or "")
        if not desc:
            tags = [t for t in (d.get("tags") or []) if isinstance(t, str)]
            desc = "标签: " + ", ".join(tags[:8]) if tags else ""
        hits.append({
            "title": d.get("id") or "(无题)",
            "url": "https://huggingface.co/datasets/" + str(d.get("id") or ""),
            "meta": meta,
            "excerpt": desc[:800],
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
