#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""把 enum-parent-map.js 的精确父子关系转成最终 doc-map.json。

doc-map.json 每行：{md, token, title, level, chapter(L1), path(完整层级), confidence}
confidence: exact（枚举命中）/ l1（自身就是根章节）/ missing（树中无此节点→未分类）

用法：python finalize_tree.py
"""
import json
import os
import re
import sys
from collections import Counter

SKILL = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
STATE = os.path.join(SKILL, "state")
WIKI_DIR = r"E:\AI-Station\ResearchFactory-Eng\feishu-Down\wiki-output\waytoagi"

SRC_RE = re.compile(r'source:\s*"https://waytoagi\.feishu\.cn/wiki/([A-Za-z0-9]+)"')


def main():
    ni_path = os.path.join(STATE, "node-info.json")
    if not os.path.exists(ni_path):
        print("❌ node-info.json 不存在，先跑 enum-parent-map.js")
        return 1
    node_info = json.load(open(ni_path, encoding="utf-8"))

    def path_of(tok):
        chain, cur, guard = [], tok, 0
        while guard < 12:
            info = node_info.get(cur)
            if not info or info.get("parent") is None:
                break
            cur = info["parent"]
            pinfo = node_info.get(cur)
            if pinfo:
                chain.append(pinfo.get("title", "?"))
            guard += 1
        return list(reversed(chain))

    rows = []
    for f in sorted(os.listdir(WIKI_DIR)):
        if not f.endswith(".md"):
            continue
        head = open(os.path.join(WIKI_DIR, f), encoding="utf-8", errors="replace").read(2000)
        m = SRC_RE.search(head)
        tok = m.group(1) if m else None
        info = node_info.get(tok) if tok else None
        if not info:
            rows.append({"md": f, "token": tok, "title": f[:-3], "level": None,
                         "chapter": "_未分类", "path": [], "confidence": "missing"})
            continue
        chain = path_of(tok)
        if info.get("parent") is None:               # 自身是根章节
            chapter, conf = info["title"], "l1"
        elif chain:
            chapter, conf = chain[0], "exact"
        else:
            chapter, conf = "_未分类", "missing"
        rows.append({"md": f, "token": tok, "title": info.get("title", f[:-3]),
                     "level": info.get("level"), "chapter": chapter,
                     "path": chain, "confidence": conf})

    out = os.path.join(STATE, "doc-map.json")
    json.dump(rows, open(out, "w", encoding="utf-8"), ensure_ascii=False, indent=1)
    cc = Counter(r["chapter"] for r in rows)
    qc = Counter(r["confidence"] for r in rows)
    print(f"共 {len(rows)} 篇 md | 置信度: {dict(qc)}")
    for ch, c in cc.most_common():
        print(f"  {c:5d}  {ch[:46]}")
    print(f"输出: {out}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
