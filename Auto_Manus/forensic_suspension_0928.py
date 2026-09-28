# -*- coding: utf-8 -*-
"""封号根因取证 — 只读本地账本, 零平台访问.

数据源: data/epc50_corps_log.jsonl (append-only 派发账本, 唯一真源)
输出: 每日派发量/动用账号数/单号压力/封号窗前行为画像
"""
import collections
import io
import json
import sys
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")
ROOT = Path(__file__).parent

rows = []
for ln in (ROOT / "data" / "epc50_corps_log.jsonl").read_text(
        encoding="utf-8").splitlines():
    ln = ln.strip()
    if not ln:
        continue
    try:
        rows.append(json.loads(ln))
    except Exception:
        pass

emails = set(r["email"] for r in rows)
print(f"账本总派发: {len(rows)} 单 | 动用账号: {len(emails)} 个 | "
      f"跨度: {rows[0]['ts'][:10]} → {rows[-1]['ts'][:16]}")

day = collections.Counter(r["ts"][:10] for r in rows)
acc = collections.defaultdict(set)
for r in rows:
    acc[r["ts"][:10]].add(r["email"])
print("\n== 每日派发量 / 动用账号数 (行为画像: 平台看到了什么) ==")
for d in sorted(day):
    print(f"  {d}: {day[d]:4d} 单 / {len(acc[d]):3d} 号")

ed = collections.Counter((r["ts"][:10], r["email"]) for r in rows)
mx = max(ed.values()) if ed else 0
worst = [f"{e}@{d}:{v}" for (d, e), v in ed.items() if v == mx][:3]
tot = collections.Counter(r["email"] for r in rows)
print(f"\n== 单号压力 == 单号单日峰值: {mx} 单 {worst}")
print("累计派发 Top10:", tot.most_common(10))

print("\n== 0927 12:00 → 封号窗 逐小时派发 (最后活动时间线) ==")
hr = collections.Counter(r["ts"][:13] for r in rows
                         if r["ts"] >= "2026-09-27T12")
for h in sorted(hr):
    print(f"  {h}: {'█' * min(hr[h], 40)} {hr[h]}")

uc = collections.Counter(r.get("use", "?") for r in rows)
print("\n用途分布:", dict(uc))
dom = collections.Counter(e.split("@")[-1] for e in emails)
print("账号邮箱域分布:", dict(dom))
