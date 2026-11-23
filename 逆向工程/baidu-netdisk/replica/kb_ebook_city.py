# -*- coding: utf-8 -*-
"""kb_ebook_city.py — 中文电子书城检索层入库 45 库（24,071 册全结构化索引）。
产物：指南 + 分类总览 + Top40 分类全量书单 + 检索工具 + all-books.json。
边界：第三方城通链接仅作检索导航（E14：卖检索不卖文件）；文件级采集走微信读书产线。"""
import sys, os, json, shutil, collections

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
SRC_JSON = r"E:\AI-Station\vendors\ebook-treasure-chest\docs\all-books.json"
SEARCH_PY = r"E:\AI-Station\.claude\skills\ebook-treasure\scripts\search_books.py"
STAGE = os.path.join(os.path.dirname(os.path.abspath(__file__)), "_kb_build", "ebook_city")
TOPN = 40

books = json.load(open(SRC_JSON, encoding="utf-8"))
os.makedirs(STAGE, exist_ok=True)

# 指南
open(os.path.join(STAGE, "00 中文电子书城检索指南.md"), "w", encoding="utf-8").write(
    f"""# 中文电子书城检索层（24,071 册全结构化索引）

> 上游：ebook-treasure-chest（19.9k stars）· 1,000+ 分类 · 全结构化
> 提取日期：2026-11 · 密码统一 8866

## 三种用法

1. **检索工具**（离线秒出）：`py -3 search_books.py "关键词" -n 20`
   - 书名/分类/作者多词 OR 检索；`--json` 程序化消费
2. **浏览书单**：`01 分类总览.md` 看全部分类计数；Top40 热门分类有全量书单 md
3. **全量数据**：`all-books.json`（24,071 条：书名/作者/分类/格式/链接）

## 库画像（Top 类目）

""" )
# 分类计数
cat = collections.Counter(b.get("category") or "未分类" for b in books)
top = cat.most_common()
lines = ["# 01 分类总览（1,000+ 类）", "", f"> 共 {len(books):,} 册 · {len(cat)} 个分类", "",
         "| 分类 | 册数 |", "|---|---|"]
for k, v in top:
    lines.append(f"| {k} | {v:,} |")
open(os.path.join(STAGE, "01 分类总览.md"), "w", encoding="utf-8").write("\n".join(lines) + "\n")

# Top40 分类全量书单
by_cat = collections.defaultdict(list)
for b in books:
    by_cat[b.get("category") or "未分类"].append(b)
made = 0
for k, v in top[:TOPN]:
    safe = "".join("-" if c in '\\/:*?"<>|' else c for c in str(k)).strip() or "未分类"
    rows = [f"# 分类书单：{k}（{v:,} 册）", "",
            "| 书名 | 作者 | 格式 |", "|---|---|---|"]
    for b in by_cat[k]:
        rows.append(f"| {b.get('title','')} | {b.get('author','')} | {'/'.join(b.get('formats') or [])} |")
    open(os.path.join(STAGE, f"分类_{safe}.md"), "w", encoding="utf-8").write("\n".join(rows) + "\n")
    made += 1

# 检索工具 + 全量 JSON
shutil.copy(SEARCH_PY, os.path.join(STAGE, "search_books.py"))
shutil.copy(SRC_JSON, os.path.join(STAGE, "all-books.json"))

# 指南补充库画像
top10 = " / ".join(f"{k} {v:,}" for k, v in top[:10])
guide = os.path.join(STAGE, "00 中文电子书城检索指南.md")
g = open(guide, encoding="utf-8").read()
open(guide, "w", encoding="utf-8").write(g + top10 + f"""

## 边界说明（合规）

- 链接为第三方城通网盘分享，**本库提供检索导航，不售卖文件**（卖检索不卖文件）
- 付费买家含检索工具与全量索引；文件获取遵循第三方平台规则与版权
- 工程类精品书籍以本库 45/51/52 库自有采集为准（微信读书产线限流补充）
""")
print(f"staged: {made} 分类书单 + 总览 + 指南 + 工具 + JSON @ {STAGE}")
print("Top10:", top10)
