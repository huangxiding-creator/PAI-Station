# -*- coding: utf-8 -*-
"""dl_collect_ima — ima 知识库广场收割 → 战役弹药池 (1019 用户令接入产线).

从「逆向IMA下载器」会话逆向复刻的 ima-kb-harvest skill 调用,
按战役关键词搜索广场 → 收割整库 → 入池 (engine=kb:ima_plaza)。
用法: py -X utf8 tools/dl_collect_ima.py --campaign EPC-DSIM --kws "设计管理,造价,EPC"
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(__file__).resolve().parents[1]
SKILL_SCRIPTS = REPO / ".claude" / "skills" / "ima-kb-harvest" / "scripts"
HARVEST = SKILL_SCRIPTS / "harvest.py"
PY = sys.executable


def run_harvest(*args: str) -> tuple[int, str]:
    cp = subprocess.run(
        [PY, "-X", "utf8", str(HARVEST), *args],
        capture_output=True, text=True, encoding="utf-8",
        timeout=1800, cwd=str(SKILL_SCRIPTS))
    return cp.returncode, cp.stdout + cp.stderr


def check_login() -> bool:
    rc, out = run_harvest("status")
    return "[✓]" in out


def search(kw: str, pages: int = 2) -> list[dict]:
    rc, out = run_harvest("search", kw, "--pages", str(pages))
    # 解析输出中的候选库(id/名称/简介)
    import re
    libs = []
    for m in re.finditer(r"(\w{10,25})\s*[|│]\s*(.+?)\s*[|│]\s*(.+?)(?:\n|$)", out):
        libs.append({"id": m.group(1), "name": m.group(2).strip(), "desc": m.group(3).strip()})
    return libs


def harvest(kw: str, out_dir: Path, max_kbs: int = 5, min_files: int = 3) -> bool:
    rc, out = run_harvest(
        "harvest", kw,
        "--out", str(out_dir),
        "--max-kbs", str(max_kbs),
        "--min-files", str(min_files),
        "--workers", "4",
        "--yes")
    print(out[-500:] if len(out) > 500 else out)
    return rc == 0


def ingest_to_pool(campaign: str, out_dir: Path, max_files: int = 200) -> int:
    """收割产出 md/txt → ammo_pool 入池 (engine=kb:ima_plaza)。"""
    files = []
    for ext in ("*.md", "*.txt"):
        files.extend(out_dir.rglob(ext))
    files = [f for f in files if "_raw" not in str(f) and "_index" not in str(f)][:max_files]
    ok = 0
    for f in files:
        r = subprocess.run(
            [PY, "-X", "utf8", "reforge_factory/ammo_pool.py", "ingest", campaign,
             "--file", str(f), "--engine", "kb:ima_plaza", "--cred", "research"],
            capture_output=True, text=True, timeout=120, cwd=str(REPO))
        ok += r.returncode == 0
    return ok


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--campaign", required=True)
    ap.add_argument("--kws", required=True, help="逗号分隔搜索关键词")
    ap.add_argument("--max-kbs", type=int, default=5)
    ap.add_argument("--max-ingest", type=int, default=200)
    ns = ap.parse_args()

    if not check_login():
        print("[ima] 登录态失效, 需扫码 (harvest.py login)")
        return 1

    out_base = REPO / "data" / "harvest" / "ima_plaza" / ns.campaign
    out_base.mkdir(parents=True, exist_ok=True)
    total = 0
    for kw in ns.kws.split(","):
        kw = kw.strip()
        if not kw:
            continue
        print(f"[ima] 搜索「{kw}」...")
        od = out_base / kw.replace(" ", "_")
        if harvest(kw, od, ns.max_kbs):
            n = ingest_to_pool(ns.campaign, od, ns.max_ingest)
            print(f"[ima] 「{kw}」入池 {n}")
            total += n
    print(f"[ima] 总入池 {total} → {ns.campaign}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
