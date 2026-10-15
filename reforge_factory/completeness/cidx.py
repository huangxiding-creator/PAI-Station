# -*- coding: utf-8 -*-
"""CIdx 完备度指数 + 五轴账本汇聚 (T-008 / REQ-020 / KB-COMPLETENESS-SPEC).

公式 (KB-COMPLETENESS-SPEC 首创口径, 原文在案):
  CIdx = 0.25·T覆 + 0.20·B覆 + 0.20·D覆 + 0.20·P均深归一 + 0.15·C覆
    T覆       = 有证据年数/(总年数-豁免年数)           ← T_axis.json (entity_timeline)
    B覆       = 点亮面数/十面                          ← B_axis.json (coverage_facets)
    D覆       = (未降级维 + 0.5×降级维)/九维, 缺格计 0 ← D_axis.json (dimension_matrix)
    P均深归一 = Σ(L级×EEI数)/(5×EEI总数), L0=0        ← P_axis.json (depth_ladder)
    C覆       = 命中渠道/在役渠道                      ← C_axis.json (channel_matrix)
  各分项保留 4 位小数; CIdx 由 4dp 分项加权后同样 4dp。

缺轴 → 该轴 unknown 计 0 分并记 missing_axes (坏 JSON 同口径);
字段缺/类型坏 → fail-soft 计 0 不炸 (轴文件仍在, 不进 missing_axes)。
全 green 判定 all_green_or_waived: 每轴 green=true **或** 显式豁免
(轴 payload 带 waived/waiver 真值; KB 口径「含显式豁免/降级/队列转化的轴」中
 降级/队列转化已并入各轴传感器自己的 green, 此处只补轴级人工豁免)。

账本 (真实池只增不删, 只追加 completeness_ledger.jsonl, 不覆盖轴文件):
  ammo_pool/<战役>/completeness_ledger.jsonl 每次 assemble 追加 6 行 ——
  五轴行 {"axis","ts","sensor","score","green","waived","missing","note"}
  + 汇总行 {"axis":"CIdx","ts","campaign","axis_scores","cidx","all_green",
            "missing_axes","waived_axes","weights","formula"}。
  每行都带 axis 字段 (REQ-020.AC1 五轴各≥1 条记录的机读口径)。

CLI:
  py reforge_factory/completeness/cidx.py --campaign EPC-BID26 [--json]
      [--ammo-root DIR] [--ledger PATH] [--dry-run]
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"

#: 五轴固定顺序 (账本行序/axis_scores 键序一致)
AXES = ("T", "B", "D", "P", "C")
#: KB-COMPLETENESS-SPEC 权重 (和为 1.00)
WEIGHTS = {"T": 0.25, "B": 0.20, "D": 0.20, "P": 0.20, "C": 0.15}
FORMULA = "0.25·T覆+0.20·B覆+0.20·D覆+0.20·P均深归一+0.15·C覆"

#: 轴 → 传感器名 (对账用; 实际以轴件 payload.sensor 为准, 此表兜底)
AXIS_SENSORS = {"T": "entity_timeline", "B": "coverage_facets",
                "D": "dimension_matrix", "P": "depth_ladder",
                "C": "channel_matrix"}

#: B 轴固定十分面 (KB 口径: 点亮面数/十面, 非除以 len(facets))
B_FACET_TOTAL = 10
#: D 轴固定九维 (KB 口径: /九维)
D_DIM_TOTAL = 9
#: P 轴深度满分 5 (L5)
P_LEVEL_MAX = 5

_MISSING_FILE = "轴文件缺席"
_MISSING_JSON = "轴文件非合法 JSON"


def _r4(x: float) -> float:
    """统一 4 位小数 (负值/NaN 防御归 0)."""
    try:
        v = round(float(x), 4)
    except (TypeError, ValueError):
        return 0.0
    if v != v or v < 0:  # NaN 或负
        return 0.0
    return min(v, 1.0) if v > 1.0 else v


# ---------- 五覆纯函数 (入参 payload dict, 无 IO) --------------------------

def score_t(payload: dict) -> float:
    """T覆 = 有证据年数/(总年数-豁免年数).

    总年数 = current_year-founded_year+1 (缺则退化用 year_counts 年份跨度);
    豁免年数 = len(gap_waivers) (REQ-021 显式豁免登记, 只免分母不免证据)。
    分母 ≤0 → fail-soft 0。
    """
    if not isinstance(payload, dict):
        return 0.0
    counts = payload.get("year_counts")
    if not isinstance(counts, dict) or not counts:
        return 0.0
    try:
        evidence = sum(1 for v in counts.values()
                       if isinstance(v, (int, float)) and v > 0)
    except Exception:
        return 0.0

    total = 0
    try:
        founded, current = payload.get("founded_year"), payload.get("current_year")
        if isinstance(founded, int) and isinstance(current, int) \
                and current >= founded:
            total = current - founded + 1
        else:
            years = [int(k) for k in counts if str(k).lstrip("-").isdigit()]
            total = (max(years) - min(years) + 1) if years else 0
    except Exception:
        total = 0

    waivers = payload.get("gap_waivers")
    waived_n = len(waivers) if isinstance(waivers, list) else 0
    denom = total - waived_n
    if denom <= 0:
        return 0.0
    return _r4(min(evidence / denom, 1.0))


def score_b(payload: dict) -> float:
    """B覆 = 点亮面数/十面 (lit_count 优先, 缺则数 facets 里 lit=True 的面)."""
    if not isinstance(payload, dict):
        return 0.0
    lit = payload.get("lit_count")
    if not isinstance(lit, int) or lit < 0:
        facets = payload.get("facets")
        lit = (sum(1 for f in facets.values()
                   if isinstance(f, dict) and f.get("lit") is True)
               if isinstance(facets, dict) else 0)
    return _r4(min(lit / B_FACET_TOTAL, 1.0))


def score_d(payload: dict) -> float:
    """D覆 = (未降级维 + 0.5×降级维)/九维; 缺格维 (open_gaps/无格) 计 0."""
    if not isinstance(payload, dict):
        return 0.0
    dims = payload.get("dims")
    cells = payload.get("cells")
    if not isinstance(dims, list) or not dims:
        dims = list(cells) if isinstance(cells, dict) else []
        if not dims:
            return 0.0
    if not isinstance(cells, dict):
        return 0.0
    gaps = payload.get("open_gaps")
    gaps = {str(g) for g in gaps} if isinstance(gaps, list) else set()
    weight = 0.0
    for d in dims:
        if str(d) in gaps:
            continue  # 缺格计 0 (即使格子同时标了 downgraded, 缺格优先)
        cell = cells.get(d)
        if not isinstance(cell, dict):
            continue
        weight += 0.5 if cell.get("downgraded") else 1.0
    return _r4(weight / D_DIM_TOTAL)


def score_p(payload: dict) -> float:
    """P均深归一 = Σ(L级×EEI数)/(5×EEI总数), L0=0.

    分母用 eei_total 字段 (question_tree 实际生成数口径); l_dist 缺席时
    兜底采用传感器算好的 mean_depth_norm; 两者皆缺 → 0 (fail-soft)。
    """
    if not isinstance(payload, dict):
        return 0.0
    dist = payload.get("l_dist")
    total = payload.get("eei_total")
    if isinstance(dist, dict) and dist:
        if not isinstance(total, int) or total <= 0:
            total = sum(v for v in dist.values()
                        if isinstance(v, (int, float)))
        if isinstance(total, int) and total > 0:
            s = 0
            for lv, n in dist.items():
                try:
                    s += int(str(lv)[1:]) * n
                except (ValueError, TypeError):
                    continue
            return _r4(s / (P_LEVEL_MAX * total))
    mdn = payload.get("mean_depth_norm")
    if isinstance(mdn, (int, float)):
        return _r4(mdn)
    return 0.0


def score_c(payload: dict) -> float:
    """C覆 = 命中渠道/在役渠道 (channels_hit/channels_total 重算, 4dp)."""
    if not isinstance(payload, dict):
        return 0.0
    hit, total = payload.get("channels_hit"), payload.get("channels_total")
    if not (isinstance(hit, int) and isinstance(total, int)) or total <= 0:
        return 0.0
    return _r4(min(hit / total, 1.0))


SCORERS = {"T": score_t, "B": score_b, "D": score_d, "P": score_p, "C": score_c}


def compute_cidx(axis_scores: dict) -> float:
    """CIdx = Σ(权重×4dp 分项), 再 4dp. 缺轴按 0 计."""
    return _r4(sum(WEIGHTS[a] * axis_scores.get(a, 0.0) for a in AXES))


def _is_waived(payload) -> bool:
    """轴级显式豁免: payload 带 waived/waiver 真值 (bool 或非空串/dict)."""
    if not isinstance(payload, dict):
        return False
    for key in ("waived", "waiver"):
        v = payload.get(key)
        if v is True:
            return True
        if isinstance(v, str) and v.strip():
            return True
        if isinstance(v, dict) and v:
            return True
    return False


# ---------- 汇聚 + 账本 ----------------------------------------------------

def _load_axis(path: Path):
    """读轴件 → (payload|None, note). None = 缺轴 (文件无/坏 JSON)."""
    if not path.is_file():
        return None, _MISSING_FILE
    try:
        return json.loads(path.read_text(encoding="utf-8")), ""
    except Exception:
        return None, _MISSING_JSON


def assemble(campaign: str, *, pool_root: Path | str | None = None,
             ledger_path: Path | str | None = None, write: bool = True) -> dict:
    """读五轴 json → 算五覆 + CIdx → 追加账本 6 行 (write=True).

    只增不删: 轴文件只读; 账本 append 模式追加, 永不覆盖。
    """
    root = Path(pool_root) if pool_root else DEFAULT_AMMO_ROOT
    cdir = root / campaign / "completeness"
    ts = datetime.now().astimezone().isoformat(timespec="seconds")

    axis_scores: dict[str, float] = {}
    axis_green: dict[str, bool] = {}
    axis_waived: dict[str, bool] = {}
    missing_axes: list[str] = []
    rows: list[dict] = []

    for axis in AXES:
        payload, note = _load_axis(cdir / f"{axis}_axis.json")
        missing = payload is None
        if missing:
            missing_axes.append(axis)
            axis_scores[axis] = 0.0
            axis_green[axis] = False
            axis_waived[axis] = False
        else:
            try:
                axis_scores[axis] = SCORERS[axis](payload)
            except Exception:  # 未知结构防御: fail-soft 计 0
                axis_scores[axis] = 0.0
            green = payload.get("green") is True if isinstance(payload, dict) else False
            axis_green[axis] = green
            axis_waived[axis] = _is_waived(payload)
        sensor = (payload or {}).get("sensor") if isinstance(payload, dict) else None
        rows.append({
            "ts": ts, "axis": axis,
            "sensor": sensor or AXIS_SENSORS[axis],
            "score": axis_scores[axis], "green": axis_green[axis],
            "waived": axis_waived[axis], "missing": missing, "note": note,
        })

    waived_axes = [a for a in AXES if axis_waived[a]]
    # 全 green 判定 all_green_or_waived: 每轴 green 或 waived (缺轴两者皆非)
    all_green = all(axis_green[a] or axis_waived[a] for a in AXES)
    cidx_v = compute_cidx(axis_scores)

    summary = {
        "ts": ts, "axis": "CIdx", "campaign": campaign,
        "axis_scores": {a: axis_scores[a] for a in AXES},
        "cidx": cidx_v, "all_green": all_green,
        "missing_axes": missing_axes, "waived_axes": waived_axes,
        "weights": dict(WEIGHTS), "formula": FORMULA,
    }
    rows.append(summary)

    ledger = Path(ledger_path) if ledger_path else \
        root / campaign / "completeness_ledger.jsonl"
    if write:
        ledger.parent.mkdir(parents=True, exist_ok=True)
        with ledger.open("a", encoding="utf-8", newline="\n") as fh:
            for row in rows:
                fh.write(json.dumps(row, ensure_ascii=False) + "\n")

    out = dict(summary)
    out["axis_rows"] = rows[:len(AXES)]
    out["ledger"] = str(ledger) if write else None
    return out


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="CIdx 完备度指数 + 五轴账本汇聚 (只读轴件, 只追加账本)")
    ap.add_argument("--campaign", required=True, help="战役名, 如 EPC-BID26")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根 (默认仓库默认)")
    ap.add_argument("--ledger", default=None, help="completeness_ledger.jsonl 路径覆盖")
    ap.add_argument("--json", action="store_true", help="输出完整 JSON (默认摘要行)")
    ap.add_argument("--dry-run", action="store_true", help="只算不落账本")
    args = ap.parse_args(argv)

    try:
        out = sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass

    res = assemble(args.campaign, pool_root=args.ammo_root,
                   ledger_path=args.ledger, write=not args.dry_run)

    if args.json:
        print(json.dumps(res, ensure_ascii=False))
    else:
        sc = res["axis_scores"]
        parts = " ".join(f"{a}覆={sc[a]:.4f}" for a in AXES)
        print(f"[CIdx] {args.campaign}: {parts}")
        print(f"[CIdx] CIdx={res['cidx']:.4f}  all_green={res['all_green']}"
              f"  missing={res['missing_axes']}  waived={res['waived_axes']}")
        print(f"[CIdx] 账本 {'追加 ' + res['ledger'] if res['ledger'] else '未落盘(dry-run)'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
