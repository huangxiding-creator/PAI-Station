# -*- coding: utf-8 -*-
"""wenku ndview 类目/标签提取件（目录层情报；KB-FACTORY 2.0 A1 轴①深挖 · 新文件）。

职责：与 dangdang toc_lines（目录层抓取）同位——为蓝图编目树补目录层分层素材，
从 ndview pageData/readerInfo 提取 tags（标签）与 category（类目）。

候选键防御性扫描（零造假纪律优先于键名猜测）：ndview 真实 pageData 未在本地
留样（captures 只留 title/pages 摘要），readerInfo 与 docInfo 的类目/标签键名
无法离线核验——故按公开 pageData 常见形态列候选键序，命中即透传、缺席如实
不造（不造空值不造键名不造类目）。真网络留样落地后可在此收窄候选集。

纯本地纯函数：零网络零落盘零时钟，同输入必同输出；不 import 任何渠道件
（被 wenku_meta 单向引用，防环）。

接线说明（wenku_meta.py 两处，均为深化不破坏既有契约）：
    from kb_factory.channel_adapters.wenku_taxonomy import (
        merge_docinfo_taxonomy, taxonomy_fields)
    1) _ndview_urllib_fetch：pageData.docInfo 的候选键合入返回 dict（浅拷贝不改源）；
    2) _ndview_extra：taxonomy_fields(ri) → ndview.tags / ndview.category 进白名单产出
       （_NDVIEW_KEYS 已扩 "tags"/"category" 两键，产出仍 ⊆ 白名单，下载道零泄漏不变）。
"""
from __future__ import annotations

__all__ = ["TAG_KEYS", "CATEGORY_KEYS", "taxonomy_fields", "merge_docinfo_taxonomy"]

# 标签候选键序（先命中先用；候选键只可能是标签语义键，不含任何下载道字段）
TAG_KEYS = ("tagList", "tags", "tag")
# 类目候选键序（同上；docTypeName 语义=文档类型名，作类目兜底位）
CATEGORY_KEYS = ("categoryName", "secondCategoryName", "className", "category",
                 "docTypeName")


def _norm_tags(v) -> list | None:
    """标签归一：str→[str]；list→滤出非空 str 项；空/异形→None（如实缺席）。"""
    if isinstance(v, str):
        v = v.strip()
        return [v] if v else None
    if isinstance(v, list):
        out = [s.strip() for s in v if isinstance(s, str) and s.strip()]
        return out or None
    return None


def _norm_category(v) -> str | None:
    """类目归一：非空 str→strip；其余→None（如实缺席，不造空串）。"""
    if isinstance(v, str) and v.strip():
        return v.strip()
    return None


def taxonomy_fields(src: dict) -> dict:
    """dict → {"tags": [str], "category": str} 子集（候选键缺席的成员如实省略）。

    只读不改入参；任何形态异常（None/嵌套 dict/数字）一律按缺席处理，绝不抛出。
    """
    out: dict = {}
    if not isinstance(src, dict):
        return out
    for k in TAG_KEYS:
        tags = _norm_tags(src.get(k))
        if tags and "tags" not in out:
            out["tags"] = tags
    for k in CATEGORY_KEYS:
        cat = _norm_category(src.get(k))
        if cat and "category" not in out:
            out["category"] = cat
    return out


def merge_docinfo_taxonomy(ri: dict, page_data: dict) -> dict:
    """pageData.docInfo 的类目/标签候选键合入 ri（浅拷贝返回，不改性）。

    docInfo 缺席/非 dict → ri 原样返回（零行为漂移）；ri 已有的键不覆写
    （readerInfo 优先，docInfo 只补位）。仅合入候选键集内的键——下载道字段
    （htmlUrls 载荷/rsign/md5sum/storeId/bucketNum/rtcsRangeInfo）不在集内，
    铁律不破。
    """
    di = page_data.get("docInfo") if isinstance(page_data, dict) else None
    if not isinstance(di, dict) or not isinstance(ri, dict):
        return ri
    out = dict(ri)
    for k in frozenset(TAG_KEYS) | frozenset(CATEGORY_KEYS):
        if k in di and k not in out:
            out[k] = di[k]
    return out
