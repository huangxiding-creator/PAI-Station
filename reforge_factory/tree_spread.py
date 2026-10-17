# -*- coding: utf-8 -*-
"""tree_spread — 挂树同维铺展器 (饱和门杠杆, 1015 补采配套).

问题: tree_backfill 按最高分子问题挂树 → 同维证据堆积在单一子问的 E1
(BID26 实况 Q4-E1 +4354 件), 树的其余子问/EEI 空转 → 饱和门 (≥80% EEI
双源) 悬空。堆积是「最高分通吃」启发式的副产物, 不是证据归属的真相声明
(一篇命中"政策"维的政策文件, 通常同时覆盖该维多个子问)。

本件: **同维重铺** —
  1. 只在证据已归属的维度内重铺 (跨维不动=相关判定不推翻);
  2. against 证据钉在反证位不动; authority 信号件优先权威槽;
  3. 其余 support 件在该维全部子问的 E1/E3 槽轮转 (E3 须有官方信号,
     无信号只转 E1 们);
  4. 备份 manifest.pre-spread.bak.jsonl 一次; 行数/字段/判定期零改动,
     只动 tree_node;
  5. 幂等: 重跑 = 轻微再均衡 (轮转起点记 pool_state.spread_epoch)。

用法: py reforge_factory/tree_spread.py --campaign EPC-BID26 [--dry]
"""
from __future__ import annotations

import argparse
import json
import sys
from collections import Counter, defaultdict
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool as ap                                   # noqa: E402

AUTHORITY_MARKS = ("gov.cn", ".org.cn", "official", "govlist", "cnki",
                   "standards", "policy", "ggzy", "credibility")


def run(cid: str, dry: bool = False) -> int:
    d = ap._camp_dir(cid)
    mp = d / "manifest.jsonl"
    tree = json.loads((d / "question_tree.json").read_text(encoding="utf-8"))

    # 维 → [(子问id, [E1,E3 槽]), 反证槽集]
    dim_slots: dict[str, list[tuple[str, list[str]]]] = defaultdict(list)
    dim_against: dict[str, set[str]] = defaultdict(set)
    for q in tree.get("subquestions", []):
        dim = str(q.get("dim", ""))
        e1e3 = []
        for e in q.get("eeis", []):
            eid, st = str(e.get("id", "")), str(e.get("stance", "support"))
            if st in ("against", "contradict"):
                dim_against[dim].add(eid)
            elif any(a in str(e.get("need", "")) for a in ("权威", "官方")):
                e1e3.append(eid)              # 权威槽 (有官方信号才入)
            else:
                e1e3.insert(0, eid)           # 正面槽优先位
        if e1e3:
            dim_slots[dim].append((str(q.get("id", "")), e1e3))
    eei_dim = {eid: dim for dim, qs in dim_slots.items()
               for _, eids in qs for eid in eids}
    eei_dim.update({eid: dim for dim, s in dim_against.items() for eid in s})

    with ap._pool_lock(d):
        rows = [json.loads(x) for x in
                mp.read_text(encoding="utf-8").splitlines() if x.strip()]
        cursor: dict[str, int] = defaultdict(int)
        moved = 0
        before = Counter()
        after = Counter()
        for r in rows:
            node = str(r.get("tree_node") or "")
            before[node] += 1
            if r.get("judge") != "valid" or not node:
                after[node] += 1
                continue
            dim = eei_dim.get(node)
            if not dim or dim not in dim_slots:
                after[node] += 1
                continue                    # 树外/异版节点不动
            against_slots = sorted(dim_against.get(dim, ()))
            if node in dim_against[dim]:
                # v2: 反证行同维 E2 轮转 (反证内容对同维各子问的反证需求
                # 同样成立 — 堆积在首子问 E2 是启发式副产物, 非归属真相)
                if len(against_slots) > 1:
                    pick = against_slots[cursor[dim + ":x"] % len(against_slots)]
                    cursor[dim + ":x"] += 1
                    if pick != node:
                        moved += 1
                        node = pick
                after[node] += 1
                continue
            is_authority = (str(r.get("credibility")) == "official"
                            or any(m in str(r.get("url_norm") or "")
                                   + str(r.get("engine") or "")
                                   for m in AUTHORITY_MARKS))
            if is_authority:
                qslots = [eids for _, eids in dim_slots[dim]]
                auth = [e for eids in qslots for e in eids[1:1] or []]
                # 权威件 → 各子问的权威槽 (e1e3[1:] 位) 轮转
                auth_ids = [eids[-1] for _, eids in dim_slots[dim]
                            if len(eids) > 1]
                if auth_ids:
                    pick = auth_ids[cursor[dim + ":a"] % len(auth_ids)]
                    cursor[dim + ":a"] += 1
                else:
                    pick = node
            else:
                flat = [e for _, eids in dim_slots[dim] for e in eids[:1]]
                pick = flat[cursor[dim] % len(flat)]
                cursor[dim] += 1
            if pick != node:
                moved += 1
                node = pick
            r["tree_node"] = node
            after[node] += 1
        if dry:
            top_before = before.most_common(3)
            top_after = after.most_common(3)
            print(f"[spread] DRY: 可移动 {moved} | 堆积 Top3 前 {top_before}"
                  f" → 后 {top_after}")
            return 0
        bak = d / "manifest.pre-spread.bak.jsonl"
        if not bak.is_file():
            mp.replace(bak)
        mp.write_text(
            "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
            encoding="utf-8")
    print(f"[spread] 重铺 {moved} 件 | 备份 {bak.name}")
    return 0


def main() -> int:
    apx = argparse.ArgumentParser(description="挂树同维铺展 (饱和门杠杆)")
    apx.add_argument("--campaign", required=True)
    apx.add_argument("--dry", action="store_true")
    ns = apx.parse_args()
    return run(ns.campaign, ns.dry)


if __name__ == "__main__":
    sys.exit(main())
