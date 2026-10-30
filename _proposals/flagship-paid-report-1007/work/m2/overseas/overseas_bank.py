# -*- coding: utf-8 -*-
"""sched_bank — 章级弹药 bank 抽取器 (EPC-OVERSEAS S2, 照 dsim_bank 型).

每章: manifest valid 行按章检索词计分 (text_head+文件名) → top-N 落 bank md,
锚点 P{id} 供写手引用与 gate2 锚点门逐字核验。数字零造假链: 章内数字必须
逐字存在于 bank。
用法: py _proposals/flagship-paid-report-1007/work/m2/sched_bank.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[5]
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "overseas" / "sched"
POOL = REPO / "ammo_pool" / "EPC-OVERSEAS"

TOP_N = 35
READ_HEAD = 6000


def read_head_safe(fp: Path, n: int) -> str:
    try:
        if fp.suffix.lower() == ".pdf":
            try:
                import fitz
                with fitz.open(fp) as doc:
                    return (" ".join(p.get_text() for p in doc))[:n]
            except Exception:
                return ""
        return fp.read_text(encoding="utf-8", errors="replace")[:n]
    except OSError:
        return ""


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    chapters = json.loads((M2 / "chapters.json").read_text(encoding="utf-8"))
    ALIAS = {"印尼": "印度尼西亚", "土耳其": "土耳其", "哈萨克": "哈萨克斯坦"}
    for ch in chapters:
        ch["kws"] = list(dict.fromkeys(ch["kws"] + [ALIAS[k] for k in ch["kws"] if k in ALIAS]))
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
                 f"检索词: {'、'.join(kws)} | 树子问: {', '.join(ch.get('qs', []))}",
                 f"候选 {len(scored)} | 取 top {min(TOP_N, len(scored))}", ""]
        bank_chars = 0
        for rank, (s, chars, i, r) in enumerate(scored[:TOP_N], 1):
            head = read_head_safe(Path(r["source_path"]), READ_HEAD)
            if not head:
                head = str(r.get("text_head", ""))[:READ_HEAD]
            parts.append(f"## P{(ch['no']-1)*100+rank:06d} (分{s} {chars:,}字 "
                         f"{r.get('engine','')} {r.get('credibility','')})")
            parts.append(f"路径: {Path(r['source_path']).name[:90]}")
            parts.append("")
            parts.append(head)
            parts.append("")
            bank_chars += chars
        out = M2 / f"bank_ch{ch['no']:02d}.md"
        out.write_text("\n".join(parts), encoding="utf-8")
        print(f"[bank] 第{ch['no']}章 候选{len(scored):>5} 底料"
              f"{bank_chars:>12,}字 → {out.name}")
    print("[bank] 全部完成")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
