# -*- coding: utf-8 -*-
"""bid26_finish_kit — BID26 新宪法收尾机制件 (T-023 / REQ-051, 百倍V3).

REQ-051: 当 BID26 收尾时, 系统应只升不逆 — 已批事项不重开, 按新宪法收尾
(密度门/产品族/过程附录), 完备性回测缺口走**补采呈批**不静默扩采。
本件是收尾**机制件** (不代产线写报告), 三件套:

  ① checklist()  收尾检查清单 (新宪法收尾位全量盘点, 现状如实):
       - 完备性五轴现状 — 读 ammo_pool/<战役>/completeness_ledger.jsonl 最后
         一批 (T/B/D/P/C 轴行 + CIdx 行); B/P 轴传感器 (coverage_facets /
         depth_ladder) 以问题树实际 EEI 为分母, 树未建 → 恒 0 分, 如实标
         blocked_by_question_tree (先 question_tree.py generate → 重扫 →
         cidx assemble 才可能绿, 不伪造不豁免);
       - 密度门接线位 m2/density_check (旁挂 m2 章节验收, 密度门主判);
       - AI 审稿人 ai_reviewer --campaign <cid> (成稿门禁十项机检);
       - 过程附录 appendix_builder (四件套随稿强制件);
       - 产品族 superline/product_family_gen (六层变现面);
       - 红队轮 redteam_run (unanswered>0 → 阻塞收尾);
       - 发布协议 S4-S7 下限 3+3 (S5 文章×3 + S6 视频×3 含 H3≥1)。
     每项 {item, tool, status: ready|blocked_<why>, note} →
     work/bid26_finish_checklist.{json,md} 双落盘 (md 人读, json 机读)。

  ② supplement_ledger 补采对账账本 (REQ-051.AC1 机器化):
       register(eei_or_gap, reason, approve_ref) — 追加
         work/bid26_supplement_ledger.jsonl 一行
         {ts, campaign, eei_or_gap, reason, approve_ref};
       **无 approve_ref 拒记** (SupplementRefused, CLI exit 2) —
       「不静默扩采」的门闩: 扩采 EEI 均须有批准记录或呈批件引用;
       audit(gaps, ledger) — completeness 回测缺口 vs 账本登记对账,
       未登记缺口 = 违规 (CLI exit 2); 全登记 exit 0。一行可登记多缺口
       (逗号/分号/空白分隔, 精确 token 匹配, 不做模糊包含)。

  ③ no_revert() 只升不逆对照器 — 前后两份清单对照: 已 ready (已批/已接线)
     的事项不得回落 blocked 或消失 (逆行即违规, CLI exit 2); blocked→ready
     (只升) 与 blocked→blocked 合法。

CLI (repo 根, py 命令):
  py reforge_factory/bid26_finish_kit.py checklist [--campaign EPC-BID26]
      [--pool-root D] [--work-dir D] [--m2-wiring F] [--pipeline-doc F] [--no-write]
  py reforge_factory/bid26_finish_kit.py register --gap "Q1-E1" --reason "回测缺口"
      --approve-ref "用户2026-10-15批准" [--campaign EPC-BID26] [--ledger F]
  py reforge_factory/bid26_finish_kit.py audit --gaps "Q1-E1,Q1-E2"
      [--gaps-file F.json] [--ledger F]
  py reforge_factory/bid26_finish_kit.py no-revert --prev prev.json --now now.json
退出码: 0=合规 | 2=违规 (拒记 / 未登记缺口 / 逆行回落 / 用法错)
真实池只读; 输出只增不删。
"""
from __future__ import annotations

import argparse
import json
import re
import sys
from collections import Counter
from datetime import datetime
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.stderr.reconfigure(encoding="utf-8", errors="replace")

# ---------------------------------------------------------------- 路径常量
_REPO_ROOT = Path(__file__).resolve().parents[1]          # E:\AI-Station
POOL_ROOT = _REPO_ROOT / "ammo_pool"
V3_WORK_DIR = _REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化" / \
    "百倍V3_极致调研变现计划" / "work"
M2_WIRING = _REPO_ROOT / "_proposals" / "flagship-paid-report-1007" / \
    "work" / "m2" / "density_check.py"
PIPELINE_DOC = _REPO_ROOT / "_proposals" / "flagship-paid-report-1007" / \
    "work" / "REPORT_PIPELINE.md"
DENSITY_THRESHOLDS = _REPO_ROOT / "reforge_factory" / "config" / \
    "density_thresholds.json"
DEFAULT_CAMPAIGN = "EPC-BID26"
DEFAULT_LEDGER = V3_WORK_DIR / "bid26_supplement_ledger.jsonl"
CHECKLIST_JSON = "bid26_finish_checklist.json"
CHECKLIST_MD = "bid26_finish_checklist.md"

#: 五轴固定顺序 (口径同 completeness/cidx.py AXES)
AXES = ("T", "B", "D", "P", "C")
#: 问题树文件名 (v2 优先 v1 兜底, 口径同 redteam_run.TREE_NAMES)
TREE_NAMES = ("question_tree_v2.json", "question_tree.json")
#: B/P 轴传感器 (以问题树实际 EEI 为分母 — 树缺则恒 0 分)
TREE_BOUND_SENSORS = {"B": "coverage_facets", "P": "depth_ladder"}

#: 清单必出十二项 (顺序即清单序; 测试对拍锚)
REQUIRED_ITEMS = (
    "完备性五轴·T 时间轴",
    "完备性五轴·B 十面覆盖",
    "完备性五轴·D 维度矩阵",
    "完备性五轴·P 深度阶梯",
    "完备性五轴·C 渠道矩阵",
    "完备性五轴·CIdx 五覆指数",
    "密度门接线位 m2/density_check",
    "AI 审稿人 成稿门禁",
    "过程附录四件套",
    "产品族六层变现面",
    "红队轮",
    "发布协议 S4-S7 下限3+3",
)

_GAP_SPLIT = re.compile(r"[,;，；\s|/、]+")


class SupplementRefused(RuntimeError):
    """补采登记被拒 (REQ-051: 无批准引用不得扩采 — 不静默扩采的门闩)."""


# ---------------------------------------------------------------- 小工具
def _now_iso() -> str:
    return datetime.now().astimezone().isoformat(timespec="seconds")


def _read_json(path: Path):
    try:
        return json.loads(Path(path).read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return None


def _tree_present(pool_root: Path, campaign: str) -> bool:
    return any((Path(pool_root) / campaign / n).exists() for n in TREE_NAMES)


def _redteam_unanswered(work_dir: Path, campaign: str) -> tuple[int, int] | None:
    """读 work/redteam_<cid>.json → (总路径数, 未回应数); 缺席返回 None."""
    data = _read_json(Path(work_dir) / f"redteam_{campaign}.json")
    if not isinstance(data, dict):
        return None
    paths = data.get("failure_paths") or []
    unanswered = sum(1 for p in paths
                     if isinstance(p, dict) and p.get("response_status") == "unanswered")
    return len(paths), unanswered


# ------------------------------------------------------- ① 收尾检查清单 ---
def _last_ledger_block(ledger: Path) -> tuple[dict, dict[str, dict]]:
    """读 completeness_ledger.jsonl → (最后一批 CIdx 行, {轴: 轴行}).

    每批 6 行 = 五轴行 + CIdx 汇总行 (CIdx 收尾); 逐行扫, CIdx 到达时快照
    该批五轴行, 取最后一个完整批; 无 CIdx 行则兜底返回见过的最后五轴行。
    """
    cidx_best: dict = {}
    axis_best: dict[str, dict] = {}
    axis_run: dict[str, dict] = {}
    ledger = Path(ledger)
    if not ledger.exists():
        return {}, {}
    for line in ledger.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            rec = json.loads(line)
        except json.JSONDecodeError:
            continue
        if not isinstance(rec, dict):
            continue
        ax = rec.get("axis")
        if ax in AXES:
            axis_run[ax] = rec
        elif ax == "CIdx":
            cidx_best, axis_best = rec, dict(axis_run)
            axis_run = {}
    if not axis_best and axis_run:            # 无 CIdx 行的兜底批
        axis_best = axis_run
    return cidx_best, axis_best


def _axis_item(axis: str, row: dict | None, tree_missing: bool) -> dict:
    name, sensor = {
        "T": ("完备性五轴·T 时间轴", "entity_timeline"),
        "B": ("完备性五轴·B 十面覆盖", "coverage_facets"),
        "D": ("完备性五轴·D 维度矩阵", "dimension_matrix"),
        "P": ("完备性五轴·P 深度阶梯", "depth_ladder"),
        "C": ("完备性五轴·C 渠道矩阵", "channel_matrix"),
    }[axis]
    if not row:
        return {"item": name, "tool": f"completeness/{sensor}.py scan <cid>",
                "status": "blocked_no_ledger",
                "note": "completeness_ledger.jsonl 无该轴行 — 先跑五轴传感器 + cidx assemble"}
    score, green, waived = row.get("score"), bool(row.get("green")), bool(row.get("waived"))
    base = f"score={score} green={green} waived={waived} sensor={sensor}"
    if green or waived:
        return {"item": name, "tool": f"completeness/{sensor}.py scan <cid>",
                "status": "ready",
                "note": (base + " (豁免视同绿)" if waived and not green else base)}
    if tree_missing and axis in TREE_BOUND_SENSORS:
        return {"item": name, "tool": f"completeness/{sensor}.py scan <cid>",
                "status": "blocked_by_question_tree",
                "note": base + "; 问题树未建 → 该轴以树实际 EEI 为分母恒 0 分 — "
                        "先 question_tree.py generate <cid> → 重扫该轴 → cidx assemble "
                        "(如实列缺, 不伪造不豁免)"}
    return {"item": name, "tool": f"completeness/{sensor}.py scan <cid>",
            "status": "blocked_axis_not_green",
            "note": base + "; 收尾前重扫传感器, 回测缺口走补采呈批 "
                    "(supplement_ledger register)"}


def _cidx_item(cidx: dict) -> dict:
    if not cidx:
        return {"item": "完备性五轴·CIdx 五覆指数", "tool": "completeness/cidx.py assemble <cid>",
                "status": "blocked_no_ledger",
                "note": "completeness_ledger.jsonl 无 CIdx 汇总行 — 跑 cidx assemble"}
    waived = set(cidx.get("waived_axes") or [])
    scores = cidx.get("axis_scores") or {}
    all_green = bool(cidx.get("all_green")) or waived >= set(AXES)
    note = (f"cidx={cidx.get('cidx')} all_green={cidx.get('all_green')} "
            f"axis_scores={scores} waived_axes={sorted(waived) or '无'}")
    return {"item": "完备性五轴·CIdx 五覆指数", "tool": "completeness/cidx.py assemble <cid>",
            "status": "ready" if all_green else "blocked_axis_not_green",
            "note": note + ("" if all_green else "; 五轴未全绿 — 缺口走补采呈批, 不静默扩采")}


def checklist(campaign: str = DEFAULT_CAMPAIGN, *,
              pool_root: Path | str = POOL_ROOT,
              work_dir: Path | str = V3_WORK_DIR,
              m2_wiring: Path | str = M2_WIRING,
              pipeline_doc: Path | str = PIPELINE_DOC,
              write: bool = True) -> dict:
    """按新宪法生成 BID26 收尾清单 (现状如实) → dict; write=True 时双落盘."""
    pool_root, work_dir = Path(pool_root), Path(work_dir)
    m2_wiring, pipeline_doc = Path(m2_wiring), Path(pipeline_doc)
    cidx_row, axis_rows = _last_ledger_block(
        pool_root / campaign / "completeness_ledger.jsonl")
    tree_missing = not _tree_present(pool_root, campaign)

    items: list[dict] = []
    for axis in AXES:
        items.append(_axis_item(axis, axis_rows.get(axis), tree_missing))
    items.append(_cidx_item(cidx_row))

    # 密度门接线位 (旁挂 m2, 密度门主判)
    if m2_wiring.exists():
        items.append({"item": "密度门接线位 m2/density_check", "tool": str(m2_wiring),
                      "status": "ready",
                      "note": f"旁挂 m2 章节验收已接线 (密度门主判 → 既有 m2_gate 断言保留); "
                              f"阈值 {DENSITY_THRESHOLDS.name} 现读热改; "
                              f"打回落账 work/density_rejects.jsonl"})
    else:
        items.append({"item": "密度门接线位 m2/density_check", "tool": str(m2_wiring),
                      "status": "blocked_not_wired",
                      "note": "m2/density_check.py 不在场 — 按 REQ-014 密度门旁挂接线"})

    # AI 审稿人 (成稿门禁)
    ai_tool = _REPO_ROOT / "reforge_factory" / "ai_reviewer.py"
    ai_prod = work_dir / f"ai_review_{campaign}.json"
    items.append({"item": "AI 审稿人 成稿门禁",
                  "tool": f"reforge_factory/ai_reviewer.py --campaign {campaign}",
                  "status": "ready" if ai_tool.exists() else "blocked_tool_missing",
                  "note": ("固定清单十项机检 (REQ-028), 未过线不出厂"
                           + (f"; 现有产物在档: {ai_prod.name} (成稿时对真稿现跑)"
                              if ai_prod.exists() else "; 成稿时对真稿现跑"))})

    # 过程附录 (四件套随稿强制件)
    apx_tool = _REPO_ROOT / "reforge_factory" / "appendix_builder.py"
    apx_demo = work_dir / f"appendix_demo_{campaign}"
    items.append({"item": "过程附录四件套",
                  "tool": f"reforge_factory/appendix_builder.py --campaign {campaign}",
                  "status": "ready" if apx_tool.exists() else "blocked_tool_missing",
                  "note": ("PRISMA 漏斗/ACH 矩阵/覆盖热图/存证戳 (REQ-026)"
                           + (f"; 演示件在档: {apx_demo.name}/"
                              if apx_demo.exists() else "; 真成稿目录随稿落 appendix/"))})

    # 产品族 (六层变现面)
    pf_tool = _REPO_ROOT / "reforge_factory" / "superline" / "product_family_gen.py"
    pf_prod = work_dir / f"product_family_{campaign}.json"
    items.append({"item": "产品族六层变现面",
                  "tool": f"reforge_factory/superline/product_family_gen.py --campaign {campaign}",
                  "status": "ready" if pf_tool.exists() else "blocked_tool_missing",
                  "note": ("L0-L5 六层变现面骨架 (REQ-031), 徽章零手拍"
                           + (f"; 产物在档: {pf_prod.name}"
                              if pf_prod.exists() else ""))})

    # 红队轮 (unanswered>0 → 阻塞)
    rt_tool = _REPO_ROOT / "reforge_factory" / "redteam_run.py"
    rt = _redteam_unanswered(work_dir, campaign)
    if rt is None:
        items.append({"item": "红队轮", "tool": f"reforge_factory/redteam_run.py --campaign {campaign}",
                      "status": "blocked_redteam_not_run",
                      "note": f"work/redteam_{campaign}.json 不在档 — 成稿门禁前跑红队轮 (REQ-043)"})
    elif rt[1] > 0:
        items.append({"item": "红队轮", "tool": f"reforge_factory/redteam_run.py --campaign {campaign}",
                      "status": "blocked_redteam_unanswered",
                      "note": f"{rt[1]}/{rt[0]} 条失败路径 unanswered — 逐条回应或降级后重跑 (exit 2 口径)"})
    else:
        items.append({"item": "红队轮", "tool": f"reforge_factory/redteam_run.py --campaign {campaign}",
                      "status": "ready" if rt_tool.exists() else "blocked_tool_missing",
                      "note": f"产物在档 work/redteam_{campaign}.json: {rt[0]} 条失败路径 0 unanswered"})

    # 发布协议 S4-S7 下限 3+3
    if pipeline_doc.exists():
        items.append({"item": "发布协议 S4-S7 下限3+3", "tool": str(pipeline_doc),
                      "status": "ready",
                      "note": "S4 上架 → S5 文章×3 + S6 视频×3 (H3≥1) = 协议下限, 上限按漏斗 "
                              "→ S7 企微通知 + PDF 推送 → RUN_LEDGER 回填"})
    else:
        items.append({"item": "发布协议 S4-S7 下限3+3", "tool": str(pipeline_doc),
                      "status": "blocked_release_doc_missing",
                      "note": "REPORT_PIPELINE.md 不在场 — 发布协议接线位缺失"})

    cnt = Counter(it["status"] for it in items)
    counts = {
        "ready": cnt.pop("ready", 0),
        "blocked": sum(cnt.values()),
        **{k: v for k, v in sorted(cnt.items())},
    }
    out = {"campaign": campaign, "ts": _now_iso(),
           "engine": "bid26_finish_kit-v1 (T-023 REQ-051 收尾机制件)",
           "tree_present": not tree_missing,
           "ledger": str(DEFAULT_LEDGER if work_dir == V3_WORK_DIR
                         else work_dir / "bid26_supplement_ledger.jsonl"),
           "items": items, "counts": counts}
    if write:
        work_dir.mkdir(parents=True, exist_ok=True)
        (work_dir / CHECKLIST_JSON).write_text(
            json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
        (work_dir / CHECKLIST_MD).write_text(_render_md(out), encoding="utf-8")
    return out


def _render_md(out: dict) -> str:
    """清单 md 渲染 (人读; 状态中文呈现, 机读态走 json)."""
    c = out["counts"]
    blocked_detail = " / ".join(f"{k} {v}" for k, v in c.items()
                                if k.startswith("blocked_"))
    lines = [
        f"# {out['campaign']} 收尾检查清单（新宪法 · 只升不逆）",
        "",
        f"- 生成: {out['ts']} ｜ 引擎: {out['engine']}",
        f"- 问题树在场: {'是' if out['tree_present'] else '否（B/P 轴缺树 → 补树才能绿）'}",
        f"- 汇总: 就绪 {c['ready']} ｜ 受阻 {c['blocked']}"
        + (f"（{blocked_detail}）" if blocked_detail else ""),
        f"- 补采口径: 完备性回测缺口一律 `{out['ledger']}` 呈批登记"
        "（无 approve_ref 拒记；audit 对账未登记缺口 = 违规 exit 2）",
        "",
        "| # | 事项 | 工具/接线位 | 状态 | 说明 |",
        "|---|------|-------------|------|------|",
    ]
    for i, it in enumerate(out["items"], 1):
        st = "就绪" if it["status"] == "ready" else f"受阻: {it['status']}"
        note = str(it["note"]).replace("|", "\\|").replace("\n", " ")
        tool = str(it["tool"]).replace("|", "\\|")
        lines.append(f"| {i} | {it['item']} | {tool} | {st} | {note} |")
    lines.append("")
    lines.append("> 只升不逆：已就绪（已批/已接线）事项不得回落；对照器 "
                 "`no-revert --prev <旧清单> --now <新清单>`。")
    return "\n".join(lines) + "\n"


# ------------------------------------------------------ ② 补采对账账本 ----
def register(eei_or_gap: str, reason: str, approve_ref: str, *,
             campaign: str = DEFAULT_CAMPAIGN,
             ledger_path: Path | str | None = None) -> dict:
    """补采呈批登记 — 追加一行到账本; 无 approve_ref 拒记 (REQ-051.AC1).

    eei_or_gap 支持一行多缺口 (逗号/分号/空白分隔), audit 按 token 精确对账。
    """
    gap = (eei_or_gap or "").strip()
    reason = (reason or "").strip()
    approve = (approve_ref or "").strip()
    if not gap:
        raise SupplementRefused(
            "eei_or_gap 为空: 拒记 (REQ-051 补采呈批不静默扩采 — 缺口标识必填)")
    if not approve:
        raise SupplementRefused(
            "approve_ref 为空: 拒记 (REQ-051 扩采 EEI 均须批准记录/呈批件引用 — "
            "不静默扩采的机器门闩)")
    path = Path(ledger_path) if ledger_path else DEFAULT_LEDGER
    path.parent.mkdir(parents=True, exist_ok=True)
    rec = {"ts": _now_iso(), "campaign": campaign, "eei_or_gap": gap,
           "reason": reason, "approve_ref": approve}
    with path.open("a", encoding="utf-8", newline="\n") as fh:
        fh.write(json.dumps(rec, ensure_ascii=False) + "\n")
    return rec


def read_ledger(ledger_path: Path | str | None = None) -> list[dict]:
    path = Path(ledger_path) if ledger_path else DEFAULT_LEDGER
    if not path.exists():
        return []
    rows = []
    for line in path.read_text(encoding="utf-8").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            rec = json.loads(line)
        except json.JSONDecodeError:
            continue
        if isinstance(rec, dict) and rec.get("eei_or_gap"):
            rows.append(rec)
    return rows


def _covers(value: str, gap: str) -> bool:
    """账本一行是否覆盖某缺口: 整串相等或 token 精确命中 (不做模糊包含)."""
    value = (value or "").strip()
    if value == gap:
        return True
    return gap in [t for t in _GAP_SPLIT.split(value) if t]


def audit(gaps, ledger_path: Path | str | None = None) -> dict:
    """completeness 回测缺口 vs 账本登记对账 — 未登记缺口 = 违规 (ok=False)."""
    gaps = [str(g).strip() for g in gaps if str(g).strip()]
    rows = read_ledger(ledger_path)
    values = [r.get("eei_or_gap", "") for r in rows]
    registered, unregistered = [], []
    for g in gaps:
        (registered if any(_covers(v, g) for v in values) else unregistered).append(g)
    path = Path(ledger_path) if ledger_path else DEFAULT_LEDGER
    return {"ok": not unregistered, "gaps_total": len(gaps),
            "registered": registered, "unregistered": unregistered,
            "ledger_lines": len(rows), "ledger": str(path)}


# --------------------------------------------------- ③ 只升不逆对照器 ----
def no_revert(prev, now) -> dict:
    """前后清单对照 — prev 中 ready 的事项在 now 不得回落 blocked/消失."""
    def _items(x):
        if isinstance(x, dict):
            return x.get("items") or []
        return list(x or [])

    pm = {i.get("item"): i.get("status", "") for i in _items(prev) if i.get("item")}
    nm = {i.get("item"): i.get("status", "") for i in _items(now) if i.get("item")}
    reverted = []
    for item, st in pm.items():
        if st == "ready" and nm.get(item) != "ready":
            reverted.append({"item": item, "prev": "ready",
                             "now": nm.get(item) or "missing"})
    return {"ok": not reverted, "reverted": reverted,
            "checked_ready": sum(1 for s in pm.values() if s == "ready")}


# ----------------------------------------------------------------- CLI ----
def _parse_gaps(ns) -> list[str]:
    gaps: list[str] = []
    raw = (ns.gaps or "").strip()
    if raw:
        gaps += [t for t in _GAP_SPLIT.split(raw) if t]
    if getattr(ns, "gaps_file", None):
        p = Path(ns.gaps_file)
        data = _read_json(p)
        if isinstance(data, list):
            gaps += [str(t).strip() for t in data if str(t).strip()]
        elif p.exists():
            gaps += [t for t in _GAP_SPLIT.split(p.read_text(encoding="utf-8")) if t]
    return gaps


def main(argv: list[str] | None = None) -> int:
    argv = list(sys.argv[1:] if argv is None else argv)
    ap = argparse.ArgumentParser(
        prog="bid26_finish_kit",
        description="BID26 新宪法收尾机制件 (T-023/REQ-051): 清单 + 补采对账账本 + 只升不逆对照器")
    sub = ap.add_subparsers(dest="cmd", required=True)

    p_ck = sub.add_parser("checklist", help="生成收尾检查清单 (json+md)")
    p_ck.add_argument("--campaign", default=DEFAULT_CAMPAIGN)
    p_ck.add_argument("--pool-root", default=str(POOL_ROOT))
    p_ck.add_argument("--work-dir", default=str(V3_WORK_DIR))
    p_ck.add_argument("--m2-wiring", default=str(M2_WIRING))
    p_ck.add_argument("--pipeline-doc", default=str(PIPELINE_DOC))
    p_ck.add_argument("--no-write", action="store_true")

    p_reg = sub.add_parser("register", help="补采呈批登记 (无 approve_ref 拒记 exit 2)")
    p_reg.add_argument("--gap", required=True, help="EEI/缺口标识 (可逗号分隔多个)")
    p_reg.add_argument("--reason", required=True)
    p_reg.add_argument("--approve-ref", default="", help="批准记录/呈批件引用 (必填)")
    p_reg.add_argument("--campaign", default=DEFAULT_CAMPAIGN)
    p_reg.add_argument("--ledger", default=None)

    p_au = sub.add_parser("audit", help="缺口 vs 账本对账 (未登记 exit 2)")
    p_au.add_argument("--gaps", default="", help="缺口清单 (逗号/空白分隔)")
    p_au.add_argument("--gaps-file", default=None, help="缺口 json 数组/文本文件")
    p_au.add_argument("--ledger", default=None)

    p_nr = sub.add_parser("no-revert", help="只升不逆对照 (逆行回落 exit 2)")
    p_nr.add_argument("--prev", required=True, help="旧清单 json")
    p_nr.add_argument("--now", required=True, help="新清单 json")

    try:
        ns = ap.parse_args(argv)
    except SystemExit:
        return 2

    if ns.cmd == "checklist":
        res = checklist(ns.campaign, pool_root=ns.pool_root, work_dir=ns.work_dir,
                        m2_wiring=ns.m2_wiring, pipeline_doc=ns.pipeline_doc,
                        write=not ns.no_write)
        c = res["counts"]
        md = Path(ns.work_dir) / CHECKLIST_MD
        print(f"[checklist] {ns.campaign}: 就绪 {c['ready']} / 受阻 {c['blocked']}"
              f"（{ {k: v for k, v in c.items() if k.startswith('blocked_')} }）")
        print(f"[checklist] md={md}")
        for it in res["items"]:
            print(f"  - {it['status']:<32} {it['item']}")
        return 0

    if ns.cmd == "register":
        try:
            rec = register(ns.gap, ns.reason, ns.approve_ref,
                           campaign=ns.campaign, ledger_path=ns.ledger)
        except SupplementRefused as e:
            print(f"[拒记] {e}", file=sys.stderr)
            return 2
        print(json.dumps(rec, ensure_ascii=False))
        return 0

    if ns.cmd == "audit":
        gaps = _parse_gaps(ns)
        res = audit(gaps, ledger_path=ns.ledger)
        print(f"[audit] 缺口 {res['gaps_total']} | 账本 {res['ledger_lines']} 行 | "
              f"已登记 {len(res['registered'])} | 未登记 {len(res['unregistered'])}"
              f" | ledger={res['ledger']}")
        if res["unregistered"]:
            print("[audit][违规] 未登记缺口 (REQ-051 不静默扩采): "
                  + ", ".join(res["unregistered"]), file=sys.stderr)
            print("  → register --gap <缺口> --reason <理由> --approve-ref <批准引用> 后重审",
                  file=sys.stderr)
            return 2
        return 0

    if ns.cmd == "no-revert":
        prev, now = _read_json(Path(ns.prev)), _read_json(Path(ns.now))
        if prev is None or now is None:
            print("[no-revert] prev/now json 不可读", file=sys.stderr)
            return 2
        res = no_revert(prev, now)
        print(f"[no-revert] 已就绪事项 {res['checked_ready']} | 逆行回落 "
              f"{len(res['reverted'])}")
        for r in res["reverted"]:
            print(f"  [逆行] {r['item']}: {r['prev']} → {r['now']}", file=sys.stderr)
        return 0 if res["ok"] else 2

    return 2


if __name__ == "__main__":
    sys.exit(main())
