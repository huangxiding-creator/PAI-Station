# -*- coding: utf-8 -*-
"""visa_sku_build — 第16份 VISA-2026 上架内容构建."""
import json
import shutil
import time
from pathlib import Path

REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "visa"

shutil.copy2(SRC / "sched" / "out" / "REPORT_FULL_世界出版版.pdf",
             CONTENT / "full" / "VISA-2026.pdf")
shutil.copy2(SRC / "sched" / "_ch01_final.md",
             CONTENT / "sample" / "visa_sample.md")
print("[ok] full/VISA-2026.pdf + sample/visa_sample.md")

chs = json.loads((SRC / "sched" / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""}
            for c in chs]
entry = {
    "sku": "VISA-2026",
    "title": "《工程签证与变更索赔实战研究报告》",
    "subtitle": ("12 章 · 26.6 万字 · 330+ 页（签证效力与程序 + 变更估价 + "
                 "费用工期索赔攻防 + 判例谱系实战）"),
    "price": 698,
    "price_label": "¥698",
    "words_wan": 27,
    "cat": "topic",
    "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "26.6 万字（总装实测 266,373 CJK）"},
        {"k": "章节体量", "v": "12 章 · 330+ 页 PDF（pypdf 实测口径）"},
        {"k": "证据纪律", "v": "1.45 亿字弹药池 + 判例语料切片 + 逐章收编台账"},
        {"k": "判例覆盖", "v": "2009-2021 判决年卷 · 签证效力/变更估价/索赔时效全谱系"},
        {"k": "实战深度", "v": "签证程序 · 费用工期索赔 · 反索赔 · FIDIC 国际 · 行动清单"},
    ],
    "sample_file": "visa_sample.md",
    "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False,
    "chapters": chapters,
    "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "VISA-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 VISA-2026 (共{len(data['reports'])}SKU)")
