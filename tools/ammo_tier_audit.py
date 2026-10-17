#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""弹药池价值分层审计 (1005 用户定调: 有效资料 = 对当前研究报告有帮助的资料).

背景: judge_heuristic 的 valid = 命中课题 19 词之一 (含 EPC总承包/新能源 等
行业泛词) — 是相关性代理, 不是价值标准. 本工具按标题/路径把 manifest 的
valid 行分三层, 给出门槛账的真实成色:

  T1 报告直接  — 研究对象本体资料 (公司名系关键词)
  T2 同业对标  — 同行业可比企业/设计院资料
  T3 行业框架  — 行业通用方法论/政策 (只作框架章参考, 不按同口径计入弹药)
  T0 泛命中    — 标题无任何层词 (内容级命中/语义救回, 成色最低需抽检)

分层词表: 战役目录 tiers.json {"T1": [...], "T2": [...]} (T3=T1∪T2 之外的
课题词). 缺省自动推导: pool_state.kws 中含公司短名的进 T1, 含"设计院/电力"
等的进 T2.

用法:
  python ammo_tier_audit.py EPC49-SEPDC [--t1 词,词] [--t2 词,词] [--top N]
"""
import argparse
import json
import os
import sys
from collections import defaultdict

POOL_ROOT = r"E:\AI-Station\ammo_pool"

# 自动推导用启发 (公司短名从 campaign 名/人工给)
_AUTO_T2 = ("设计院", "电力勘测", "中国电建", "中国能建", "工程局", "中冶",
            "中石化", "首钢")


def load_campaign(cid: str) -> tuple[dict, list[dict]]:
    d = os.path.join(POOL_ROOT, cid)
    state = json.load(open(os.path.join(d, "pool_state.json"), encoding="utf-8"))
    rows = []
    for line in open(os.path.join(d, "manifest.jsonl"), encoding="utf-8"):
        line = line.strip()
        if line:
            try:
                rows.append(json.loads(line))
            except json.JSONDecodeError:
                continue
    return state, rows


def resolve_tiers(cid: str, state: dict, t1_arg: str, t2_arg: str):
    tp = os.path.join(POOL_ROOT, cid, "tiers.json")
    if os.path.isfile(tp) and not (t1_arg or t2_arg):
        cfg = json.load(open(tp, encoding="utf-8"))
        return cfg["T1"], cfg["T2"], "tiers.json"
    if t1_arg and t2_arg:
        t1 = t1_arg.split(",")
        t2 = t2_arg.split(",")
    else:                                    # 自动推导兜底
        kws = state.get("kws") or []
        company = state.get("campaign", "")
        t1 = [k for k in kws if any(z in k for z in ("四川", "本公司"))] or kws[:1]
        t2 = [k for k in kws if k not in t1
              and any(z in k for z in _AUTO_T2)]
    return t1, t2, "auto"


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cid")
    ap.add_argument("--t1", help="逗号分隔 T1 词表 (覆盖 tiers.json)")
    ap.add_argument("--t2", help="逗号分隔 T2 词表")
    ap.add_argument("--top", type=int, default=8)
    a = ap.parse_args()

    state, rows = load_campaign(a.cid)
    t1, t2, src = resolve_tiers(a.cid, state, a.t1, a.t2)
    print(f"[tier-audit] {a.cid} | 词表来源 {src}")
    print(f"  T1({len(t1)}): {t1}")
    print(f"  T2({len(t2)}): {t2}\n")

    tiers = {t: [0, 0] for t in ("T1_报告直接", "T2_同业对标",
                                 "T3_行业框架", "T0_泛命中")}
    by_engine = defaultdict(lambda: defaultdict(lambda: [0, 0]))
    kws = state.get("kws") or []
    n_valid = 0
    for r in rows:
        if r.get("judge") != "valid":
            continue
        n_valid += 1
        title = os.path.basename(r.get("source_path")
                                 or r.get("url_norm") or "")
        ch = r.get("chars") or 0
        if any(k in title for k in t1):
            t = "T1_报告直接"
        elif any(k in title for k in t2):
            t = "T2_同业对标"
        elif any(k in title for k in kws):
            t = "T3_行业框架"
        else:
            t = "T0_泛命中"
        tiers[t][0] += 1
        tiers[t][1] += ch
        by_engine[t][r.get("engine") or "?"][0] += 1
        by_engine[t][r.get("engine") or "?"][1] += ch

    total = sum(v[1] for v in tiers.values())
    print(f"valid 行 {n_valid:,} | 分层总字数 {total:,}")
    for t, (n, ch) in tiers.items():
        pct = 100 * ch / total if total else 0
        print(f"  {t}: {n:>6,} 件 | {ch:>13,} 字 ({pct:.2f}%)")
    for t in ("T1_报告直接", "T2_同业对标"):
        print(f"\n  == {t} 引擎来源 top{a.top} ==")
        for e, (n, ch) in sorted(by_engine[t].items(),
                                 key=lambda kv: -kv[1][1])[:a.top]:
            print(f"    {e}: {n:,} 件 {ch:,} 字")
    print("\n[tier-audit] 注意: 标题级分层是下界 — 内容级命中未展开; "
          "T0/T3 成色需按 抽样→抽取→人工/语义复判 收口")
    return 0


if __name__ == "__main__":
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.exit(main())
