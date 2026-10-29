# -*- coding: utf-8 -*-
"""top50_bank — 章级弹药 bank 抽取器 (EPC-TOP50 第11份 S2, 照 jiage_bank 型/第10份验证产线).

每章: manifest valid 行按章检索词计分 (text_head+文件名) → top-N 落 bank md,
锚点 P{id} 供写手引用与 gate2 锚点门逐字核验。数字零造假链: 章内数字必须
逐字存在于 bank。分层: tiers.json (EPC-TOP50 S1 T1=直接词24/T2=对标词10)
对每条底料打 T1 命中数标签。
用法: py _proposals/flagship-paid-report-1007/work/m2/top50/top50_bank.py
"""
from __future__ import annotations

import json
import sys
from pathlib import Path

# top50_bank.py 与 jiage_bank.py 同在 m2/ 下一层 (m2/top50/), parents[5] 仍=E:\AI-Station
REPO = Path(__file__).resolve().parents[5]
M2 = REPO / "_proposals" / "flagship-paid-report-1007" / "work" / "m2" / "top50" / "sched"
POOL = REPO / "ammo_pool" / "EPC-TOP50"

TOP_N = 35
READ_HEAD = 6000

# 章检索词别名扩写 (TOP50 版: 集团简称→全称; kws 已用全称时不触发)
ALIAS = {"电建": "中国电建", "能建": "中国能建", "寰球": "中国寰球",
         "天辰": "中国天辰", "五环": "中国五环", "成达": "中国成达"}


def load_tiers() -> dict[str, list[str]]:
    try:
        return json.loads((POOL / "tiers.json").read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return {}


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
    for ch in chapters:
        ch["kws"] = list(dict.fromkeys(ch["kws"] + [ALIAS[k] for k in ch["kws"] if k in ALIAS]))
    tiers = load_tiers()
    t1 = tiers.get("T1", [])
    print(f"[bank] tiers.json T1×{len(t1)} T2×{len(tiers.get('T2', []))}")
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
        subqs = ch.get("subqs") or ch.get("qs", [])
        parts = [f"# Bank·第{ch['no']}章 {ch['title']} `[三态：{ch['type']}]`",
                 f"检索词: {'、'.join(kws)} | 树子问: {', '.join(subqs)}",
                 f"候选 {len(scored)} | 取 top {min(TOP_N, len(scored))}", ""]
        bank_chars = 0
        t1_hit_rows = 0
        for rank, (s, chars, i, r) in enumerate(scored[:TOP_N], 1):
            head = read_head_safe(Path(r["source_path"]), READ_HEAD)
            if not head:
                head = str(r.get("text_head", ""))[:READ_HEAD]
            t1n = sum(1 for k in t1 if k in head) if t1 else 0
            t1_hit_rows += 1 if t1n else 0
            parts.append(f"## P{(ch['no']-1)*100+rank:06d} (分{s} {chars:,}字 "
                         f"{r.get('engine','')} {r.get('credibility','')} T1:{t1n})")
            parts.append(f"路径: {Path(r['source_path']).name[:90]}")
            parts.append("")
            parts.append(head)
            parts.append("")
            bank_chars += chars
        if t1:
            parts.insert(3, f"分层: tiers.json T1 词命中 {t1_hit_rows}/{min(TOP_N, len(scored))} 条底料")
        out = M2 / f"bank_ch{ch['no']:02d}.md"
        out.write_text("\n".join(parts), encoding="utf-8")
        print(f"[bank] 第{ch['no']}章 候选{len(scored):>5} 底料"
              f"{bank_chars:>12,}字 T1命中{t1_hit_rows:>2} → {out.name}")
    print("[bank] 全部完成")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
