# -*- coding: utf-8 -*-
"""corps_pool_ingest — Manus 军团产出 → 任意战役池通用入库器 (1019 全工厂共享令).

解除 EPC49 专属绑定: 扫 Auto_Manus/data/ 军团蒸馏/收割件,
按战役关键词分流入池 (engine=manus:corps)。幂等。
用法: py -X utf8 tools/corps_pool_ingest.py --campaign EPC-DSIM [--max 200]
"""
from __future__ import annotations

import argparse
import json
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
AUTO = REPO / "Auto_Manus" / "data"

# 军团产出目录(蒸馏件/收割件)
SOURCES = [
    AUTO / "distilled",       # 蒸馏件
    AUTO / "harvest",         # 收割件
    AUTO / "corps_v3_out",    # v3 产出
]


def find_files(max_n: int) -> list[Path]:
    out = []
    for src in SOURCES:
        if not src.is_dir():
            continue
        for f in sorted(src.rglob("*.md")):
            out.append(f)
            if len(out) >= max_n:
                return out
    return out


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--max", type=int, default=200)
    ns = ap.parse_args()
    files = find_files(ns.max)
    if not files:
        print("[corps] 无军团产出件（HALTED 或目录空）")
        return 1
    print(f"[corps] 可用件 {len(files)}")
    ok = 0
    for f in files:
        r = subprocess.run(
            [sys.executable, "-X", "utf8", "reforge_factory/ammo_pool.py",
             "ingest", ns.campaign, "--file", str(f),
             "--engine", "manus:corps", "--cred", "research"],
            capture_output=True, text=True, timeout=120, cwd=str(REPO))
        ok += r.returncode == 0
    print(f"[corps] 入池 {ok}/{len(files)} → {ns.campaign}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
