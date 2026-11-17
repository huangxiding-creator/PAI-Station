# -*- coding: utf-8 -*-
"""subcon_sku_build — 第18份 SUBCON-2026 上架."""
import json, shutil, time
from pathlib import Path
REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "subcon"
shutil.copy2(SRC / "sched" / "out" / "REPORT_FULL_v3出版级.pdf", CONTENT / "full" / "SUBCON-2026.pdf")
shutil.copy2(SRC / "sched" / "_ch01_final.md", CONTENT / "sample" / "subcon_sample.md")
chs = json.loads((SRC / "sched" / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""} for c in chs]
entry = {
    "sku": "SUBCON-2026", "title": "《EPC分包与总分包界面管理实战研究报告》",
    "subtitle": "12 章 · 25 万字 · 350+ 页（分包法律边界 + 合同设计 + 界面管控 + 结算连带责任实战）",
    "price": 698, "price_label": "¥698", "words_wan": 25,
    "cat": "topic", "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "25 万字级（总装实测为准）"},
        {"k": "章节体量", "v": "12 章 · 350+ 页 PDF"},
        {"k": "证据纪律", "v": "亿字级弹药池 + 判例语料切片 + 逐章收编台账"},
        {"k": "覆盖谱系", "v": "合法/违法分包边界 + 挂靠与实际施工人 + 背靠背结算 + 连带责任 + FIDIC国际分包"},
        {"k": "实战深度", "v": "分包策划 + 合同条款设计 + 界面协同 + 安全连带 + 行动清单"},
    ],
    "sample_file": "subcon_sample.md", "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False, "chapters": chapters, "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "SUBCON-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 SUBCON-2026 (共{len(data['reports'])}SKU)")
