# -*- coding: utf-8 -*-
"""W1 北极星基线：ebook-treasure 随机 200 本 × 9 活源 → 命中/盘型/绿盘可下率

口径（任务书 §4 + 预算铁律的落法，RUNLOG 备案）：
  200 本书名随机抽（seed=20261031 可复现）；
  搜索预算 ≤400 发 = 每本书轮转打 2 个活源（9 源轮转，每源 ~44-45 本）——
  「全活源」体现在全批覆盖全部 9 源；如需 200×9 全网格(1800 发) 须另批预算。
  单源串行间隔≥2s 随机；全源并发≤4；直连失败代理单发重试（重试亦入台账）。
产出：analysis/NORTH_STAR_BASELINE.md + northstar_hits.jsonl（逐发台账）。
"""
from __future__ import annotations

import json
import random
import sys
import threading
import time
from collections import Counter
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
sys.path.insert(0, str(ROOT / "engine" / "sourcehub"))
sys.stdout.reconfigure(encoding="utf-8")

from searchagg import LIVE_SOURCES, SearchSession, SearchLedger, Hit   # noqa: E402
from adapters import light_of                                        # noqa: E402

N_BOOKS = 200
PER_BOOK_SOURCES = 2
SEED = 20261031
BOOKS_JSON = Path("E:/AI-Station/vendors/ebook-treasure-chest/docs/all-books.json")


def main():
    books_all = json.loads(BOOKS_JSON.read_text(encoding="utf-8"))
    rng = random.Random(SEED)
    books = rng.sample(books_all, N_BOOKS)
    # 轮转配源：book_i -> (S[2i%9], S[2i+1%9])
    plan = [(b["title"], [LIVE_SOURCES[(2 * i) % 9], LIVE_SOURCES[(2 * i + 1) % 9]])
            for i, b in enumerate(books)]

    ledger = SearchLedger(str(ROOT / "analysis" / "northstar_hits.jsonl"))
    results: dict[str, dict] = {}   # title -> {source: [disks]}
    lock = threading.Lock()
    sessions = {s: SearchSession(s, ledger) for s in LIVE_SOURCES}
    t0 = time.time()

    def _worker(src: str):
        for i, (title, srcs) in enumerate(plan):
            if src not in srcs:
                continue
            hits: list[Hit] = sessions[src].search(title)
            with lock:
                rec = results.setdefault(title, {})
                rec[src] = [h.disk for h in hits]
            if len(results) % 25 == 0:
                print(f"  进度 {len(results)}/{N_BOOKS} 本有记录 · {ledger.shots} 发 · "
                      f"{round(time.time()-t0)}s", flush=True)

    with ThreadPoolExecutor(max_workers=4) as pool:   # 全源并发≤4 铁律
        list(pool.map(_worker, LIVE_SOURCES))

    # ---- 统计 ----
    found_books = {t: v for t, v in results.items() if any(v.values())}
    src_hit_counter = Counter()
    disk_counter = Counter()
    green_books = set()
    for t, per_src in found_books.items():
        for src, disks in per_src.items():
            if disks:
                src_hit_counter[src] += 1
        all_disks = [d for ds in per_src.values() for d in ds]
        disk_counter.update(set(all_disks))
        if any(light_of(d) == "绿" for d in all_disks):
            green_books.add(t)
    hit_src_dist = Counter(len([1 for ds in per_src.values() if ds]) for per_src in found_books.values())

    lines = [
        "# NORTH STAR 基线（W1 · 2026-10-31）",
        "",
        "> 数字全实测：逐发台账 analysis/northstar_hits.jsonl；抽书 seed=20261031 可复现。",
        "",
        "## 口径",
        f"- 书源：ebook-treasure-chest all-books.json（{len(books_all)} 本）随机抽 **{N_BOOKS}** 本",
        f"- 搜索：**{PER_BOOK_SOURCES} 源/本书轮转**（9 活源全批覆盖；主射 {N_BOOKS*PER_BOOK_SOURCES} 发"
        f" ≤400 预算；含代理重试共 {ledger.shots} 发入台账）",
        "- 间隔≥2s 随机/源内串行/全源并发≤4；curl_cffi impersonate=chrome124",
        "",
        "## 四数",
        f"1. **找到链接的书数：{len(found_books)}/{N_BOOKS}（{len(found_books)/N_BOOKS:.1%}）**",
        f"2. 命中源数分布（每书，0-2 源口径）：{dict(sorted(hit_src_dist.items()))}",
        f"3. 链接盘型分布（去重/书）：{dict(disk_counter.most_common())}",
        f"4. **绿盘可下率：{len(green_books)}/{N_BOOKS}（{len(green_books)/N_BOOKS:.1%}）**"
        "（书级=至少一条一级绿盘链；实际可下性另由 W1_GREEN_GATES 十盘真件门实证）",
        "",
        "## 源命中排名（书数）",
    ]
    for s, n in src_hit_counter.most_common():
        lines.append(f"- {s}: {n}")
    lines += ["", f"## 搜索账", f"- 主射 {N_BOOKS*PER_BOOK_SOURCES} 发；台账总发 {ledger.shots}（含网络失败代理重试）",
              f"- 耗时 {round(time.time()-t0)}s", ""]
    (ROOT / "analysis" / "NORTH_STAR_BASELINE.md").write_text("\n".join(lines), encoding="utf-8")
    (ROOT / "analysis" / "northstar_summary.json").write_text(json.dumps({
        "n_books": N_BOOKS, "per_book_sources": PER_BOOK_SOURCES, "seed": SEED,
        "found_books": len(found_books), "green_books": len(green_books),
        "src_hits": dict(src_hit_counter), "disk_dist": dict(disk_counter),
        "hit_src_dist": dict(hit_src_dist), "shots": ledger.shots,
    }, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"\n== 北极星收官：找到 {len(found_books)}/{N_BOOKS} · 绿盘 {len(green_books)} · "
          f"{ledger.shots} 发 / {round(time.time()-t0)}s")


if __name__ == "__main__":
    main()
