# -*- coding: utf-8 -*-
"""jes2_merge — 第21份(EPC-JES2) 全书总装: _ch00_daolun + _ch01..12_final → out/REPORT_FULL.md
      + 专业排版全链 (report_to_docx → docx_paiban → PDF), 照 LUMPSUM/HANDOV S3 配方.
缺章时拒绝总装(--allow-partial 可出 interim 统计); CJK 门槛 200,000.
用法: py -X utf8 jes2_merge.py [--allow-partial]
"""
from __future__ import annotations

import json
import re
import subprocess
import sys
import time
from pathlib import Path

HERE = Path(__file__).resolve().parent
SCHED = HERE / "sched"
OUT = SCHED / "out"
OUT.mkdir(exist_ok=True)
REPO = HERE.parents[4]  # E:/AI-Station (ess→m2→work→flagship-paid-report-1007→_proposals→AI-Station)
TOOLS = REPO / "tools"
CJK_GATE = 200_000
TITLE = "《建工司法解释二逐条实务与多立场应对实战研究报告》"
CAMPAIGN = "EPC-JES2"


def cjk_len(t: str) -> int:
    return len(re.findall(r"[\u4e00-\u9fff]", t))


def finalize(book_md: Path) -> int:
    """1022 宪法令: 合并完成后必须专业排版 — 自动串 docx→排版→PDF 全链."""
    docx = book_md.with_suffix(".docx")
    r1 = subprocess.run(
        [sys.executable, "-X", "utf8",
         str(TOOLS / "report_to_docx.py"), str(book_md), str(docx)],
        capture_output=True, text=True, encoding="utf-8",
        errors="replace", timeout=1800)
    if r1.returncode != 0 or not docx.exists():
        print(f"[finalize] ✗ docx 生成失败: {(r1.stderr or '')[-300:]}")
        return 1
    print(f"[finalize] docx ✓ {docx.stat().st_size:,}B")
    r2 = subprocess.run(
        [sys.executable, "-X", "utf8",
         str(TOOLS / "docx_paiban.py"), str(docx),
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
    parts = [f"# {TITLE}", "",
             "出品：总包创研院研究团队", "",
             (SCHED / "_ch00_daolun.md").read_text(encoding="utf-8").rstrip() + "\n"]
    missing, cjk_total = [], 0
    for nn in [str(i).zfill(2) for i in range(1, 13)]:
        f = SCHED / f"_ch{nn}_final.md"
        if not f.is_file():
            missing.append(nn)
            continue
        t = f.read_text(encoding="utf-8", errors="replace")
        cjk_total += cjk_len(t)
        parts.append(t.rstrip() + "\n")
    daolun_cjk = cjk_len((SCHED / "_ch00_daolun.md").read_text(encoding="utf-8"))
    book = "\n".join(parts)
    book_cjk = cjk_len(book)
    print(f"[merge] 章:{12 - len(missing)}/12 缺:{missing or '无'} "
          f"章CJK {cjk_total:,} + 导言 {daolun_cjk:,} = 全书 {book_cjk:,}")
    if missing and not allow_partial:
        print(f"[merge] 缺章 {missing} — 拒绝总装 (--allow-partial 可出interim)")
        return 1
    if book_cjk < CJK_GATE:
        print(f"[merge] 全书 CJK {book_cjk:,} < 门 {CJK_GATE:,} — 拒绝")
        return 1
    book_md = OUT / "REPORT_FULL.md"
    book_md.write_text(book, encoding="utf-8")
    print(f"[merge] ✓ {book_md} ({book_md.stat().st_size:,}B)")
    t0 = time.time()
    rc = finalize(book_md)
    print(f"[finalize] elapsed {time.time() - t0:.0f}s rc={rc}")
    if rc == 0:
        import hashlib
        sha = hashlib.sha256(book_md.read_bytes()).hexdigest()[:16]
        man = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"), "campaign": CAMPAIGN,
               "title": TITLE, "version_date": "2026-11",
               "merge": {"sha256_16": sha, "cjk_total": book_cjk,
                         "chapters": 12 - len(missing), "missing": missing,
                         "mode": "interim" if missing else "passthrough"}}
        (OUT / "s3_run_manifest.json").write_text(
            json.dumps(man, ensure_ascii=False, indent=1), encoding="utf-8")
        print(f"[manifest] ✓ sha16={sha}")
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
