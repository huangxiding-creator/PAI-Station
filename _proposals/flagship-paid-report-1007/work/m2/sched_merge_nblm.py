# -*- coding: utf-8 -*-
"""sched_merge_nblm — SCHED 全书总装(NB版): nblm_out 编辑稿 → REPORT_FULL_NB.md.

部件: _ch00_daolun.md(导言) + nblm_out/ch01..12_编辑稿.md(NB铁律章稿)
      + chZ.md(结语) + chA.md(附录)。
缺章时拒绝总装(--allow-partial 可出 interim 统计); CJK 门槛 200,000。
用法: py -X utf8 sched_merge_nblm.py [--allow-partial]
"""
from __future__ import annotations

import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
M2 = Path(__file__).resolve().parent
SCHED = M2 / "sched"
OUT = SCHED / "nblm_out"
CJK_GATE = 200_000


def finalize(book_md: Path) -> int:
    """1022 宪法令: 合并完成后必须专业排版 — 自动串 docx→排版→PDF 全链.
    md → report_to_docx → docx_paiban(通用件, 研报预设) → Word COM PDF."""
    import subprocess
    docx = book_md.with_suffix(".docx")
    r1 = subprocess.run(
        [sys.executable, "-X", "utf8",
         str(REPO / "tools" / "report_to_docx.py"), str(book_md), str(docx)],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=1800)
    if r1.returncode != 0 or not docx.exists():
        print(f"[finalize] ✗ docx 生成失败: {(r1.stderr or '')[-200:]}")
        return 1
    print(f"[finalize] docx ✓ {docx.stat().st_size:,}B")
    r2 = subprocess.run(
        [sys.executable, "-X", "utf8",
         str(REPO / "tools" / "docx_paiban.py"), str(docx),
         "--out", str(book_md.with_name(book_md.stem + "_排版版.docx")),
         "--pdf"],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=3600)
    tail = (r2.stdout or "")[-300:]
    print(("[finalize] " + ("✓ " if r2.returncode == 0 else "✗ ")) + tail)
    return 0 if r2.returncode == 0 else 2


def main() -> int:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    allow_partial = "--allow-partial" in sys.argv
    parts: list[Path] = [SCHED / "_ch00_daolun.md"]
    missing = []
    for i in range(1, 13):
        p = OUT / f"ch{i:02d}_编辑稿.md"
        if not p.is_file() or p.stat().st_size < 20000:
            missing.append(i)
        parts.append(p)
    parts += [SCHED / "chZ.md", SCHED / "chA.md"]
    if missing and not allow_partial:
        print(f"[merge] 缺编辑稿章: {missing} — 拒绝总装(可用 --allow-partial 看interim)")
        return 1
    full = []
    for i, p in enumerate(parts):
        if not p.is_file():
            continue
        t = p.read_text(encoding="utf-8")
        t = re.sub(r"\n（校：[^）]*）\n", "\n", t)
        full.append(t.strip())
    text = "\n\n---\n\n".join(full) + "\n"
    dst = SCHED / "REPORT_FULL_NB.md"
    dst.write_text(text, encoding="utf-8")
    cjk = len(re.findall(r"[一-鿿]", text))
    status = "✅过门" if cjk >= CJK_GATE else f"❌未过门(差{CJK_GATE-cjk:,})"
    if missing:
        status += f" | interim缺章{missing}"
    print(f"[merge] {dst.name} 落盘 {dst.stat().st_size:,}B | 全书CJK {cjk:,} {status}")
    if missing:
        return 1
    # 1022 宪法令: 合并完成→专业排版硬门 (过 CJK 门后自动全链)
    if '--no-finalize' not in sys.argv:
        rc = finalize(dst)
        if rc != 0:
            print('[merge] ⚠️ 排版链未全绿 — 成书在但排版门未过, 勿上架')
            return 3
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
