# -*- coding: utf-8 -*-
"""sku_insert — 通用研报 SKU 头插器 (1124 用户令 ②: 编排器依赖件).

安全门 (1124 ZHAOBIAO 被挤掉教训): 插入前后核总数+1 / 前头SKU存活 / 位置校验。
插入位 = KB块之后、首个研报SKU之前 (研报区 newest-first 头部)。
用法: py -X utf8 tools/sku_insert.py --sku X-2026 --title 《书名》 --pages 437 --words-wan 36 \
     --chapters-json work/m2/x/sched/chapters.json [--sample-file x_sample.md] [--price 698]
"""
from __future__ import annotations

import argparse
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
RJ = Path(r"E:\AI-Station\report_platform\content\report.json")


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--sku", required=True)
    ap.add_argument("--title", required=True)
    ap.add_argument("--pages", required=True)
    ap.add_argument("--words-wan", required=True)
    ap.add_argument("--chapters-json", required=True)
    ap.add_argument("--sample-file", required=True)
    ap.add_argument("--sample-label", default="第1章 全章免费试读")
    ap.add_argument("--price", type=int, default=698)
    ap.add_argument("--subtitle-extra", default="")
    ns = ap.parse_args()

    chj = json.loads(Path(ns.chapters_json).read_text(encoding="utf-8"))
    chapters = [{"id": f"ch{x['no']}", "title": f"第{x['no']}章 {x['title']}", "desc": ""}
                for x in chj]
    entry = {
        "sku": ns.sku,
        "title": ns.title,
        "subtitle": (f"12 章 · {ns.words_wan} 万字 · {ns.pages} 页（判例四段式 + 条款范本 + "
                     f"自查台账{ns.subtitle_extra}）"),
        "price": ns.price,
        "price_label": f"¥{ns.price:,}",
        "words_wan": int(ns.words_wan),
        "cat": "topic",
        "cat_name": "专题实战",
        "badges": [
            {"k": "全书字数", "v": f"{ns.words_wan} 万字级（总装实测）"},
            {"k": "章节体量", "v": f"12 章 · {ns.pages} 页 PDF"},
            {"k": "证据纪律", "v": "全量语料定向收割 + 数字逐字对勘零造假 + 截断防御声明"},
            {"k": "覆盖谱系", "v": " / ".join(c["title"].split(" ", 1)[1] for c in chapters[:6])},
            {"k": "实战深度", "v": "判例四段式 + 失效模式目录 + 条款范本 + 合规自查清单"},
        ],
        "sample_file": ns.sample_file,
        "sample_label": ns.sample_label,
        "coming_soon": False,
        "chapters": chapters,
        "listed_at": time.strftime("%Y-%m-%d %H:%M"),
    }
    d = json.loads(RJ.read_text(encoding="utf-8"))
    reports = d["reports"]
    skus = [r.get("sku") for r in reports]
    if ns.sku in skus:
        print("[skip] 已在架")
        return 0
    idx = next((i for i, r in enumerate(reports)
                if not str(r.get("sku", "")).startswith("KB")), 0)
    before, head_before = len(reports), skus[:8]
    reports.insert(idx, entry)
    RJ.write_text(json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8", newline="\n")

    d2 = json.loads(RJ.read_text(encoding="utf-8"))
    skus2 = [r.get("sku") for r in d2["reports"]]
    checks = {
        "总数+1": len(skus2) == before + 1,
        "前头存活": all(s in skus2 for s in head_before),
        "位置正确": skus2.index(ns.sku) == idx,
    }
    print("[安全门]", checks)
    if not all(checks.values()):
        print("[ABORT] 安全门未过 — 检查 report.json!")
        return 1
    print("[ok] 研报区头8位:", skus2[idx:idx + 4])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
