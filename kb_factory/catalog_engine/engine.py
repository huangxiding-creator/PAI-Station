# -*- coding: utf-8 -*-
"""KB-CAT v1 编目引擎核心（stdlib only，规则引擎，零 LLM）。

确定性纪律：无随机源、无时钟；同输入必同输出。
需要抖动时以 sha256(规范化输入) 为种子（本版未使用抖动，接口已备：need_hash8）。
"""
from __future__ import annotations

from typing import Optional

# 规模计划（size_hint → L1 数 / 每 L1 的 L2 数 / 每 L2 槽数）：
#     small  10/10/10 = 1,000 槽
#     medium 12/12/12 = 1,728 槽
#     large  16/14/14 = 3,136 槽
#     huge   20/10/250 = 50,000 槽
# phi-1 配比：small 50/35/15 · medium 55/35/10 · large|huge 58/34/8
# 报价（A 档）：base 29.0 + gb×2.0
import hashlib
import json

from . import blueprint as bp
from . import taxonomy
from .metadata import (BADGES, EXT_BYTES, PERM_BY_BADGE, badge_for_index, make_slot,
                       pick_ext, sanitize_filename)

ENGINE_VERSION = "kb-cat/1.0.0"
MAX_L1 = 22
MIN_L1 = 8

SIZE_PLANS = {
    "small": {"l1": 10, "l2": 10, "fpg": 10},
    "medium": {"l1": 12, "l2": 12, "fpg": 12},
    "large": {"l1": 16, "l2": 14, "fpg": 14},
    "huge": {"l1": 20, "l2": 10, "fpg": 250},
}
RATIO_BY_SIZE = {
    "small": {"core": 50, "field": 35, "guide": 15},
    "medium": {"core": 55, "field": 35, "guide": 10},
    "large": {"core": 58, "field": 34, "guide": 8},
    "huge": {"core": 58, "field": 34, "guide": 8},
}
QUOTE_PARAMS = {"base": 29.0, "per_gb": 2.0, "md_factor": 1.5, "ima_add": 19.0}


def validate_need(need: dict) -> dict:
    """需求 JSON 门：{domain:str, keywords:[str], intent:str, size_hint:str}。"""
    if not isinstance(need, dict):
        raise ValueError("need 必须是 dict")
    for k in ("domain", "intent", "size_hint"):
        if not isinstance(need.get(k), str) or not need[k].strip():
            raise ValueError(f"need.{k} 必须是非空 str")
    kws = need.get("keywords", [])
    if not isinstance(kws, list) or not all(isinstance(x, str) and x.strip() for x in kws):
        raise ValueError("need.keywords 必须是 [str]")
    if need["size_hint"] not in SIZE_PLANS:
        raise ValueError(f"size_hint 越界: {need['size_hint']}，可选 {sorted(SIZE_PLANS)}")
    return {"domain": need["domain"].strip(), "keywords": [x.strip() for x in kws],
            "intent": need["intent"].strip(), "size_hint": need["size_hint"]}


def need_hash8(need: dict) -> str:
    """输入规范化哈希（确定性种子/标识符用；zh 文本不转义以稳定哈希）。"""
    blob = json.dumps(need, sort_keys=True, ensure_ascii=False, separators=(",", ":"))
    return hashlib.sha256(blob.encode("utf-8")).hexdigest()[:8]


def build_blueprint(raw_need: dict, mode: str = "document_driven") -> dict:
    """蓝图生成入口——mode 选择引擎：
    - document_driven: 检索真实法规/标准 → 从文件体系提炼框架（1022 用户令）
    - taxonomy: 通用分类法扇出（v1 原始模式，fallback）
    """
    if mode == "document_driven":
        bp = _try_document_driven(raw_need)
        if bp is not None:
            return bp
        # 降级：检索不足 → fallback 到 taxonomy
    return _build_blueprint_taxonomy(raw_need)


def _try_document_driven(raw_need: dict) -> Optional[dict]:
    """文件驱动模式：检索真实文件 → 提炼框架。检索不足返回 None（降级）。"""
    try:
        from .doc_search import search_all_sources
        from .document_engine import build_blueprint_document_driven
    except ImportError:
        return None

    docs = search_all_sources(raw_need)
    if len(docs) < 10:  # 少于 10 件真实文件 → 降级到 taxonomy
        return None

    bp = build_blueprint_document_driven(raw_need, docs)
    bp["provenance"]["fallback_from"] = None
    bp["provenance"]["doc_count"] = len(docs)
    return bp


def _build_blueprint_taxonomy(raw_need: dict) -> dict:
    """原 taxonomy 模式（v1 逻辑保持不变）。"""
    need = validate_need(raw_need)
    plan = SIZE_PLANS[need["size_hint"]]
    ratio = RATIO_BY_SIZE[need["size_hint"]]
    h8 = need_hash8(need)
    stage_log = [f"S1 需求解析: domain={need['domain']} size_hint={need['size_hint']} keywords={len(need['keywords'])}"]

    match = taxonomy.match_seed(need)
    stage_log.append(f"S2 种子匹配: mode={match['mode']} seeds={match['seed_taxonomy']}")

    l1_specs = taxonomy.pick_l1(need, plan, match["mode"])
    if len(l1_specs) < MIN_L1:  # 防御：极小计划也不破 L1≥8 下限
        l1_specs = taxonomy.pick_l1(need, {"l1": MIN_L1}, match["mode"])
    stage_log.append(f"S3 L1 选类: {len(l1_specs)} 个（上限 {MAX_L1}）")

    ctx = {"idx": 0, "bytes": 0, "files": 0, "dirs": 0, "splits": 0,
           "by_tier": {"core": 0, "field": 0, "guide": 0}, "by_ext": {}}
    l1_nodes = []
    for i, spec in enumerate(l1_specs, 1):
        l1_dir = f"{spec['code']}-{i:02d}"
        l1_node = {"code": spec["code"], "dir": l1_dir, "path": f"{l1_dir}/",
                   "name": spec["name"], "theme": spec["theme"], "source": spec["source"], "l2": []}
        for j, topic in enumerate(taxonomy.build_l2_topics(spec, need, plan["l2"]), 1):
            nn = f"{j:02d}"
            path = f"{l1_dir}/{nn}/"
            slots = _make_slots(topic, spec["name"], need["domain"], path,
                                bp.tier_counts(plan["fpg"], ratio), ctx, h8)
            l2 = {"code": f"{l1_dir}/{nn}", "dir": nn, "path": path, "name": topic,
                  "theme": f"{topic}：{spec['name']}主题组文件槽", "file_count": len(slots)}
            if len(slots) > bp.MAX_FILES_PER_DIR:
                safe = sanitize_filename(topic)
                l2["split_dirs"] = bp.split_files(safe, slots, base_path=path)
                l2["files"] = []
                ctx["splits"] += len(l2["split_dirs"])
                ctx["dirs"] += len(l2["split_dirs"])
            else:
                l2["files"] = slots
                ctx["dirs"] += 1
            l1_node["l2"].append(l2)
        stage = f"S4 L2 主题组[{spec['code']}]: {len(l1_node['l2'])} 组"
        if i == 1:
            stage_log.append(stage)
        l1_node["index_md"] = bp.render_l1_index(l1_node)
        for l2 in l1_node["l2"]:
            l2["index_md"] = bp.render_l2_index(l2, l1_node)
        l1_nodes.append(l1_node)
    stage_log.append(f"S5 槽位配比: core/field/guide={ratio['core']}/{ratio['field']}/{ratio['guide']} "
                     f"共 {ctx['files']} 槽")
    stage_log.append(f"S6 分拆检查: 上限 {bp.MAX_FILES_PER_DIR}/目录，分拆目录 {ctx['splits']} 个")

    gb = round(ctx["bytes"] / 1024 ** 3, 2)
    stats = {"files": ctx["files"], "bytes": ctx["bytes"], "gb": gb,
             "by_tier": ctx["by_tier"], "by_ext": ctx["by_ext"],
             "l1_count": len(l1_nodes), "l2_count": sum(len(x["l2"]) for x in l1_nodes),
             "dir_count": ctx["dirs"], "split_dir_count": ctx["splits"]}
    quote = dict(QUOTE_PARAMS, total=round(QUOTE_PARAMS["base"] + gb * QUOTE_PARAMS["per_gb"], 1))
    stage_log.append(f"S7 统计与报价: gb={gb} quote.total={quote['total']}")
    provenance = {"engine_version": ENGINE_VERSION, "seed_taxonomy": match["seed_taxonomy"],
                  "stage_log": stage_log}
    tree = {"mode": match["mode"], "root": need["domain"], "l1": l1_nodes}
    return bp.assemble_blueprint(need["domain"], need, tree, ratio, stats, quote, provenance)


def _make_slots(topic, l1_name, domain, path, counts, ctx, h8):
    """按配比造占位槽：{主题}_{类型}_{序号}.{ext}；徽章按全局序轮转（确定性）。"""
    slots = []
    for tier in bp.TIERS:
        for k in range(1, counts[tier] + 1):
            ext = pick_ext(tier, k)
            name = f"{sanitize_filename(topic)}_{tier}_{k:03d}.{ext}"
            badge = badge_for_index(ctx["idx"])
            perm = PERM_BY_BADGE[badge]
            slot = {"name": name, "path": path, "tier": tier, "ext": ext}
            slot.update(make_slot(name=name, tier=tier, ext=ext, theme=topic, l1_name=l1_name,
                                  domain=domain, path=path, badge=badge, perm=perm,
                                  idx=ctx["idx"], need_hash8=h8))
            slots.append(slot)
            ctx["idx"] += 1
            ctx["bytes"] += EXT_BYTES[ext]
            ctx["by_tier"][tier] += 1
            ctx["by_ext"][ext] = ctx["by_ext"].get(ext, 0) + 1
    ctx["files"] += len(slots)
    return slots
