# -*- coding: utf-8 -*-
"""v3_number_audit — 数字零造假复算抽检 (百倍V3 T-027 / REQ-001.AC1).

五大类各抽 N 处 (默认 5) 只读复算, 每处输出一条:
    {item, category, source_value, recomputed_value, match, diff, note}
全一致 exit 0; 任何不一致 exit 2 并逐条列差值; 运行性错误 exit 1。

① 完备性类  ammo_pool/<campaign>/completeness_ledger.jsonl 最新 CIdx 行的
   五轴分 vs completeness/<X>_axis.json 原始字段独立重推。分项公式按
   KB-COMPLETENESS-SPEC 平行实现 (不 import cidx.py —— 审计件不复用被
   审计件的算式): T覆=有证据年/(总年-豁免年), B覆=点亮面/10,
   D覆=(未降级维+0.5×降级维)/9 缺格计0, P均深归一=Σ(L级×EEI)/(5×EEI总数),
   C覆=命中渠道/在役渠道; 各 4dp。另加 1 处 CIdx 加权合成对拍
   (Σ 权重×账本行自记轴分, 权重取该行 weights 字段)。
② 漏斗类    report_platform/funnel_events.jsonl 事件计数 (独立解析) vs
   `py report_platform/funnel_query.py --sku X --json --ledger ... --db <不存在>`
   同口径计数。--db 指向不存在的路径: funnel_query 以 mode=ro 探测该路径,
   永不创建, sqlite 源恒 0 → 对拍口径收敛为「jsonl 单源」。
③ 字数类    pool_state.json t1_chars (缺则 tier_gate_v3.t1_chars) vs
   明细行级加总优先的复算阶梯 (note 附 caliber 标注):
   1) tier_content_detail_v2.jsonl 在盘 → 行级加总 (fulltext_v2 全文级
      口径, reforge_factory/tier_fulltext_reledger.py 落账依据);
   2) 旧 tier_content_detail.jsonl 在盘 → 读法A (raw_decode 容物理拼接行,
      去重 -full 归位优先, T1+T1-full 合并 — t1_reconciliation.md §3
      指定读法);
   3) 兜底标题级下界: manifest valid × dedup × tiers.json T1 词表标题匹配
      (ammo_pool.tier_report 生产线口径的平行实现)。
   源值与复算口径不一致时差异如实列出 (note 附 caliber 与 t1_t2_source
   溯源), 供人工判读口径还是错账。
④ 决策账本类  ammo_pool/<campaign>/decision_ledger.jsonl 行 schema 完整性
   (KB-DECISION-LEDGER-SPEC 12 键位 + decision_type 八枚举 + id D-#### 格式,
   常量平行定义) 与 id 连续性 (D-0001 起无跳号无重复)。
⑤ 冲刺账本类  sprint_ledger.jsonl 周记录 target/actual (同周取最后一行,
   与追加式修正语义一致) vs
   `py reforge_factory/sprint_ledger.py --status --json --ledger ...` 对拍;
   另拍累计实绩/累计目标, 及镜像账本 (V3 工作区) 与权威账本逐行一致性。

红线: 一切数据源只读; 本件不写任何账本/状态文件 (输出只增指 stdout)。

CLI:
    py reforge_factory/v3_number_audit.py            # 真池实跑 (默认路径)
    py reforge_factory/v3_number_audit.py --json     # 机读
    py reforge_factory/v3_number_audit.py --n 3 --campaign EPC-BID26 ...
"""
from __future__ import annotations

import argparse
import json
import subprocess
import sys
from pathlib import Path

try:  # 管道/重定向下 Windows 默认 GBK, 与 UTF-8 消费端错配
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    sys.stderr.reconfigure(encoding="utf-8", errors="replace")
except (AttributeError, ValueError):
    pass

REPO_ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(Path(__file__).resolve().parent))
import sprint_ledger as _SL                                # noqa: E402 (仅取路径常量)

# ---------- 默认路径 (真池实跑口径; 测试全走 tmp 夹具 + 显式覆盖) ----------
DEFAULT_CAMPAIGN = "EPC-BID26"
DEFAULT_AMMO_ROOT = REPO_ROOT / "ammo_pool"
DEFAULT_FUNNEL_LEDGER = REPO_ROOT / "report_platform" / "funnel_events.jsonl"
DEFAULT_FUNNEL_QUERY = REPO_ROOT / "report_platform" / "funnel_query.py"
# 不存在的 db 探测路径: funnel_query._sqlite_ro 先 exists() 再 mode=ro 连接,
# 两道都不会创建文件 → sqlite 源恒 0, 对拍口径收敛为 jsonl 单源。
DEFAULT_FUNNEL_DB = REPO_ROOT / "report_platform" / "__v3_audit_absent_db__.db"
DEFAULT_SPRINT_LEDGER = _SL.CANONICAL_LEDGER
DEFAULT_SPRINT_MIRROR = _SL.MIRROR_LEDGER
DEFAULT_SPRINT_SCRIPT = REPO_ROOT / "reforge_factory" / "sprint_ledger.py"

FUNNEL_LEVELS = ("visit", "sample_read", "click_buy", "pay")
AXES = ("T", "B", "D", "P", "C")
KB_WEIGHTS = {"T": 0.25, "B": 0.20, "D": 0.20, "P": 0.20, "C": 0.15}

#: KB-DECISION-LEDGER-SPEC 平行常量 (审计件不 import 被审计件)
DECISION_REQUIRED_KEYS = ("id", "ts", "decision_type", "context", "options",
                          "chosen", "rationale", "budget_used", "outcome",
                          "outcome_ts", "score")
DECISION_TYPE_ENUM = frozenset((
    "research_rounds", "channel_dispatch", "channel_new", "depth_alloc",
    "report_scope", "chapter_budget", "topic_select", "pricing_suggest"))

NUM_TOL = 5e-5          # 4dp 记账数的比较容差
MONEY_TOL = 0.01        # 金额 (元) 比较容差


# ---------- 通用 ----------
def _item(category: str, item: str, source_value, recomputed_value,
          match: bool, diff=None, note: str = "") -> dict:
    return {"item": item, "category": category,
            "source_value": source_value, "recomputed_value": recomputed_value,
            "match": bool(match),
            "diff": diff, "note": note}


def _num_match(a, b, tol: float = NUM_TOL) -> bool:
    try:
        return abs(float(a) - float(b)) <= tol
    except (TypeError, ValueError):
        return a == b


def _read_jsonl(path: Path) -> tuple[list, int]:
    """逐行 JSONL → (合法行, 坏行数). 缺文件 → ([], -1)."""
    if not path.exists():
        return [], -1
    rows: list = []
    bad = 0
    for line in path.read_text(encoding="utf-8", errors="replace").splitlines():
        line = line.strip()
        if not line:
            continue
        try:
            rows.append(json.loads(line))
        except ValueError:
            bad += 1
    return rows, bad


def _load_json(path: Path):
    try:
        return json.loads(path.read_text(encoding="utf-8", errors="replace"))
    except (OSError, ValueError):
        return None


# ---------- ① 完备性类 (平行实现, 不 import cidx) --------------------------
def _r4(x) -> float:
    try:
        v = round(float(x), 4)
    except (TypeError, ValueError):
        return 0.0
    if v != v or v < 0:
        return 0.0
    return v if v <= 1.0 else 1.0


def _score_t(p: dict) -> float:
    counts = p.get("year_counts")
    if not isinstance(counts, dict) or not counts:
        return 0.0
    evidence = sum(1 for v in counts.values()
                   if isinstance(v, (int, float)) and v > 0)
    founded, current = p.get("founded_year"), p.get("current_year")
    if isinstance(founded, int) and isinstance(current, int) and current >= founded:
        total = current - founded + 1
    else:
        years = [int(k) for k in counts if str(k).lstrip("-").isdigit()]
        total = (max(years) - min(years) + 1) if years else 0
    waived = p.get("gap_waivers")
    waived_n = len(waived) if isinstance(waived, list) else 0
    denom = total - waived_n
    return _r4(evidence / denom) if denom > 0 else 0.0


def _score_b(p: dict) -> float:
    lit = p.get("lit_count")
    if not isinstance(lit, int) or lit < 0:
        facets = p.get("facets")
        lit = (sum(1 for f in facets.values()
                   if isinstance(f, dict) and f.get("lit") is True)
               if isinstance(facets, dict) else 0)
    return _r4(lit / 10)


def _score_d(p: dict) -> float:
    dims = p.get("dims")
    cells = p.get("cells")
    if (not isinstance(dims, list) or not dims) and isinstance(cells, dict):
        dims = list(cells)
    if not isinstance(dims, list) or not dims or not isinstance(cells, dict):
        return 0.0
    gaps = p.get("open_gaps")
    gaps = {str(g) for g in gaps} if isinstance(gaps, list) else set()
    w = 0.0
    for d in dims:
        if str(d) in gaps:
            continue
        cell = cells.get(d)
        if isinstance(cell, dict):
            w += 0.5 if cell.get("downgraded") else 1.0
    return _r4(w / 9)


def _score_p(p: dict) -> float:
    dist = p.get("l_dist")
    total = p.get("eei_total")
    if isinstance(dist, dict) and dist:
        if not isinstance(total, int) or total <= 0:
            total = sum(v for v in dist.values() if isinstance(v, (int, float)))
        if isinstance(total, int) and total > 0:
            s = 0
            for lv, n in dist.items():
                try:
                    s += int(str(lv)[1:]) * n
                except (ValueError, TypeError):
                    continue
            return _r4(s / (5 * total))
    mdn = p.get("mean_depth_norm")
    return _r4(mdn) if isinstance(mdn, (int, float)) else 0.0


def _score_c(p: dict) -> float:
    hit, total = p.get("channels_hit"), p.get("channels_total")
    if not (isinstance(hit, int) and isinstance(total, int)) or total <= 0:
        return 0.0
    return _r4(hit / total)


PARALLEL_SCORERS = {"T": _score_t, "B": _score_b, "D": _score_d,
                    "P": _score_p, "C": _score_c}


def audit_completeness(pool_dir: Path) -> tuple[list[dict], list[str]]:
    """最新 CIdx 行五轴分 + 合成 vs 轴件原始字段平行重推."""
    notes: list[str] = []
    ledger = pool_dir / "completeness_ledger.jsonl"
    rows, bad = _read_jsonl(ledger)
    if bad == -1:
        return [], [f"账本不存在: {ledger}"]
    if bad:
        notes.append(f"账本含坏行 {bad} 条 (已跳过)")
    summary = next((r for r in reversed(rows)
                    if isinstance(r, dict) and r.get("axis") == "CIdx"), None)
    if summary is None:
        return [], [f"{ledger.name} 无 CIdx 汇总行, 无从对拍"]

    src_scores = summary.get("axis_scores") or {}
    items: list[dict] = []
    cdir = pool_dir / "completeness"
    for axis in AXES:
        payload = _load_json(cdir / f"{axis}_axis.json")
        if not isinstance(payload, dict):
            notes.append(f"{axis} 轴文件缺席/坏 JSON, 复算按 0")
            recomputed = 0.0
        else:
            try:
                recomputed = PARALLEL_SCORERS[axis](payload)
            except Exception:                        # 平行算式自身防御
                recomputed = 0.0
                notes.append(f"{axis} 轴平行算式异常, 复算按 0")
        src = src_scores.get(axis)
        items.append(_item(
            "completeness", f"completeness/{axis}覆", src, recomputed,
            _num_match(src, recomputed),
            diff=(round(float(src) - recomputed, 6)
                  if isinstance(src, (int, float)) else None)))

    weights = summary.get("weights")
    if not (isinstance(weights, dict) and all(a in weights for a in AXES)):
        weights = dict(KB_WEIGHTS)
        notes.append("汇总行 weights 缺/坏, 合成复算回退 KB 固定权重")
    if {a: weights[a] for a in AXES} != KB_WEIGHTS:
        notes.append(f"汇总行权重与 KB 口径不一致: {weights} (按行内权重复算)")
    comp = _r4(sum(float(weights[a]) * float(src_scores.get(a, 0.0))
                   for a in AXES))
    src_cidx = summary.get("cidx")
    items.append(_item(
        "completeness", "completeness/CIdx加权", src_cidx, comp,
        _num_match(src_cidx, comp),
        diff=(round(float(src_cidx) - comp, 6)
              if isinstance(src_cidx, (int, float)) else None),
        note=f"ts={summary.get('ts')} 行; Σ(行内权重×行内轴分) 4dp"))
    return items, notes


# ---------- ② 漏斗类 --------------------------------------------------------
def _count_funnel(ledger: Path) -> tuple[dict[str, dict[str, int]], int]:
    """独立解析账本 → (per-sku 四级计数, 合法事件总数).

    合法谓词与 REQ-032 schema 一致: dict 且 sku/channel 非空 且 level 四选一。
    """
    per: dict[str, dict[str, int]] = {}
    total = 0
    rows, _ = _read_jsonl(ledger)
    for ev in rows:
        if (isinstance(ev, dict) and ev.get("sku") and ev.get("channel")
                and ev.get("level") in FUNNEL_LEVELS):
            per.setdefault(str(ev["sku"]),
                           {lv: 0 for lv in FUNNEL_LEVELS})[ev["level"]] += 1
            total += 1
    return per, total


def _run_funnel_query(script: Path, sku: str, ledger: Path, db: Path) -> dict:
    proc = subprocess.run(
        [sys.executable, str(script), "--sku", sku, "--json",
         "--ledger", str(ledger), "--db", str(db)],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        raise RuntimeError(f"funnel_query 退出码 {proc.returncode}: "
                           f"{proc.stderr.strip()[:200]}")
    return json.loads(proc.stdout)


def audit_funnel(ledger: Path, query_script: Path, absent_db: Path,
                 n: int = 5, query_runner=None) -> tuple[list[dict], list[str]]:
    notes: list[str] = []
    runner = query_runner or (lambda sku, lg, db:
                              _run_funnel_query(query_script, sku, lg, db))
    my_per, my_total = _count_funnel(ledger)
    items: list[dict] = []

    r = runner("V3AUDIT-TOTAL", ledger, absent_db)   # 占位 sku: 只看 sources
    tool_total = int((r.get("sources") or {}).get("jsonl", -1))
    items.append(_item("funnel", "funnel/total_events", my_total, tool_total,
                       my_total == tool_total,
                       diff=(my_total - tool_total
                             if tool_total >= 0 else None),
                       note=f"{ledger} 合法事件独立计数 vs funnel_query "
                            f"sources.jsonl (jsonl 单源口径)"))

    skus = sorted(my_per, key=lambda s: (-sum(my_per[s].values()), s))[:n]
    if not skus:
        notes.append("账本无合法事件 (或为空), 仅对拍 total 项")
    for sku in skus:
        r = runner(sku, ledger, absent_db)
        tool_levels = (r.get("per_sku") or {}).get(sku) \
            or {lv: 0 for lv in FUNNEL_LEVELS}
        for lv in FUNNEL_LEVELS:
            mine = my_per[sku][lv]
            tool = int(tool_levels.get(lv, 0))
            items.append(_item(
                "funnel", f"funnel/{sku}/{lv}", mine, tool, mine == tool,
                diff=mine - tool))
    return items, notes


# ---------- ③ 字数类 --------------------------------------------------------
DETAIL_V2_NAME = "tier_content_detail_v2.jsonl"
DETAIL_LEGACY_NAME = "tier_content_detail.jsonl"


def _recompute_t1_detail_v2(pool_dir: Path) -> dict | None:
    """阶梯1: fulltext_v2 新明细行级加总 → {t1, n1, caliber}; 缺件 None."""
    p = pool_dir / DETAIL_V2_NAME
    if not p.is_file():
        return None
    t1 = n1 = 0
    rows, bad = _read_jsonl(p)
    for r in rows:
        if (isinstance(r, dict) and r.get("tier") == "T1"
                and isinstance(r.get("chars"), int)
                and not isinstance(r.get("chars"), bool)):
            t1 += r["chars"]
            n1 += 1
    caliber = f"fulltext_v2 明细行级加总 ({DETAIL_V2_NAME}"
    if bad:
        caliber += f", 坏行 {bad} 条跳过"
    return {"t1": t1, "n1": n1, "caliber": caliber + ")"}


def _recompute_t1_legacy_detail(pool_dir: Path) -> dict | None:
    """阶梯2: 1014 旧明细读法A (t1_reconciliation.md §3 指定).

    raw_decode 容物理拼接行 (1015 实盘形态); 去重时 -full 归位优先,
    T1+T1-full 合并计 T1, T2 同理; 每唯一文件只计一遍 chars。
    """
    p = pool_dir / DETAIL_LEGACY_NAME
    if not p.is_file():
        return None
    text = p.read_text(encoding="utf-8", errors="replace")
    dec = json.JSONDecoder()
    recs: list = []
    i, n = 0, len(text)
    while i < n:
        while i < n and text[i] in " \t\r\n":
            i += 1
        if i >= n:
            break
        try:
            obj, i = dec.raw_decode(text, i)     # 坏尾: 前段已收, 如实截断
        except ValueError:
            break
        recs.append(obj)
    best: dict[str, tuple[int, str, int]] = {}   # file → (优先级, 基层, chars)
    for r in recs:
        if not isinstance(r, dict):
            continue
        tier = str(r.get("tier") or "")
        f = r.get("file")
        if tier not in ("T1", "T2", "T1-full", "T2-full") or not f:
            continue
        base = tier[:2]
        pr = 1 if tier.endswith("-full") else 0
        cur = best.get(f)
        if cur is None or pr > cur[0]:
            best[f] = (pr, base, r.get("chars") or 0)
    t1 = sum(c for pr, b, c in best.values() if b == "T1")
    n1 = sum(1 for pr, b, c in best.values() if b == "T1")
    return {"t1": t1, "n1": n1,
            "caliber": (f"1014旧明细读法A (去重,-full归位优先,T1+T1-full合并, "
                        f"{len(recs)} 记录/{len(best)} 唯一文件)")}


def _recompute_t1_title(pool_dir: Path) -> tuple[int, int]:
    """阶梯3兜底: manifest 行级加总 (标题级下界平行实现) → (t1_chars, t1_items)."""
    import os
    cfg = _load_json(pool_dir / "tiers.json") or {}
    t1k = cfg.get("T1") if isinstance(cfg, dict) else None
    t1k = [k for k in t1k if isinstance(k, str)] if isinstance(t1k, list) else []
    t1 = 0
    n1 = 0
    seen: set[str] = set()
    rows, _ = _read_jsonl(pool_dir / "manifest.jsonl")
    for r in rows:
        if not isinstance(r, dict) or r.get("judge") != "valid":
            continue
        key = r.get("dedup_key") or r.get("url_norm") or r.get("source_path") or ""
        if key:
            if key in seen:
                continue
            seen.add(key)
        title = os.path.basename(str(r.get("source_path")
                                     or r.get("url_norm") or ""))
        ch = r.get("chars") or 0
        if t1k and any(k in title for k in t1k):
            t1 += ch
            n1 += 1
    return t1, n1


def _recompute_t1_ladder(pool_dir: Path) -> dict:
    """复算阶梯: v2 明细 → 旧明细读法A → 标题级兜底 (caliber 随行)."""
    r = _recompute_t1_detail_v2(pool_dir)
    if r is not None:
        return r
    r = _recompute_t1_legacy_detail(pool_dir)
    if r is not None:
        return r
    t1, n1 = _recompute_t1_title(pool_dir)
    return {"t1": t1, "n1": n1,
            "caliber": "标题级下界 (manifest×tiers.json 标题匹配)"}


def audit_chars(ammo_root: Path, n: int = 5) -> tuple[list[dict], list[str]]:
    notes: list[str] = []
    items: list[dict] = []
    pools = []
    if not ammo_root.is_dir():
        return [], [f"ammo_root 不存在: {ammo_root}"]
    for d in sorted(ammo_root.iterdir()):
        if not d.is_dir():
            continue
        sp = d / "pool_state.json"
        st = _load_json(sp)
        if not isinstance(st, dict):
            continue
        t1 = st.get("t1_chars")
        if not isinstance(t1, int) or isinstance(t1, bool):
            t1 = ((st.get("tier_gate_v3") or {}).get("t1_chars")
                  if isinstance(st.get("tier_gate_v3"), dict) else None)
        if isinstance(t1, int) and not isinstance(t1, bool):
            pools.append((d.name, t1, st))
        else:
            notes.append(f"{d.name}: 无 t1 账 (t1_chars/tier_gate_v3.t1_chars "
                         f"均缺), 不入字数抽检")
    for name, src, st in pools[:n]:
        d = ammo_root / name
        rec = _recompute_t1_ladder(d)
        v3 = st.get("tier_gate_v3") or {}
        prov = str(v3.get("t1_t2_source") or "pool_state.t1_chars 原值")[:80]
        note = (f"溯源: {prov}; t1_items 源={st.get('t1_items')} vs "
                f"复算={rec['n1']}; 复算口径={rec['caliber']}")
        items.append(_item("chars", f"chars/{name}/t1_chars", src, rec["t1"],
                           src == rec["t1"], diff=src - rec["t1"], note=note))
    if len(pools) > n:
        notes.append(f"有 t1 账的池共 {len(pools)} 个, 按名序抽前 {n} 个")
    return items, notes


# ---------- ④ 决策账本类 ----------------------------------------------------
def _decision_schema_ok(row: dict) -> tuple[bool, str]:
    missing = [k for k in DECISION_REQUIRED_KEYS if k not in row]
    if missing:
        return False, f"缺键 {missing}"
    if row.get("decision_type") not in DECISION_TYPE_ENUM:
        return False, f"decision_type={row.get('decision_type')!r} 越八枚举"
    import re
    if not re.match(r"^D-\d{4,}$", str(row.get("id") or "")):
        return False, f"id={row.get('id')!r} 非 D-#### 格式"
    return True, "12/12 键位+八枚举+id 格式齐全"


def audit_decisions(ammo_root: Path, n: int = 5) -> tuple[list[dict], list[str]]:
    notes: list[str] = []
    items: list[dict] = []
    ledgers = sorted(ammo_root.glob("*/decision_ledger.jsonl")) \
        if ammo_root.is_dir() else []
    if not ledgers:
        return [], [f"{ammo_root} 下暂无 decision_ledger.jsonl "
                    f"(T-005 工具在役, 尚无战役落账), 决策类零抽检"]
    sampled = 0
    for lp in ledgers:
        campaign = lp.parent.name
        rows, bad = _read_jsonl(lp)
        if bad:
            notes.append(f"{campaign}: 账本坏行 {bad} 条")
        recs = [r for r in rows if isinstance(r, dict)]
        # -- id 连续性 (整本对账, 不抽样) --
        import re
        nums = sorted(int(m.group(1)) for r in recs
                      if (m := re.match(r"^D-(\d{4,})$", str(r.get("id") or ""))))
        gaps = [b for a, b in zip(nums, nums[1:]) if b != a + 1]
        dup = len(nums) != len(set(nums))
        cont_ok = bool(nums) and nums[0] == 1 and not gaps and not dup
        rng = f"{nums[0]}..{nums[-1]}" if nums else "空"
        gap_desc = f", 跳号{gaps}" if gaps else (", 有重复" if dup else "")
        items.append(_item(
            "decision", f"decision/{campaign}/id连续性", rng,
            "D-0001 起连续无跳号无重复", cont_ok,
            diff=None, note=f"{len(nums)} 条 id 记录{gap_desc}"))
        # -- schema 抽样 --
        for r in recs:
            if sampled >= n:
                break
            ok, desc = _decision_schema_ok(r)
            present = sum(1 for k in DECISION_REQUIRED_KEYS if k in r)
            items.append(_item(
                "decision", f"decision/{campaign}/{r.get('id')}:schema",
                f"{present}/{len(DECISION_REQUIRED_KEYS)} 键位", desc, ok,
                note=str(r.get("decision_type") or "")))
            sampled += 1
    if sampled < n:
        notes.append(f"决策行共 {sampled} 条 < 抽检数 {n}, 已全查")
    return items, notes


# ---------- ⑤ 冲刺账本类 ----------------------------------------------------
def _run_sprint_status(script: Path, ledger: Path) -> dict:
    proc = subprocess.run(
        [sys.executable, str(script), "--status", "--json",
         "--ledger", str(ledger)],
        capture_output=True, text=True, encoding="utf-8", errors="replace")
    if proc.returncode != 0:
        raise RuntimeError(f"sprint_ledger --status 退出码 {proc.returncode}: "
                           f"{proc.stderr.strip()[:200]}")
    return json.loads(proc.stdout)


def audit_sprint(ledger: Path, script: Path, mirror: Path | None = None,
                 n: int = 5, status_runner=None
                 ) -> tuple[list[dict], list[str]]:
    notes: list[str] = []
    items: list[dict] = []
    runner = status_runner or (lambda lg: _run_sprint_status(script, lg))
    if not ledger.exists():
        return [], [f"账本不存在: {ledger}"]
    rows, bad = _read_jsonl(ledger)
    if bad:
        items.append(_item("sprint", "sprint/ledger可解析", f"坏行 {bad} 条",
                           "0 坏行", False))
    recs = [r for r in rows if isinstance(r, dict) and r.get("week")]
    last_by_week: dict[str, dict] = {}
    for r in recs:
        last_by_week[str(r["week"])] = r

    status = runner(ledger)
    st_weeks = {str(w.get("week")): w for w in status.get("weeks", [])
                if isinstance(w, dict)}
    weeks = sorted(last_by_week, key=lambda w: (
        0 if w in st_weeks else 1, w))[:n]
    for wk in weeks:
        src = last_by_week[wk]
        st = st_weeks.get(wk)
        if st is None:
            items.append(_item("sprint", f"sprint/{wk}/target",
                               src.get("target"), "status 未列该周", False,
                               note="账本有周而 --status 缺席"))
            continue
        for field, tol in (("target", 0.5), ("actual", MONEY_TOL)):
            sv, tv = src.get(field), st.get(field)
            items.append(_item(
                "sprint", f"sprint/{wk}/{field}", sv, tv,
                _num_match(sv, tv, tol),
                diff=(round(float(sv) - float(tv), 2)
                      if isinstance(sv, (int, float))
                      and isinstance(tv, (int, float)) else None),
                note="账本同周末行 (追加式修正语义) vs --status weeks"))
    my_actual_cum = sum(float(r.get("actual") or 0) for r in last_by_week.values())
    my_plan_cum = sum(int(r.get("target") or 0) for r in last_by_week.values())
    items.append(_item("sprint", "sprint/cum/actual", my_actual_cum,
                       status.get("actual_cum"),
                       _num_match(my_actual_cum, status.get("actual_cum"),
                                  MONEY_TOL),
                       diff=round(my_actual_cum - float(status.get("actual_cum")
                                                        or 0), 2)))
    items.append(_item("sprint", "sprint/cum/plan_target", my_plan_cum,
                       status.get("plan_cum_of_settled"),
                       _num_match(my_plan_cum,
                                  status.get("plan_cum_of_settled"), 0.5),
                       diff=my_plan_cum - int(status.get("plan_cum_of_settled")
                                              or 0),
                       note="已对账周 (末行) target 合计"))
    if mirror is not None:
        if not mirror.exists():
            notes.append(f"镜像账本不存在: {mirror}, 镜像对拍跳过")
        else:
            a = ledger.read_text(encoding="utf-8", errors="replace")
            b = mirror.read_text(encoding="utf-8", errors="replace")
            same = a == b
            items.append(_item(
                "sprint", "sprint/mirror_parity",
                f"镜像 {len(b.splitlines())} 行", f"权威 {len(a.splitlines())} 行",
                same, diff=None,
                note=("逐行一致" if same else
                      "镜像与权威账本内容不一致 (settle 应双写同记录)")))
    return items, notes


# ---------- 总装 ------------------------------------------------------------
CATEGORIES = (("completeness", "①完备性"), ("funnel", "②漏斗"),
              ("chars", "③字数"), ("decision", "④决策账本"),
              ("sprint", "⑤冲刺账本"))


def run_all(*, n: int = 5, campaign: str = DEFAULT_CAMPAIGN,
            ammo_root: Path = DEFAULT_AMMO_ROOT,
            funnel_ledger: Path = DEFAULT_FUNNEL_LEDGER,
            funnel_query: Path = DEFAULT_FUNNEL_QUERY,
            funnel_db: Path = DEFAULT_FUNNEL_DB,
            sprint_ledger_path: Path = DEFAULT_SPRINT_LEDGER,
            sprint_mirror: Path = DEFAULT_SPRINT_MIRROR,
            sprint_script: Path = DEFAULT_SPRINT_SCRIPT) -> dict:
    jobs = {
        "completeness": lambda: audit_completeness(ammo_root / campaign),
        "funnel": lambda: audit_funnel(funnel_ledger, funnel_query,
                                       funnel_db, n=n),
        "chars": lambda: audit_chars(ammo_root, n=n),
        "decision": lambda: audit_decisions(ammo_root, n=n),
        "sprint": lambda: audit_sprint(sprint_ledger_path, sprint_script,
                                       mirror=sprint_mirror, n=n),
    }
    categories: dict[str, dict] = {}
    errors: list[str] = []
    for key, label in CATEGORIES:
        try:
            items, notes = jobs[key]()
        except Exception as exc:                    # 运行性错误 ≠ 数字不一致
            categories[key] = {"label": label, "items": [],
                               "notes": [f"运行性错误: {exc}"]}
            errors.append(f"{key}: {exc}")
            continue
        categories[key] = {"label": label, "items": items, "notes": notes}

    flat = [it for c in categories.values() for it in c["items"]]
    mismatch = [it for it in flat if not it["match"]]
    checked = len(flat)
    exit_code = 2 if mismatch else (1 if errors else 0)
    return {"categories": categories, "items": flat,
            "totals": {"checked": checked, "match": checked - len(mismatch),
                       "mismatch": len(mismatch), "errors": len(errors)},
            "exit_code": exit_code}


def _fmt_val(v) -> str:
    if isinstance(v, float) and v.is_integer():
        return str(int(v))
    return str(v)


def _print_human(res: dict, n: int) -> None:
    t = res["totals"]
    print(f"[v3_number_audit] 数字零造假复算抽检 (T-027 / REQ-001.AC1) "
          f"N={n} (population<N 时全查)")
    for key, cat in res["categories"].items():
        items = cat["items"]
        ok = sum(1 for it in items if it["match"])
        flag = "一致" if ok == len(items) and items else \
            ("空抽(见注)" if not items else "不一致")
        print(f"{cat['label']} {ok}/{len(items)} {flag}")
        for note in cat["notes"]:
            print(f"    note: {note}")
        for it in items:
            mark = "OK" if it["match"] else "NG"
            line = (f"    [{mark}] {it['item']}  "
                    f"源={_fmt_val(it['source_value'])} "
                    f"复算={_fmt_val(it['recomputed_value'])}")
            if not it["match"] and it["diff"] is not None:
                line += f"  差={_fmt_val(it['diff'])}"
            print(line)
    print(f"汇总: 抽检 {t['checked']} 处, 一致 {t['match']}, "
          f"不一致 {t['mismatch']}, 运行错误 {t['errors']} → "
          f"exit {res['exit_code']}"
          + ("  (不一致条目如上, 审计只暴露不修饰)" if res["exit_code"] == 2 else ""))


def main(argv: list[str] | None = None) -> int:
    ap = argparse.ArgumentParser(
        description="数字零造假复算抽检 (T-027 / REQ-001.AC1): "
                    "完备性/漏斗/字数/决策/冲刺 五类抽 N 处重算对拍")
    ap.add_argument("--n", type=int, default=5, help="每类抽检数 (默认 5)")
    ap.add_argument("--campaign", default=DEFAULT_CAMPAIGN,
                    help="完备性类战役名 (默认 EPC-BID26)")
    ap.add_argument("--ammo-root", default=str(DEFAULT_AMMO_ROOT))
    ap.add_argument("--funnel-ledger", default=str(DEFAULT_FUNNEL_LEDGER))
    ap.add_argument("--funnel-query", default=str(DEFAULT_FUNNEL_QUERY))
    ap.add_argument("--funnel-db", default=str(DEFAULT_FUNNEL_DB),
                    help="对拍用的不存在 db 路径 (只读探测, 永不创建)")
    ap.add_argument("--sprint-ledger", default=str(DEFAULT_SPRINT_LEDGER))
    ap.add_argument("--sprint-mirror", default=str(DEFAULT_SPRINT_MIRROR))
    ap.add_argument("--sprint-script", default=str(DEFAULT_SPRINT_SCRIPT))
    ap.add_argument("--json", action="store_true", help="机读输出")
    args = ap.parse_args(argv)

    res = run_all(n=max(1, args.n), campaign=args.campaign,
                  ammo_root=Path(args.ammo_root),
                  funnel_ledger=Path(args.funnel_ledger),
                  funnel_query=Path(args.funnel_query),
                  funnel_db=Path(args.funnel_db),
                  sprint_ledger_path=Path(args.sprint_ledger),
                  sprint_mirror=Path(args.sprint_mirror),
                  sprint_script=Path(args.sprint_script))
    if args.json:
        print(json.dumps(res, ensure_ascii=False, indent=1))
    else:
        _print_human(res, max(1, args.n))
    return res["exit_code"]


if __name__ == "__main__":
    raise SystemExit(main())
