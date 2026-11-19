# -*- coding: utf-8 -*-
"""fin_sku_build — 第19份 FIN-2026 上架."""
import json, shutil, time
from pathlib import Path
REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "fin"
shutil.copy2(SRC / "sched" / "out" / "REPORT_FULL_v3出版级.pdf", CONTENT / "full" / "FIN-2026.pdf")
shutil.copy2(SRC / "sched" / "_ch01_final.md", CONTENT / "sample" / "fin_sample.md")
chs = json.loads((SRC / "sched" / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""} for c in chs]
entry = {
    "sku": "FIN-2026", "title": "《EPC项目融资模式与投资决策实战研究报告》",
    "subtitle": "12 章 · 90 万字 · 400+ 页（BOT/PPP/EPC+F + SPV/银团/REITs/产业基金 + IRR/风险分担实战）",
    "price": 698, "price_label": "¥698", "words_wan": 90,
    "cat": "topic", "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "90 万字级（总装实测为准）"},
        {"k": "章节体量", "v": "12 章 · 400+ 页 PDF"},
        {"k": "证据纪律", "v": "亿字级弹药池 + 判例语料切片 + 逐章收编台账"},
        {"k": "覆盖谱系", "v": "BOT/PPP/EPC+F + SPV/银团/出口信贷 + REITs/ABS/产业基金/融资租赁"},
        {"k": "实战深度", "v": "投资回报测算 + 风险分担 + 国际融资 + 行动清单"},
    ],
    "sample_file": "fin_sample.md", "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False, "chapters": chapters, "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "FIN-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 FIN-2026 (共{len(data['reports'])}SKU)")
