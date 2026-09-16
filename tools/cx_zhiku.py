# -*- coding: utf-8 -*-
"""观点维驱动：04 智库各渠道策展条目入库 + 思想版图报告。

用法：python tools/cx_zhiku.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.entities import EntityStore  # noqa: E402
from paistation.cx.ingest_zhiku import register_zhiku, scan_zhiku  # noqa: E402

ROOT = REPO / "04 智库"
REPORT = REPO / "SELF_PROFILE/cx_观点维_思想版图_20260916.md"


def main() -> int:
    items = scan_zhiku(ROOT)
    print(f"策展条目: {len(items)}")

    store = EntityStore(REPO / "data/cx/entities.db")
    created = register_zhiku(store, items)
    print(f"边新建: {created} | topic 实体现 {store.count('topic')}")

    by_chan: dict[str, list[str]] = {}
    for chan, name in items:
        by_chan.setdefault(chan, []).append(name)
    lines = [
        "# 思想版图（观点维 · 智库各渠道策展清单）",
        "",
        f"> 2026-09-16 · 本人指令：观点维直接用智库各渠道内容 · "
        f"{len(items)} 条策展（收藏/付费/提取=思想取向信号）",
        "",
    ]
    for chan in ("微信读书", "混沌学园", "一堂", "万维钢调研方法论",
                 "洞见研报", "通往AGI之路"):
        lst = by_chan.get(chan, [])
        lines += [f"## {chan}（{len(lst)}）", ""]
        lines += [f"- {n}" for n in lst]
        lines.append("")
    lines += ["## 读法", "",
              "- **主线一 调研方法论**：万维钢总论+微信读书《如何快速了解一个行业》"
              "《怎么做调研》《去现场》——他的内容生产方法论底座",
              "- **主线二 AI 产品**：混沌 AI 思维武器库/任鑫/AGI 之路——AI 自媒体与"
              "总包千问的产品思想源",
              "- **主线三 商业五步法**：一堂需求原点/商业模式/解决方案——总包说业务"
              "设计框架",
              "- **主线四 EPC 专业**：微信读书 EPC×2+洞见智慧水利——主业纵深"]
    REPORT.write_text("\n".join(lines) + "\n", encoding="utf-8")
    print(f"→ {REPORT.name}")
    print("links:", json.dumps(store.link_stats(), ensure_ascii=False))
    store.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
