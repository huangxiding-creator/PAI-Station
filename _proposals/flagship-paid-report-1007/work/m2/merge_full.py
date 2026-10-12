# -*- coding: utf-8 -*-
"""merge_full — 五卷 PDF 合并成单件 full/BLUEBOOK-2027.pdf（引擎售卖件）。

pypdf PdfWriter 逐卷 append + 卷级书签；验页数（737）与大小（<20MB 引擎墙）。
usage: PYTHONIOENCODING=utf-8 python merge_full.py
"""
import hashlib
import sys
from pathlib import Path

from pypdf import PdfReader, PdfWriter

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[2]
DIST = ROOT / "bluebook" / "dist"
OUT = Path(r"E:\AI-Station\report_platform\content\full\BLUEBOOK-2027.pdf")
VOLS = ["卷一-市场全景", "卷二-标杆企业", "卷三-区域机会", "卷四-专题实战", "卷五-独家判断"]
EXPECT_PAGES = 737
MAX_BYTES = 20 * 1024 * 1024


def main():
    w = PdfWriter()
    pages = 0
    for name in VOLS:
        r = PdfReader(str(DIST / f"{name}.pdf"))
        n = len(r.pages)
        w.append(r, outline_item=name)  # 卷级书签指向本卷首页
        print(f"{name}: {n}p @ {pages}")
        pages += n
    OUT.parent.mkdir(parents=True, exist_ok=True)
    with OUT.open("wb") as f:
        w.write(f)
    size = OUT.stat().st_size
    sha = hashlib.sha256(OUT.read_bytes()).hexdigest()[:16]
    print(f"合计 {pages}p / {format(size, ',')}B / sha256:{sha}")
    ok = pages == EXPECT_PAGES and 0 < size <= MAX_BYTES
    print("MERGE " + ("PASS" if ok else f"FAIL 期望{EXPECT_PAGES}p或超20MB墙"))
    sys.exit(0 if ok else 1)


if __name__ == "__main__":
    main()
