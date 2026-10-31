# -*- coding: utf-8 -*-
"""sched_nb_draft — NB(68卷历史报告库)章级初稿生成器 (1020 用户令:
一定要用 NB 生成研究报告各章初稿).

流: chapters.json 每章检索词 × NB 90/91 卷切篇计分 (去重变体, 保纯.md)
→ top 篇原文落 _chNN_nb_draft.md (初稿基底) → 同文追加进 bank_chNN.md
作 P{ch}005x 深注锚 (正文引用即可过数字核验).
用法: py sched_nb_draft.py [--top 3]
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from pathlib import Path

M2 = Path(__file__).resolve().parent / "sched"
NB = Path(r"E:\AI-Station\ResearchFactory-Eng\NB_MD_library_v2")
VOLS = ["90_研究报告成果合集_vol001.md", "90_研究报告成果合集_vol002.md",
        "90_研究报告成果合集_vol003.md", "91_法规共性资料_vol001.md"]
BLOCK_HEAD = "\n\n---\n\n# "
MIN_CHARS = 2000


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    ap = argparse.ArgumentParser()
    ap.add_argument("--top", type=int, default=3)
    ns = ap.parse_args()
    chapters = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))

    segs_all: list[tuple[str, str, str]] = []      # (title, vol, text)
    for vol in VOLS:
        fp = NB / vol
        if not fp.is_file():
            continue
        raw = fp.read_text(encoding="utf-8", errors="replace")
        for seg in raw.split(BLOCK_HEAD)[1:]:
            nl = seg.find("\n", 1)
            title = seg[:nl].strip() if nl > 0 else seg.strip()[:80]
            if len(seg) < MIN_CHARS:
                continue
            segs_all.append((title, vol, BLOCK_HEAD + seg))
    print(f"[nb] 切篇 {len(segs_all)} 段 (来自 {len(VOLS)} 卷)")

    # 去重变体: 标题归一 (去路径前缀/变体后缀/字数标记) 后取最长
    def norm_title(s: str) -> str:
        s = re.sub(r"^《[^》]*》\s*/\s*", "", s.strip())
        s = re.sub(r"_(citefixed|conf)(?=\.md$|$)", "", s)
        s = re.sub(r"\s*\[目标字数[^\]]*\]", "", s)
        s = re.sub(r"\.md$", "", s)
        s = s.replace("_", " ").replace("　", " ")
        s = re.sub(r"\s+", " ", s)
        return s.strip()[:60]
    by_title: dict[str, tuple[str, str, int]] = {}
    for title, vol, text in segs_all:
        base = norm_title(title)
        if base not in by_title or len(text) > by_title[base][2]:
            by_title[base] = (vol, text, len(text))
    uniq = [(t, v[0], v[1]) for t, v in by_title.items()]
    print(f"[nb] 去重后 {len(uniq)} 篇")

    for ch in chapters:
        kws = ch["kws"] + ch.get("qs", [])
        scored = []
        for title, vol, text in uniq:
            head = text[:6000]
            s = sum(3 if k in title else 0 for k in ch["kws"]) \
                + sum(1 for k in ch["kws"] if k in head)
            if s > 0:
                scored.append((s, len(text), title, vol, text))
        scored.sort(key=lambda x: (-x[0], -x[1]))
        picked, seen_base = [], set()
        for s, n, title, vol, text in scored:
            if norm_title(title) in seen_base:
                continue
            seen_base.add(norm_title(title))
            picked.append((s, n, title, vol, text))
            if len(picked) >= ns.top:
                break
        out = [f"# NB初稿基底·第{ch['no']}章 {ch['title']}",
               f"检索词: {'、'.join(ch['kws'])} | NB命中 {len(scored)} 篇 "
               f"取 top{len(picked)} (1020用户令: 各章初稿必须由NB生成)",
               ""]
        bank_add = ""
        for i, (s, n, title, vol, text) in enumerate(picked, 1):
            out.append(f"## NB-{i} [{s}分 {n:,}字 | {vol[:24]}]")
            out.append(f"源章: {title[:80]}")
            out.append("")
            out.append(text[:24000])
            out.append("")
            anchor = f"P{(ch['no']-1)*100+50+i:06d}"
            bank_add += (f"\n## {anchor} (NB章基底 {s}分 {n:,}字)\n"
                         f"路径: {vol}#{title[:70]}\n\n{text[:24000]}\n")
        (M2 / f"_ch{ch['no']:02d}_nb_draft.md").write_text(
            "\n".join(out), encoding="utf-8")
        if bank_add:
            bp = M2 / f"bank_ch{ch['no']:02d}.md"
            bp.write_text(bp.read_text(encoding="utf-8") + bank_add,
                          encoding="utf-8")
        names = [p[2][:40] for p in picked]
        print(f"[nb] 第{ch['no']}章 命中{len(scored):>3} "
              f"top{len(picked)}: {names}")
    print("[nb] 全部章初稿基底落盘")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
