# -*- coding: utf-8 -*-
"""eurostat 腿 — Eurostat SDMX API (1025 渠道普查纳管令; A级·项目数据).

注册表: channels_survey_2026/MASTER_REGISTRY.json (Eurostat API,
dissemination SDMX 1.0, 免登录API, registry evidence: HTTP 200 direct);
欧盟统计局, 建筑生产指数/建筑许可/PPI, 欧洲工程景气主源。
本腿查询词=数据集代码 (如 sts_copr_m 建筑生产月度; 代码错→404/414如实记)。
引擎调用+staging+ingest骨架照 last30days_leg.py 模式 (纯HTTP零浏览器,
共用芯 http_api_leg_core)。

用法: py reforge_factory/legs/eurostat_leg.py --campaign EPC-JIAGE
      --queries sts_copr_m
"""
from __future__ import annotations

import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import http_api_leg_core as core

SPEC = {"engine": "eurostat", "source": "Eurostat SDMX dissemination API",
        "note": "A级·项目数据·免登录API (registry: HTTP 200 direct)"}
_CODE = {"v": ""}                       # endpoint→extract 传递数据集代码


def endpoint(query, rows):
    code = query.strip().split()[0]
    _CODE["v"] = code
    return ("https://ec.europa.eu/eurostat/api/dissemination/statistics/1.0/data/" + code,
            {"format": "JSON", "lang": "EN", "sinceTimePeriod": "2019"},
            {}, "GET", None)


def extract(data):
    if not isinstance(data, dict) or "value" not in data:
        return []
    dims = data.get("id") or []
    dim_labels = {}
    for dim in dims:
        cat = ((data.get("dimension") or {}).get(dim) or {}).get("category") or {}
        idx, lab = cat.get("index") or {}, cat.get("label") or {}
        norm = {}
        for k, v in idx.items():
            positions = v if isinstance(v, dict) else {v: v}
            for pos in positions:
                norm[pos] = lab.get(k, k)
        dim_labels[dim] = norm
    time_dim = dims[-1] if dims else ""
    label = data.get("label") or ("Eurostat " + _CODE["v"])
    hits = []
    for key, v in sorted((data.get("value") or {}).items(),
                         key=lambda kv: str(kv[0]), reverse=True):
        if v is None:
            continue
        parts = str(key).split(",")
        t = key
        if time_dim and parts and parts[-1].isdigit():
            t = dim_labels.get(time_dim, {}).get(int(parts[-1]), parts[-1])
        hits.append({
            "title": "%s · %s = %s" % (label, t, v),
            "url": "https://ec.europa.eu/eurostat/databrowser/view/" + _CODE["v"],
            "meta": [m for m in [str(t), _CODE["v"]] if m],
            "excerpt": "欧盟统计局数据集 %s (%s) 时间点 %s 观测值 = %s"
                       % (_CODE["v"], label, t, v),
        })
    return hits


if __name__ == "__main__":
    raise SystemExit(core.run(SPEC))
