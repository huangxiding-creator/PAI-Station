# -*- coding: utf-8 -*-
"""independence_audit — 独立性三键审计器 (断言链 W2-2, 证据合同件).

盘上诊断 (PROPOSAL.md §一 缺口⑤): EPC50 ima 占 93.89% 文档 / EPC49 wenshu
占 92.26% —— 「独立源」若按行数算是假独立. 本件按 **三键连通分量** 重算:

  独立性三键 = 域名 host + 渠道 engine + 文档 doc (dedup_key 剥 #节点后缀)
  规则: 任意一键同键 = 非独立 (PROPOSAL.md 合同2) → 同 EEI 内共享任一键的
  证据行并成一个连通分量, 分量数 = 该 EEI 的独立源数.

  - host: url_norm 真实域名 (grade_rules.host_of; 占位 URL 回退 source_path
    stem — 单文件聚合站各文件算各站);
  - engine: 渠道垄断是独立性的隐形杀手 (ima 同渠道 800 文档 ≠ 800 独立源);
  - doc: 文档为原子 (W1-1 同款 doc_base).

产出 (只增不删, sidecar 落盘原账零改动):
  <pool>/<cid>/independence.json — 逐 EEI {docs/engines/hosts/independent_n/
  single_source} + 全池单源清单 + 零据 EEI (读问题树, v2 优先 v1 兜底).

用法:
  python independence_audit.py <cid> [--pool-root E:\\AI-Station\\ammo_pool]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from doc_weight_audit import doc_base          # noqa: E402  (W1-1 同源)
from grade_rules import host_of                # noqa: E402  (W1-2 同源)

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
SINGLE_SOURCE_WARN_PCT = 20.0     # 单源 EEI 占比告警线 (有据 EEI 中)


def _host_of_row(row: dict) -> str:
    """行级 host: 真实域名优先, 占位 URL 回退 source_path stem."""
    h = host_of(str(row.get("url_norm") or ""))
    if h:
        return h
    sp = str(row.get("source_path") or "")
    return Path(sp).stem if sp else ""


def cluster_count(keys: list[tuple[str, str, str]]) -> int:
    """三键连通分量数 (纯函数): 共享任一非空键的行并为一簇.

    keys = [(host, engine, doc), ...]; 并查集路径压缩, 不改入参.
    """
    n = len(keys)
    parent = list(range(n))

    def find(i: int) -> int:
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    by_key: dict[str, int] = {}
    for i, (h, e, d) in enumerate(keys):
        for k in (h, e, d):
            if not k:
                continue
            if k in by_key:
                ri, rk = find(i), find(by_key[k])
                if ri != rk:
                    parent[max(ri, rk)] = min(ri, rk)
            else:
                by_key[k] = i
    return len({find(i) for i in range(n)}) if n else 0


def audit_rows(rows: list[dict]) -> dict:
    """逐 EEI 三键审计 (纯函数, 不改入参; 只吃 judge==valid 且带 tree_node)."""
    valid = [r for r in rows
             if r.get("judge") == "valid" and r.get("tree_node")]
    per: dict[str, dict] = {}
    for r in valid:
        node = str(r["tree_node"])
        host, eng = _host_of_row(r), str(r.get("engine") or "?")
        doc = doc_base(str(r.get("dedup_key") or r.get("source_path") or ""))
        p = per.setdefault(node, {"keys": [], "docs": set(), "engines": set(),
                                  "hosts": set()})
        p["keys"].append((host, eng, doc))
        p["docs"].add(doc)
        p["engines"].add(eng)
        if host:
            p["hosts"].add(host)
    out = {}
    single: list[str] = []
    for node, p in sorted(per.items()):
        n_ind = cluster_count(p["keys"])
        out[node] = {"docs": len(p["docs"]), "engines": sorted(p["engines"]),
                     "hosts": sorted(p["hosts"]), "independent_n": n_ind,
                     "single_source": n_ind <= 1}
        if n_ind <= 1:
            single.append(node)
    return {"per_eei": out, "single_source_eeis": single,
            "with_evidence": len(out)}


def _tree_eei_ids(pool_dir: Path) -> list[str]:
    """问题树 EEI 全集 (question_tree_v2 优先, v1 兜底; 无树返空表)."""
    for name in ("question_tree_v2.json", "question_tree.json"):
        p = pool_dir / name
        if p.is_file():
            tree = json.loads(p.read_text(encoding="utf-8"))
            return [e["id"] for q in tree.get("subquestions", [])
                    for e in q.get("eeis", [])]
    return []


def audit_campaign(cid: str, pool_root: Path = POOL_ROOT) -> dict:
    """读 manifest (+树) → 三键审计 → sidecar 落盘 (independence.json)."""
    d = pool_root / cid
    rows = [json.loads(x) for x in (d / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines() if x.strip()]
    res = audit_rows(rows)
    tree_ids = _tree_eei_ids(d)
    zero = sorted(set(tree_ids) - set(res["per_eei"]))
    res["tree_eei_total"] = len(tree_ids)
    res["zero_evidence_eeis"] = zero
    res["tree_source"] = ("v2" if (d / "question_tree_v2.json").is_file()
                          else ("v1" if (d / "question_tree.json").is_file()
                                else "none"))
    n_we = res["with_evidence"]
    pct = round(len(res["single_source_eeis"]) * 100.0 / n_we, 2) if n_we else 0.0
    res["single_source_pct"] = pct
    res["warnings"] = []
    if n_we and pct > SINGLE_SOURCE_WARN_PCT:
        res["warnings"].append(
            f"单源 EEI 占比 {pct}% (>{SINGLE_SOURCE_WARN_PCT:.0f}% 告警): "
            f"{len(res['single_source_eeis'])}/{n_we} 个有据 EEI 仅 1 个独立源 "
            f"— 按合同2 须补独立源或终稿带「单一来源」标注")
    res["cid"] = cid
    res["generated"] = time.strftime("%Y-%m-%d %H:%M")
    res["engine_version"] = "independence-v1 (W2-2 断言链引擎)"
    (d / "independence.json").write_text(
        json.dumps(res, ensure_ascii=False, indent=1), encoding="utf-8")
    return res


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="独立性三键 (host+engine+doc) 审计")
    ap.add_argument("cid")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ns = ap.parse_args(argv)
    r = audit_campaign(ns.cid, Path(ns.pool_root))
    print(f"[ind] {ns.cid}: 有据 EEI {r['with_evidence']}/"
          f"{r['tree_eei_total']} (树 {r['tree_source']}) | "
          f"单源 {len(r['single_source_eeis'])} ({r['single_source_pct']}%) | "
          f"零据 {len(r['zero_evidence_eeis'])}")
    top = sorted(r["per_eei"].items(),
                 key=lambda kv: (-kv[1]["independent_n"], kv[0]))[:3]
    for node, p in top:
        print(f"[ind]   {node}: 独立源 {p['independent_n']} "
              f"(docs {p['docs']}/engines {len(p['engines'])}/"
              f"hosts {len(p['hosts'])})")
    for w in r["warnings"]:
        print(f"[ind] ⚠ {w}")
    print(f"[ind] sidecar: {Path(ns.pool_root) / ns.cid / 'independence.json'}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
