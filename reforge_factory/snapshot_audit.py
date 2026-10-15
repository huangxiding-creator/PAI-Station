# -*- coding: utf-8 -*-
"""snapshot_audit — REQ-044.AC1 存档快照增量审计器 (只读扫描, 只增不删).

判据 (REQUIREMENTS REQ-044 / METHODOLOGY §三.2 Bellingcat 取证链):
  judge 判 valid 的**增量**行 (行 ts 日期界 > --since; 生效日当天=存量基线
  豁免 — 口径与 ammo_pool.is_snapshot_incremental 同源) 必须 100% 带存档
  快照三字段 (snapshot_hash / snapshot_ts / snapshot_url) 且快照体在盘.

分桶:
  covered = 三字段齐 ∧ 快照体在盘 (内容模式=战役目录内相对路径;
            指针模式=本地原文件路径)
  pending = snapshot_pending=true → 单列豁免 (judge fail-soft, 不计缺)
  missing = 非 pending 未覆盖 (字段缺 / 快照体丢) → 有缺
exit 0 = 非 pending 覆盖 100% | 2 = 有缺 | 1 = 池/manifest 不可读

用法:
  py reforge_factory/snapshot_audit.py [--campaign EPC-BID26]
                                       [--since 2026-10-15]
                                       [--pool-root E:\\AI-Station\\ammo_pool]
"""
from __future__ import annotations

import argparse
import json
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
from ammo_pool import is_snapshot_incremental    # noqa: E402  口径同源

if sys.stdout:                                     # pythonw 无控制台守卫 (同 ammo_pool)
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
SINCE_DEFAULT = "2026-10-15"     # REQ-044 W0 生效日 (与 gates.effective_date 同值)


def _artifact_path(camp_dir: Path, url: str) -> Path:
    """快照体定位: snapshots/ 前缀=战役目录内相对路径, 否则视为本地文件指针."""
    return camp_dir / url if url.startswith("snapshots/") else Path(url)


def audit_campaign(camp_dir: Path, since: str) -> dict | None:
    """单战役扫描 (纯读): manifest 缺失返回 None, 否则返回分桶报告."""
    mp = camp_dir / "manifest.jsonl"
    if not mp.is_file():
        return None
    rep = {"campaign": camp_dir.name, "incremental_valid": 0, "covered": 0,
           "pending": 0, "missing": 0, "artifact_missing": 0,
           "fields": {"hash": 0, "ts": 0, "url": 0}}
    for ln in mp.read_text(encoding="utf-8").splitlines():
        if not ln.strip():
            continue
        try:
            r = json.loads(ln)
        except json.JSONDecodeError:
            continue                          # 坏行不炸审计, 也不计数
        if r.get("judge") != "valid":
            continue
        if not is_snapshot_incremental(r.get("ts", ""), since):
            continue                          # 存量基线豁免
        rep["incremental_valid"] += 1
        for k, key in (("hash", "snapshot_hash"), ("ts", "snapshot_ts"),
                       ("url", "snapshot_url")):
            if str(r.get(key) or ""):
                rep["fields"][k] += 1
        if r.get("snapshot_pending"):
            rep["pending"] += 1               # fail-soft 单列, 不计缺
            continue
        if not all(str(r.get(k) or "") for k in
                   ("snapshot_hash", "snapshot_ts", "snapshot_url")):
            rep["missing"] += 1
            continue
        if _artifact_path(camp_dir, str(r["snapshot_url"])).is_file():
            rep["covered"] += 1
        else:
            rep["missing"] += 1               # 字段在但体丢 = 引用失锚
            rep["artifact_missing"] += 1
    return rep


def run_audit(pool_root: Path, campaign: str, since: str) -> tuple[list[dict], int]:
    """执行审计: 返回 (逐战役报告, exit 码). 0=非 pending 100% 覆盖 /
    2=有缺 / 1=指定池不可读. campaign 为空=全池."""
    if campaign:
        dirs = [pool_root / campaign]
        if not (pool_root / campaign / "manifest.jsonl").is_file():
            print(f"[snap-audit] ✗ 池或 manifest 不存在: {campaign}",
                  file=sys.stderr)
            return [], 1
    else:
        dirs = sorted(p for p in pool_root.iterdir()
                      if p.is_dir() and (p / "manifest.jsonl").is_file())
    reports: list[dict] = []
    for d in dirs:
        rep = audit_campaign(d, since)
        if rep is not None:
            reports.append(rep)
    code = 2 if any(r["missing"] for r in reports) else 0
    return reports, code


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="REQ-044.AC1 存档快照增量审计 (valid 行 100% 带快照)")
    ap.add_argument("--campaign", default="",
                    help="campaign_id (缺省=全池逐战役扫描)")
    ap.add_argument("--since", default=SINCE_DEFAULT,
                    help=f"cutoff 日期 (默认 W0 生效日 {SINCE_DEFAULT})")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    args = ap.parse_args(argv)
    reports, code = run_audit(Path(args.pool_root), args.campaign, args.since)
    tot_iv = tot_np = tot_cov = tot_pend = tot_miss = tot_art = 0
    for r in reports:
        non_pend = r["covered"] + r["missing"]        # 分母=非 pending 行
        pct = 100.0 * r["covered"] / non_pend if non_pend else 100.0
        print(f"[snap-audit] {r['campaign']}: 增量valid {r['incremental_valid']:,} "
              f"| 覆盖 {r['covered']:,} ({pct:.1f}%) "
              f"| pending {r['pending']:,} (单列) | 缺 {r['missing']:,}"
              + (f" (含快照体丢 {r['artifact_missing']:,})"
                 if r["artifact_missing"] else ""))
        tot_iv += r["incremental_valid"]
        tot_np += non_pend
        tot_cov += r["covered"]
        tot_pend += r["pending"]
        tot_miss += r["missing"]
        tot_art += r["artifact_missing"]
    pct = 100.0 * tot_cov / tot_np if tot_np else 100.0
    print(f"[snap-audit] 合计 (since>{args.since}): 增量valid {tot_iv:,} | "
          f"覆盖 {tot_cov:,} ({pct:.1f}%) | pending {tot_pend:,} (单列) | "
          f"缺 {tot_miss:,}" + (f" (含快照体丢 {tot_art:,})" if tot_art else ""))
    print(f"[snap-audit] 判定: {'✅ 非 pending 覆盖 100% (REQ-044.AC1 PASS)' if code == 0 else '⛔ 有缺 (REQ-044.AC1 FAIL)'}")
    return code


if __name__ == "__main__":
    sys.exit(main())
