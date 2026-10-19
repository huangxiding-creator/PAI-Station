# -*- coding: utf-8 -*-
"""dsim_bank — 章级弹药 bank 抽取器 (EPC49 S2, 照 train_bank 型).

每章: manifest valid 行按章检索词计分 (text_head+文件名) → top-N 落 bank md,
锚点 P{id} 供写手引用与 gate2 锚点门逐字核验。数字零造假链: 章内数字必须
逐字存在于 bank。
用法: py _proposals/flagship-paid-report-1007/work/m2/dsim_bank.py
"""
from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[4]
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "dsim"
POOL = REPO / "ammo_pool" / "EPC-DSIM"

TOP_N = 35
READ_HEAD = 1600


def read_head_safe(fp: Path, n: int) -> str:
    try:
        if fp.suffix.lower() == ".pdf":
            return ""
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
    for ch in chapters:
        kws = ch["kws"]
        scored = []
        for i, r in enumerate(rows):
            sp = str(r.get("source_path", ""))
            hay = str(r.get("text_head", "")) + " " + Path(sp).stem
            s = sum(2 if k in Path(sp).stem else 0 for k in kws) \
                + sum(1 for k in kws if k in hay)
            chars = int(r.get("chars", 0))
            s += min(3, chars // 8000)
            if s > 0:
                scored.append((s, chars, i, r))
        scored.sort(key=lambda x: (-x[0], -x[1]))
        parts = [f"# Bank·第{ch['no']}章 {ch['title']} `[三态：{ch['type']}]`",
                 "", f"> 检索词: {' / '.join(kws)} | 命中源 top{TOP_N}", ""]
        j = 0
        for s, chars, _, r in scored[:300]:      # 跳无文源直到凑足 TOP_N
            if j >= TOP_N:
                break
            sp = Path(str(r.get("source_path", "")))
            head = read_head_safe(sp, READ_HEAD)
            if not head:
                continue
            parts.append(f"## P{ch['no']}{j:03d} {sp.stem[:56]}")
            parts.append(f"> 源: {sp} | {chars:,}字 | 引擎 {r.get('engine','')}")
            parts.append("")
            parts.append(head)
            parts.append("")
            j += 1
        out = M2 / f"bank_ch{int(ch['no']):02d}.md"
        out.write_text("\n".join(parts), encoding="utf-8")
        print(f"[bank] 第{ch['no']}章 → {out.name} "
              f"({j} 源, {out.stat().st_size // 1024}KB)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
