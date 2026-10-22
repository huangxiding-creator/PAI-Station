# -*- coding: utf-8 -*-
"""doc_search.py — 文件驱动引擎的多源检索器。

从 wenku/std-samr/IMA 检索真实法规/标准/规范文件，输出 DocFile 列表。
频控纪律：每渠道 ≤15 次请求，间隔≥3s，总计≤45 次。
"""
from __future__ import annotations

import time
from typing import Optional

from .document_engine import DocFile, extract_domain


def search_wenku_docs(domain_info: dict, max_queries: int = 10) -> list[DocFile]:
    """从 wenku 免登录 API 检索领域法规/标准/规范。"""
    try:
        from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    except ImportError:
        return []

    adapter = WenkuMetaAdapter()
    docs = []

    # 组合查询词：领域 + 文件类型词
    domain = domain_info["domain"]
    search_terms = []
    for kw in domain_info.get("law_keywords", [])[:3]:
        search_terms.append(kw)
    for kw in domain_info.get("std_keywords", [])[:3]:
        search_terms.append(kw)
    # 补充泛搜词
    search_terms.extend([f"{domain}规范", f"{domain}标准", f"{domain}法规",
                         f"{domain}操作手册", f"{domain}案例"])

    seen_titles = set()
    for term in search_terms[:max_queries]:
        try:
            items = adapter.metadata(term, limit=12)
        except Exception:
            continue
        for m in items:
            t = m.title or ""
            if t and t not in seen_titles:
                seen_titles.add(t)
                docs.append(DocFile(
                    title=t,
                    source="wenku",
                    fmt=m.fmt or "pdf",
                    pages=m.pages,
                    badge=m.badge or "green_free",
                    perm=m.perm or "green",
                    url=getattr(m, "source_url", None),
                    doc_id=(getattr(m, "extra", None) or {}).get("doc_id"),  # wenku docID
                ))
        time.sleep(0.1)  # adapter 内建频控

    return docs


def search_gb_standards(domain_info: dict) -> list[DocFile]:
    """从 std-samr-gb 技能检索国标（如果可用）。"""
    # std-samr-gb 是一个 Skill，不是 Python 模块——这里预留接口
    # 实际调用时由外层 Skill 触发，或后续封装为 API
    return []


def search_ima_docs(domain_info: dict) -> list[DocFile]:
    """从 IMA 知识库广场检索已有专业库结构。"""
    try:
        from kb_factory.channel_adapters.ima_meta import ImaMetaAdapter
    except ImportError:
        return []

    adapter = ImaMetaAdapter()
    if not adapter.available():
        return []

    docs = []
    domain = domain_info["domain"]
    try:
        items = adapter.metadata(domain, limit=12)
        for m in items:
            docs.append(DocFile(
                title=m.title or "",
                source="ima",
                fmt=m.fmt or "kb",
                badge=m.badge or "ima_public",
                perm=m.perm or "green",
                doc_id=(getattr(m, "extra", None) or {}).get("kb_id"),  # ima kb_id
            ))
    except Exception:
        pass
    return docs


def search_local_corpus(domain_info: dict) -> list[DocFile]:
    """从本地语料库检索（自产研报/知识件/混沌语料等）。"""
    import os
    from pathlib import Path

    roots = [
        Path(os.environ.get("KB_LOCAL_CORPUS", "E:/AI-Station/09 发布")),
        Path("E:/AI-Station/mosaico-water-safety/assets/knowledge"),
    ]

    domain = domain_info["domain"]
    docs = []
    for root in roots:
        if not root.exists():
            continue
        for p in root.rglob("*.pdf"):
            name = p.stem
            if any(kw in name for kw in [domain, domain_info["raw_need"][:6]]):
                docs.append(DocFile(
                    title=name,
                    source="local",
                    fmt="pdf",
                    size_kb=int(p.stat().st_size / 1024),
                    badge="self_owned",
                    perm="green",
                    doc_id=name,  # 本地文件名即标识（在盘可点验）
                ))
        for p in root.rglob("*.md"):
            name = p.stem
            if any(kw in name for kw in [domain, domain_info["raw_need"][:6]]):
                docs.append(DocFile(
                    title=name,
                    source="local",
                    fmt="md",
                    size_kb=int(p.stat().st_size / 1024),
                    badge="self_owned",
                    perm="green",
                    doc_id=name,  # 本地文件名即标识（在盘可点验）
                ))
    return docs


def search_all_sources(need: dict) -> list[DocFile]:
    """多源检索入口——文件驱动引擎的数据供给。"""
    text = " ".join(filter(None, [
        need.get("domain", ""),
        " ".join(need.get("keywords", [])),
        need.get("intent", ""),
    ]))
    domain_info = extract_domain(text)

    all_docs = []

    # wenku 是主力（免登录 API 已通）
    wenku_docs = search_wenku_docs(domain_info)
    all_docs.extend(wenku_docs)
    print(f"  wenku: {len(wenku_docs)} 件")

    # IMA（有登录态时）
    ima_docs = search_ima_docs(domain_info)
    all_docs.extend(ima_docs)
    print(f"  ima: {len(ima_docs)} 件")

    # 本地语料
    local_docs = search_local_corpus(domain_info)
    all_docs.extend(local_docs)
    print(f"  local: {len(local_docs)} 件")

    # 去重（按标题相似度）
    seen = set()
    deduped = []
    for d in all_docs:
        key = d.title[:30].strip().lower()
        if key not in seen:
            seen.add(key)
            deduped.append(d)

    return deduped
