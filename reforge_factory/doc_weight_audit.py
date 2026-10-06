# -*- coding: utf-8 -*-
"""W1-1 当量去重审计器 — 断言链引擎证据合同件 (1006 用户批 ①).

盘上诊断 (EPC50-SNEI 实读): pool_state.total_chars=193,801,218 行级合计,
文档级去重真值 12,937,514 —— **15.0x 通胀**. 根因: 同一文档按树节点切片
入库 (dedup_key 带 #节点 后缀), 行级 chars=整档字数被逐节点重复计入.
弹药门 T1+T2≥3000万 在虚胖分母上判定, EPC50 文档级实际未过门.

本件 = 诚实度量衡 (纯审计, 只增不删):
  - 文档级当量: dedup_key 剥 #后缀 → 文档基键, 字数取 max (文档真实大小)
  - 通胀倍数: 行级合计 / 文档级合计 (健康池应 ≈1.0x)
  - 渠道集中度: 文档数与字数按 engine 分布, 单渠道占比告警 (>60% WARN)
  - 节点独立度: 每 tree_node 的独立文档数/独立渠道数; 单文档节点清单
    (对齐循证双独立源规则: 独立性按文档+渠道双键, 不按行数)
  - sidecar: <pool>/<cid>/doc_weight.json 落盘, 原 manifest/pool_state 零改动

用法:
  python doc_weight_audit.py <cid> [--pool-root E:\\AI-Station\\ammo_pool]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

CONCENTRATION_WARN_PCT = 60.0     # 单渠道文档占比告警线
NODE_SUFFIX = re.compile(r"#[^#]*$")   # dedup_key 尾部 #T001Q02 节点后缀


def doc_base(dedup_key: str) -> str:
    """dedup_key → 文档基键 (剥 #节点 后缀; 无后缀原样返回)."""
    return NODE_SUFFIX.sub("", dedup_key or "").strip().lower()


def audit_rows(rows: list[dict]) -> dict:
    """行级→文档级对账 (纯函数, 不改入参).

    只吃 judge==valid 行 (与 tier_report 同口径); 返回新对象。
    """
    valid = [r for r in rows if r.get("judge") == "valid"]
    row_chars = sum(int(r.get("chars") or 0) for r in valid)

    doc_chars: dict[str, int] = {}
    doc_engine: dict[str, set] = {}
    engine_docs: dict[str, set] = {}
    for r in valid:
        base = doc_base(str(r.get("dedup_key") or r.get("source_path") or ""))
        c = int(r.get("chars") or 0)
        if c > doc_chars.get(base, 0):
            doc_chars[base] = c
        eng = str(r.get("engine") or "?")
        doc_engine.setdefault(base, set()).add(eng)
        engine_docs.setdefault(eng, set()).add(base)
    doc_total = sum(doc_chars.values())
    n_docs = len(doc_chars)

    eng_share = {e: {"docs": len(ds), "doc_pct": round(len(ds) * 100.0 / n_docs, 2),
                     "chars_top_engine_only": None}
                 for e, ds in engine_docs.items()}
    top_engine, top_docs = max(engine_docs.items(),
                               key=lambda kv: len(kv[1])) if engine_docs else ("", set())

    node_docs: dict[str, set] = {}
    node_engs: dict[str, set] = {}
    for r in valid:
        node = str(r.get("tree_node") or "")
        if not node:
            continue
        base = doc_base(str(r.get("dedup_key") or r.get("source_path") or ""))
        node_docs.setdefault(node, set()).add(base)
        node_engs.setdefault(node, set()).add(str(r.get("engine") or "?"))
    single_doc_nodes = sorted(n for n, ds in node_docs.items() if len(ds) == 1)
    single_engine_nodes = sorted(n for n, es in node_engs.items()
                                 if len(es) == 1)

    inflation = round(row_chars / doc_total, 2) if doc_total else 0.0
    return {
        "rows_valid": len(valid),
        "rows_total": len(rows),
        "row_chars": row_chars,
        "doc_count": n_docs,
        "doc_chars": doc_total,
        "inflation_x": inflation,
        "doc_mean_chars": round(doc_total / n_docs) if n_docs else 0,
        "engine_doc_counts": {e: len(ds) for e, ds in
                              sorted(engine_docs.items(), key=lambda kv: -len(kv[1]))},
        "top_engine": {"engine": top_engine,
                        "doc_pct": round(len(top_docs) * 100.0 / n_docs, 2)
                        if n_docs else 0.0},
        "node_count": len(node_docs),
        "single_doc_nodes": single_doc_nodes,
        "single_doc_node_pct": round(len(single_doc_nodes) * 100.0
                                     / len(node_docs), 2) if node_docs else 0.0,
        "single_engine_nodes_n": len(single_engine_nodes),
        "_eng_share": eng_share,
    }


def audit_campaign(cid: str, pool_root: Path = POOL_ROOT) -> dict:
    """读 manifest (+question_tree 若在) → 审计 → sidecar 落盘."""
    d = pool_root / cid
    rows = [json.loads(x) for x in (d / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines() if x.strip()]
    res = audit_rows(rows)
    tree_p = d / "question_tree.json"
    tree_n = 0
    if tree_p.is_file():
        tree = json.loads(tree_p.read_text(encoding="utf-8"))
        tree_n = sum(len(q.get("eeis", []))
                     for q in tree.get("subquestions", []))
    res["tree_eei_total"] = tree_n
    res["zero_doc_eei"] = max(tree_n - res["node_count"], 0)
    top = res["top_engine"]
    res["warnings"] = []
    if top["doc_pct"] > CONCENTRATION_WARN_PCT:
        res["warnings"].append(
            f"渠道集中度: {top['engine']} 占 {top['doc_pct']}% 文档 "
            f"(>{CONCENTRATION_WARN_PCT:.0f}% 告警, 独立性存疑)")
    if res["inflation_x"] > 2.0:
        res["warnings"].append(
            f"字数通胀 {res['inflation_x']}x (>2x): 行级当量不可作门, "
            f"弹药门应按 doc_chars={res['doc_chars']:,} 判")
    res["cid"] = cid
    res["generated"] = time.strftime("%Y-%m-%d %H:%M")
    res["engine_version"] = "doc-weight-v1 (W1-1 断言链引擎)"
    res.pop("_eng_share", None)
    out = d / "doc_weight.json"
    out.write_text(json.dumps(res, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    return res


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="弹药池文档级当量去重审计")
    ap.add_argument("cid")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ns = ap.parse_args(argv)
    r = audit_campaign(ns.cid, Path(ns.pool_root))
    print(f"[dw] {ns.cid}: 行级 {r['row_chars']:,} vs 文档级 "
          f"{r['doc_chars']:,} ({r['doc_count']} docs) = "
          f"{r['inflation_x']}x 通胀")
    print(f"[dw] 节点 {r['node_count']}/{r['tree_eei_total']} EEI 有据 | "
          f"单文档节点 {len(r['single_doc_nodes'])} ({r['single_doc_node_pct']}%) | "
          f"零据 EEI {r['zero_doc_eei']}")
    print(f"[dw] 渠道文档占比 Top: {r['top_engine']}")
    for w in r["warnings"]:
        print(f"[dw] ⚠ {w}")
    print(f"[dw] sidecar: {Path(ns.pool_root) / ns.cid / 'doc_weight.json'}")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
