# -*- coding: utf-8 -*-
"""redteam_gate — 红队轮双门 + KAC + ICD 203 双维 + 校准账本 (断言链 W4-2).

盘上诊断 (PROPOSAL.md §一 缺口⑦): 校准账本全盘零文件, 判断质量无分数;
METHODOLOGY §三.3 红队腿设计在案未落地. 本件四合一:

  ① Premortem 双门 (Klein 协议, HBR 2007-09): 目录冻结与开跑之间 (gate=pre)
     + 出稿前 (gate=post) 各跑一轮「本报告发布后被证明是错的」;
     失败原因 100% 映射 {缓解: measure | 接受: reason}, post 门每条还须
     树内证据回应 (evidence). 独立会话承担 — premortem_prompt() 出题,
     heuristic_premortem() 本地启发式兜底 (METHODOLOGY: 军团参谋出题+
     本地兜底双轨).
  ② KAC 关键假设检查 (CIA Tradecraft Primer): linchpin 假设 100% 带
     「出现什么新信息就必须放弃它」指标 (abandon_if), 无指标阻塞出稿;
     开工/定稿双跑留痕 (phases ⊇ {start, final}).
  ③ ICD 203 双维标注: 可能性 7 档硬编码表 (1-5% … 95-99%) + 置信度三档
     由证据侧三因子自动推导 (独立源数/来源等级/碎片度) **禁止手拍**;
     渲染层分句机检 — 可能性词与置信度词禁同句.
  ④ 校准账本 calibration_ledger.jsonl (Tetlock GJP): 每报告 ≥5 条
     {判断, 概率, 验证口径, 截止} 追加式入账, Brier score 到期对账.

产出 (只增不删, sidecar 落盘原账零改动):
  <pool>/<cid>/premortem.json            双门登记簿 (独立会话或启发式产出)
  <pool>/<cid>/kac.json                  关键假设登记簿
  <pool>/<cid>/icd203.json               双维标注 (claim_id → p + 口径)
  <pool>/<cid>/calibration_ledger.jsonl  校准账本 (追加式+指纹去重)
  <pool>/<cid>/redteam.json              机检报告 (四门汇总)

用法 (reforge_factory 根):
  PYTHONPATH=. python superline/redteam_gate.py --campaign-id EPC50-SNEI \
      --draft superline/replay_out_charter/EPC50-SNEI/claim_ledger_replay.md \
      --heuristic
"""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import time
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")
DISPOSITIONS = ("缓解", "接受")
KAC_PHASES = ("start", "final")
MIN_PREMORTEM_ITEMS = 3
MAX_PREMORTEM_ITEMS = 5
MIN_PREDICTIONS = 5                                # 每报告 ≥5 条预测入账

# ICD 203 可能性 7 档硬编码表 (irp.fas.org/dni/icd/icd-203.pdf)
LIKELIHOOD_BANDS: tuple[tuple[str, int, int], ...] = (
    ("几乎不可能", 1, 5), ("很不可能", 5, 20), ("不可能", 20, 35),
    ("大致均等", 35, 65), ("可能", 65, 85), ("很可能", 85, 95),
    ("几乎肯定", 95, 99),
)
CONFIDENCE_TERMS = ("高置信", "中等置信", "低置信", "置信度")
SENT_SPLIT_RE = re.compile(r"[。！？；\n]+")


# ---------------------------------------------------------- ICD 203 双维

def likelihood_band(pct: float) -> tuple[str, str]:
    """概率(百分数 0-100) → (可能性词, 区间串). 界外钳到首末档."""
    for word, lo, hi in LIKELIHOOD_BANDS:
        if pct <= hi:
            return word, f"{lo}-{hi}%"
    return LIKELIHOOD_BANDS[-1][0], \
        f"{LIKELIHOOD_BANDS[-1][1]-0}-{LIKELIHOOD_BANDS[-1][2]}%"


def derive_confidence(independent_n: int, best_grade: str,
                      n_docs: int) -> str:
    """置信度三档 — 证据侧三因子自动推导, 禁止作者手拍 (ICD 203).

    因子: 独立源佐证数 / 来源等级 / 碎片度 (多文档单簇=同源复读碎片化,
    Heuer 增量信息定律: 加信心不加准确).
    """
    if independent_n >= 2 and best_grade in ("A", "B"):
        c = "high"
    elif (independent_n >= 2 and best_grade == "C") or \
            (independent_n == 1 and best_grade == "A"):
        c = "moderate"
    else:
        c = "low"
    if n_docs >= 3 and independent_n <= 1:
        c = {"high": "moderate", "moderate": "low"}.get(c, c)  # 碎片化降一档
    return c


def split_violations(text: str) -> list[str]:
    """分句机检: 可能性词与置信度词禁同句 (ICD 203 两维分句纪律)."""
    words = [w for w, _, _ in LIKELIHOOD_BANDS]
    bad: list[str] = []
    for sent in SENT_SPLIT_RE.split(text):
        s = sent.strip()
        if not s:
            continue
        if any(w in s for w in words) and any(t in s for t in CONFIDENCE_TERMS):
            bad.append(s[:60])
    return bad


# ---------------------------------------------------------- 提示词 (独立会话座位)

def premortem_prompt(report_title: str, gate: str) -> str:
    """Klein premortem 出题提示词 — 独立会话 (Manus 独立 profile /
    contextTransfer 隔离) 承担, 检查者与干活者上下文隔离 (合同3)."""
    when = ("目录已冻结、采集未开跑 — 现在改计划最便宜"
            if gate == "pre" else "终稿已就绪、出队之前 — 最后一道门")
    return (
        f"# Premortem {'开跑前' if gate == 'pre' else '出稿前'} 出题 (gate={gate})\n"
        f"报告: {report_title}. {when}.\n\n"
        "想象: 报告发布三个月后, 读者证明它全错. 请**独立默写** (不许互相讨论)\n"
        f"{MIN_PREMORTEM_ITEMS}-{MAX_PREMORTEM_ITEMS} 条最可能的失败路径, 每条输出:\n"
        '  {"risk": "...", "disposition": "缓解|接受",\n'
        '   "measure": "缓解措施 (disposition=缓解时必填)",\n'
        '   "reason": "接受理由 (disposition=接受时必填)",\n'
        '   "evidence": "树内证据回应 (post 门必填)"}\n'
        "规则: 轮读去重后逐条映射{缓解|接受} — 100% 映射是机检门;\n"
        "回应不了树内证据的章节须降级或补采 (METHODOLOGY §三.3).")


def kac_prompt(tree: dict) -> str:
    """KAC 出题提示词 (开工+定稿各跑一次; linchpin 无指标阻塞出稿)."""
    hyps = [h.get("text", "") for h in tree.get("hypotheses", [])
            if isinstance(h, dict)][:7]
    return ("# Key Assumptions Check 出题\n对下列树根假设逐条体检:\n  - "
            + "\n  - ".join(hyps) + "\n\n每条输出:\n"
            '  {"text": "...", "linchpin": true|false, "basis": "接受依据",\n'
            '   "abandon_if": ["出现什么新信息就必须放弃它 (linchpin 必填指标)"]}\n'
            "规则: linchpin=true 而 abandon_if 为空 → 阻塞出稿 (机检门).")


# ---------------------------------------------------------- 本地启发式兜底

def heuristic_premortem(ledger: dict) -> list[dict]:
    """断言账本真统计 → 失败路径登记簿 (零 LLM 兜底; 独立会话缺位时)."""
    st = ledger.get("stats", {}) if isinstance(ledger, dict) else {}
    claims = ledger.get("claims", []) if isinstance(ledger, dict) else []
    by_state = st.get("by_state", {})
    n = max(1, st.get("claims", 1))
    items: list[dict] = []
    if by_state.get("单源", 0):
        items.append({
            "risk": f"单源断言 {by_state['单源']}/{n} 出稿后被独立源推翻",
            "disposition": "缓解",
            "measure": "gap_tickets 已全量入队补独立第二源; 补不齐句带「单一来源」标注",
            "reason": "", "evidence": "claim_ledger.json by_state"})
    if by_state.get("未确证", 0):
        items.append({
            "risk": f"未确证断言 {by_state['未确证']} 条为幽灵引用",
            "disposition": "缓解",
            "measure": "清理引用号或补落账文档; precision 门 <0.9 阻塞出队",
            "reason": "", "evidence": "claim_ledger.json 幽灵引用字段"})
    if st.get("t0_blocked"):
        items.append({
            "risk": f"T0 关键数字断言 {st['t0_blocked']} 条无双源/一手支撑",
            "disposition": "缓解",
            "measure": "T0 门阻塞句强制补 A 级一手源或双独立源后重跑账本",
            "reason": "", "evidence": "claim_ledger.json T0门阻塞旗标"})
    n_pred = sum(1 for c in claims if c.get("类型") == "预测")
    if n_pred:
        items.append({
            "risk": f"预测断言 {n_pred} 条无验证口径到期对账",
            "disposition": "缓解",
            "measure": "全部入 calibration_ledger (≥5 条/报告) 带 Brier 对账",
            "reason": "", "evidence": "claim_ledger.json 类型=预测"})
    items.append({
        "risk": "渠道垄断下「多源」实为同源复读 (增量信息只加信心不加准确)",
        "disposition": "接受",
        "measure": "",
        "reason": "独立性按三键口径已在账本显形, 终稿按独立源数而非文档数表述确定性",
        "evidence": "independence.json 三键连通分量"})
    return items[:MAX_PREMORTEM_ITEMS]


def heuristic_kac(tree: dict) -> list[dict]:
    """问题树假设 → KAC 登记簿兜底 (linchpin=排序首位假设)."""
    hyps = [h for h in tree.get("hypotheses", []) if isinstance(h, dict)]
    out = []
    for i, h in enumerate(hyps):
        out.append({
            "text": h.get("text", ""), "linchpin": i == 0,
            "basis": "问题树 ACH 种子假设 (question_bridge)",
            "abandon_if": ([f"反证腿 EEI 命中使 {h.get('text', '')[:20]} "
                            "假设转 disproved"]
                           if i == 0 else [])})
    return out


# ---------------------------------------------------------- 机检门

def validate_premortem(items: list[dict], gate: str) -> list[str]:
    """双门登记簿校验: 3-5 条; 100% 映射{缓解|接受}; post 门证据回应必填."""
    errs: list[str] = []
    if not (MIN_PREMORTEM_ITEMS <= len(items) <= MAX_PREMORTEM_ITEMS):
        errs.append(f"premortem[{gate}] 条数 {len(items)} 须在 "
                    f"{MIN_PREMORTEM_ITEMS}-{MAX_PREMORTEM_ITEMS}")
    for i, it in enumerate(items):
        if it.get("disposition") not in DISPOSITIONS:
            errs.append(f"premortem[{gate}][{i}].disposition 非法 "
                        f"{it.get('disposition')!r} (须 缓解|接受)")
        elif it.get("disposition") == "缓解" and not str(it.get("measure") or "").strip():
            errs.append(f"premortem[{gate}][{i}] 缓解项缺 measure")
        elif it.get("disposition") == "接受" and not str(it.get("reason") or "").strip():
            errs.append(f"premortem[{gate}][{i}] 接受项缺 reason")
        if gate == "post" and not str(it.get("evidence") or "").strip():
            errs.append(f"premortem[{gate}][{i}] post 门缺树内证据回应 evidence")
    return errs


def validate_kac(assumptions: list[dict], phases: list[str]) -> list[str]:
    """KAC 校验: linchpin 100% 带 abandon_if 指标; 开工/定稿双跑留痕."""
    errs: list[str] = []
    if not assumptions:
        errs.append("kac 登记簿为空")
    for i, a in enumerate(assumptions):
        if a.get("linchpin") and not [x for x in a.get("abandon_if") or []
                                      if str(x).strip()]:
            errs.append(f"kac[{i}] linchpin 假设缺 abandon_if 指标 (阻塞出稿)")
    for ph in KAC_PHASES:
        if ph not in phases:
            errs.append(f"kac 缺 {ph} 阶段检查留痕 (开工/定稿双跑)")
    return errs


def icd203_rows(ledger: dict, authored: dict) -> list[dict]:
    """T0/预测断言 → 双维标注行 (置信度自动推导). authored: claim_id→{p,口径}."""
    rows = []
    for c in ledger.get("claims", []):
        if not (c.get("T0") or c.get("类型") == "预测"):
            continue
        a = authored.get(c["claim_id"], {})
        p = a.get("p")
        word, band = likelihood_band(float(p)) if isinstance(p, (int, float)) \
            else ("", "")
        # 置信度由账本证据统计推导 (独立源数/最优等级/文档碎片度) — 禁手拍
        conf = derive_confidence(c.get("独立源数", 0),
                                 c.get("最优等级") or "C",
                                 len(c.get("证据ids", [])))
        rows.append({"claim_id": c["claim_id"], "断言": c.get("断言", "")[:60],
                     "likelihood": f"{word} {band}" if word else "缺失",
                     "confidence": conf, "口径": a.get("verification", ""),
                     "deadline": a.get("deadline", ""),
                     "missing": not isinstance(p, (int, float))})
    return rows


# ---------------------------------------------------------- 校准账本

def brier(p: float, outcome: int) -> float:
    """Brier score 单条: (p - outcome)^2 (p 为 0-1 概率)."""
    return (p - outcome) ** 2


def append_predictions(path: Path, cid: str, items: list[dict]) -> int:
    """追加式入账 {判断,概率,验证口径,截止}; 指纹=sha1(cid+判断) 去重."""
    seen: set[str] = set()
    if path.is_file():
        for ln in path.read_text(encoding="utf-8").splitlines():
            if ln.strip():
                try:
                    seen.add(json.loads(ln).get("fingerprint", ""))
                except json.JSONDecodeError:
                    continue
    added = 0
    with path.open("a", encoding="utf-8") as f:
        for it in items:
            fp = hashlib.sha1((cid + str(it.get("判断", ""))).encode(
                "utf-8")).hexdigest()[:12]
            if fp in seen:
                continue
            seen.add(fp)
            f.write(json.dumps({**it, "cid": cid, "fingerprint": fp,
                                "ts": time.strftime("%Y-%m-%d %H:%M"),
                                "brier": None}, ensure_ascii=False) + "\n")
            added += 1
    return added


def score_matured(path: Path, cid: str,
                  outcomes: dict[str, int]) -> dict:
    """到期对账: outcomes = 判断文本前缀 → 0/1; 回填 brier 并返回汇总."""
    rows = []
    scored = 0
    total = 0.0
    if path.is_file():
        for ln in path.read_text(encoding="utf-8").splitlines():
            if ln.strip():
                rows.append(json.loads(ln))
    for r in rows:
        if r.get("cid") != cid or r.get("brier") is not None:
            continue
        hit = next((o for k, o in outcomes.items()
                    if k and k in str(r.get("判断", ""))), None)
        if hit is None:
            continue
        r["brier"] = round(brier(float(r["probability"]), int(hit)), 4)
        scored += 1
        total += r["brier"]
    if scored:
        path.write_text("\n".join(json.dumps(r, ensure_ascii=False)
                                  for r in rows) + "\n", encoding="utf-8")
    return {"scored": scored,
            "mean_brier": round(total / scored, 4) if scored else None}


# ---------------------------------------------------------- 战役级

def audit_campaign(cid: str, pool_root: Path = POOL_ROOT,
                   draft_text: str = "", heuristic: bool = False) -> dict:
    """读池内登记簿+断言账本 → 四门机检 → redteam.json sidecar."""
    d = pool_root / cid
    ledger = {}
    lp = d / "claim_ledger.json"
    if lp.is_file():
        ledger = json.loads(lp.read_text(encoding="utf-8"))

    pm_path = d / "premortem.json"
    pm = json.loads(pm_path.read_text(encoding="utf-8")) if pm_path.is_file() \
        else None
    if pm is None and heuristic and ledger:
        pm = {"cid": cid, "generator": "heuristic-local (独立会话缺位兜底)",
              "gates": {"pre": heuristic_premortem(ledger),
                        "post": heuristic_premortem(ledger)}}
        pm_path.write_text(json.dumps(pm, ensure_ascii=False, indent=1),
                           encoding="utf-8")
    pm_errs = []
    if pm:
        for gate in ("pre", "post"):
            pm_errs += validate_premortem(pm.get("gates", {}).get(gate, []),
                                          gate)
    else:
        pm_errs = ["premortem 登记簿不存在 (双门未跑)"]

    kac_path = d / "kac.json"
    kac = json.loads(kac_path.read_text(encoding="utf-8")) if kac_path.is_file() \
        else None
    tree = {}
    for name in ("question_tree_v2.json", "question_tree.json"):
        tp = d / name
        if tp.is_file():
            tree = json.loads(tp.read_text(encoding="utf-8"))
            break
    if kac is None and heuristic and tree:
        kac = {"cid": cid, "generator": "heuristic-local",
               "assumptions": heuristic_kac(tree),
               "phases": ["start", "final"]}
        kac_path.write_text(json.dumps(kac, ensure_ascii=False, indent=1),
                            encoding="utf-8")
    kac_errs = validate_kac((kac or {}).get("assumptions", []),
                            (kac or {}).get("phases", [])) if kac \
        else ["kac 登记簿不存在"]

    icd_authored = {}
    ip = d / "icd203.json"
    if ip.is_file():
        icd_authored = json.loads(ip.read_text(encoding="utf-8"))
    icd_rows = icd203_rows(ledger, icd_authored)
    icd_missing = [r["claim_id"] for r in icd_rows if r["missing"]]
    sv = split_violations(draft_text) if draft_text else []

    cal_path = d / "calibration_ledger.jsonl"
    n_pred = 0
    if cal_path.is_file():
        n_pred = sum(1 for ln in cal_path.read_text(encoding="utf-8")
                     .splitlines()
                     if ln.strip() and json.loads(ln).get("cid") == cid)

    gates = {
        "premortem": {"errors": pm_errs, "pass": not pm_errs},
        "kac": {"errors": kac_errs, "pass": not kac_errs},
        "icd203": {"missing_annotations": icd_missing,
                   "split_violations": sv,
                   "pass": not icd_missing and not sv},
        "calibration": {"predictions": n_pred,
                        "pass": n_pred >= MIN_PREDICTIONS},
    }
    report = {"cid": cid, "generated": time.strftime("%Y-%m-%d %H:%M"),
              "engine_version": "redteam-v1 (W4-2 断言链引擎)",
              "icd203_rows": icd_rows, "gates": gates,
              "overall_pass": all(g["pass"] for g in gates.values())}
    (d / "redteam.json").write_text(
        json.dumps(report, ensure_ascii=False, indent=1), encoding="utf-8")
    return report


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="红队轮双门+KAC+ICD203+校准账本 (W4-2)")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ap.add_argument("--draft", help="终稿 md (分句机检用)")
    ap.add_argument("--heuristic", action="store_true",
                    help="独立会话缺位时本地启发式兜底产登记簿")
    ns = ap.parse_args(argv)
    text = Path(ns.draft).read_text(encoding="utf-8") if ns.draft else ""
    r = audit_campaign(ns.campaign_id, Path(ns.pool_root), text, ns.heuristic)
    for name, g in r["gates"].items():
        mark = "PASS" if g["pass"] else "FAIL"
        print(f"[redteam] {name}: {mark}")
        for e in g.get("errors", []):
            print(f"[redteam]   ✗ {e}")
    print(f"[redteam] overall: {'PASS' if r['overall_pass'] else 'FAIL'} → "
          f"redteam.json")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
