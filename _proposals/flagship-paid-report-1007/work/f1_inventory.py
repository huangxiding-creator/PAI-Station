# -*- coding: utf-8 -*-
"""f1_inventory — 蓝皮书 F1 存量盘点: F:/新建文件夹/AI总包创新院/总包研报 全量体检.

产出: 每目录 {名, docx数, docx总字数(估), pdf数, 最大docx字数, 分类(企业/省份/专题/独家/其他), 成色}
汇总: 五类目录数/字数分布/可直接精编 vs 需补采.
字数估计: docx 解压 word/document.xml 去标签计数 (中文字符≈1字).
"""
import io
import json
import re
import sys
import zipfile
from pathlib import Path

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8", errors="replace")

SRC = Path(r"F:\新建文件夹\AI总包创新院\总包研报")
OUT = Path(r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\f1_inventory.json")


def docx_words(p: Path) -> int:
    try:
        with zipfile.ZipFile(p) as z:
            xml = z.read("word/document.xml").decode("utf-8", "ignore")
        txt = re.sub(r"<[^>]+>", "", xml)
        # 中文字 + 西文单词 两种都算
        han = len(re.findall(r"[\u4e00-\u9fff]", txt))
        words = len(re.findall(r"[A-Za-z]+", txt))
        return han + words
    except Exception:
        return 0


def classify(name: str) -> str:
    if re.search(r"(省|自治区|市)EPC|市场机会", name) and re.search(
            r"(省|自治区|市)", name):
        return "省份"
    if any(k in name for k in ("全景洞察报告", "经营管理研究报告",
                               "业务探秘", "探秘", "从100篇论文")):
        return "企业"
    if any(k in name for k in ("中国铁设", "浙江水利")):
        return "独家"
    if any(k in name for k in ("报告", "指南", "手册", "复盘", "解析",
                               "沉思录", "指北")):
        return "专题"
    return "其他"


rows = []
for d in sorted(SRC.iterdir()):
    if not d.is_dir() or d.name.startswith("00"):
        continue
    docxs = list(d.rglob("*.docx"))
    pdfs = list(d.rglob("*.pdf"))
    words_list = [docx_words(p) for p in docxs]
    total_w = sum(words_list)
    max_w = max(words_list) if words_list else 0
    rows.append({
        "dir": d.name,
        "cls": classify(d.name),
        "docx": len(docxs),
        "pdf": len(pdfs),
        "words_total": total_w,
        "words_max": max_w,
        # 成色: 最大单稿 >=8万字=可精编; >=3万=可合并; 其余/无docx=需补采
        "grade": ("A" if max_w >= 80000 else
                  "B" if max_w >= 30000 else
                  "C" if max_w > 0 else "D"),
    })

rows.sort(key=lambda r: -r["words_total"])
OUT.write_text(json.dumps(rows, ensure_ascii=False, indent=1), "utf-8")

# 汇总
agg = {}
for r in rows:
    a = agg.setdefault(r["cls"], {"n": 0, "words": 0, "A": 0, "B": 0, "C": 0, "D": 0})
    a["n"] += 1
    a["words"] += r["words_total"]
    a[r["grade"]] += 1

print("=== 分类汇总 ===")
for k, v in sorted(agg.items()):
    print("%s: %2d 目录, %6.1f 万字总量, 成色 A%d/B%d/C%d/D%d" % (
        k, v["n"], v["words"] / 10000, v["A"], v["B"], v["C"], v["D"]))
print("总目录:", len(rows), " 总字数: %.1f 万" % (sum(r["words_total"] for r in rows) / 10000))
print()
print("=== 字数 TOP15 ===")
for r in rows[:15]:
    print("%-6s %s  %6.1f万字 (max稿 %6.1f万, docx%d pdf%d) %s" % (
        r["cls"], r["dir"][:38], r["words_total"] / 10000,
        r["words_max"] / 10000, r["docx"], r["pdf"], r["grade"]))
print()
print("=== 成色D(需补采) ===")
for r in rows:
    if r["grade"] == "D":
        print("  D:", r["dir"][:50])
