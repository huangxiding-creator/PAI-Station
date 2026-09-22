# -*- coding: utf-8 -*-
"""G4 ACH 对抗场 — 竞争性假设分析 (Heuer/CIA) 的工程化 v0.

原理: 对每个关键判断列 N 个竞争假设, 用证据矩阵做**排除**而非确认 —
得分最低者先排除. 每条证据按 (立场 stance, 信源等级 grade, 独立源数)
计入假设账. 专杀 LLM 调研两大病: 确认偏误 + 幻觉.

判断链 (三铁律): 本地启发式 v0 (免费); Jev 接线后 Noul/Choice/Score
三原语逐位替换 (矛盾判定/假设路由/兼容性评分) — fail-soft.

用法:
  python ach_arena.py <cid>            # 矩阵+排除排序+结论
  python ach_arena.py <cid> --detail   # 逐证据明细
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path
from urllib.parse import urlsplit

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
GRADE_W = {"A": 1.0, "B": 0.7, "C": 0.4}   # Cochrane 分级权重


def load(cid: str) -> tuple[dict, list[dict]]:
    d = POOL_ROOT / cid
    tree = json.loads((d / "question_tree.json").read_text(encoding="utf-8"))
    rows = [json.loads(x) for x in
            (d / "manifest.jsonl").read_text(encoding="utf-8").splitlines()
            if x.strip()]
    return tree, [r for r in rows if r.get("judge") == "valid"]


def stance_to_compat(stance: str) -> dict[str, float]:
    """证据立场 → 对各假设的兼容分 (v0 映射: H1 扩张 / H2 恶化 / H3 分化).
    树超过 3 假设时按序号轮转 (军团参谋升级树后由 Jev Choice 位接管)."""
    if stance == "support":
        return {"H1": 1.0, "H2": -1.0, "H3": 0.3}
    if stance == "against":
        return {"H1": -1.0, "H2": 1.0, "H3": 0.3}
    return {"H1": -0.5, "H2": -0.5, "H3": -0.5}   # contradict=数据矛盾


def run(cid: str, detail: bool) -> int:
    tree, valid = load(cid)
    hyps = {h["id"]: {"text": h["text"], "score": 0.0, "hurt": [],
                      "help": []} for h in tree["hypotheses"]}
    conflicts: list[dict] = []
    # 独立源去重: 同 host 同 EEI 只计一次 (防单站刷量)
    seen: set[tuple] = set()
    for r in valid:
        if not r.get("tree_node"):
            continue
        host = (urlsplit(r.get("url_norm", "")).netloc
                or Path(r["source_path"]).stem)
        kk = (host, r["tree_node"])
        if kk in seen:
            continue
        seen.add(kk)
        w = GRADE_W.get(r.get("grade", "C"), 0.4)
        for hid, c in stance_to_compat(r.get("stance", "support")).items():
            if hid not in hyps:
                continue
            hyps[hid]["score"] += c * w
            label = f"{r['tree_node']}({host[:18]},{r.get('grade', 'C')})"
            (hyps[hid]["hurt"] if c < 0 else hyps[hid]["help"]).append(label)
        if r.get("stance") == "contradict":
            conflicts.append({k: r.get(k) for k in
                              ("tree_node", "source_path", "url_norm")})
    ranked = sorted(hyps.items(), key=lambda x: x[1]["score"])
    print(f"\n╔═ ACH 对抗场 ═ {cid} ═ {tree['topic']}")
    print(f"║ 证据 {len(valid)} 条 (挂树 {len(seen)} 独立源-EEI 对)")
    print(f"║ [排除法排序: 得分最低=最先排除]")
    for hid, h in ranked:
        print(f"║   {hid} {h['score']:>+6.1f}  {h['text'][:40]}")
    best = ranked[-1]
    worst = ranked[0]
    print(f"║")
    print(f"║ 领先假设: {best[0]} — 但先看反驳 (确认偏误拦截):")
    if best[1]["hurt"]:
        for x in best[1]["hurt"][:3]:
            print(f"║   ↳ 反驳证据 {x}")
    else:
        print(f"║   ⚠ 零反证记录 — 当前领先是未经对抗的单边叙事, "
              f"禁止直接采信 (须补 against 证据后重跑)")
    print(f"║ 最先排除: {worst[0]} — 最伤它的证据 (排除依据, 须可溯源):")
    for x in worst[1]["hurt"][:3]:
        print(f"║   ↳ {x}")
    if conflicts:
        print(f"║ ⚠ 数据矛盾 {len(conflicts)} 条 — 全假设降权, 须人工核:")
        for c in conflicts[:3]:
            print(f"║   ↳ {c['tree_node']} {Path(c['source_path']).name}")
    if detail:
        print(f"║ [逐假设证据账]")
        for hid, h in ranked:
            print(f"║   {hid}: 助证 {len(h['help'])} | 反证 {len(h['hurt'])}")
            for x in (h["help"] + h["hurt"])[:6]:
                print(f"║      {x}")
    gap = [h for h in hyps.values() if not h["help"] and not h["hurt"]]
    if gap or len(valid) < 5:
        print(f"║ ⏳ 证据不足以分辨假设 (挂树 <5 条) — 按 coverage 缺口补采后重跑")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="G4 ACH 对抗场")
    ap.add_argument("cid")
    ap.add_argument("--detail", action="store_true")
    return run(ap.parse_args().cid, ap.parse_args().detail)


if __name__ == "__main__":
    sys.exit(main())
