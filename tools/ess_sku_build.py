# -*- coding: utf-8 -*-
"""ess_sku_build — 第14份 ESS-2026 上架内容构建 (report.json头插 + PDF/sample入位)."""
import json
import shutil
import time
from pathlib import Path

REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "ess" / "sched"

# 1) PDF + sample 入位
shutil.copy2(SRC / "out" / "REPORT_FULL_排版版.pdf", CONTENT / "full" / "ESS-2026.pdf")
shutil.copy2(SRC / "_ch01_final.md", CONTENT / "sample" / "ess_sample.md")
print("[ok] full/ESS-2026.pdf + sample/ess_sample.md")

# 2) SKU 头插
chs = json.loads((SRC / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""}
            for c in chs]
entry = {
    "sku": "ESS-2026",
    "title": "《国际储能与光伏EPC总承包投标实战研究报告·2026》",
    "subtitle": ("12 章 · 26.2 万字 · 382 页（储能与光伏EPC投标全链 + 技术路线"
                 "与成本管控 + 政策并网与海外FIDIC实战）"),
    "price": 698,
    "price_label": "¥698",
    "words_wan": 26,
    "cat": "topic",
    "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "26.2 万字（总装实测 262,341 CJK）"},
        {"k": "章节体量", "v": "12 章 · 382 页 PDF（pypdf 实测口径）"},
        {"k": "证据纪律", "v": "NBLM 产线 + 逐章收编台账 + 数字 token 可溯"},
        {"k": "弹药覆盖", "v": "37 渠道 306 件 1.87 亿字语料 · ima/微盘/判决切片/海外标讯全谱系"},
        {"k": "三场景实战", "v": "市场与投标决策 · 技术方案与成本管控 · 履约与风控（含海外FIDIC）"},
    ],
    "sample_file": "ess_sample.md",
    "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False,
    "chapters": chapters,
    "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "ESS-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 ESS-2026 (reports[0], 共{len(data['reports'])}SKU)")
