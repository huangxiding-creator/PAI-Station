# -*- coding: utf-8 -*-
"""dl_collect_standards — 国标/行业标准检索下载 → 战役弹药池 (1019 用户令接入产线).

调用 std-samr-gb skill 逆向客户端（免登录/免验证码）,
按战役关键词检索+批量下载标准全文 PDF → 入池 (engine=standard:samr)。
用法: py -X utf8 tools/dl_collect_standards.py --campaign EPC-DSIM --kws "设计变更,工程造价"
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
SKILL = REPO / ".claude" / "skills" / "std-samr-gb" / "scripts"
CLI = SKILL / "cli.py"
PY = sys.executable


def run_cli(*args: str, timeout: int = 1800) -> tuple[int, str]:
    cp = subprocess.run(
        [PY, "-X", "utf8", str(CLI), *args],
        capture_output=True, text=True, encoding="utf-8",
        timeout=timeout, cwd=str(SKILL))
    return cp.returncode, cp.stdout + cp.stderr


def search(kw: str) -> list[dict]:
    out_file = SKILL / f"_tmp_search_{kw[:8]}.jsonl"
    rc, out = run_cli("search", kw, "--state", "现行",
                      "--out", str(out_file))
    rows = []
    if out_file.exists():
        for ln in out_file.open(encoding="utf-8"):
            try:
                rows.append(json.loads(ln))
            except json.JSONDecodeError:
                continue
        out_file.unlink()
    return rows


def download(kw: str, out_dir: Path, limit: int = 20) -> bool:
    rc, out = run_cli("download", kw, "--dir", str(out_dir),
                      "--state", "现行", "--limit", str(limit))
    return rc == 0


def ingest_to_pool(campaign: str, out_dir: Path, max_files: int = 100) -> int:
    """下载产出台账/PDF → ammo_pool (PDF 需 pool 的 pdf 抽字支持)."""
    files = list(out_dir.rglob("*.jsonl")) + list(out_dir.rglob("*.pdf"))
    files = [f for f in files if f.name != "manifest.jsonl"][:max_files]
    ok = 0
    for f in files:
        # PDF 直接入池（pool 的 read_text_safe 支持 pdf 抽字）
        r = subprocess.run(
            [PY, "-X", "utf8", "reforge_factory/ammo_pool.py", "ingest", campaign,
             "--file", str(f), "--engine", "standard:samr", "--cred", "official"],
            capture_output=True, text=True, timeout=120, cwd=str(REPO))
        ok += r.returncode == 0
    return ok


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--kws", required=True, help="逗号分隔搜索关键词")
    ap.add_argument("--limit", type=int, default=20, help="每关键词最多下载标准数")
    ap.add_argument("--max-ingest", type=int, default=100)
    ns = ap.parse_args()

    out_base = REPO / "data" / "harvest" / "standards" / ns.campaign
    out_base.mkdir(parents=True, exist_ok=True)
    total = 0
    for kw in ns.kws.split(","):
        kw = kw.strip()
        if not kw:
            continue
        rows = search(kw)
        if not rows and len(kw) > 2:
            kw = kw[:2]  # 缩词重试（分词限制: 复合词常无结果）
            rows = search(kw)
            print(f"[samr] 缩词为「{kw}」重试")
        print(f"[samr] 「{kw}」检索命中 {len(rows)} 件现行标准")
        if not rows:
            continue
        od = out_base / kw.replace(" ", "_")
        if download(kw, od, ns.limit):
            n = ingest_to_pool(ns.campaign, od, ns.max_ingest)
            print(f"[samr] 「{kw}」入池 {n}")
            total += n
    print(f"[samr] 总入池 {total} → {ns.campaign}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
