# -*- coding: utf-8 -*-
"""bid26_bank — 章级弹药 bank 抽取器 (BID26 S2).

每章: manifest valid 行按章检索词计分 (text_head+文件名) → top-N 落
bank md (源路径+标题+正文节选), 锚点 P{id} 供写手引用与 gate2 锚点门
逐字核验。数字零造假链: 章内数字必须逐字存在于 bank。

用法: py _proposals/flagship-paid-report-1007/work/m2/bid26_bank.py
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "train"
POOL = REPO / "ammo_pool" / "EPC-TRAIN"

TOP_N = 35
READ_HEAD = 1600          # 每源节选字符 (bank 体量 = 35×1.6K ≈ 56K/章)


def read_head_safe(fp: Path, n: int) -> str:
    try:
        if fp.suffix.lower() == ".pdf":
            return ""                     # pdf 走池同款抽取过重, bank 以 md/txt 为主
        return fp.read_text(encoding="utf-8", errors="replace")[:n]
    except OSError:
        return ""


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    chapters = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))
    rows = []
    for ln in (POOL / "manifest.jsonl").read_text(encoding="utf-8").splitlines():
        if not ln.strip():
            continue
        try:
            r = json.loads(ln)
        except json.JSONDecodeError:
            continue
        if r.get("judge") == "valid":
            rows.append(r)
    print(f"[bank] valid 行 {len(rows)}")
    stock_guide = None
    for r in rows:                        # A级存量主源优先置顶
        sp = str(r.get("source_path", ""))
        if sp.endswith("不存在的主源.md"):
            stock_guide = r
            break
    for ch in chapters:
        kws = ch["kws"]
        scored = []
        for i, r in enumerate(rows):
            sp = str(r.get("source_path", ""))
            hay = str(r.get("text_head", "")) + " " + Path(sp).stem
            s = sum(2 if k in Path(sp).stem else 0 for k in kws) \
                + sum(1 for k in kws if k in hay)
            chars = int(r.get("chars", 0))
            s += min(3, chars // 8000)     # 长件微加成 (封顶防巨头通吃)
            if s > 0:
                scored.append((s, chars, i, r))
        scored.sort(key=lambda x: (-x[0], -x[1]))
        picked = scored[:TOP_N]
        if False:
            picked.insert(0, (99, int(stock_guide.get("chars", 0)), -1,
                              stock_guide))
        parts = [f"# Bank·第{ch['no']}章 {ch['title']} `[三态：{ch['type']}]`",
                 "", f"> 检索词: {' / '.join(kws)} | 命中源 {len(picked)} 件",
                 ""]
        for j, (s, chars, _, r) in enumerate(picked):
            sp = Path(str(r.get("source_path", "")))
            head = read_head_safe(sp, READ_HEAD)
            if not head:
                continue
            parts.append(f"## P{ch['no']}{j:03d} {sp.stem[:56]}")
            parts.append(f"> 源: {sp} | {chars:,}字 | "
                         f"引擎 {r.get('engine','')}")
            parts.append("")
            parts.append(head)
            parts.append("")
        out = M2 / f"bank_ch{int(ch['no']):02d}.md"
        out.write_text("\n".join(parts), encoding="utf-8")
        print(f"[bank] 第{ch['no']}章 → {out.name} "
              f"({len(picked)} 源, {out.stat().st_size // 1024}KB)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
