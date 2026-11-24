# -*- coding: utf-8 -*-
"""book_merge — 通用全书总装器 (1124 用户令 ②: 编排器依赖件, 参数化灭错拷).

_ch00_daolun + _ch01..12_final → out/REPORT_FULL.md → docx → 排版版 → PDF → manifest.
用法: py -X utf8 tools/book_merge.py --campaign-dir work/m2/f176d --title 《书名》 --campaign EPC-XX [--allow-partial]
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
TOOLS = REPO / "tools"
CJK_GATE = 200_000


def cjk_len(t: str) -> int:
    return len(re.findall(r"[一-鿿]", t))


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign-dir", required=True)
    ap.add_argument("--title", required=True)
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--version-date", default="2026-11")
    ap.add_argument("--allow-partial", action="store_true")
    ns = ap.parse_args()

    sched = REPO / ns.campaign_dir / "sched"
    out = sched / "out"
    out.mkdir(exist_ok=True)
    daolun = sched / "_ch00_daolun.md"
    parts = [f"# {ns.title}", "", "出品：总包创研院研究团队", ""]
    if daolun.is_file():
        parts.append(daolun.read_text(encoding="utf-8").rstrip() + "\n")
    missing, cjk_total = [], 0
    for nn in [f"{i:02d}" for i in range(1, 13)]:
        f = sched / f"_ch{nn}_final.md"
        if not f.is_file():
            missing.append(nn)
            continue
        t = f.read_text(encoding="utf-8", errors="replace")
        cjk_total += cjk_len(t)
        parts.append(t.rstrip() + "\n")
    book = "\n".join(parts)
    book_cjk = cjk_len(book)
    print(f"[merge] 章:{len(nos) - len(missing)}/{len(nos)} 缺:{missing or '无'} 全书 {book_cjk:,} CJK")
    if missing and not ns.allow_partial:
        print(f"[merge] 缺章 {missing} — 拒绝总装")
        return 1
    if book_cjk < CJK_GATE:
        print(f"[merge] 全书 CJK {book_cjk:,} < {CJK_GATE:,} — 拒绝")
        return 1
    book_md = out / "REPORT_FULL.md"
    book_md.write_text(book, encoding="utf-8")
    docx = book_md.with_suffix(".docx")
    r1 = subprocess.run([sys.executable, "-X", "utf8", str(TOOLS / "report_to_docx.py"),
                         str(book_md), str(docx)], capture_output=True, text=True,
                        encoding="utf-8", errors="replace", timeout=1800)
    if r1.returncode != 0 or not docx.exists():
        print(f"[finalize] docx 失败: {(r1.stderr or '')[-300:]}")
        return 1
    r2 = subprocess.run([sys.executable, "-X", "utf8", str(TOOLS / "docx_paiban.py"),
                         str(docx), "--out", str(book_md.with_name(book_md.stem + "_排版版.docx")),
                         "--pdf"], capture_output=True, text=True, encoding="utf-8",
                        errors="replace", timeout=3600)
    print(("[finalize] " + ("✓ " if r2.returncode == 0 else "✗ ")) + (r2.stdout or "")[-200:])
    if r2.returncode != 0:
        return 2
    sha = hashlib.sha256(book_md.read_bytes()).hexdigest()[:16]
    (out / "s3_run_manifest.json").write_text(json.dumps({
        "ts": time.strftime("%Y-%m-%d %H:%M:%S"), "campaign": ns.campaign,
        "title": ns.title, "version_date": ns.version_date,
        "merge": {"sha256_16": sha, "cjk_total": book_cjk, "chapters": len(nos) - len(missing),
                  "missing": missing, "mode": "interim" if missing else "passthrough"},
    }, ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[manifest] sha16={sha}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
