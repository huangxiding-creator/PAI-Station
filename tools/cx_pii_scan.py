# -*- coding: utf-8 -*-
"""PII 全盘首扫：chunks 明表 → inventory.pii_findings → 普查报告。

用法：python tools/cx_pii_scan.py
结果仅落本地库（目的边界=本人+工作；永不外发）。
"""
from __future__ import annotations

import sqlite3
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

REPO = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(REPO / "src"))

from paistation.cx.pii_scan import save_findings, scan_chunks  # noqa: E402

INDEX_DB = REPO / "data/local_index/index.db"
INV_DB = REPO / "data/local_index/inventory.db"


def main() -> int:
    chunks = sqlite3.connect(f"file:{INDEX_DB}?mode=ro", uri=True)
    n = chunks.execute("SELECT COUNT(*) FROM chunks").fetchone()[0]
    print(f"chunks {n} 行，开始 PII 普查（身份证/手机/银行卡/邮箱）…")
    t0 = time.time()
    findings = scan_chunks(chunks)
    dt = time.time() - t0
    chunks.close()
    print(f"扫描耗时 {dt/60:.1f} 分钟；命中文件 {len(findings)} 个")

    inv = sqlite3.connect(str(INV_DB))
    touched = save_findings(inv, findings)
    inv.commit()

    census: dict[str, int] = {}
    for kinds in findings.values():
        for kind, n_ in kinds.items():
            census[kind] = census.get(kind, 0) + n_
    print(f"\n== 普查总账（触达 {touched} 行）==")
    for kind, total in sorted(census.items(), key=lambda x: -x[1]):
        print(f"{kind:10s} {total}")
    print("\n== 命中最密文件 Top 10 ==")
    ranked = sorted(
        findings.items(),
        key=lambda kv: -sum(kv[1].values()))[:10]
    for path, kinds in ranked:
        top = ",".join(f"{k}×{v}" for k, v in
                       sorted(kinds.items(), key=lambda x: -x[1]))
        print(f"{sum(kinds.values()):5d}  {top:24s} {path[:66]}")
    inv.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
