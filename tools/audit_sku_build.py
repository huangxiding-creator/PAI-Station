# -*- coding: utf-8 -*-
"""audit_sku_build — 第15份 AUDIT-2026 上架内容构建 (照 ess_sku_build)."""
import json
import shutil
import time
from pathlib import Path

REPO = Path(r"E:\AI-Station")
CONTENT = REPO / "report_platform" / "content"
SRC = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "audit"

shutil.copy2(SRC / "sched" / "out" / "REPORT_FULL_排版版.pdf",
             CONTENT / "full" / "AUDIT-2026.pdf")
shutil.copy2(SRC / "sched" / "_ch01_final.md",
             CONTENT / "sample" / "audit_sample.md")
print("[ok] full/AUDIT-2026.pdf + sample/audit_sample.md")

chs = json.loads((SRC / "sched" / "chapters.json").read_text(encoding="utf-8"))
chapters = [{"id": f"ch{c['no']}", "title": f"第{c['no']}章 {c['title']}", "desc": ""}
            for c in chs]
entry = {
    "sku": "AUDIT-2026",
    "title": "《EPC工程审计与决算实战研究报告》",
    "subtitle": ("12 章 · 25 万字 · 400+ 页（EPC审计监管与准则体系 + 竣工决算编制"
                 "与送审实务 + 审减攻防与造价鉴定实战）"),
    "price": 698,
    "price_label": "¥698",
    "words_wan": 25,
    "cat": "topic",
    "cat_name": "专题实战",
    "badges": [
        {"k": "全书字数", "v": "25 万字级（总装实测为准）"},
        {"k": "章节体量", "v": "12 章 · 400+ 页 PDF（pypdf 实测口径）"},
        {"k": "证据纪律", "v": "2.4 亿字弹药池 + 判例语料切片 + 逐章收编台账"},
        {"k": "判例覆盖", "v": "2009-2021 判决年卷 · 结算审减/造价鉴定/审计效力全谱系"},
        {"k": "实战深度", "v": "送审策略 · 审减攻防 · FIDIC国际决算 · 三场景行动清单"},
    ],
    "sample_file": "audit_sample.md",
    "sample_label": "第1章 导论全章免费试读",
    "coming_soon": False,
    "chapters": chapters,
    "listed_at": time.strftime("%Y-%m-%d %H:%M"),
}
rp = CONTENT / "report.json"
data = json.loads(rp.read_text(encoding="utf-8"))
assert not any(r.get("sku") == "AUDIT-2026" for r in data["reports"]), "SKU已存在"
data["reports"].insert(0, entry)
rp.write_text(json.dumps(data, ensure_ascii=False, indent=1), encoding="utf-8")
print(f"[ok] report.json 头插 AUDIT-2026 (共{len(data['reports'])}SKU)")
