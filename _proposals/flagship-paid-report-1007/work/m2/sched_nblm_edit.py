# -*- coding: utf-8 -*-
"""sched_nblm_edit — NB 初稿收编器: 聊天痕清洗 + 语言律扫查 + 产出报告体.

输入 nblm_out/chNN_初稿.md → 输出 nblm_out/chNN_编辑稿.md:
1) 剥离对话痕(「接下来您可以…」建议块/往复客套/重复章题)
2) 源引用对照段挪到章末《引用来源》附录
3) 语言律扫查(黑话/计算机术语/AI腔)标记待人工/军团修点
4) 统计(CJK/引用数/小节数)
用法: py -X utf8 sched_nblm_edit.py [--chapters 1,2,...]
"""
from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path

OUT = Path(__file__).resolve().parent / "sched" / "nblm_out"
JARGON = ["算法", "模型", "引擎", "API", "爬虫", "数据库", "脚本", "自动化抓取",
          "平台化", "颗粒度", "抓手", "闭环", "对齐", "赋能", "底层逻辑",
          "数据驱动", "深度学习", "大语言", "提示词"]
CHAT_PAT = [
    r"📌.*?(?=\n\n|\Z)",
    r"接下来您可以[：:].*?\Z",
    r"(?m)^>?\s*(好的|明白了|当然)[，,].*?\n",
    r"——\s*$",
]


def clean(text: str) -> tuple[str, list[str]]:
    notes = []
    # 1) 源对照段抽出
    m = re.search(r"(?m)^#{0,3}\s*(源引用对照|引用来源|来源索引).*", text)
    appendix = ""
    if m:
        # 找该节起点, 到下一个 ## 或文末
        rest = text[m.start():]
        end = None
        for mm in re.finditer(r"(?m)^## ", rest[1:]):
            end = mm.start() + 1
            break
        appendix = (rest[:end] if end else rest).strip()
        text = (text[:m.start()] + (rest[end:] if end else "")).rstrip()
        notes.append(f"源对照段抽出({len(appendix)}字)→章末附录")
    # 2) 聊天痕清洗
    for p in CHAT_PAT:
        text, n = re.subn(p, "", text, flags=re.S)
        if n:
            notes.append(f"清洗对话痕×{n}")
    # 3) 语言律扫查(只标记不擅改——留给军团精修)
    hits = {j: text.count(j) for j in JARGON if j in text}
    if hits:
        notes.append("术语待修:" + ",".join(f"{k}×{v}" for k, v in hits.items()))
    # 4) 附录回贴
    if appendix:
        text += "\n\n## 本章引用来源\n\n" + appendix + "\n"
    return text, notes


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--chapters", default="")
    ns = ap.parse_args()
    nums = [int(x) for x in ns.chapters.split(",") if x.strip()] \
        or list(range(1, 13))
    for n in nums:
        src = OUT / f"ch{n:02d}_初稿.md"
        if not src.is_file():
            print(f"[edit] ch{n:02d} 无初稿, 跳过")
            continue
        text, notes = clean(src.read_text(encoding="utf-8"))
        dst = OUT / f"ch{n:02d}_编辑稿.md"
        dst.write_text(text, encoding="utf-8")
        cjk = len(re.findall(r"[一-鿿]", text))
        cites = len(set(re.findall(r"\[(\d+)[,\]]", text)))
        secs = len(re.findall(r"(?m)^#{1,3} ", text))
        print(f"[edit] ch{n:02d}: CJK {cjk:,} | 引用{cites}源 | "
              f"{secs}节 → {dst.name}")
        for x in notes:
            print(f"    - {x}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
