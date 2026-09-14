#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""增量同步：对比最新树（parent-map/node-info）与本地已有 md，找出缺失文档。

产出：
  state/new-pages.json   —— 缺失文档清单 [{token,title,level,chapter}...]
  api-pages.json 刷新    —— 写回 feishu-Down/wiki-output/waytoagi/api-pages.json
                            （wiki-crawler.js 会优先加载它，且能从已有 md 的
                             frontmatter source 恢复已完成集 → 重跑=只抓缺失）

用法：python sync_incremental.py [--download] [--chapters "1.2,1.3"] [--limit N]
  --download   生成清单后直接调 wiki-crawler.js 抓缺失文档（走 feishu-Down 环境）
  --chapters   只处理指定 L1 章节（逗号分隔，按 doc-map 章节名精确匹配前缀亦可）
  --limit      缺失清单截断（试跑用；不影响 api-pages.json 全量刷新）

⚠️ 2026-09-12 基线：树 14455 节点 vs 本地 3398 md，缺口 11078 篇为真实新增
（原 ResearchFactory 爬取仅覆盖 23.5%）。全量补齐 ≈11078×20s≈61h，建议
--chapters 分批。快讯/周刊类章节（4.1、2.8）时效性强，可优先级放低。
"""
import argparse
import json
import os
import re
import subprocess
import sys

SKILL = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(SKILL, "state")
WIKI_DIR = r"E:\AI-Station\ResearchFactory-Eng\feishu-Down\wiki-output\waytoagi"
EXPORTER = r"E:\AI-Station\ResearchFactory-Eng\feishu-Down\feishu-exporter"

SRC_RE = re.compile(r'source:\s*"https://waytoagi\.feishu\.cn/wiki/([A-Za-z0-9]+)"')


def chapter_of(token, ni, l1_titles):
    """token → L1 祖先标题（无则 ''）。"""
    seen = set()
    t = token
    while t and t not in seen:
        seen.add(t)
        info = ni.get(t) or {}
        p = info.get("parent")
        if p is None:
            return info.get("title") or ""
        t = p
    return ""


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--download", action="store_true")
    ap.add_argument("--chapters", default=None, help='逗号分隔 L1 章节名（可前缀匹配）')
    ap.add_argument("--limit", type=int, default=0, help="缺失清单截断（试跑）")
    args = ap.parse_args()

    ni = json.load(open(os.path.join(STATE, "node-info.json"), encoding="utf-8"))
    pm = json.load(open(os.path.join(STATE, "parent-map.json"), encoding="utf-8"))

    # L1 章节白名单（前缀匹配）
    wanted = None
    if args.chapters:
        prefixes = tuple(s.strip() for s in args.chapters.split(",") if s.strip())
        l1_titles = {v["title"] for v in ni.values() if v.get("parent") is None}
        wanted = {t for t in l1_titles if t.startswith(prefixes)}
        print(f"章节过滤: {sorted(wanted)}")

    have = set()
    for f in os.listdir(WIKI_DIR):
        if f.endswith(".md"):
            m = SRC_RE.search(open(os.path.join(WIKI_DIR, f), encoding="utf-8",
                                   errors="replace").read(2000))
            if m:
                have.add(m.group(1))

    # 按 BFS 序展开成 api-pages 兼容格式（level 从 node-info 取）
    pages, missing = [], []
    for parent, kids in pm.items():
        plevel = ni.get(parent, {}).get("level") or 1
        for k in kids:
            pages.append({"token": k["token"], "title": k["title"],
                          "level": max(2, plevel + 1), "has_child": bool(k.get("has_child"))})
            if k["token"] in have:
                continue
            if wanted is not None and chapter_of(k["token"], ni, None) not in wanted:
                continue
            missing.append({"token": k["token"], "title": k["title"],
                            "level": max(2, plevel + 1)})
    if args.limit:
        missing = missing[: args.limit]
    # 根节点补进开头
    roots = [{"token": t, "title": v["title"], "level": 1, "has_child": True}
             for t, v in ni.items() if v.get("parent") is None]
    # 章节过滤时 api-pages 同步收窄（否则 wiki-crawler 会抓全部缺失而非所选章节）
    out = list(pages)
    if wanted is not None:
        out = [p for p in pages if chapter_of(p["token"], ni, None) in wanted]
        print(f"api-pages 已按章节收窄: {len(out)}/{len(pages)} 页")
    out_pages = {"pages": roots + out}
    json.dump(out_pages, open(os.path.join(WIKI_DIR, "api-pages.json"), "w",
                              encoding="utf-8"), ensure_ascii=False, indent=1)
    json.dump(missing, open(os.path.join(STATE, "new-pages.json"), "w",
                            encoding="utf-8"), ensure_ascii=False, indent=1)
    print(f"树节点 {len(pages)} | 本地已有 {len(have)} | 缺失 {len(missing)}")
    print(f"api-pages.json 已刷新（wiki-crawler 断点续跑将只抓缺失）")
    for m in missing[:10]:
        print(f"  - {m['title'][:40]}")
    if len(missing) > 10:
        print(f"  ... 共 {len(missing)} 篇")

    if args.download and missing:
        print("\n🚀 启动 wiki-crawler.js 抓取缺失文档（约 20s/篇）...")
        r = subprocess.run(["node", "wiki-crawler.js"], cwd=EXPORTER)
        return r.returncode
    return 0


if __name__ == "__main__":
    sys.exit(main())
