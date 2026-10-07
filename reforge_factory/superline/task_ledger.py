# -*- coding: utf-8 -*-
"""task_ledger — 断言账本 (断言链 W3-1, 验证合同件; P1-6 认知级三段账升级).

盘上诊断 (PROPOSAL.md §一 缺口⑥): 终稿引用句与证据无链接 —— 哪句话踩在
单源/零源证据上不可知、不可审、不可补. 本件把写作层的每个引用句落成
断言行, 字段映射 PRISMA+IFCN+GRADE (合同3):

  {断言, 类型(事实/预测/观点), eeis[], 证据ids[], 独立性类别,
   验证态(双独立源确证/单源/未确证), 确定性(高/中/低/极低),
   降级旗标[], 反证urls[]}

引用标记语法 (写作层合同, 章写作提示词产出):
  [[S:D0001,D0002@M01-001E1]]
   └ 逗号分隔的短文档号 (doc_registry.json 登记) + 可选 @EEI 节点

判定全部 join 盘上真账 (零 LLM 零网络):
  - 文档登记表: manifest.jsonl valid 行 → doc_base 短号 D%04d (确定性排序);
  - 等级: grade_map.jsonl sidecar (W1-2) 优先, 缺席回退 grade_rules.grade_row;
  - 独立性: independence_audit.cluster_count 三键连通分量 (W2-2 同源);
  - ALCE 双指标门 (adapted): citation recall ≥0.95 ∧ precision ≥0.9;
  - GRADE 清单门 (adapted, 只取本地可检因子): 起点=最优源等级, 降级
    {单源/幽灵引用/C级占多数} 各 -1, 升级 {双独立∧含A/B} +1 → 四级确定性;
  - T0 断言 (关键数字/引语): 须 双独立源确证∨含 A 级一手源, 否则阻塞旗标;
  - 第四触发位 (P1-7 三触发位 [待证]/估算推断/引用源=1 之外扩展):
    单源/未确证断言 100% 进 gap_tickets.jsonl 补采工单 (append-only,
    指纹去重; 补不齐的终稿该句强制带「单一来源」标注或删除).

产出 (只增不删, sidecar 落盘原账零改动):
  <pool>/<cid>/doc_registry.json    文档短号登记表
  <pool>/<cid>/claim_ledger.json    断言账本 + ALCE/GRADE 机检汇总
  <pool>/<cid>/gap_tickets.jsonl    第四触发位补采工单 (追加式)

用法 (reforge_factory 根):
  PYTHONPATH=. python superline/task_ledger.py --campaign-id EPC50-SNEI \
      --draft <终稿.md> [--pool-root E:\\AI-Station\\ammo_pool]
  PYTHONPATH=. python superline/task_ledger.py --campaign-id X --registry-only
"""
from __future__ import annotations

import argparse
import json
import re
import sys
import time
from pathlib import Path

_ROOT = str(Path(__file__).resolve().parents[1])   # reforge_factory 根
if _ROOT not in sys.path:
    sys.path.insert(0, _ROOT)

from doc_weight_audit import doc_base              # noqa: E402  (W1-1 同源)
from grade_rules import grade_row, host_of         # noqa: E402  (W1-2 同源)
from independence_audit import cluster_count       # noqa: E402  (W2-2 同源)

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

POOL_ROOT = Path(r"E:\AI-Station\ammo_pool")

# ALCE 双指标门 (github.com/princeton-nlp/ALCE, adapted — 合同3)
RECALL_GATE = 0.95
PRECISION_GATE = 0.90

GRADE_START = {"A": 3, "B": 2, "C": 1}             # GRADE 起点分 (源等级)
CERTAINTY_BANDS = {4: "高", 3: "中", 2: "低", 1: "极低"}

# 引用标记: [[S:D0001,D0002@M01-001E1]] (@节点可选, 内部不许嵌套空白)
CITE_RE = re.compile(r"\[\[S:([A-Za-z0-9_,\-]+?)(?:@([A-Za-z0-9_,\-]+)?\]\]|\]\])")
# 数字+单位 (T0 关键句信号): 万/亿/%/元/倍/人/吨/公里/平方米/千瓦/MW/GW…
NUM_UNIT_RE = re.compile(
    r"\d+(?:\.\d+)?\s*(?:万|亿|%|％|元|倍|人|吨|公里|平方千米|平方米|千瓦|"
    r"兆瓦|MW|GW|kV|毫米|米|亩|个亿|万美元)")
PREDICT_RE = re.compile(r"预计|预测|有望|或将|预期|或将达|未来\s*\d+\s*年|将达|将超")
OPINION_RE = re.compile(r"认为|观点|似乎|笔者|笔者以为|研判| arguably")
QUOTE_RE = re.compile(r"[「『][^」』]{4,}[」』]")
SENT_SPLIT_RE = re.compile(r"[。！？；\n]+")

GAP_LEGACY_TRIGGERS = ("待证标记", "估算推断段", "引用源数=1")   # P1-7 原三触发位


# ---------------------------------------------------------- 文档登记表

def build_registry(rows: list[dict], graded: dict[str, str]) -> list[dict]:
    """manifest valid 行 → 文档级登记表 (纯函数, 不改入参).

    graded: dedup_key → A/B/C (grade_map sidecar; 缺席由调用方回退填充).
    文档级等级 = 该文档全部行最优等级 (A<B<C).
    """
    docs: dict[str, dict] = {}
    for r in rows:
        if r.get("judge") != "valid":
            continue
        base = doc_base(str(r.get("dedup_key") or r.get("source_path") or ""))
        if not base:
            continue
        g = graded.get(str(r.get("dedup_key") or ""))
        eng = str(r.get("engine") or "?")
        url = str(r.get("url_norm") or "")
        d = docs.setdefault(base, {"doc_base": base, "engines": set(),
                                   "host": host_of(url), "grade": None,
                                   "n_rows": 0})
        d["engines"].add(eng)
        d["n_rows"] += 1
        if g and g in GRADE_START and (d["grade"] is None or g < d["grade"]):
            d["grade"] = g
    out = []
    for i, base in enumerate(sorted(docs), start=1):
        d = docs[base]
        out.append({"id": f"D{i:04d}", "doc_base": base,
                    "engines": sorted(d["engines"]), "host": d["host"] or "",
                    "grade": d["grade"] or "C", "n_rows": d["n_rows"]})
    return out


def registry_rows_by_id(registry: list[dict]) -> dict[str, dict]:
    return {d["id"]: d for d in registry}


# ---------------------------------------------------------- 断言抽取

def _clean_line(line: str) -> str:
    """剥离 markdown 噪声: 表格行/标题行/列表符/加粗 (这些不构成断言句)."""
    s = line.strip()
    if not s or s.startswith("|") or s.startswith("#"):
        return ""
    return s.lstrip("-*·> ").replace("**", "")


def extract_claims(text: str) -> list[dict]:
    """终稿文本 → 引用句断言列表 (纯函数).

    句 = 。！？；\n 切分; 每句 ≥1 个 [[S:...]] 标记才入账 (机检锚:
    终稿引用句 100% 落账). 同时回填 key_sentence (数字+单位) 供 recall 分母.
    """
    claims: list[dict] = []
    for raw in text.splitlines():
        line = _clean_line(raw)
        if not line:
            continue
        for sent in SENT_SPLIT_RE.split(line):
            s = sent.strip()
            if not s or "[[S:" not in s:
                continue
            refs: list[str] = []
            nodes: list[str] = []
            for m in CITE_RE.finditer(s):
                refs.extend(x for x in m.group(1).split(",") if x)
                if m.group(2):
                    nodes.extend(x for x in m.group(2).split(",") if x)
            if not refs:
                continue
            claims.append({
                "断言": s, "refs": refs, "eeis": sorted(set(nodes)),
                "key_sentence": bool(NUM_UNIT_RE.search(s)),
            })
    for i, c in enumerate(claims, start=1):
        c["claim_id"] = f"C{i:04d}"
    return claims


def claim_type(snippet: str) -> str:
    """断言类型启发式 (本地零 LLM): 预测 > 观点 > 事实."""
    if PREDICT_RE.search(snippet):
        return "预测"
    if OPINION_RE.search(snippet):
        return "观点"
    return "事实"


def is_t0(snippet: str) -> bool:
    """T0 断言判据: 关键数字+单位 或 直接引语 (RFE/RL 成文规则)."""
    return bool(NUM_UNIT_RE.search(snippet) or QUOTE_RE.search(snippet))


# ---------------------------------------------------------- 判定 join

def judge_claim(claim: dict, by_id: dict[str, dict],
                node_against_urls: dict[str, list[str]]) -> dict:
    """单断言 → 合同3 全字段 (纯函数). 独立性 = 三键连通分量 (W2-2 同源)."""
    resolved = [by_id[r] for r in claim["refs"] if r in by_id]
    ghost = [r for r in claim["refs"] if r not in by_id]
    keys = [(d["host"], d["engines"][0] if d["engines"] else "?",
             d["doc_base"]) for d in resolved]
    n_ind = cluster_count(keys) if keys else 0
    grades = [d["grade"] for d in resolved if d["grade"] in GRADE_START]

    if n_ind >= 2:
        state, indep = "双独立源确证", "独立多源"
    elif len(resolved) >= 2 and n_ind <= 1:
        state, indep = "单源", "同源复读"          # 多文档但三键连通=转载复读
    elif len(resolved) == 1:
        state, indep = "单源", "单一来源"
    else:
        state, indep = "未确证", "未落账"

    flags: list[str] = []
    score = GRADE_START[min(grades)] if grades else 1
    if state != "双独立源确证":
        score -= 1
        flags.append("单源未确证" if state == "未确证" else "单一独立源")
    if ghost:
        score -= 1
        flags.append("幽灵引用")
    if grades and sum(1 for g in grades if g == "C") * 2 > len(grades):
        score -= 1
        flags.append("C级源占多数")
    if n_ind >= 2 and any(g in ("A", "B") for g in grades):
        score += 1
        flags.append("双独立且含A/B级")
    score = max(1, min(4, score))
    t0 = is_t0(claim["断言"])
    t0_ok = (state == "双独立源确证"
             or any(g == "A" for g in grades))
    if t0 and not t0_ok:
        flags.append("T0门阻塞")
    against = sorted({u for n in claim["eeis"] for u in node_against_urls.get(n, [])})
    return {
        "claim_id": claim["claim_id"], "断言": claim["断言"],
        "类型": claim_type(claim["断言"]), "eeis": claim["eeis"],
        "证据ids": list(claim["refs"]), "幽灵引用": ghost,
        "独立性类别": indep, "独立源数": n_ind, "验证态": state,
        "最优等级": min(grades) if grades else "",
        "确定性": CERTAINTY_BANDS[score], "降级旗标": flags,
        "反证urls": against, "T0": t0,
    }


def key_sentence_count(text: str) -> int:
    """recall 分母: 全稿关键句数 (数字+单位, 表格/标题行除外)."""
    n = 0
    for raw in text.splitlines():
        line = _clean_line(raw)
        if not line:
            continue
        n += sum(1 for s in SENT_SPLIT_RE.split(line)
                 if s.strip() and NUM_UNIT_RE.search(s))
    return n


# ---------------------------------------------------------- 第四触发位

def gap_tickets(judged: list[dict]) -> list[dict]:
    """单源/未确证断言 → 补采工单 (P1-7 第四触发位, 100% 命中机检锚)."""
    out: list[dict] = []
    for c in judged:
        if c["验证态"] == "双独立源确证":
            continue
        trig = "零源断言" if c["验证态"] == "未确证" else "单源断言"
        out.append({
            "trigger": trig, "claim_id": c["claim_id"],
            "eeis": c["eeis"], "refs": c["证据ids"],
            "snippet": c["断言"][:80],
            "demand": "补独立第二源; 补不齐则终稿带「单一来源」标注或删除",
        })
    return out


def append_gap_tickets(path: Path, tickets: list[dict]) -> int:
    """追加式落盘, 指纹去重 (trigger+断言文本 sha 判同); 返回新增条数."""
    import hashlib
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
        for t in tickets:
            fp = hashlib.sha1((t["trigger"] + t["snippet"]).encode(
                "utf-8")).hexdigest()[:12]
            if fp in seen:
                continue
            seen.add(fp)
            f.write(json.dumps({**t, "fingerprint": fp, "ts":
                       time.strftime("%Y-%m-%d %H:%M")}, ensure_ascii=False)
                    + "\n")
            added += 1
    return added


# ---------------------------------------------------------- 战役级

def audit_draft(text: str, rows: list[dict], graded: dict[str, str],
                node_against_urls: dict[str, list[str]] | None = None) -> dict:
    """纯函数主干: 抽取 → 判定 → 指标汇总 (不改入参)."""
    registry = build_registry(rows, graded)
    by_id = registry_rows_by_id(registry)
    claims = extract_claims(text)
    judged = [judge_claim(c, by_id, node_against_urls or {}) for c in claims]
    total_refs = sum(len(c["证据ids"]) for c in judged)
    resolved_refs = sum(len(c["证据ids"]) - len(c["幽灵引用"])
                        for c in judged)
    key_total = key_sentence_count(text)
    key_cited = sum(1 for c, j in zip(claims, judged) if c["key_sentence"])
    recall = round(key_cited / key_total, 4) if key_total else 1.0
    precision = round(resolved_refs / total_refs, 4) if total_refs else 0.0
    by_state: dict[str, int] = {}
    for c in judged:
        by_state[c["验证态"]] = by_state.get(c["验证态"], 0) + 1
    return {
        "stats": {
            "claims": len(judged), "by_state": by_state,
            "t0_blocked": sum(1 for c in judged if "T0门阻塞" in c["降级旗标"]),
            "citation_recall": recall, "citation_precision": precision,
            "gates": {"recall_pass": recall >= RECALL_GATE,
                      "precision_pass": precision >= PRECISION_GATE},
        },
        "claims": judged, "registry": registry,
        "gap_tickets": gap_tickets(judged),
    }


def _load_graded(pool_dir: Path, rows: list[dict]) -> dict[str, str]:
    """grade sidecar 优先; 缺席回退 grade_rules.grade_row (内存判定不落盘)."""
    gm = pool_dir / "grade_map.jsonl"
    if gm.is_file():
        out: dict[str, str] = {}
        for ln in gm.read_text(encoding="utf-8").splitlines():
            if ln.strip():
                d = json.loads(ln)
                out[d.get("dedup_key", "")] = d.get("grade", "C")
        return out
    return {str(r.get("dedup_key") or ""): grade_row(r)["grade"] for r in rows}


def _node_against_urls(rows: list[dict]) -> dict[str, list[str]]:
    """EEI 节点 → 反证行 URL 清单 (manifest stance=against; 合同3 反证urls 源)."""
    out: dict[str, list[str]] = {}
    for r in rows:
        if r.get("judge") == "valid" and r.get("stance") == "against" \
                and r.get("tree_node"):
            out.setdefault(str(r["tree_node"]), []).append(
                str(r.get("url_norm") or ""))
    return out


def audit_campaign(draft_path: Path, cid: str,
                   pool_root: Path = POOL_ROOT) -> dict:
    """读终稿+池真账 → sidecar 落盘 (doc_registry/claim_ledger/gap_tickets)."""
    pool_dir = pool_root / cid
    rows = [json.loads(x) for x in (pool_dir / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines() if x.strip()]
    graded = _load_graded(pool_dir, rows)
    text = Path(draft_path).read_text(encoding="utf-8")
    res = audit_draft(text, rows, graded, _node_against_urls(rows))
    (pool_dir / "doc_registry.json").write_text(
        json.dumps({"cid": cid, "docs": res["registry"]},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    out = {"cid": cid, "draft": str(draft_path),
           "generated": time.strftime("%Y-%m-%d %H:%M"),
           "engine_version": "claim-ledger-v1 (W3-1 断言链引擎)",
           "triggers_note": "第四触发位 (P1-7 扩展): 单源/零源断言; "
                            f"原三触发位 {GAP_LEGACY_TRIGGERS} 由 gap_extractor 承担",
           **{k: v for k, v in res.items() if k != "registry"}}
    (pool_dir / "claim_ledger.json").write_text(
        json.dumps(out, ensure_ascii=False, indent=1), encoding="utf-8")
    out["gap_added"] = append_gap_tickets(pool_dir / "gap_tickets.jsonl",
                                          res["gap_tickets"])
    return out


def _main(argv: list[str]) -> int:
    ap = argparse.ArgumentParser(description="断言账本 (验证合同 W3-1)")
    ap.add_argument("--campaign-id", required=True)
    ap.add_argument("--draft", help="终稿 md 路径 (缺省只产文档登记表)")
    ap.add_argument("--pool-root", default=str(POOL_ROOT))
    ns = ap.parse_args(argv)
    pool_dir = Path(ns.pool_root) / ns.campaign_id
    rows = [json.loads(x) for x in (pool_dir / "manifest.jsonl")
            .read_text(encoding="utf-8").splitlines() if x.strip()]
    graded = _load_graded(pool_dir, rows)
    reg = build_registry(rows, graded)
    (pool_dir / "doc_registry.json").write_text(
        json.dumps({"cid": ns.campaign_id, "docs": reg},
                   ensure_ascii=False, indent=1), encoding="utf-8")
    print(f"[ledger] {ns.campaign_id}: 文档登记表 {len(reg)} docs → "
          f"doc_registry.json")
    if not ns.draft:
        return 0
    r = audit_campaign(Path(ns.draft), ns.campaign_id, Path(ns.pool_root))
    s = r["stats"]
    print(f"[ledger] 断言 {s['claims']} | 状态 {s['by_state']} | "
          f"T0阻塞 {s['t0_blocked']} | recall {s['citation_recall']} "
          f"({'PASS' if s['gates']['recall_pass'] else 'FAIL'}) | "
          f"precision {s['citation_precision']} "
          f"({'PASS' if s['gates']['precision_pass'] else 'FAIL'})")
    print(f"[ledger] gap 新增 {r['gap_added']} 条 (单源/零源断言 100% 进 gap)")
    print(f"[ledger] sidecar: claim_ledger.json / gap_tickets.jsonl")
    return 0


if __name__ == "__main__":
    sys.exit(_main(sys.argv[1:]))
