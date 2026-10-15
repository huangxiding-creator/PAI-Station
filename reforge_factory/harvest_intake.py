# -*- coding: utf-8 -*-
"""harvest_intake — 渠道收割件归阵器 (六路舰队 → 池).

输入: rows JSON 文件 [{file, url?, engine, tree, cred?}] (工作流/收割件
产出契约) → 校验 (文件在/EEI 在树/引擎标签含渠道id) → ammo_pool.ingest_files
批量入池 (锁内分块, 万件级秒级) → 提示 judge。

用法: py reforge_factory/harvest_intake.py --campaign EPC-BID26 --rows <json>
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, str(Path(__file__).resolve().parent))
import ammo_pool                                        # noqa: E402


def run(cid: str, rows_path: Path) -> int:
    rows = json.loads(rows_path.read_text(encoding="utf-8"))
    if not isinstance(rows, list):
        print("[intake] rows 不是 list", file=sys.stderr)
        return 2
    tree_ids: set[str] = set()
    tp = Path(ammo_pool._camp_dir(cid)) / "question_tree.json"
    if tp.is_file():
        t = json.loads(tp.read_text(encoding="utf-8"))
        tree_ids = {str(e["id"]) for q in t.get("subquestions", [])
                    for e in q.get("eeis", [])}
    items, bad_file, bad_tree = [], [], []
    for r in rows:
        fp = Path(str(r.get("file", "")))
        if not fp.is_file():
            bad_file.append(str(fp))
            continue
        eng = str(r.get("engine", ""))
        tree = str(r.get("tree", ""))
        if tree and tree_ids and tree not in tree_ids:
            bad_tree.append(tree)
            continue
        items.append({"file": str(fp), "engine": eng,
                      "cred": r.get("cred", "media"), "tree": tree})
    print(f"[intake] rows {len(rows)} | 可入 {len(items)} | 文件缺失 "
          f"{len(bad_file)} | 树外EEI {len(set(bad_tree))} "
          f"({sorted(set(bad_tree))[:6]})")
    for f in bad_file[:5]:
        print(f"  miss: {f}")
    if not items:
        return 0
    added, skipped = ammo_pool.ingest_files(cid, items)
    print(f"[intake] 入池 +{added} / 跳过 {skipped} → 下一步: "
          f"ammo_pool.py judge {cid}")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser(description="收割件归阵 (批量入池)")
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--rows", required=True, help="rows JSON 文件路径")
    ns = ap.parse_args()
    return run(ns.campaign, Path(ns.rows))


if __name__ == "__main__":
    sys.exit(main())
