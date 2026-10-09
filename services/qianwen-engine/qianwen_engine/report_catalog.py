# -*- coding: utf-8 -*-
"""报告商城目录（v0.9.0 用户令 1008：研究报告商城整合进总包AI顾问）。

数据源 report_platform/content/report.json（66 SKU）随镜像部署在
REPORT_CONTENT_DIR；PDF 全文在 <dir>/full/<sku>.pdf，试读在 <dir>/sample/。

可售判定（防「卖出无货/手机打不开」两类事故）：
- BLUEBOOK-2027（¥10000 预售）无 PDF → 整理中不上架购买；
- TOPIC-06 PDF 异常膨胀 143MB（生成事故，手机端不可用）→ 超
  REPORT_PDF_MAX_BYTES 一律整理中。两者目录仍展示（状态 sellable=false）。
"""
from __future__ import annotations

import json
import re
import threading
from pathlib import Path
from typing import Optional

from . import config

_LOCK = threading.Lock()
_CACHE: dict = {"mtime": 0.0, "reports": [], "by_sku": {}}

# 纯数值徽标（"13.7" / "262"）；"15.6 万字"、"18.3%"、"1600+ 份" 均不匹配。
_PURE_NUM = re.compile(r"^[0-9]+(?:\.[0-9]+)?$")


def _norm_badges(badges) -> list:
    """徽标 k/v 规范（v0.9.1 语序倒装修复）。

    正本 report.json 与报告平台官网共用：官网模板值先序渲染 <b>{v}</b>{k}
    （build_site.py「13.7万字成稿」），故 ent/prov/topic/excl 的源数据是
    v=纯数值、k=单位标签；而小程序目录/详情模板是 {{b.k}} {{b.v}} 标签
    前序，直接透传会渲染成「万字成稿 13.7 / 章 11」倒装语序。

    规范规则（API 边界统一，源文件不动）：v 为纯数值且 k 非纯数值 →
    交换为 k=数值 v=单位标签，渲染「13.7 万字成稿」「11 章」；旗舰卷
    （k=指标名 v=带单位值，如 报告字数/15.6 万字）与非 dict 条目（字符串
    徽标、缺键）原样透传。幂等：交换后 v 不再是纯数值，不会二次交换。
    """
    out = []
    for b in badges or []:
        if (isinstance(b, dict) and {"k", "v"} <= b.keys()
                and _PURE_NUM.match(str(b.get("v") or ""))
                and not _PURE_NUM.match(str(b.get("k") or ""))):
            out.append({"k": b["v"], "v": b["k"]})
        else:
            out.append(b)
    return out


def _content_dir() -> Path:
    return Path(config.REPORT_CONTENT_DIR)


def _load() -> list:
    """读 report.json（mtime 变更才重读；进程内缓存，列表接口热路径不扫盘）。"""
    f = _content_dir() / "report.json"
    try:
        mtime = f.stat().st_mtime
    except OSError:
        return []
    with _LOCK:
        if mtime == _CACHE["mtime"] and _CACHE["reports"]:
            return _CACHE["reports"]
        try:
            data = json.loads(f.read_text(encoding="utf-8"))
            reports = list(data.get("reports") or [])
        except (OSError, ValueError):
            return _CACHE["reports"] or []
        _CACHE["mtime"] = mtime
        _CACHE["reports"] = reports
        _CACHE["by_sku"] = {r.get("sku", ""): r for r in reports}
        return reports


def _sellable(r: dict) -> bool:
    """PDF 存在且不超大小上限（缺文件/超限=整理中，可看不可买）。"""
    sku = r.get("sku") or ""
    if not sku or sku in config.REPORT_HIDDEN_SKUS:
        return False
    try:
        size = (_content_dir() / "full" / f"{sku}.pdf").stat().st_size
    except OSError:
        return False
    return 0 < size <= config.REPORT_PDF_MAX_BYTES


def _item(r: dict) -> dict:
    """目录条目（客户端字段裁剪：intro/正文级大字段按需走详情腿）。"""
    return {
        "sku": r.get("sku", ""),
        "title": r.get("title", ""),
        "subtitle": r.get("subtitle", ""),
        "price": int(r.get("price") or 0),
        "price_label": r.get("price_label", ""),
        "words_wan": r.get("words_wan"),
        "badges": _norm_badges(r.get("badges")),
        "cat": r.get("cat", ""),
        "cat_name": r.get("cat_name", ""),
        "intro_lede": r.get("intro_lede", ""),
        "sellable": _sellable(r),
    }


def catalog() -> list:
    return [_item(r) for r in _load()]


def get_report(sku: str) -> Optional[dict]:
    """详情（含章节/适用人群/简介全文/试读文件名）。"""
    r = _CACHE["by_sku"].get(sku) if _CACHE["by_sku"] else None
    if r is None:
        _load()
        r = _CACHE["by_sku"].get(sku)
    if r is None:
        return None
    out = _item(r)
    out.update({
        "chapters": r.get("chapters") or [],
        "audience": r.get("audience", ""),
        "intro": r.get("intro", ""),
        "sample_file": r.get("sample_file", ""),
        "sample_label": r.get("sample_label", ""),
        "method_note": r.get("method_note", ""),
    })
    return out


def sellable(sku: str) -> bool:
    r = get_report(sku)
    return bool(r and r["sellable"])


def pdf_path(sku: str) -> Optional[Path]:
    if not sellable(sku):
        return None
    p = _content_dir() / "full" / f"{sku}.pdf"
    return p if p.exists() else None


def sample_text(sku: str) -> Optional[str]:
    """试读 markdown 正文（文件缺失返回 None → 客户端显示「试读整理中」）。"""
    r = get_report(sku)
    name = (r or {}).get("sample_file") or ""
    if not name:
        return None
    p = _content_dir() / "sample" / name
    try:
        return p.read_text(encoding="utf-8")
    except OSError:
        return None


def price_fen(sku: str) -> int:
    r = _CACHE["by_sku"].get(sku) if _CACHE["by_sku"] else {}
    return int((r or {}).get("price") or 0) * 100
