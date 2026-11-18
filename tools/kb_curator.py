# -*- coding: utf-8 -*-
"""
KB-Curator — 知识库变现引擎 · 弹药策展模块
从弹药池 manifest.jsonl 中筛选可变现材料并复制到产品目录。

筛选标准(核心层, 与产线口径一致):
  - judge == valid
  - chars > min_chars (默认 500)
  - engine 含 corpus_stores / crosspool / wedrive 前缀的优先(排序优先, 其余殿后)
补充层(--include-pending, 明示开启):
  - judge == pending 且 chars > min_chars 且源文件在盘
  - 用于把战役问题树已映射(tree_node/stance)但未经判读的跨池弹药纳入产品,
    报告中按 tier 分账披露, 不与核心层混计。

输出:
  <output>/files/                     原始文件名复制(重名加短哈希前缀)
  <output>/curator_report.json        总账: total_files/total_bytes_gb/by_engine/quality_score + 明细

用法:
  python kb_curator.py --pool EPC-SUBCON \
      --output E:/AI-Station/data/kb_products/KB-SUBCON-2026 [--include-pending] \
      [--ammo-root E:/AI-Station/ammo_pool] [--min-chars 500] [--max-files N] [--force]
"""
import argparse
import hashlib
import json
import os
import shutil
import sys
import time

PRIORITY_ENGINE_PREFIXES = ("corpus_stores", "crosspool", "wedrive")
# 质量系数四因子权重(定价公式共用)
W_VALID, W_DENSITY, W_SCARCE, W_STRUCT = 0.3, 0.3, 0.2, 0.2
DENSITY_BENCHMARK_CHARS = 20000  # 平均每文件 2 万字即密度满分


def load_manifest(pool_dir: str):
    path = os.path.join(pool_dir, "manifest.jsonl")
    recs = []
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            r = json.loads(line)
            r["_chars"] = int(r.get("chars") or 0)
            recs.append(r)
    return recs


def engine_priority(engine: str) -> int:
    return 0 if any(engine.startswith(p) for p in PRIORITY_ENGINE_PREFIXES) else 1


def select_entries(recs, min_chars: int, include_pending: bool):
    core, supp = [], []
    for r in recs:
        if r.get("judge") == "valid" and r["_chars"] > min_chars:
            core.append(r)
        elif include_pending and r.get("judge") == "pending" and r["_chars"] > min_chars:
            supp.append(r)
    # 引擎优先 -> 字数降序; 核心层在前
    key = lambda r: (engine_priority(r.get("engine", "")), -r["_chars"])
    core.sort(key=key)
    supp.sort(key=key)
    return core, supp


def dedup(entries):
    """按 source_path 去重(同文件多条目取判读最优先/字数最高); 再按 dedup_key 去内容重。"""
    by_path = {}
    for r in entries:
        sp = r.get("source_path", "")
        prev = by_path.get(sp)
        rank = (0 if r.get("judge") == "valid" else 1, -r["_chars"])
        if prev is None or rank < (0 if prev.get("judge") == "valid" else 1, -prev["_chars"]):
            by_path[sp] = r
    out, seen_keys, dup_key_skipped = [], set(), 0
    for sp, r in by_path.items():
        dk = r.get("dedup_key") or ""
        if dk and dk in seen_keys:
            dup_key_skipped += 1
            continue
        if dk:
            seen_keys.add(dk)
        out.append(r)
    order = {id(r): i for i, r in enumerate(entries)}
    out.sort(key=lambda r: order.get(id(r), 1 << 30))
    return out, dup_key_skipped


def unique_dest(files_dir: str, name: str, dedup_key: str) -> str:
    """保留原始文件名; 冲突时加 dedup_key 短哈希前缀; 再冲突加序号。"""
    cand = os.path.join(files_dir, name)
    if not os.path.exists(cand):
        return cand
    stem, ext = os.path.splitext(name)
    h8 = hashlib.sha1((dedup_key or name).encode("utf-8")).hexdigest()[:8]
    cand = os.path.join(files_dir, f"{stem}__{h8}{ext}")
    i = 2
    while os.path.exists(cand):
        cand = os.path.join(files_dir, f"{stem}__{h8}_{i}{ext}")
        i += 1
    return cand


def main():
    ap = argparse.ArgumentParser(description="KB-Curator 弹药策展")
    ap.add_argument("--pool", required=True, help="弹药池名, 如 EPC-SUBCON")
    ap.add_argument("--ammo-root", default="E:/AI-Station/ammo_pool")
    ap.add_argument("--output", required=True, help="产品输出目录")
    ap.add_argument("--min-chars", type=int, default=500)
    ap.add_argument("--include-pending", action="store_true",
                    help="纳入 judge=pending 且在盘的补充层(报告分账披露)")
    ap.add_argument("--max-files", type=int, default=0, help="可选: 总文件数上限(核心层优先)")
    ap.add_argument("--force", action="store_true", help="输出目录已有文件时仍覆写重跑")
    args = ap.parse_args()

    pool_dir = os.path.join(args.ammo_root, args.pool)
    manifest = os.path.join(pool_dir, "manifest.jsonl")
    if not os.path.exists(manifest):
        sys.exit(f"[curator] manifest 不存在: {manifest}")
    files_dir = os.path.join(args.output, "files")
    if os.path.isdir(files_dir) and os.listdir(files_dir) and not args.force:
        sys.exit(f"[curator] {files_dir} 非空; 确认重跑请加 --force")

    t0 = time.time()
    recs = load_manifest(pool_dir)
    core_raw, supp_raw = select_entries(recs, args.min_chars, args.include_pending)

    # 池级判读率(全 manifest 口径, 数字零造假)
    pool_total_chars = sum(r["_chars"] for r in recs)
    pool_valid_chars = sum(r["_chars"] for r in recs if r.get("judge") == "valid")

    core, core_dk = dedup(core_raw)
    supp, supp_dk = dedup(supp_raw)
    # 补充层再剔除与核心层同 dedup_key 的
    core_keys = {r.get("dedup_key") for r in core if r.get("dedup_key")}
    supp = [r for r in supp if not (r.get("dedup_key") and r.get("dedup_key") in core_keys)]

    selected = core + supp
    if args.max_files and len(selected) > args.max_files:
        selected = selected[: args.max_files]

    os.makedirs(files_dir, exist_ok=True)
    items, missing = [], []
    for r in selected:
        sp = r.get("source_path", "")
        if not sp or not os.path.exists(sp):
            missing.append(sp)
            continue
        base = os.path.basename(sp)
        dest = unique_dest(files_dir, base, r.get("dedup_key", ""))
        renamed = os.path.basename(dest) != base
        try:
            shutil.copy2(sp, dest)
        except OSError as e:
            print(f"[curator] 复制失败 {base}: {e}")
            continue
        items.append({
            "file": os.path.basename(dest),
            "renamed": renamed,
            "tier": "core" if r.get("judge") == "valid" else "supplement",
            "judge": r.get("judge"),
            "engine": r.get("engine", ""),
            "tree_node": r.get("tree_node", ""),
            "source_path": sp,
            "bytes": os.path.getsize(dest),
            "chars": r["_chars"],
        })

    total_files = len(items)
    total_bytes = sum(i["bytes"] for i in items)
    total_chars = sum(i["chars"] for i in items)

    by_engine = {}
    for i in items:
        e = by_engine.setdefault(i["engine"], {"files": 0, "bytes": 0, "chars": 0})
        e["files"] += 1
        e["bytes"] += i["bytes"]
        e["chars"] += i["chars"]
    by_tier = {
        t: {
            "files": sum(1 for i in items if i["tier"] == t),
            "bytes": sum(i["bytes"] for i in items if i["tier"] == t),
            "chars": sum(i["chars"] for i in items if i["tier"] == t),
        }
        for t in ("core", "supplement")
    }

    # 质量四因子(实测口径)
    valid_rate = (pool_valid_chars / pool_total_chars) if pool_total_chars else 0.0
    density = min(1.0, (total_chars / total_files) / DENSITY_BENCHMARK_CHARS) if total_files else 0.0
    rss_share = (sum(1 for i in items if "rss_harvest" in i["source_path"].lower()) / total_files) if total_files else 0.0
    scarcity = 1.0 - rss_share
    structure = (sum(1 for i in items if i["file"].lower().endswith(".md")) / total_files) if total_files else 0.0
    quality_score = round(W_VALID * valid_rate + W_DENSITY * density
                          + W_SCARCE * scarcity + W_STRUCT * structure, 4)

    report = {
        "module": "kb_curator",
        "pool": args.pool,
        "pool_dir": pool_dir,
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "filter": {"judge": "valid(+pending 补充层)", "min_chars": args.min_chars,
                   "include_pending": args.include_pending, "max_files": args.max_files or None},
        "priority_engine_prefixes": list(PRIORITY_ENGINE_PREFIXES),
        "total_files": total_files,
        "total_bytes": total_bytes,
        "total_bytes_gb": round(total_bytes / 2 ** 30, 4),
        "total_chars": total_chars,
        "by_tier": by_tier,
        "by_engine": by_engine,
        "dedup_skipped_same_content": core_dk + supp_dk,
        "missing_source_files": len(missing),
        "renamed_collisions": sum(1 for i in items if i["renamed"]),
        "quality_score": quality_score,
        "quality_components": {
            "valid_rate": {"value": round(valid_rate, 4), "weight": W_VALID,
                           "basis": "池内 judge=valid 字数 / 全池字数"},
            "density": {"value": round(density, 4), "weight": W_DENSITY,
                        "basis": f"平均每文件字数 / {DENSITY_BENCHMARK_CHARS} (封顶1.0)"},
            "scarcity": {"value": round(scarcity, 4), "weight": W_SCARCE,
                         "basis": "1 - 公开rss文章文件数占比"},
            "structure": {"value": round(structure, 4), "weight": W_STRUCT,
                          "basis": "结构化 .md 文件数占比"},
        },
        "files": items,
    }
    os.makedirs(args.output, exist_ok=True)
    rp = os.path.join(args.output, "curator_report.json")
    with open(rp, "w", encoding="utf-8") as f:
        json.dump(report, f, ensure_ascii=False, indent=1)

    print(f"[curator] pool={args.pool} files={total_files} "
          f"({by_tier['core']['files']} core + {by_tier['supplement']['files']} supplement) "
          f"size={total_bytes / 2 ** 30:.3f}GB chars={total_chars:,}")
    print(f"[curator] quality_score={quality_score} "
          f"(valid={valid_rate:.4f} density={density:.4f} scarce={scarcity:.4f} struct={structure:.4f})")
    print(f"[curator] report={rp} elapsed={time.time() - t0:.1f}s missing={len(missing)}")


if __name__ == "__main__":
    main()
