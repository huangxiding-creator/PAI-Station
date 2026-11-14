# -*- coding: utf-8 -*-
"""insure_sku_build — 第17份 INSURE-2026 上架."""
import json, shutil, time
from pathlib import Path
REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "insure"
shutil.copy2(SRC / "sched" / "out" / "REPORT_FULL_世界出版版.pdf", CONTENT / "full" / "INSURE-2026.pdf")
shutil.copy2(SRC / "sched" / "_ch01_final.md", CONTENT / "sample" / "insure_sample.md")
chs = json.loads((SRC / "sched" / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""} for c in chs]
entry = {
    "sku": "INSURE-2026", "title": "《EPC工程保险与保函实务研究报告》",
    "subtitle": "12 章 · 25 万字 · 370+ 页（保函全谱系 + 工程保险 + 保函欺诈与裁判规则实战）",
    "price": 698, "price_label": "¥698", "words_wan": 25,
    "cat": "topic", "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "25 万字级（总装实测为准）"},
        {"k": "章节体量", "v": "12 章 · 370+ 页 PDF"},
        {"k": "证据纪律", "v": "1.9 亿字弹药池 + 判例语料切片 + 逐章收编台账"},
        {"k": "覆盖谱系", "v": "投标/履约/预付款/质保金保函 + 工程一切险/保证保险/IDI/职业责任"},
        {"k": "实战深度", "v": "独立保函规则 + 保函欺诈例外 + URDG国际 + FIDIC担保"},
    ],
    "sample_file": "insure_sample.md", "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False, "chapters": chapters, "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "INSURE-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 INSURE-2026 (共{len(data['reports'])}SKU)")
