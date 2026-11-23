# -*- coding: utf-8 -*-
"""超级总包知识库目录与更新流（v1.0.0，1123 用户令《100× 总案》C1/C2）。

数据源 KB_CONTENT_DIR 下两个 JSON（建库产线 kb_engine_data.py 生成，随镜像部署）：
- kb_catalog.json  45 库体系树 + 版本 + 就位统计
- kb_updates.json  面向买家的更新流（价值可见 changelog）

只读公开端点（营销面数据，无鉴权；内部运维数字不出境）。
缓存策略与 report_catalog 同款：mtime 变更才重读，热路径零扫盘。
"""
from __future__ import annotations

import json
import threading
from pathlib import Path

from fastapi import APIRouter

from . import config

router = APIRouter(prefix="/api/kb", tags=["kb"])

_LOCK = threading.Lock()
_CACHE: dict = {"catalog_mtime": 0.0, "catalog": {}, "updates_mtime": 0.0, "updates": {}}


def _dir() -> Path:
    return Path(config.KB_CONTENT_DIR)


def _load(name: str, mkey: str, ckey: str) -> dict:
    f = _dir() / name
    try:
        mtime = f.stat().st_mtime
    except OSError:
        return _CACHE[ckey] or {}
    with _LOCK:
        if mtime == _CACHE[mkey] and _CACHE[ckey]:
            return _CACHE[ckey]
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
        except (OSError, ValueError):
            return _CACHE[ckey] or {}
        if not isinstance(data, dict):
            return _CACHE[ckey] or {}
        _CACHE[mkey] = mtime
        _CACHE[ckey] = data
        return data


@router.get("/catalog")
def kb_catalog():
    """45 库体系树 + 版本号 + 就位统计（C1）。"""
    d = _load("kb_catalog.json", "catalog_mtime", "catalog")
    if not d:
        return {"version": "", "libs": [], "stats": {}, "available": False}
    return {**d, "available": True}


@router.get("/updates")
def kb_updates():
    """面向买家的更新流（C2，与 B2 变更摘要同源）。"""
    d = _load("kb_updates.json", "updates_mtime", "updates")
    if not d:
        return {"generated": "", "entries": [], "available": False}
    return {**d, "available": True}
