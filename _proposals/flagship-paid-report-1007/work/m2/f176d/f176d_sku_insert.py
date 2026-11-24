# -*- coding: utf-8 -*-
"""f176d_sku_insert — SYNERGY-2026 头插 report.json (第24份·设计施工协同与利润分配).

位置: KB块(前5条)之后、ZHAOBIAO-2026之前 = 研报区 newest-first 头部。
幂等: 已存在跳过。**安全门(1124教训): 插入前后核总数(97)与前头SKU(ZHAOBIAO/TAX)存活。**
缩进1空格、ensure_ascii=False 与原文件一致。
用法: py -X utf8 f176d_sku_insert.py --pages <PDF页数> [--words-wan 36]
"""
from __future__ import annotations

import argparse
import io
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
RJ = Path(r"E:\AI-Station\report_platform\content\report.json")

CHAPTERS = [
    ("ch1", "第1章 EPC设计施工协同的全景与规则框架"),
    ("ch2", "第2章 EPC模式下的设计管理：从方案到施工图的衔接规则"),
    ("ch3", "第3章 设计优化与价值工程：收益归属的法律框架"),
    ("ch4", "第4章 设计变更与施工变更的界分与联动规则"),
    ("ch5", "第5章 利润分配的合同条款设计：激励模式与风险共担"),
    ("ch6", "第6章 设计施工界面争议与判例：接口管理的失效模式"),
    ("ch7", "第7章 联合体模式下的设计施工协同：责任划分与追偿"),
    ("ch8", "第8章 设计施工协同的信息化管控与证据留痕"),
    ("ch9", "第9章 施工图审查与设计质量管控的合规要求"),
    ("ch10", "第10章 设计优化收益的量化评估与分配机制"),
    ("ch11", "第11章 设计施工协同的税务处理与合规要点"),
    ("ch12", "第12章 企业协同能力建设与合规自查清单"),
]

SKU = {
    "sku": "SYNERGY-2026",
    "title": "《EPC设计施工协同与利润分配实战研究报告》",
    "subtitle": ("12 章 · {words} 万字 · {pages} 页（设计管理衔接/优化收益归属/变更界分联动/"
                 "利润分配条款/界面失效模式/联合体追偿/税务合规 + 判例四段式 + 协同自查台账）"),
    "price": 698,
    "price_label": "¥698",
    "words_wan": 36,
    "cat": "topic",
    "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "{words} 万字级（总装实测）"},
        {"k": "章节体量", "v": "12 章 · {pages} 页 PDF"},
        {"k": "证据纪律", "v": "跨池判例切片定向收割 + 数字逐字对勘零造假 + 截断防御声明"},
        {"k": "覆盖谱系", "v": "规则全景/设计管理/优化归属/变更界分/利润分配/界面失效/联合体追偿/信息化留痕/审图合规/量化分配/税务处理/协同清单"},
        {"k": "实战深度", "v": "判例四段式 + 失效模式目录表 + 条款范本 + 八项书写要点 + 协同自查台账"},
    ],
    "sample_file": "synergy_sample.md",
    "sample_label": "第1章 规则框架全章免费试读",
    "coming_soon": False,
    "chapters": [{"id": cid, "title": t, "desc": ""} for cid, t in CHAPTERS],
    "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--pages", required=True)
    ap.add_argument("--words-wan", default="36")
    ns = ap.parse_args()

    d = json.loads(RJ.read_text(encoding="utf-8"))
    reports = d["reports"]
    skus = [r.get("sku") for r in reports]
    if "SYNERGY-2026" in skus:
        print("[skip] SYNERGY-2026 已在架")
        return 0

    entry = json.loads(json.dumps(SKU, ensure_ascii=False))  # deep copy
    for b in entry["badges"]:
        b["v"] = b["v"].replace("{pages}", ns.pages).replace("{words}", ns.words_wan)
    entry["subtitle"] = entry["subtitle"].replace("{pages}", ns.pages).replace("{words}", ns.words_wan)
    entry["words_wan"] = int(ns.words_wan)

    # 插入位 = TAX-2026 之前 = KB块后研报区头部 (ZHAOBIAO在TAX前, SYNERGY更新应在其前)
    idx = next(i for i, r in enumerate(reports) if r.get("sku") == "ZHAOBIAO-2026")
    before = len(reports)
    head_before = skus[:7]
    reports.insert(idx, entry)

    RJ.write_text(json.dumps(d, ensure_ascii=False, indent=1), encoding="utf-8", newline="\n")

    # 安全门: 重读核验
    d2 = json.loads(RJ.read_text(encoding="utf-8"))
    skus2 = [r.get("sku") for r in d2["reports"]]
    ok_count = len(skus2) == before + 1
    ok_head = all(s in skus2 for s in head_before)
    ok_pos = skus2.index("SYNERGY-2026") == idx
    print(f"[insert] {before}→{len(skus2)} 条; 头7位存活={ok_head}; 位置{skus2.index('SYNERGY-2026')}(期望{idx})={ok_pos}; 总数+1={ok_count}")
    if not (ok_count and ok_head and ok_pos):
        print("[ABORT] 安全门未过 — 检查 report.json!")
        return 1
    print("[ok] 头8位:", skus2[:8])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
