"""合一指数 U（M12，PROPOSAL_V2.md 1.3）：分域可度量，不做玄学。

U = 0.35·NPI + 0.35·F_pass + 0.30·(1 - C_rate)

工程含义（提案原文）：U 是任务域级指标；每域持续上升并跨过 60 分
奇点即该域"上岗"。"合一" = 所有可能任务域的 U→1 渐进过程——
永远在逼近，从不宣布完成。零数据 → 0（诚实占位，不编造）。
快照落 11 进化/pdca/unity_<周>_<域>.json；仪表盘聚合分域+周环比。
"""
from __future__ import annotations

import json
import os
import tempfile
from datetime import datetime
from pathlib import Path

from ..organ.registry import find_by_name, organ_dir

SINGULARITY = 60          # 分域上岗线（曾鸣 60 分奇点）
_C_RATE_CAP = 5.0         # 每千字纠正次数封顶（归一分母）


def _ratio(part: float | None, total: float) -> float:
    if not total:
        return 0.0
    return max(0.0, min(1.0, (part or 0) / total))


def npi(adoption: float | None, next_hit: float | None,
        drift: float | None) -> float:
    """需求逼近指数：采纳/命中全缺 → 0（无逼近数据不编造）；
    drift 缺席只弃权自己的 0.2 权重，不补分。"""
    if adoption is None and next_hit is None:
        return 0.0
    score = 0.4 * _ratio(adoption, 1.0) + 0.4 * _ratio(next_hit, 1.0)
    if drift is not None:
        score += 0.2 * (1.0 - max(0.0, min(1.0, drift)))
    return score


def f_pass(passed: int, total: int) -> float:
    """初稿一次通过率：终稿与初稿 diff<阈值的交付占比。"""
    return _ratio(passed, total)


def c_rate(corrections: int, kchars: float) -> float:
    """纠正频率归一（每千字纠正次数 / 5 封顶）；零交付 → 1（不白给）。"""
    if not kchars:
        return 1.0
    return min(corrections / kchars, _C_RATE_CAP) / _C_RATE_CAP


def u_score(adoption, next_hit, drift, passed: int, total: int,
            corrections: int, kchars: float) -> float:
    """合一指数 U（0-1 域级标量；×100 呈现时保留两位）。"""
    return (0.35 * npi(adoption, next_hit, drift)
            + 0.35 * f_pass(passed, total)
            + 0.30 * (1.0 - c_rate(corrections, kchars)))


# ---------------------------------------------------------------- 快照

def _pdca_dir(root: Path) -> Path:
    return organ_dir(Path(root), find_by_name("进化")) / "pdca"


def save_snapshot(root: Path, domain: str, u: float, components: dict,
                  now: datetime | None = None) -> Path:
    """分域周快照：unity_<ISO周>_<域>.json（原子写，幂等覆盖当周）。"""
    now = now or datetime.now()
    iso = now.isocalendar()
    week = f"{iso[0]}-W{iso[1]:02d}"
    row = {"domain": domain, "u": round(float(u), 4),
           "components": dict(components), "iso_week": week,
           "date": now.strftime("%Y-%m-%d")}
    path = _pdca_dir(root) / f"unity_{week}_{domain}.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    fd, tmp = tempfile.mkstemp(dir=str(path.parent), suffix=".tmp")
    try:
        with os.fdopen(fd, "w", encoding="utf-8") as fh:
            json.dump(row, fh, ensure_ascii=False, indent=1)
        os.replace(tmp, path)
    finally:
        if os.path.exists(tmp):
            os.unlink(tmp)
    return path


def load_snapshots(root: Path) -> list[dict]:
    """读全部快照（坏行跳过），按 (域, 周) 排序。"""
    folder = _pdca_dir(root)
    if not folder.exists():
        return []
    rows = []
    for path in sorted(folder.glob("unity_*.json")):
        try:
            rows.append(json.loads(path.read_text(encoding="utf-8")))
        except (OSError, json.JSONDecodeError):
            continue
    return sorted(rows, key=lambda r: (r.get("domain", ""),
                                       r.get("iso_week", "")))


# ---------------------------------------------------------------- 仪表盘

def dashboard(root: Path) -> str:
    """分域仪表盘：最新 U + 周环比 + 60 分奇点上岗标记。"""
    rows = load_snapshots(root)
    if not rows:
        return "【合一指数 U】暂无快照——本周尚无交付数据（零数据不编造）"
    latest: dict[str, dict] = {}
    for row in rows:                      # 排序后后者覆盖 → 每域最新
        latest[row["domain"]] = row
    lines = ["【合一指数 U 仪表盘】"]
    for domain, row in sorted(latest.items()):
        history = [r for r in rows if r["domain"] == domain]
        delta = ""
        if len(history) >= 2:
            diff = round(history[-1]["u"] - history[-2]["u"])
            delta = f"（{'↑' if diff >= 0 else '↓'}{abs(diff)}）"
        score = round(row["u"])
        badge = "　★已上岗" if score >= SINGULARITY else ""
        lines.append(f"- {domain}：U {score}{delta}{badge}")
        comp = row.get("components", {})
        if comp:
            parts = " ".join(f"{k}={v:.2f}" for k, v in comp.items()
                             if isinstance(v, (int, float)))
            if parts:
                lines.append(f"  {parts}")
    return "\n".join(lines)
