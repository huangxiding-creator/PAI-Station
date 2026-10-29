# -*- coding: utf-8 -*-
"""attach_extras — gap_supply 采回件的计划外追加挂树.

gap_supply 计划表每任务钦定 1..5 EEI, 但 ammo_pool ingest CLI 单 --tree
一次挂一个 → 本件按 supply_log.jsonl 的 ok 行, 把 eei 列表其余槽位追加为
同行副本 (EPC50-SNEI 行=文件×问题对先例; dedup_key 同键不虚账)。

只追加分 (幂等: 同 file×eei 已存在则跳过); judge 后跑 (valid 才追加)。
用法: py -X utf8 attach_extras.py [supply_log_path]
"""
from __future__ import annotations

import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
POOL = Path(r"E:\AI-Station\ammo_pool\EPC-TOP50")


def main() -> int:
    logs = sorted((POOL / "staging" / "gap_supply").glob("*/supply_log.jsonl"))
    # r4 直抓腿日志同构并入 (file/eeis/ok 字段一致)
    df = POOL / "staging" / "direct_fetch" / "fetch_log.jsonl"
    if df.is_file():
        logs.append(df)
    if not logs:
        print("[attach-extras] 无 supply_log", file=sys.stderr)
        return 2
    log_path = Path(sys.argv[1]) if len(sys.argv) > 1 else None
    tasks = []
    for lg in ([log_path] if log_path else logs):
        tasks += [json.loads(x) for x in
                  lg.read_text(encoding="utf-8").splitlines() if x.strip()]
    mp = POOL / "manifest.jsonl"
    rows = [json.loads(x) for x in
            mp.read_text(encoding="utf-8").splitlines() if x.strip()]
    by_file_eei = {(r.get("source_path"), r.get("tree_node")) for r in rows}

    added = 0
    for t in tasks:
        if not t.get("ok") or not t.get("file") or len(t.get("eeis", [])) < 2:
            continue
        base = next((r for r in rows
                     if r.get("source_path") == t["file"]
                     and r.get("judge") == "valid"), None)
        if not base:
            print(f"  [skip] {Path(t['file']).name[:40]} 非valid/未判")
            continue
        for eid in t["eeis"][1:]:
            key = (t["file"], eid)
            if key in by_file_eei:
                continue
            nr = dict(base)
            nr["tree_node"] = eid
            nr["stance"] = "against" if eid.endswith("-E2") else "support"
            rows.append(nr)
            by_file_eei.add(key)
            added += 1
    if added:
        tmp = mp.with_suffix(".jsonl.tmp")
        tmp.write_text(
            "".join(json.dumps(r, ensure_ascii=False) + "\n" for r in rows),
            encoding="utf-8")
        tmp.replace(mp)
    print(f"[attach-extras] 追加 {added} 行 "
          f"(源 {log_path.name if log_path else 'all-logs'}, "
          f"现 manifest {len(rows)} 行)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
