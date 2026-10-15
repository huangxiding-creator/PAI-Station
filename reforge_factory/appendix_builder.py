# -*- coding: utf-8 -*-
"""appendix_builder — 过程附录四件套出厂器 (T-014 / REQ-026 / KB-PROCESS-APPENDIX-SPEC).

四件 (落 <draft_dir>/appendix/, 随稿强制件; 真实池只读, 输出只增):
  ① prisma_funnel.md     采集漏斗 (PRISMA 2020 流程图口径, CC BY):
       识别=manifest 总行数 → judge 三态 (valid/rejected/pending) →
       有效分层 T1/T2/T3 字符 — 全部从 manifest/pool_state/tiers.json 实算,
       每步一句理由模板行; 附 pool_state 对账表 (REQ-026.AC1 零差口径).
  ② ach_matrix.md        证据×假设矩阵 (Heuer ACH):
       战役在档 ach_arena 产物优先转录 → question_tree hypotheses 全矩阵
       (与 ach_arena v0 同口径: 挂树独立源×grade 权重×stance 兼容分,
        排除法排序+领先假设反证清单) → 无假设则按挂树 stance=against 的
       EEI×证据列表出矩阵雏形并显式标 degraded.
  ③ coverage_heatmap.md  覆盖热图 (五轴完备性+CIdx+豁免/降级清单):
       防御式复用 completeness/heatmap_gen.render (T-009 并行在建,
       import 失败/调用异常 → 内嵌简版渲染兜底, 避免依赖竞态).
  ④ evidence_stamps.json 存证时间戳清单 (Bellingcat 取证链):
       valid 行带快照三字段 (snapshot_hash/snapshot_ts/snapshot_url) 者的
       清单 + 总量/覆盖统计; --sample N 抽检回放 (sha256 实测对拍).

CLI:
  py reforge_factory/appendix_builder.py --campaign EPC-BID26 \
      [--draft-dir DIR] [--pool-root DIR] [--reconcile] [--sample 20]
  --draft-dir 缺省 = V3 work/appendix_demo_<战役>/ (演示件, 非真成稿目录)
  退出码: 0=正常 | 2=对账有差或抽检回放有断锚 (REQ-026.AC1 机检位)
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
import sys
import time
from pathlib import Path

if sys.stdout:                                     # pythonw 无控制台守卫 (同 ammo_pool)
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 同级/下级导入纪律: grade_rules (注册域) / completeness (heatmap_gen)
_HERE = Path(__file__).resolve().parent
for _p in (str(_HERE),):
    if _p not in sys.path:
        sys.path.insert(0, _p)
from grade_rules import host_of                      # noqa: E402  零 urllib 口径

REPO_ROOT = _HERE.parent
DEFAULT_POOL_ROOT = REPO_ROOT / "ammo_pool"
#: 演示件缺省落位 (V3 work; 非真成稿目录)
V3_WORK = (REPO_ROOT / "ResearchFactory-Eng" / "06 迭代优化"
           / "百倍V3_极致调研变现计划" / "work")

TREE_NAMES = ("question_tree_v2.json", "question_tree.json")
#: 快照三字段 (与 ammo_pool.snapshot_valid_row / snapshot_audit 同源)
STAMP_FIELDS = ("snapshot_hash", "snapshot_ts", "snapshot_url")
#: 存证清单上限 (超限截断并置 stamps_truncated; 防巨池把附录撑爆)
MAX_STAMPS = 2000
#: ACH 矩阵正文最多展示的证据行 (聚合计全量, 仅正文截断)
ACH_MAX_ROWS = 40
#: grade → 兼容分权重 (Cochrane 分级, 与 ach_arena.GRADE_W 同值)
GRADE_W = {"A": 1.0, "B": 0.7, "C": 0.4}
#: stance → 假设兼容分 (ach_arena v0 映射, 同源复刻; 超树假设按序轮转)
_STANCE_COMPAT = {
    "support": {"H1": 1.0, "H2": -1.0, "H3": 0.3},
    "against": {"H1": -1.0, "H2": 1.0, "H3": 0.3},
    "contradict": {"H1": -0.5, "H2": -0.5, "H3": -0.5},
}


# ---------- 基础读取 (真实池只读) ----------
def load_manifest(camp_dir: Path) -> list[dict]:
    """manifest.jsonl → 行列表 (坏行跳过不炸, 与审计器同口径)."""
    mp = camp_dir / "manifest.jsonl"
    if not mp.is_file():
        raise FileNotFoundError(f"manifest 不存在: {mp}")
    rows: list[dict] = []
    for ln in mp.read_text(encoding="utf-8").splitlines():
        if not ln.strip():
            continue
        try:
            rows.append(json.loads(ln))
        except json.JSONDecodeError:
            continue
    return rows


def _load_json(path: Path) -> dict | None:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except (OSError, json.JSONDecodeError):
        return None


def load_tree(camp_dir: Path) -> dict | None:
    """question_tree_v2 优先 v1 兜底 (与 depth_ladder 同口径)."""
    for name in TREE_NAMES:
        t = _load_json(camp_dir / name)
        if t is not None:
            return t
    return None


# ---------- ① PRISMA 漏斗 (实算) ----------
def tier_split(valid_rows: list[dict], t1k: list[str], t2k: list[str],
               kws: list[str]) -> dict:
    """有效行标题级分层 (与 ammo_pool.tier_report 同口径):
    T1/T2 词表命中 → 课题词 (pool_state.kws) 命中 T3 → 泛命中 T0;
    dedup 后首行记账 (manifest 行=文件×问题对, 行累加=虚账)."""
    t = {"t1": 0, "t2": 0, "t3": 0, "t0": 0,
         "n1": 0, "n2": 0, "n3": 0, "n0": 0}
    seen: set[str] = set()
    for r in valid_rows:
        key = str(r.get("dedup_key") or r.get("url_norm")
                  or r.get("source_path") or "")
        if key:
            if key in seen:
                continue
            seen.add(key)
        title = os.path.basename(str(r.get("source_path")
                                     or r.get("url_norm") or ""))
        ch = r.get("chars") or 0
        if t1k and any(k in title for k in t1k):
            tk, nk = "t1", "n1"
        elif t2k and any(k in title for k in t2k):
            tk, nk = "t2", "n2"
        elif any(k in title for k in kws):
            tk, nk = "t3", "n3"
        else:
            tk, nk = "t0", "n0"
        t[tk] += ch
        t[nk] += 1
    return t


def funnel(camp_dir: Path) -> dict:
    """识别→judge 三态→有效分层, 全部实算 (纯读)."""
    rows = load_manifest(camp_dir)
    st = _load_json(camp_dir / "pool_state.json") or {}
    tiers_cfg = _load_json(camp_dir / "tiers.json") or {}
    valid = [r for r in rows if r.get("judge") == "valid"]
    rejected = [r for r in rows if r.get("judge") == "rejected"]
    pending = [r for r in rows if r.get("judge") == "pending"]
    other = len(rows) - len(valid) - len(rejected) - len(pending)
    ti = tier_split(valid, tiers_cfg.get("T1") or [], tiers_cfg.get("T2") or [],
                    st.get("kws") or [])
    return {
        "identified": len(rows),
        "valid": len(valid), "valid_chars": sum(r.get("chars") or 0
                                                for r in valid),
        "rejected": len(rejected), "rejected_chars": sum(
            r.get("chars") or 0 for r in rejected),
        "pending": len(pending), "pending_chars": sum(
            r.get("chars") or 0 for r in pending),
        "judge_other": other,
        "tiers": ti, "kws": st.get("kws") or [],
        "tiers_configured": bool(tiers_cfg.get("T1")),
    }


def reconcile(camp_dir: Path, f: dict) -> dict:
    """REQ-026.AC1 对账: 漏斗计数 vs pool_state 三态 + 行数守恒, 零差口径."""
    st = _load_json(camp_dir / "pool_state.json") or {}
    pairs = (("items", f["valid"]), ("pending_items", f["pending"]),
             ("rejected_items", f["rejected"]))
    diffs: list[dict] = []
    for field, mine in pairs:
        theirs = st.get(field)
        if theirs is not None and int(theirs) != int(mine):
            diffs.append({"field": field, "pool_state": int(theirs),
                          "manifest": int(mine)})
    if all(st.get(k) is not None for k, _ in pairs):
        triple = sum(int(st.get(k, 0)) for k, _ in pairs)
        if triple != f["identified"]:
            diffs.append({"field": "items+pending+rejected",
                          "pool_state": triple, "manifest": f["identified"]})
    return {"ok": not diffs, "diffs": diffs,
            "pool_state": {k: st.get(k) for k, _ in pairs}}


def render_funnel_md(campaign: str, f: dict, rec: dict) -> str:
    ts = time.strftime("%Y-%m-%d %H:%M")
    t = f["tiers"]
    L: list[str] = []
    L.append(f"# 采集漏斗 (PRISMA 2020 流程图口径) — {campaign}")
    L.append("")
    L.append(f"> 生成: {ts} | 数据源: `ammo_pool/{campaign}/` "
             f"(manifest.jsonl + pool_state.json + tiers.json, 全实算) "
             f"| 口径: PRISMA 2020 (CC BY)")
    L.append("")
    L.append("## 漏斗计数表")
    L.append("")
    L.append("| 步骤 | 计数(件) | 字符 | 理由 (每步一句) |")
    L.append("|---|---|---|---|")
    L.append(f"| ① 识别 (identified) | {f['identified']:,} | — "
             f"| 检索引擎全量清单 = manifest 总行数 (行=文件×问题对) |")
    L.append(f"| ② 入池判定 judge=valid | {f['valid']:,} "
             f"| {f['valid_chars']:,} | judge 三态之有效: 证据力达标入池, "
             f"供后续分层与论证线取用 |")
    L.append(f"| ② 入池判定 judge=rejected | {f['rejected']:,} "
             f"| {f['rejected_chars']:,} | judge 三态之否决: 证据力不足/"
             f"重复/离题, 不入论证线 |")
    L.append(f"| ② 入池判定 judge=pending | {f['pending']:,} "
             f"| {f['pending_chars']:,} | judge 三态之待审: fail-soft 挂起, "
             f"不计入有效弹药 |")
    if f["judge_other"]:
        L.append(f"| ② 其他 judge 态 | {f['judge_other']:,} | — "
                 f"| 非三态行如实单列, 待归档 |")
    L.append(f"| ③ 有效分层 T1 | {t['n1']:,} | {t['t1']:,} | "
             f"tiers.json T1 核心词表标题级命中 (dedup 后首行记账) |")
    L.append(f"| ③ 有效分层 T2 | {t['n2']:,} | {t['t2']:,} | "
             f"tiers.json T2 词表标题级命中, T1 未命中者 |")
    L.append(f"| ③ 有效分层 T3 (参考账) | {t['n3']:,} | {t['t3']:,} | "
             f"课题词 (pool_state.kws, {len(f['kws'])} 条) 标题级命中, "
             f"行业框架参考 |")
    L.append(f"| ③ 泛命中 T0 (不计入) | {t['n0']:,} | {t['t0']:,} | "
             f"标题无课题词的泛命中, 不计入门槛账 |")
    L.append("")
    if not f["tiers_configured"]:
        L.append("> ⚠ tiers.json 未配置 T1 词表 — 分层列为空表口径, "
                 "须补词表后重建。")
        L.append("")
    L.append("## pool_state 对账 (REQ-026.AC1 零差口径)")
    L.append("")
    L.append("| 字段 | pool_state | manifest 实算 | 差 |")
    L.append("|---|---|---|---|")
    ps = rec["pool_state"]
    for field, mine in (("items", f["valid"]),
                        ("pending_items", f["pending"]),
                        ("rejected_items", f["rejected"])):
        theirs = ps.get(field)
        mark = "—" if theirs is None or int(theirs) == int(mine) else \
            f"**{int(theirs) - int(mine):+d}**"
        L.append(f"| {field} | "
                 f"{('—' if theirs is None else format(int(theirs), ','))} "
                 f"| {mine:,} | {mark} |")
    L.append("")
    if rec["ok"]:
        L.append("**判定: 零差 ✓** — 漏斗计数与 pool_state 三态一致。")
    else:
        L.append("**判定: 有差 ⛔** — 差异字段: "
                 + "; ".join(f"{d['field']} pool_state={d['pool_state']} "
                             f"vs manifest={d['manifest']}"
                             for d in rec["diffs"]))
    L.append("")
    return "\n".join(L)


# ---------- ② ACH 证据×假设矩阵 ----------
def _row_host(row: dict) -> str:
    h = host_of(str(row.get("url_norm") or ""))
    if h:
        return h
    sp = str(row.get("source_path") or "")
    return Path(sp).stem if sp else ""


def stance_compat(stance: str) -> dict[str, float]:
    """stance → 假设兼容分 (ach_arena v0 同源; 优先复用在档实现)."""
    try:
        import ach_arena                            # noqa: PLC0415  防御式
        return ach_arena.stance_to_compat(stance)
    except Exception:                               # 本地同值兜底
        return _STANCE_COMPAT.get(str(stance or "support").lower(),
                                  _STANCE_COMPAT["contradict"])


def _find_ach_product(camp_dir: Path) -> Path | None:
    """战役在档 ach_arena 产物 (ach_arena*.{json,md} 优先, ach* 次之)."""
    cands = sorted(p for p in camp_dir.glob("ach_arena*.json")) \
        + sorted(p for p in camp_dir.glob("ach_arena*.md")) \
        + sorted(p for p in camp_dir.glob("ach*.json")) \
        + sorted(p for p in camp_dir.glob("ach*.md"))
    return cands[0] if cands else None


def _cell_label(c: float) -> str:
    if c > 0:
        return f"C {c:+.1f}"
    if c < 0:
        return f"I {c:+.1f}"
    return "N 0.0"


def render_ach_md(campaign: str, camp_dir: Path) -> str:
    ts = time.strftime("%Y-%m-%d %H:%M")
    rows = [r for r in load_manifest(camp_dir) if r.get("judge") == "valid"]
    hung = [r for r in rows if r.get("tree_node")]
    L: list[str] = [f"# 证据×假设矩阵 (ACH) — {campaign}", "",
                    f"> 生成: {ts} | 方法: Heuer ACH 排除法 (兼容分 C/I/N, "
                    f"得分最低者先排除) | 口径: ach_arena v0 "
                    f"(挂树独立源×grade 权重)", ""]

    prod = _find_ach_product(camp_dir)
    if prod is not None:                            # 在档产物优先转录
        L.append(f"## ach_arena 在档产物转录: `{prod.name}`")
        L.append("")
        L.append("```json")
        L.append(prod.read_text(encoding="utf-8").strip())
        L.append("```")
        L.append("")
        return "\n".join(L)

    tree = load_tree(camp_dir)
    hyps = (tree or {}).get("hypotheses") or []

    if hyps:                                        # 全矩阵路径
        hids = [str(h.get("id")) for h in hyps]
        base = stance_compat("support")             # 键序模板 (H1/H2/H3)
        order = [k for k in base if k in hids] + \
                [k for k in hids if k not in base]
        score = {h: 0.0 for h in hids}
        hurt: dict[str, list[str]] = {h: [] for h in hids}
        help_: dict[str, list[str]] = {h: [] for h in hids}
        seen: set[tuple] = set()
        ev_rows: list[tuple] = []                   # (label, stance, compat)
        for r in hung:
            host = _row_host(r)
            kk = (host, str(r["tree_node"]))
            if kk in seen:                          # 同 host 同 EEI 只计一次
                continue
            seen.add(kk)
            comp = stance_compat(str(r.get("stance") or "support"))
            w = GRADE_W.get(str(r.get("grade") or "C"), 0.4)
            label = f"{r['tree_node']}({host[:18]},{r.get('grade', 'C')})"
            ev_rows.append((label, str(r.get("stance") or "support"),
                            {h: comp.get(h, 0.0) for h in hids}))
            for h in hids:
                c = comp.get(h, 0.0)
                score[h] += c * w
                (hurt[h] if c < 0 else help_[h]).append(label)
        L.append(f"## 矩阵 (证据 {len(rows):,} 条, 挂树独立源-EEI 对 "
                 f"{len(seen):,})")
        L.append("")
        L.append("| 证据 (EEI·host·grade) | stance | "
                 + " | ".join(hids) + " |")
        L.append("|---|---|" + "---|---|" * (len(hids) - 1) + "---|")
        for label, stance, comp in ev_rows[:ACH_MAX_ROWS]:
            L.append(f"| {label} | {stance} | "
                     + " | ".join(_cell_label(comp[h]) for h in hids) + " |")
        if len(ev_rows) > ACH_MAX_ROWS:
            L.append(f"| …正文截断 (聚合含全量 {len(ev_rows):,} 行) | | "
                     + " | ".join("…" for _ in hids) + " |")
        L.append("")
        L.append("## 排除法排序 (得分最低=最先排除; grade 权重 A1.0/B0.7/C0.4)")
        L.append("")
        L.append("| 假设 | 兼容分合计 | 文本 |")
        L.append("|---|---|---|")
        ranked = sorted(hyps, key=lambda h: score[str(h.get("id"))])
        for h in ranked:
            hid = str(h.get("id"))
            L.append(f"| {hid} | {score[hid]:+.1f} "
                     f"| {str(h.get('text') or '')[:60]} |")
        L.append("")
        best, worst = ranked[-1], ranked[0]
        L.append(f"- 领先假设: **{best.get('id')}** — 反证拦截 (确认偏误检查):")
        for x in hurt[str(best.get("id"))][:3]:
            L.append(f"  - ↳ 反驳证据 {x}")
        if not hurt[str(best.get("id"))]:
            L.append("  - ⚠ 零反证记录 — 领先假设未经对抗, 禁止直接采信 "
                     "(须补 against 证据后重跑)")
        L.append(f"- 最先排除: {worst.get('id')} — 排除依据 (最伤它的证据):")
        for x in hurt[str(worst.get("id"))][:3]:
            L.append(f"  - ↳ {x}")
        L.append("")
        return "\n".join(L)

    # ---- degraded: 无 ACH 产物且树无假设 → against-EEI 矩阵雏形 ----
    L.append("## [degraded] 反证位矩阵雏形 — 树无 hypotheses, 无 ACH 产物")
    L.append("")
    L.append("> 显式降级: 本战役 question_tree 未定义竞争假设且无 ach_arena "
              "产物, 无法出完整证据×假设矩阵; 以下为挂树 stance=against 的 "
              "EEI×证据列表雏形, 供补假设后重跑。")
    L.append("")
    from collections import Counter
    sc = Counter(str(r.get("stance") or "") for r in hung)
    if hung:
        L.append(f"有效证据 {len(rows):,} 条 (挂树 {len(hung):,}): stance 分布 "
                 + ", ".join(f"{k or '∅'}={v:,}" for k, v in sc.most_common())
                 + "。")
    else:
        L.append(f"有效证据 {len(rows):,} 条, 但**挂树 0 条** — 证据未挂 "
                 f"question_tree 节点, ACH 无从起算 (须先挂树再补假设)。")
    L.append("")
    against_rows = [r for r in hung
                    if str(r.get("stance") or "").lower()
                    in ("against", "contradict")]
    groups: dict[str, list[dict]] = {}
    for r in against_rows:
        groups.setdefault(str(r["tree_node"]), []).append(r)
    # 树内反证位 EEI (stance=against) 并入, 零证据也列出 (缺口显式)
    for q in (tree or {}).get("subquestions", []):
        for e in q.get("eeis", []):
            if str(e.get("stance") or "").lower() in ("against", "contradict"):
                groups.setdefault(str(e.get("id")), [])
    if not groups:
        L.append("**⚠ 零反证记录** — 挂树证据中无 stance=against/contradict "
                 "条目: 当前为未经对抗的单边叙事, 禁止直接采信 "
                 "(须补 against 证据并建假设后重跑)。")
    else:
        L.append("| EEI (反证位) | against 证据数 | 证据清单 (host·grade·源) |")
        L.append("|---|---|---|")
        for eid in sorted(groups):
            ev = groups[eid]
            if ev:
                cell = "; ".join(f"{_row_host(r)[:18]}·{r.get('grade', 'C')}"
                                 f"·{os.path.basename(str(r.get('source_path') or r.get('url_norm') or ''))}"
                                 for r in ev[:5])
                cell += f" (+{len(ev) - 5} 条)" if len(ev) > 5 else ""
            else:
                cell = "∅ 零证据 (缺口在案)"
            L.append(f"| {eid} | {len(ev)} | {cell} |")
    L.append("")
    return "\n".join(L)


# ---------- ③ 覆盖热图 (防御式复用 heatmap_gen, 兜底内嵌渲染) ----------
def _try_heatmap_gen(campaign: str, pool_root: Path) -> str | None:
    """T-009 heatmap_gen 在档且可调 → 用其 render; 任何异常回 None.

    接线序 (防御式, 零副作用 — 不触发 heatmap_gen 自己的 work/ 落盘):
      A. render(campaign, pool_root, write=False) → payload dict →
         render_md(payload) 取文 (T-009 实测形态, md/json 逐键同源)
      B. render 直接返回 str / dict 带 md 键 (未来形态兼容)
    """
    try:
        import importlib
        mod = importlib.import_module("completeness.heatmap_gen")
        render = getattr(mod, "render", None)
        if not callable(render):
            render = getattr(mod, "render_heatmap", None)
        if not callable(render):
            return None
        try:                                        # A: payload → render_md
            payload = render(campaign=campaign, pool_root=str(pool_root),
                             write=False)
            if isinstance(payload, dict):
                rm = getattr(mod, "render_md", None)
                if callable(rm):
                    md = rm(payload)
                    if isinstance(md, str) and md.strip():
                        return md
                for k in ("md", "markdown", "text", "content"):
                    v = payload.get(k)
                    if isinstance(v, str) and v.strip():
                        return v
        except Exception:
            pass
        try:                                        # B: str 返回形态 (仍零副作用)
            out = render(campaign=campaign, pool_root=str(pool_root),
                         write=False)
            if isinstance(out, str) and out.strip():
                return out
            if out is not None and not isinstance(out, (dict, list)):
                return str(out)
        except Exception:
            pass
    except Exception:
        return None
    return None


def _fallback_heatmap_md(campaign: str, camp_dir: Path) -> str:
    """内嵌简版热图: completeness_ledger.jsonl 五轴+CIdx 表+豁免/降级清单."""
    ts = time.strftime("%Y-%m-%d %H:%M")
    L = [f"# 覆盖热图 (五轴完备性) — {campaign}", "",
         f"> 生成: {ts} | 数据源: `ammo_pool/{campaign}/"
         f"completeness_ledger.jsonl` | 渲染: appendix_builder 内嵌简版 "
         f"(T-009 heatmap_gen 未接线, 防御式兜底)", ""]
    ledger: list[dict] = []
    lp = camp_dir / "completeness_ledger.jsonl"
    if lp.is_file():
        for ln in lp.read_text(encoding="utf-8").splitlines():
            if not ln.strip():
                continue
            try:
                ledger.append(json.loads(ln))
            except json.JSONDecodeError:
                continue
    if not ledger:
        L.append("**[degraded]** 账本缺席 — 五轴账未汇聚, 须先跑 "
                 "`completeness/cidx.py --campaign` 后重建本附录。")
        return "\n".join(L) + "\n"
    axis_rows: dict[str, dict] = {}
    cidx_row: dict | None = None
    for r in ledger:                                # 末行胜出 (账本追加制)
        ax = str(r.get("axis") or "")
        if ax in ("T", "B", "D", "P", "C"):
            axis_rows[ax] = r
        elif ax == "CIdx":
            cidx_row = r
    L.append("| 轴 | 传感器 | 得分 | 状态 | 备注 |")
    L.append("|---|---|---|---|---|")
    for ax in ("T", "B", "D", "P", "C"):
        r = axis_rows.get(ax)
        if r is None:
            L.append(f"| {ax} | — | — | 缺行 | 账本无该轴行 |")
            continue
        score = r.get("score")
        score_s = f"{float(score):.4f}" if isinstance(score, (int, float)) \
            else "—"
        if r.get("missing"):
            state = "缺轴"
        elif r.get("waived"):
            state = "豁免"
        elif r.get("green"):
            state = "绿"
        else:
            state = "红"
        L.append(f"| {ax} | {r.get('sensor', '—')} | {score_s} | {state} "
                 f"| {str(r.get('note') or '')[:60]} |")
    L.append("")
    L.append("## 完备度指数 CIdx")
    L.append("")
    if cidx_row is None:
        L.append("- 账本无 CIdx 汇总行 (须跑 cidx 汇聚)。")
    else:
        v = cidx_row.get("cidx")
        v_s = f"{float(v):.4f}" if isinstance(v, (int, float)) else "—"
        miss = cidx_row.get("missing_axes") or []
        waived = cidx_row.get("waived_axes") or []
        allg = cidx_row.get("all_green")
        L.append(f"- **CIdx = {v_s}** "
                 f"(公式 0.25·T覆+0.20·B覆+0.20·D覆+0.20·P均深归一+0.15·C覆)")
        L.append(f"- 全绿判定 all_green_or_waived: "
                 f"{'✓' if allg else '✗ (缺口在案)'}"
                 + (f" | 缺轴: {', '.join(map(str, miss))}" if miss else "")
                 + (f" | 豁免轴: {', '.join(map(str, waived))}"
                    if waived else ""))
    L.append("")
    flagged = [r for r in axis_rows.values()
               if r.get("waived") or r.get("missing") or r.get("note")]
    L.append("## 豁免/降级清单")
    L.append("")
    if not flagged:
        L.append("- 无豁免/降级/缺轴项。")
    else:
        for r in flagged:
            why = ("缺轴" if r.get("missing")
                   else "豁免" if r.get("waived") else "降级")
            L.append(f"- 轴 {r.get('axis')} [{why}] "
                     f"{str(r.get('note') or '未附理由')[:80]}")
    L.append("")
    L.append("图例: 绿=传感器过门 | 红=未过门 | 豁免=显式人工豁免 (不计绿但"
             "不阻断) | 缺轴=传感器缺席计 0 | C/I/N=ACH 兼容标记 (见 ACH 附录)")
    L.append("")
    return "\n".join(L)


def render_heatmap_md(campaign: str, pool_root: Path) -> tuple[str, str]:
    out = _try_heatmap_gen(campaign, pool_root)
    if out is not None:
        return out, "heatmap_gen"
    return _fallback_heatmap_md(campaign, pool_root / campaign), "internal"


# ---------- ④ 存证时间戳清单 + 抽检回放 ----------
def stamps(camp_dir: Path) -> dict:
    """valid 行带快照三字段者的清单 + 总量/覆盖统计 (Bellingcat 取证链)."""
    rows = [r for r in load_manifest(camp_dir) if r.get("judge") == "valid"]
    full = [r for r in rows
            if all(str(r.get(k) or "") for k in STAMP_FIELDS)]
    pend = sum(1 for r in rows if r.get("snapshot_pending"))
    out: list[dict] = []
    for r in full[:MAX_STAMPS]:
        out.append({
            "dedup_key": r.get("dedup_key", ""),
            "tree_node": str(r.get("tree_node") or ""),
            "url_norm": r.get("url_norm", ""),
            "grade": r.get("grade", ""),
            "engine": r.get("engine", ""),
            "snapshot_hash": str(r["snapshot_hash"]),
            "snapshot_ts": str(r["snapshot_ts"]),
            "snapshot_url": str(r["snapshot_url"]),
            "snapshot_mode": r.get("snapshot_mode", ""),
        })
    return {
        "campaign": camp_dir.name,
        "generated_at": time.strftime("%Y-%m-%dT%H:%M:%S"),
        "stats": {
            "valid_total": len(rows),
            "with_snapshot": len(full),
            "coverage_pct": round(100.0 * len(full) / len(rows), 1)
            if rows else 0.0,
            "snapshot_pending": pend,
        },
        "stamps_truncated": len(full) > MAX_STAMPS,
        "stamps": out,
    }


def _artifact_path(camp_dir: Path, url: str) -> Path:
    """快照体定位 (与 snapshot_audit 同口径): snapshots/=战役内相对, 余=指针."""
    return camp_dir / url if url.startswith("snapshots/") else Path(url)


def replay_sample(camp_dir: Path, stamp_rows: list[dict],
                  n: int) -> dict:
    """确定性抽样回放: sha256 实测对拍 (抽检位 REQ-026.AC1)."""
    rep = {"sampled": 0, "replayed": 0, "meta_anchored": 0,
           "broken": 0, "details": []}
    if n <= 0 or not stamp_rows:
        return rep
    ordered = sorted(stamp_rows, key=lambda s: str(s["snapshot_hash"]))
    if len(ordered) <= n:
        picks = ordered
    else:                                           # 等距确定性抽样 (可复现)
        step = len(ordered) / n
        picks = [ordered[min(int(i * step), len(ordered) - 1)]
                 for i in range(n)]
    for s in picks:
        rep["sampled"] += 1
        fp = _artifact_path(camp_dir, str(s["snapshot_url"]))
        verdict = "broken"
        if fp.is_file():
            digest = hashlib.sha256(fp.read_bytes()).hexdigest()
            if digest == s["snapshot_hash"]:
                verdict = "replayed"
            else:                                   # 截断件 → meta 锚复核
                meta = _load_json(fp.parent / "meta.json") or {}
                if meta.get("sha256") == s["snapshot_hash"]:
                    verdict = "meta_anchored"
        rep[verdict if verdict in rep else "broken"] += 1
        rep["details"].append({"snapshot_hash": s["snapshot_hash"],
                               "snapshot_url": s["snapshot_url"],
                               "verdict": verdict})
    return rep


# ---------- 总装 ----------
def build(campaign: str, draft_dir, *, pool_root=None,
          sample: int | None = None) -> dict:
    """四件套总装 (真实池只读, 输出只增). 返回汇总 (含漏斗/对账/回放)."""
    root = Path(pool_root) if pool_root else DEFAULT_POOL_ROOT
    camp_dir = root / campaign
    appendix = Path(draft_dir) / "appendix"
    appendix.mkdir(parents=True, exist_ok=True)

    f = funnel(camp_dir)
    rec = reconcile(camp_dir, f)
    (appendix / "prisma_funnel.md").write_text(
        render_funnel_md(campaign, f, rec), encoding="utf-8")

    (appendix / "ach_matrix.md").write_text(
        render_ach_md(campaign, camp_dir), encoding="utf-8")

    heat_md, heat_src = render_heatmap_md(campaign, root)
    (appendix / "coverage_heatmap.md").write_text(heat_md, encoding="utf-8")

    st = stamps(camp_dir)
    rp = replay_sample(camp_dir, st["stamps"], sample) if sample else None
    if rp is not None:
        st["sample_replay"] = rp
    (appendix / "evidence_stamps.json").write_text(
        json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")

    return {"campaign": campaign,
            "appendix_dir": str(appendix), "files": 4,
            "funnel": f, "reconcile": rec,
            "heatmap_source": heat_src,
            "stamps_stats": st["stats"], "sample_replay": rp}


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="REQ-026 过程附录四件套 (PRISMA 漏斗/ACH 矩阵/"
                    "覆盖热图/存证时间戳)")
    ap.add_argument("--campaign", required=True, help="campaign_id")
    ap.add_argument("--draft-dir", default=None,
                    help="成稿目录 (缺省=V3 work/appendix_demo_<战役>/ 演示件)")
    ap.add_argument("--pool-root", default=str(DEFAULT_POOL_ROOT))
    ap.add_argument("--reconcile", action="store_true",
                    help="打印 pool_state 对账结果并按零差口径定退出码")
    ap.add_argument("--sample", type=int, default=0,
                    help="抽检 N 条快照哈希回放 (0=不抽)")
    args = ap.parse_args(argv)
    draft = args.draft_dir or (V3_WORK / f"appendix_demo_{args.campaign}")
    s = build(args.campaign, draft, pool_root=args.pool_root,
              sample=args.sample or None)
    f = s["funnel"]
    print(f"[appendix] {args.campaign} 四件落 {s['appendix_dir']}")
    print(f"[appendix] 漏斗: 识别 {f['identified']:,} → valid {f['valid']:,} "
          f"/ rejected {f['rejected']:,} / pending {f['pending']:,} "
          f"→ T1 {f['tiers']['n1']:,}·{f['tiers']['t1']:,}字 "
          f"T2 {f['tiers']['n2']:,}·{f['tiers']['t2']:,}字 "
          f"T3 {f['tiers']['n3']:,}·{f['tiers']['t3']:,}字")
    print(f"[appendix] 热图渲染源: {s['heatmap_source']} | 存证: "
          f"valid {s['stamps_stats']['valid_total']:,} / 带快照 "
          f"{s['stamps_stats']['with_snapshot']:,} "
          f"({s['stamps_stats']['coverage_pct']}%)")
    rc = 0
    if args.reconcile:
        if s["reconcile"]["ok"]:
            print("[appendix] 对账: 零差 ✓ (漏斗计数 ↔ pool_state 三态一致)")
        else:
            print("[appendix] 对账: 有差 ⛔ "
                  + "; ".join(f"{d['field']}: pool_state={d['pool_state']} "
                              f"vs manifest={d['manifest']}"
                              for d in s["reconcile"]["diffs"]))
            rc = 2
    if s["sample_replay"] is not None:
        r = s["sample_replay"]
        print(f"[appendix] 抽检回放: 采样 {r['sampled']} | sha 对拍通过 "
              f"{r['replayed']} | meta 锚 {r['meta_anchored']} | 断锚 "
              f"{r['broken']}")
        if r["broken"]:
            rc = 2
    return rc


if __name__ == "__main__":
    sys.exit(main())
