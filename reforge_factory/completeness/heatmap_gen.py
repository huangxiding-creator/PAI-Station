# -*- coding: utf-8 -*-
"""完备性热图生成 (T-009 / REQ-025 / KB-COMPLETENESS-SPEC).

render(campaign, out_dir) →
  读 ammo_pool/<战役>/completeness_ledger.jsonl 最新 CIdx 行 (账本权威, 分数以账本为准)
  + completeness/{T,B,D,P,C}_axis.json 五轴传感器格数据 (逐格只读)
  → markdown 热图 + 同内容 json 双落盘 <out_dir>/heatmap_<战役>.{md,json};
  默认 out_dir = ResearchFactory-Eng/06 迭代优化/百倍V3_极致调研变现计划/work/。
  末行固定「呈批件·S1.5」(REQ-025 三合一呈批件的热图件)。

字符图例 (icon+状态文字成对, 色名仅注记 — dataviz status 口径, 色不单独承载语义):
  ● 点亮      good 绿     #0ca30c
  ◐ 降级/豁免/队列转化  warning 琥珀 #fab219
  ○ 缺格/空窗/未点亮   critical 红  #d03b3b
  ◌ unknown (轴文件缺席)  muted 灰   #898781

逐格判定 (与 cidx.py 五覆口径同源):
  T 时间轴: 年证据>0→●; 零证据且在 gap_waivers→◐; 零证据→○
  B 十面:  lit=True→●; 提及未点亮 (evidence>0 或 best_depth≥L1)→◐; 其余→○
  D 九维:  open_gaps/无格→○(缺格优先于降级); downgraded→◐; 其余→●
  P 深度阶梯: L1-L5 各级 l_dist>0→●, =0→○ (L0 计入摘要不占格)
  C 渠道:  命中→●; 未命中且在 miss_in_queue→◐(建渠队列); 其余→○

纪律: 池内文件只读 (缺账本时 cidx.assemble(write=False) 现算回退, 不落池);
      输出只增 (只写 work/ 下自己的 heatmap_*.{md,json}, 不碰其他文件)。

CLI:
  py reforge_factory/completeness/heatmap_gen.py --campaign EPC-BID26 \
      [--out-dir DIR] [--ammo-root DIR] [--ledger PATH] [--json] [--no-write]
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime
from pathlib import Path

try:  # 包内导入 (tests / 同包引用)
    from . import cidx
except ImportError:  # 直跑脚本: py reforge_factory/completeness/heatmap_gen.py
    sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
    from completeness import cidx  # noqa: E402

REPO_ROOT = Path(__file__).resolve().parents[2]
DEFAULT_OUT_DIR = REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化" \
    / "百倍V3_极致调研变现计划" / "work"

APPROVAL = "呈批件·S1.5"

#: 字符 × 状态 × dataviz status 色名注记 (图例即数据, json 同步携带)
MARKS = {"lit": "●", "degraded": "◐", "gap": "○", "unknown": "◌"}
STATE_LABELS = {"lit": "点亮", "degraded": "降级", "gap": "缺格",
                "unknown": "unknown"}
STATE_LEGEND = {
    "lit": ("点亮", "good 绿", "#0ca30c"),
    "degraded": ("降级/豁免/队列转化", "warning 琥珀", "#fab219"),
    "gap": ("缺格/空窗/未点亮", "critical 红", "#d03b3b"),
    "unknown": ("unknown(轴文件缺席)", "muted 灰", "#898781"),
}

AXIS_NAMES = {"T": "时间轴", "B": "广度十面", "D": "九维深度",
              "P": "EEI深度阶梯", "C": "渠道矩阵"}

_MISSING_FILE = "轴文件缺席"
_MISSING_JSON = "轴文件非合法 JSON"


def _now() -> str:
    return datetime.now().astimezone().isoformat(timespec="seconds")


# ---------- 逐格纯函数 (入参 payload dict, 无 IO) --------------------------

def _waiver_years(entries) -> dict[int, str]:
    """gap_waivers → {年: 理由}; 兼容 int/str 年或 {"year","reason"} dict."""
    out: dict[int, str] = {}
    if not isinstance(entries, list):
        return out
    for e in entries:
        if isinstance(e, dict):
            try:
                y = int(e.get("year"))
            except (TypeError, ValueError):
                continue
            out[y] = str(e.get("reason") or "登记在案")
        elif isinstance(e, int):
            out[e] = "登记在案"
        elif isinstance(e, str) and e.strip().lstrip("-").isdigit():
            out[int(e)] = "登记在案"
    return out


def cells_t(payload) -> list[dict]:
    """T 逐格: 证据年● / 豁免年◐ / 空窗年○ (年跨=founded..current, 缺则键跨度)."""
    if not isinstance(payload, dict):
        return []
    counts = payload.get("year_counts")
    if not isinstance(counts, dict) or not counts:
        return []
    founded, current = payload.get("founded_year"), payload.get("current_year")
    if isinstance(founded, int) and isinstance(current, int) and current >= founded:
        span = range(founded, current + 1)
    else:
        years = sorted(int(k) for k in counts if str(k).lstrip("-").isdigit())
        if not years:
            return []
        span = range(years[0], years[-1] + 1)
    waivers = _waiver_years(payload.get("gap_waivers"))
    cells = []
    for y in span:
        n = counts.get(str(y), counts.get(y, 0))
        try:
            n = int(n)
        except (TypeError, ValueError):
            n = 0
        if n > 0:
            cells.append({"cell": str(y), "state": "lit", "detail": f"证据 {n} 条"})
        elif y in waivers:
            cells.append({"cell": str(y), "state": "degraded",
                          "detail": f"豁免年: {waivers[y]}"})
        else:
            cells.append({"cell": str(y), "state": "gap", "detail": "空窗 (0 条)"})
    return cells


def cells_b(payload) -> list[dict]:
    """B 逐格: lit→●; 提及未点亮 (evidence>0 或 best_depth≥L1)→◐; 其余→○."""
    if not isinstance(payload, dict):
        return []
    facets = payload.get("facets")
    if not isinstance(facets, dict):
        return []
    cells = []
    for name, f in facets.items():
        f = f if isinstance(f, dict) else {}
        ev = f.get("evidence")
        if not isinstance(ev, (int, float)):
            ev = f.get("evidence_count")
        ev = ev if isinstance(ev, (int, float)) else 0
        bd = str(f.get("best_depth") or "L0")
        mentioned = ev > 0 or bd not in ("L0", "")
        if f.get("lit") is True:
            state = "lit"
        elif mentioned:
            state = "degraded"
        else:
            state = "gap"
        cells.append({"cell": str(name), "state": state,
                      "detail": f"best={bd} 证据={ev}"})
    return cells


def cells_d(payload) -> list[dict]:
    """D 逐格: open_gaps/无格→○ (缺格优先); downgraded→◐; 其余→●."""
    if not isinstance(payload, dict):
        return []
    dims = payload.get("dims")
    cells_map = payload.get("cells")
    if not isinstance(dims, list) or not dims:
        dims = list(cells_map) if isinstance(cells_map, dict) else []
    if not dims or not isinstance(cells_map, dict):
        return []
    gaps = {str(g) for g in payload.get("open_gaps") or []}
    cells = []
    for d in dims:
        cell = cells_map.get(d)
        if str(d) in gaps or not isinstance(cell, dict):
            reason = (cell or {}).get("reason") if isinstance(cell, dict) else None
            cells.append({"cell": str(d), "state": "gap",
                          "detail": f"缺格: {reason or 'open_gap 无命中资料'}"})
            continue
        depth = cell.get("depth")
        hits = cell.get("hits")
        if cell.get("downgraded"):
            cells.append({"cell": str(d), "state": "degraded",
                          "detail": f"降级: {cell.get('reason') or '未注理由'}"
                                    f" depth={depth}"})
        else:
            extra = f" hits={hits}" if isinstance(hits, int) else ""
            cells.append({"cell": str(d), "state": "lit",
                          "detail": f"{depth}{extra}"})
    return cells


def cells_p(payload) -> list[dict]:
    """P 逐格: L1-L5 各级 l_dist>0→●, =0→○; L0 只入摘要 (零证据不是深度)."""
    if not isinstance(payload, dict):
        return []
    dist = payload.get("l_dist")
    if not isinstance(dist, dict) or not dist:
        return []
    cells = []
    for lv in ("L1", "L2", "L3", "L4", "L5"):
        n = dist.get(lv, 0)
        n = n if isinstance(n, (int, float)) else 0
        state = "lit" if n > 0 else "gap"
        cells.append({"cell": lv, "state": state, "detail": f"{int(n)} 条 EEI"})
    return cells


def cells_c(payload) -> list[dict]:
    """C 逐格: 命中→●; 未命中且在 miss_in_queue→◐(建渠队列); 其余→○."""
    if not isinstance(payload, dict):
        return []
    hits = payload.get("hit_channels")
    misses = payload.get("miss_list")
    in_queue = {str(m) for m in payload.get("miss_in_queue") or []}
    cells = []
    if isinstance(hits, list):
        for h in hits:
            name = h.get("name") or h.get("id") if isinstance(h, dict) else str(h)
            chars = h.get("chars") if isinstance(h, dict) else None
            extra = f" chars={chars}" if isinstance(chars, int) else ""
            cells.append({"cell": str(name), "state": "lit",
                          "detail": f"命中{extra}"})
    if isinstance(misses, list):
        for m in misses:
            if str(m) in in_queue:
                cells.append({"cell": str(m), "state": "degraded",
                              "detail": "缺口→已入建渠队列 (SOP 四步法)"})
            else:
                cells.append({"cell": str(m), "state": "gap",
                              "detail": "缺口 (未入队列)"})
    return cells


CELL_BUILDERS = {"T": cells_t, "B": cells_b, "D": cells_d,
                 "P": cells_p, "C": cells_c}


# ---------- 账本与轴件读取 --------------------------------------------------

def _load_json(path: Path):
    if not path.is_file():
        return None, _MISSING_FILE
    try:
        return json.loads(path.read_text(encoding="utf-8")), ""
    except Exception:
        return None, _MISSING_JSON


def _latest_cidx_row(ledger: Path, campaign: str) -> dict | None:
    """账本最新 CIdx 行: 优先 campaign 匹配行, 其次无 campaign 字段行."""
    if not ledger.is_file():
        return None
    try:
        rows = [json.loads(l) for l in
                ledger.read_text(encoding="utf-8").splitlines() if l.strip()]
    except Exception:
        return None
    cidx_rows = [r for r in rows if isinstance(r, dict) and r.get("axis") == "CIdx"]
    for r in reversed(cidx_rows):  # 最新优先
        if r.get("campaign") in (campaign, None):
            return r
    return None


# ---------- 汇聚 → payload --------------------------------------------------

def _attach(cells: list[dict]) -> tuple[str, dict]:
    """格列表 → (格串, 四态计数)."""
    strip = "".join(MARKS.get(c["state"], "◌") for c in cells)
    counts = {k: 0 for k in MARKS}
    for c in cells:
        counts[c["state"]] = counts.get(c["state"], 0) + 1
    return strip, counts


def build_payload(campaign: str, *, pool_root=None, ledger_path=None) -> dict:
    """读账本+五轴 → 完整 payload (纯数据, md/json 均由它派生 — 天然一致)."""
    root = Path(pool_root) if pool_root else cidx.DEFAULT_AMMO_ROOT
    cdir = root / campaign / "completeness"
    ledger = Path(ledger_path) if ledger_path else \
        root / campaign / "completeness_ledger.jsonl"

    ts = _now()
    row = _latest_cidx_row(ledger, campaign)
    source = {"pool_root": str(root), "ledger": str(ledger),
              "ledger_cidx_row": row is not None,
              "ledger_cidx_ts": row.get("ts") if row else None,
              "computed_fallback": row is None}
    if row:  # 账本权威: 分数/CIdx 以账本最新 CIdx 行为准
        axis_scores = {a: float(row.get("axis_scores", {}).get(a, 0.0)
                                or 0.0) for a in cidx.AXES}
        cidx_v = float(row.get("cidx", 0.0) or 0.0)
        all_green = bool(row.get("all_green", False))
        missing_axes = list(row.get("missing_axes") or [])
        waived_axes = list(row.get("waived_axes") or [])
    else:  # 现算回退 (只读, 不落池)
        calc = cidx.assemble(campaign, pool_root=root, write=False)
        axis_scores = calc["axis_scores"]
        cidx_v = calc["cidx"]
        all_green = calc["all_green"]
        missing_axes = calc["missing_axes"]
        waived_axes = calc["waived_axes"]

    axes: dict[str, dict] = {}
    total = {k: 0 for k in MARKS}
    t_payload: dict = {}
    for axis in cidx.AXES:
        payload, note = _load_json(cdir / f"{axis}_axis.json")
        if axis == "T" and isinstance(payload, dict):
            t_payload = payload
        missing = payload is None
        if missing:
            cells, extra = [], {"score": 0.0, "green": False, "waived": False,
                                "note": note or _MISSING_FILE}
        else:
            try:
                cells = CELL_BUILDERS[axis](payload) or []
            except Exception:  # 未知结构防御: 格层 fail-soft, 不炸整图
                cells = []
            extra = {"score": axis_scores.get(axis, 0.0),
                     "green": payload.get("green") is True
                     if isinstance(payload, dict) else False,
                     "waived": cidx._is_waived(payload),
                     "note": "传感器在档" if cells else "传感器在档但无格可判 (fail-soft)"}
        strip, counts = _attach(cells)
        if missing:  # 缺轴 → 五格 ◌ 占位 (无实格, 计数保持 0)
            strip = "◌" * len(cidx.AXES)
        for k in total:
            total[k] += counts[k]
        axes[axis] = {
            "name": AXIS_NAMES[axis],
            "sensor": (payload or {}).get("sensor") or cidx.AXIS_SENSORS[axis]
            if isinstance(payload, dict) else cidx.AXIS_SENSORS[axis],
            **extra, "missing": missing, "cells": cells,
            "marks_strip": strip, "state_counts": counts,
        }

    t_cells = axes["T"]["cells"]
    gap_years = [c["cell"] for c in t_cells if c["state"] == "gap"]
    waivers_raw = _waiver_years(t_payload.get("gap_waivers"))
    gap_waivers = [{"year": y, "reason": r} for y, r in sorted(waivers_raw.items())]
    open_gaps = [c["cell"] for c in axes["D"]["cells"] if c["state"] == "gap"]
    miss_cells = [c for c in axes["C"]["cells"] if c["state"] in ("gap", "degraded")]
    miss_list = [c["cell"] for c in miss_cells]  # 镜像传感器 miss_list (全部未命中)

    return {
        "campaign": campaign, "generated_at": ts, "source": source,
        "cidx": cidx_v, "axis_scores": {a: axis_scores[a] for a in cidx.AXES},
        "all_green": all_green, "missing_axes": missing_axes,
        "waived_axes": waived_axes, "weights": dict(cidx.WEIGHTS),
        "formula": cidx.FORMULA,
        "legend": [{"mark": MARKS[s], "state": s, "label": STATE_LEGEND[s][0],
                    "color_name": STATE_LEGEND[s][1], "hex": STATE_LEGEND[s][2]}
                   for s in ("lit", "degraded", "gap", "unknown")],
        "axes": axes,
        "state_counts_total": total,
        "lists": {"gap_years": gap_years, "gap_waivers": gap_waivers,
                  "open_gaps": open_gaps, "miss_list": miss_list,
                  "miss_in_queue": [c["cell"] for c in miss_cells
                                    if c["state"] == "degraded"],
                  "waived_axes": list(waived_axes)},
        "approval": APPROVAL,
    }


# ---------- markdown 渲染 (由 payload 派生) --------------------------------

def _fmt(x: float) -> str:
    return f"{x:.4f}"


def _decade_rows(cells: list[dict]) -> list[tuple[str, str, str]]:
    """T 逐年格按十年段卷起: [(年段标签, 格串, ●/◐/○ 计数)]."""
    rows, cur, cur_dec = [], [], None
    for c in cells:
        try:
            dec = int(c["cell"]) // 10 * 10
        except ValueError:
            dec = None
        if cur_dec is None or dec == cur_dec:
            cur.append(c)
            cur_dec = dec if cur_dec is None else cur_dec
        else:
            rows.append(cur)
            cur, cur_dec = [c], dec
    if cur:
        rows.append(cur)
    out = []
    for grp in rows:
        strip = "".join(MARKS[c["state"]] for c in grp)
        n = {s: sum(1 for c in grp if c["state"] == s)
             for s in ("lit", "degraded", "gap")}
        label = grp[0]["cell"] if len(grp) == 1 \
            else f"{grp[0]['cell']}–{grp[-1]['cell']}"
        out.append((label, strip, f"{n['lit']}/{n['degraded']}/{n['gap']}"))
    return out


def render_md(p: dict) -> str:
    """payload → markdown (全部文字取自 payload, 与 json 逐键同源)."""
    L: list[str] = []
    L.append(f"# 完备性热图 · {p['campaign']}")
    L.append("")
    src = p["source"]
    src_line = (f"账本 {src['ledger']} 最新 CIdx 行 (ts={src['ledger_cidx_ts']})"
                if src["ledger_cidx_row"] else "账本无 CIdx 行 → 现算回退 (只读未落池)")
    L.append(f"- 生成: {p['generated_at']} ｜ 数据源: {src_line}")
    L.append(f"- CIdx = **{_fmt(p['cidx'])}** ｜ 公式: {p['formula']}")
    L.append(f"- all_green_or_waived = {p['all_green']}"
             f" ｜ missing_axes={p['missing_axes'] or '无'}"
             f" ｜ waived_axes={p['waived_axes'] or '无'}")
    L.append(f"- 全图格分布: ● {_sct(p, 'lit')} / ◐ {_sct(p, 'degraded')}"
             f" / ○ {_sct(p, 'gap')} / ◌ {_sct(p, 'unknown')}")
    L.append("")
    L.append("## 图例 (字符×状态×dataviz status 色名; 色名仅注记,"
             " 语义由字符+状态文字承载, 不单独依赖色)")
    L.append("")
    L.append("| 字符 | 状态 | 色名注记 |")
    L.append("|---|---|---|")
    for item in p["legend"]:
        L.append(f"| {item['mark']} | {item['label']}"
                 f" | {item['color_name']} {item['hex']} |")
    L.append("")
    L.append("## 五轴总览")
    L.append("")
    L.append("| 轴 | 传感器 | 分数 | green | 豁免 | 格分布 ●/◐/○/◌ | 热图格 |")
    L.append("|---|---|---|---|---|---|---|")
    for a in cidx.AXES:
        ax = p["axes"][a]
        sc = ax["state_counts"]
        green = "✓" if ax["green"] else "✗"
        waived = "豁免" if ax["waived"] else "-"
        dist = (f"{sc['lit']}/{sc['degraded']}/{sc['gap']}/{sc['unknown']}")
        strip = ax["marks_strip"] if ax["marks_strip"] else "◌(无格可判)"
        strip_cell = strip if len(strip) <= 40 else strip[:40] + "…"
        L.append(f"| {a} {ax['name']} | {ax['sensor']} | {_fmt(ax['score'])}"
                 f" | {green} | {waived} | {dist} | {strip_cell} |")
    L.append("")
    L.append("## 五轴分明细")
    for a in cidx.AXES:
        ax = p["axes"][a]
        L.append("")
        title = f"### {a} {ax['name']} ({ax['sensor']}) — {len(ax['cells'])} 格"
        if ax["missing"]:
            title += f" ｜ ◌ unknown: {ax['note']}"
        L.append(title)
        L.append("")
        if a == "T" and ax["cells"]:
            L.append("| 年段 | 格串 | ●/◐/○ |")
            L.append("|---|---|---|")
            for label, strip, dist in _decade_rows(ax["cells"]):
                L.append(f"| {label} | {strip} | {dist} |")
        elif ax["cells"]:
            L.append("| 格 | 字符 | 状态 | 明细 |")
            L.append("|---|---|---|---|")
            for c in ax["cells"]:
                L.append(f"| {c['cell']} | {MARKS[c['state']]}"
                         f" | {STATE_LABELS[c['state']]} | {c['detail']} |")
        else:
            L.append(f"（无格可判 — {ax['note']}）")
    L.append("")
    L.append("## 清单")
    lists = p["lists"]
    L.append("")
    gy = lists["gap_years"]
    L.append(f"- 空窗年清单 (T 轴, {len(gy)} 项): "
             + ("、".join(gy) if gy else "无"))
    og = lists["open_gaps"]
    L.append(f"- 缺格清单 (D 轴, {len(og)} 项): " + ("、".join(og) if og else "无"))
    ml = lists["miss_list"]
    L.append(f"- 渠道缺口 (C 轴 miss_list, {len(ml)} 项): "
             + ("、".join(ml) if ml else "无"))
    mq = lists["miss_in_queue"]
    if mq:
        L.append(f"- 渠道缺口·已入建渠队列 (◐, {len(mq)} 项): " + "、".join(mq))
    gw = lists["gap_waivers"]
    gw_txt = "、".join(f"{w['year']}({w['reason']})" for w in gw) if gw else "无"
    L.append(f"- 豁免清单·年豁免 (T gap_waivers, {len(gw)} 项): {gw_txt}")
    wa = lists["waived_axes"]
    L.append(f"- 豁免清单·轴级豁免 ({len(wa)} 项): " + ("、".join(wa) if wa else "无"))
    L.append("")
    L.append(APPROVAL)
    L.append("")
    return "\n".join(L)


def _sct(p: dict, state: str) -> int:
    return p["state_counts_total"].get(state, 0)


# ---------- 对外入口 --------------------------------------------------------

def render(campaign: str, out_dir=None, *, pool_root=None, ledger_path=None,
           write: bool = True) -> dict:
    """生成热图 → 返回 payload; write=True 时双落盘 heatmap_<战役>.{md,json}."""
    payload = build_payload(campaign, pool_root=pool_root, ledger_path=ledger_path)
    if write:
        out = Path(out_dir) if out_dir else DEFAULT_OUT_DIR
        out.mkdir(parents=True, exist_ok=True)
        (out / f"heatmap_{campaign}.md").write_text(
            render_md(payload), encoding="utf-8", newline="\n")
        (out / f"heatmap_{campaign}.json").write_text(
            json.dumps(payload, ensure_ascii=False, indent=1) + "\n",
            encoding="utf-8", newline="\n")
        payload = dict(payload)
        payload["out_dir"] = str(out)
    return payload


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="完备性热图 (markdown+json 双落盘, 池只读, 呈批件·S1.5)")
    ap.add_argument("--campaign", required=True, help="战役名, 如 EPC-BID26")
    ap.add_argument("--out-dir", default=None,
                    help=f"输出目录 (默认 {DEFAULT_OUT_DIR})")
    ap.add_argument("--ammo-root", default=None, help="ammo_pool 根 (默认仓库默认)")
    ap.add_argument("--ledger", default=None, help="completeness_ledger.jsonl 路径覆盖")
    ap.add_argument("--json", action="store_true", help="输出完整 JSON (默认摘要)")
    ap.add_argument("--no-write", action="store_true", help="只算不落盘")
    args = ap.parse_args(argv)

    try:
        sys.stdout.reconfigure(encoding="utf-8")
    except Exception:
        pass

    res = render(args.campaign, args.out_dir, pool_root=args.ammo_root,
                 ledger_path=args.ledger, write=not args.no_write)
    if args.json:
        print(json.dumps(res, ensure_ascii=False))
    else:
        sc = res["axis_scores"]
        print(f"[heatmap] {args.campaign}: "
              + " ".join(f"{a}={sc[a]:.4f}" for a in cidx.AXES))
        print(f"[heatmap] CIdx={res['cidx']:.4f}  格分布 ●{_sct(res, 'lit')}"
              f"/◐{_sct(res, 'degraded')}/○{_sct(res, 'gap')}"
              f"/◌{_sct(res, 'unknown')}")
        out = res.get("out_dir")
        print(f"[heatmap] 落盘 {out}/heatmap_{args.campaign}.{{md,json}}"
              if out else "[heatmap] 未落盘 (--no-write)")
        print(f"[heatmap] {res['lists']['gap_years'].__len__()} 空窗年 ｜ "
              f"{len(res['lists']['open_gaps'])} 缺格维 ｜ "
              f"{len(res['lists']['miss_list'])} 渠道缺口")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
