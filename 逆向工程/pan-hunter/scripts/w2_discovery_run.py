# -*- coding: utf-8 -*-
"""W2 发现层五盘实测跑批（2026-10-30 深夜）

语料：analysis/w1_gate_links.json（W1 门猎实收真实链接，零新搜索）。
口径：每盘 ≥5 链（139 存量仅 2 链全跑）；无码链优先，带码链补位（验 verify 舞步）。
铁律：单盘串行链间≥2s / 盘间并发≤4 / 总预算≤150 发（DiscoveryLedger 硬门）/ 零下载零删除。
产出：analysis/w2_discovery_results.jsonl + analysis/w2_discovery_ledger.jsonl。
W3·judge#1 修复（2026-10-30）：结果文件改 **run-id 追加制**——每次跑批先落 run_start 标记行，
逐行携带 run 字段；永不 unlink 旧档（旧代码重跑即毁档，judge 中级问题#1）。
"""
from __future__ import annotations

import json
import random
import sys
import threading
import time
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from discovery import (DISCOVERY, DiscoveryLedger, discover_url,   # noqa: E402
                       strip_pwd, link_gap, BudgetExceeded)

QUOTA = {"baidu": (6, 2), "aliyun": (7, 1), "quark": (4, 2),
         "xunlei": (8, 1), "139": (2, 0)}          # (无码数, 带码补位数)
SEED = 20261031


def pick_links() -> dict[str, list[str]]:
    corpus = json.loads((ROOT / "analysis" / "w1_gate_links.json").read_text(encoding="utf-8"))
    rng = random.Random(SEED)
    out = {}
    for disk, (n_free, n_pwd) in QUOTA.items():
        links = [it["url"] for it in corpus.get(disk, [])]
        links = list(dict.fromkeys(links))                       # 去重保序
        free = [u for u in links if not strip_pwd(u)[1]]
        withpwd = [u for u in links if strip_pwd(u)[1]]
        rng.shuffle(free)
        rng.shuffle(withpwd)
        out[disk] = free[:n_free] + withpwd[:n_pwd]
    return out


def main():
    plan = pick_links()
    ledger = DiscoveryLedger(
        150, str(ROOT / "analysis" / "w2_discovery_ledger.jsonl"))
    results_path = ROOT / "analysis" / "w2_discovery_results.jsonl"
    run_id = time.strftime("%Y%m%d_%H%M%S") + f"{int(time.time()*1000)%1000:03d}"   # judge#1：run-id（含毫秒防同秒撞）
    lock = threading.Lock()
    t0 = time.time()
    with open(results_path, "a", encoding="utf-8") as f:
        f.write(json.dumps({"type": "run_start", "run": run_id,
                            "ts": time.strftime("%Y-%m-%d %H:%M:%S"),
                            "budget": 150, "quota": QUOTA}, ensure_ascii=False) + "\n")

    def _run_disk(disk: str, urls: list[str]):
        rows = []
        for u in urls:
            try:
                r = discover_url(u, ledger=ledger)
            except BudgetExceeded as e:
                print(f"[{disk}] 预算熔断：{str(e)[:80]}")
                break
            except Exception as e:
                from discovery.base import DResult
                r = DResult(url=u, disk=disk, state=f"err:{type(e).__name__}",
                            message=str(e)[:80])
            row = {"run": run_id, "disk": disk, "url": u, "ok": r.ok, "alive": r.alive,
                   "state": r.state, "message": r.message[:120], "title": r.title[:60],
                   "n_entries": len(r.entries), "file_count": r.file_count,
                   "shots": r.shots,
                   "sample": [f"{'D' if e.is_dir else 'F'}:{e.name[:40]}"
                              for e in r.entries[:3]]}
            rows.append(row)
            print(f"[{disk:7s}] {'OK ' if r.ok else '   '} {r.state:12s} "
                  f"entries={len(r.entries):3d} shots={r.shots} {u[:60]}")
            with lock:
                with open(results_path, "a", encoding="utf-8") as f:
                    f.write(json.dumps(row, ensure_ascii=False) + "\n")
            if u is not urls[-1]:
                link_gap()
        return rows

    all_rows = []
    # judge#1 修复：旧档保留（run 字段隔离各轮结果），不再 unlink
    with ThreadPoolExecutor(max_workers=4) as pool:    # 盘间≤4 铁律
        futs = {pool.submit(_run_disk, d, us): d for d, us in plan.items()}
        for f in futs:
            all_rows.extend(f.result())

    print(f"\n== 跑批收官：{ledger.shots} 发（预算 150）· {len(all_rows)} 链 · "
          f"{round(time.time()-t0)}s")


if __name__ == "__main__":
    main()
