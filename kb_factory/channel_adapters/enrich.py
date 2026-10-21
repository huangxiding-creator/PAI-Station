# -*- coding: utf-8 -*-
"""蓝图渠道回填（W5，元数据层）：把真实渠道 FileMeta 灌进蓝图文件槽。

enrich_blueprint(bp, adapters, per_topic=12)：对每个 L2 主题组，用 L2 标题（去编号）
作查询词向各 adapter 取元数据，按 phi-1 配比（bp.ratio，与引擎同款 tier_counts）
回填真实 FileMeta 替换占位名——fill 时保留槽位原 fmt 偏好尽量匹配（core→pdf 优先）；
真实条目多于槽位时按配比截断；槽位不足时未填槽保留占位并在 provenance 计
placeholder_kept。绝不增加下载行为（本模块零网络腿，网络全在 adapter 内）。

CLI：py -3 -m kb_factory.channel_adapters.enrich <bp.json> -o out.json [--dry]
     [--per-topic N] [--max-topics N] [--no-ima]
"""
import argparse
import json
import re
import sys

from kb_factory.catalog_engine.blueprint import TIERS, tier_counts
from kb_factory.catalog_engine.metadata import EXT_MIME, RIGHTS_BY_PERM, sanitize_filename
from kb_factory.channel_adapters.base import (AuditLog, CircuitOpenError, RateLimitExceeded,
                                              AUDIT_DEFAULT_PATH)

# 渠道 fmt → 蓝图槽 ext 族（docx/xlsx 为蓝图族名，doc/xls 为文库码名）
EXT_NORMALIZE = {"doc": "docx", "xls": "xlsx"}
FALLBACK_MIME = {"ppt": "application/vnd.ms-powerpoint", "txt": "text/plain",
                 "epub": "application/epub+zip", "ebook": "application/octet-stream",
                 "kb": "application/octet-stream"}

_NUM_PREFIX = re.compile(
    r"^\s*(?:\d{1,3}\s*[.、)）\-：:]|\d{1,2}\s(?=\S)|[（(][一二三四五六七八九十\d]{1,3}[)）]"
    r"|第[一二三四五六七八九十百\d]{1,4}[章节讲单元部分]"
    r"|[一二三四五六七八九十]{1,3}[、.．])\s*")


def strip_numbering(name: str) -> str:
    """L2 标题去编号前缀（'01 工程总承包'/'第三章 施工安全'/'一、造价管理'→去前缀；剥空则原样返回）。"""
    stripped = name or ""
    for _ in range(3):  # 叠层前缀（'01 第三章 …'）最多剥三层
        new = _NUM_PREFIX.sub("", stripped).strip()
        if new == stripped:
            break
        stripped = new
    return stripped or (name or "").strip()


def ext_for(fmt: str) -> str:
    return EXT_NORMALIZE.get(fmt, fmt or "bin")


def mime_for(ext: str) -> str:
    return EXT_MIME.get(ext) or FALLBACK_MIME.get(ext, "application/octet-stream")


def fmt_matches(slot_ext: str, fmt: str) -> bool:
    return ext_for(fmt) == slot_ext or fmt == slot_ext


def apply_meta(slot: dict, meta, channel: str) -> None:
    """把真实 FileMeta 回填进槽位（就地替换占位值；引擎标识符/日期/校验位保留）。"""
    ext = ext_for(meta.fmt)
    stem = sanitize_filename(meta.title)[:80] or str(
        meta.extra.get("doc_id") or meta.extra.get("kb_id") or "untitled")
    slot["title"] = meta.title
    slot["name"] = f"{stem}.{ext}"
    slot["ext"] = ext
    slot["format"] = mime_for(ext)
    slot["source"] = meta.source_url or f"channel:{channel}"
    slot["badge"] = meta.badge
    slot["perm"] = meta.perm
    slot["rights"] = RIGHTS_BY_PERM[meta.perm]
    bits = [f"渠道实采元数据: {channel}", f"fmt={meta.fmt}"]
    if meta.pages:
        bits.append(f"{meta.pages}页")
    did = meta.extra.get("doc_id") or meta.extra.get("kb_id")
    if did:
        bits.append(f"id={did}")
    slot["description"] = " · ".join(bits)


def _group_slots(l2: dict) -> list:
    if l2.get("files"):
        return l2["files"]
    return [f for sd in l2.get("split_dirs", []) for f in sd.get("files", [])]


def _iter_groups(bp: dict):
    for l1 in bp.get("tree", {}).get("l1", []):
        for l2 in l1.get("l2", []):
            yield l2


def _fill_group(slots: list, pool: list, ratio: dict, channels: dict):
    """按配比回填一组槽位。pool=[(FileMeta, channel)]（已去重）；返回本组填充数。"""
    k = min(len(pool), len(slots))
    budgets = dict(tier_counts(k, ratio))
    by_tier = {t: [i for i, s in enumerate(slots) if s.get("tier") == t] for t in TIERS}
    for t in TIERS:  # 某档槽不足 → 按档序级联挪额，保总数=k
        if budgets[t] > len(by_tier[t]):
            leftover = budgets[t] - len(by_tier[t])
            budgets[t] = len(by_tier[t])
            for t2 in TIERS:
                move = min(leftover, len(by_tier[t2]) - budgets[t2])
                budgets[t2] += move
                leftover -= move
                if leftover <= 0:
                    break
    filled = 0
    for t in TIERS:
        need = budgets[t]
        for idx in by_tier[t]:
            if need <= 0 or not pool:
                break
            slot = slots[idx]
            pick = next((j for j, (m, _) in enumerate(pool)
                         if fmt_matches(slot.get("ext", ""), m.fmt)), 0)  # fmt 偏好优先，否则保序
            meta, ch = pool.pop(pick)
            apply_meta(slot, meta, ch)
            channels[ch]["filled"] += 1
            need -= 1
            filled += 1
    return filled


def enrich_blueprint(bp: dict, adapters: list, per_topic: int = 12, max_topics: int | None = None,
                     audit: AuditLog | None = None) -> dict:
    """就地回填并返回蓝图（同 dict，无拷贝）。provenance 增 channel_enrichment 计数。"""
    ratio = bp["ratio"]
    channels = {a.channel: {"requests": 0, "results": 0, "filled": 0} for a in adapters}
    unavailable, filled_total, kept_total, groups_queried = {}, 0, 0, 0
    for l2 in _iter_groups(bp):
        slots = _group_slots(l2)
        if not slots:
            continue
        if max_topics is not None and groups_queried >= max_topics:
            continue
        groups_queried += 1
        query = strip_numbering(l2.get("name", ""))
        pool, seen = [], set()
        for a in adapters:
            if not a.available():
                unavailable[a.channel] = a.reason() or "unavailable"
                continue
            try:
                metas = a.metadata(query, per_topic)
            except (RateLimitExceeded, CircuitOpenError) as e:
                unavailable[a.channel] = f"{type(e).__name__}: {e}"
                continue
            channels[a.channel]["requests"] += 1
            channels[a.channel]["results"] += len(metas)
            for m in metas:
                if m.title and m.title not in seen:
                    seen.add(m.title)
                    pool.append((m, a.channel))
        filled = _fill_group(slots, pool, ratio, channels)
        filled_total += filled
        kept_total += len(slots) - filled
        if audit is not None:
            audit.log(channel="enrich", event="group", query=query, count=filled,
                      detail=f"slots={len(slots)} kept={len(slots) - filled}")
    bp["provenance"]["channel_enrichment"] = {
        "adapters": [a.channel for a in adapters],
        "per_topic": per_topic,
        "groups_queried": groups_queried,
        "channels": channels,
        "unavailable": unavailable,
        "filled": filled_total,
        "placeholder_kept": kept_total,
    }
    ch_txt = ",".join(f"{c}:{v['filled']}" for c, v in channels.items())
    bp["provenance"]["stage_log"].append(
        f"S8 渠道元数据回填: groups={groups_queried} filled={filled_total} "
        f"placeholder_kept={kept_total} channels[{ch_txt}] unavailable={list(unavailable)}")
    return bp


def plan_dry(bp: dict, adapters: list, per_topic: int = 12,
             max_topics: int | None = None) -> dict:
    """dry 计划：将要查询的词与预算，零请求、零改动。"""
    queries = []
    for l2 in _iter_groups(bp):
        if not _group_slots(l2):
            continue
        if max_topics is not None and len(queries) >= max_topics:
            break
        queries.append(strip_numbering(l2.get("name", "")))
    return {"groups_queried": len(queries), "queries": queries,
            "per_topic": per_topic,
            "budget_requests": len(queries) * len(adapters),
            "adapters": [{"channel": a.channel, "available": a.available(),
                          "limiter": getattr(a, "limiter", None) and a.limiter.status()}
                         for a in adapters]}


def build_default_adapters(audit):
    from kb_factory.channel_adapters.ima_meta import ImaMetaAdapter
    from kb_factory.channel_adapters.wenku_meta import WenkuMetaAdapter
    return [WenkuMetaAdapter(audit=audit), ImaMetaAdapter(audit=audit)]


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(prog="kb_factory.channel_adapters.enrich",
                                 description="渠道元数据回填蓝图（零下载）")
    ap.add_argument("blueprint", help="输入蓝图 JSON")
    ap.add_argument("-o", "--out", help="输出蓝图 JSON 路径")
    ap.add_argument("--dry", action="store_true", help="只打印查询词与预算，不发请求")
    ap.add_argument("--per-topic", type=int, default=12)
    ap.add_argument("--max-topics", type=int, default=None, help="只回填前 N 个 L2 组")
    ap.add_argument("--no-ima", action="store_true", help="只用文库渠道")
    args = ap.parse_args(argv)

    with open(args.blueprint, encoding="utf-8") as f:
        bp = json.load(f)
    audit = AuditLog(__import__("os").environ.get("KB_ADAPTER_AUDIT") or AUDIT_DEFAULT_PATH)
    adapters = build_default_adapters(audit)
    if args.no_ima:
        adapters = [a for a in adapters if a.channel != "ima"]

    if args.dry:
        plan = plan_dry(bp, adapters, per_topic=args.per_topic, max_topics=args.max_topics)
        print(json.dumps(plan, ensure_ascii=False, indent=1))
        print(f"[dry] 零请求零改动：{plan['groups_queried']} 组 × {len(adapters)} 渠道 "
              f"= 预算 {plan['budget_requests']} 请求")
        return 0
    if not args.out:
        ap.error("--out 必填（或用 --dry）")
    enrich_blueprint(bp, adapters, per_topic=args.per_topic, max_topics=args.max_topics,
                     audit=audit)
    with open(args.out, "w", encoding="utf-8") as f:
        json.dump(bp, f, ensure_ascii=False, indent=1)
    prov = bp["provenance"]["channel_enrichment"]
    print(f"[enrich] groups={prov['groups_queried']} filled={prov['filled']} "
          f"placeholder_kept={prov['placeholder_kept']} channels={prov['channels']} "
          f"unavailable={prov['unavailable']}")
    print(f"[audit] {audit.path}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
