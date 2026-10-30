# -*- coding: utf-8 -*-
"""W2 · judge#1 修复件：北极星 jsonl 盘型离线重算（2026-10-30 深夜）

事实前提（如实）：analysis/northstar_hits.jsonl 的 W1 原始行只含
{source,kw,path,status,hits,elapsed,ts[,error]}——**无盘型字段、无 URL**（W1 跑批把
disk 留在内存，仅汇入 northstar_summary.json；病根=judge#1）。因此：
  A. 从原始行**可算**：逐源发数/成功发/错误发/命中总数/命中面（有 hits>0 的书次）
  B. 从原始行**不可算**：盘级分布——权威值=northstar_summary.json.disk_dist（内存态），
     本件照录并标注口径，不做任何改写/推断
  C. W2 起 searchagg 记账行已带 disks 字段+命中 URL 归档位（root-cause 修复），
     本件附验算器供后续 jsonl 直接重算
产出：analysis/NORTH_STAR_DISK_RECOUNT.md
"""
from __future__ import annotations

import json
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
JSONL = ROOT / "analysis" / "northstar_hits.jsonl"
SUMMARY = ROOT / "analysis" / "northstar_summary.json"
OUT = ROOT / "analysis" / "NORTH_STAR_DISK_RECOUNT.md"

rows = [json.loads(l) for l in JSONL.read_text(encoding="utf-8").splitlines() if l.strip()]
summary = json.loads(SUMMARY.read_text(encoding="utf-8"))

shots = len(rows)
err_rows = [r for r in rows if r.get("error")]
ok_rows = [r for r in rows if not r.get("error")]
by_source = Counter(r["source"] for r in rows)
hits_by_source = {s: sum(r.get("hits", 0) for r in rows if r["source"] == s)
                  for s in by_source}
total_hits = sum(hits_by_source.values())
kw_with_hits = sum(1 for r in ok_rows if r.get("hits", 0) > 0)

# ---- 口径校验 ----
checks = {
    "行数 == summary.shots": (shots == summary["shots"]),
    "错误行 156 == 548-392（BASELINE 口径对账）": (len(err_rows) == 156),
    "W1 行不含 disks 字段（病根实证）": all("disks" not in r for r in rows),
}

lines = [
    "# NORTH STAR 盘型重算件（W2 · judge#1 修复 · 2026-10-30 深夜）",
    "",
    "> **口径声明（数字零造假）**：本件从 northstar_hits.jsonl 原始行离线重算**能算的部分**；",
    "> 盘级分布无法从原始行重算（行内无盘型/URL），照录 northstar_summary.json 的内存态权威值并标注。",
    "",
    "## 一、从原始行可算（全部重算实测）",
    "",
    f"- 台账总行数：**{shots}**（成功 {len(ok_rows)} + 错误重试 {len(err_rows)}）",
    f"- 命中总数（逐发 hits 求和，**未去重未分盘**）：{total_hits}",
    f"- 有命中发数（hits>0 的成功发）：{kw_with_hits}",
    "",
    "| 源 | 发数 | 其中错误发 | 命中总数(hits 和) |",
    "|---|---|---|---|",
]
for s in sorted(by_source, key=lambda x: -hits_by_source[x]):
    errs = sum(1 for r in err_rows if r["source"] == s)
    lines.append(f"| {s} | {by_source[s]} | {errs} | {hits_by_source[s]} |")
lines += [
    "",
    "## 二、盘级分布（不可从原始行重算——照录权威值+口径）",
    "",
    "| 盘 | 书数（去重/书口径） | 来源 |",
    "|---|---|---|",
]
for d, n in summary["disk_dist"].items():
    lines.append(f"| {d} | {n} | northstar_summary.json（W1 内存态，非重算） |")
lines += [
    "",
    "**为何不可重算**：w1_northstar.py L52-57 只把 `[h.disk for h in hits]` 留在内存，",
    "URL 与盘型均未落盘；jsonl 行的 `hits` 字段=该发命中数（不分盘）。",
    "两口径本就不同（发级计数 vs 书级去重盘集合），不可互相换算。",
    "",
    "## 三、病根修复（W2 生效）",
    "",
    "1. `searchagg.py` 记账行新增 **disks** 字段（该发命中的盘型列表）——judge#1 修复；",
    "2. `SearchLedger(hits_path=...)` 新增**命中 URL 归档位**（每命中一行 url/disk/light/source/kw）",
    "   ——URL 永不再只留内存，后续北极星复跑可直接离线重算盘型分布；",
    "3. 本件校验器：W1 行零 disks 字段=" + ("属实" if checks["W1 行不含 disks 字段（病根实证）"] else "异常"),
    "",
    "## 四、一致性校验",
    "",
]
for k, v in checks.items():
    lines.append(f"- {k}：{'PASS' if v else 'FAIL'}")
lines += [
    "",
    "## 五、结论",
    "",
    "- 原始行可算面（发数/命中总数/逐源账）已全量重算如上；",
    "- 盘级分布维持 W1 内存态权威值（quark138/xunlei68/baidu45/aliyun34/uc15/139:2/189:1/123:1）；",
    "- 若需「原始行级盘型可重算」的正式复测，须另批搜索预算重跑北极星（W2 未动用搜索预算，遵循「别再搜索」令）。",
    "",
]
OUT.write_text("\n".join(lines), encoding="utf-8")
print(f"written {OUT}  (rows={shots}, hits_sum={total_hits}, checks="
      f"{all(checks.values())})")
