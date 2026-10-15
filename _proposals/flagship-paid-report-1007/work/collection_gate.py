# -*- coding: utf-8 -*-
"""F1 调研搜集门 — 1010 用户两连令固化 (代码级, 非会话约定):

  令一「调研搜集的资料总字数不达标坚决不能开工写报告」
       → 字数门: 门参数自 reforge_factory/config/gates.json 单一权威源
         决策时现读 (T-002B/REQ-010): v3 口径 T1≥1000万 单门主判,
         T12 总门撤 (REQ-011); flags.legacy_t12_gate=True 回旧 v5 双门
         (两千万/五千万, REQ-002 应急回滚); 2亿=采集预算参考线
  令二「字数达标后详细汇报质量情况, 我验收批准后才可以开始撰写」
       → 质量门: QUALITY_DOSSIER 生成 + user_approved 旗标;
         仅当用户在会话中明示批准后方可 `approve` 落旗.

联动硬闸: m2_gate.py / m2_gate2.py 顶部检查本门 state,
  user_approved != true → 一律 exit 2 拒绝放行任何章节 (写作冻结).

用法:
  python collection_gate.py measure   # 扫语料+池, 刷 state (字数面)
  python collection_gate.py status    # 打印门态
  python collection_gate.py report    # 达标后生成质量汇报骨架
  python collection_gate.py approve --note "用户批准原话"   # 用户明示后!
"""
import argparse
import json
import os
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
WORK = Path(__file__).parent
STATE = WORK / "collection_gate_state.json"
DOSSIER = WORK / "QUALITY_DOSSIER.md"
F1_INV = WORK / "f1_inventory.json"
CORPUS = Path(r"F:\新建文件夹\AI总包创新院\总包研报")
AMMO = Path(r"E:\AI-Station\ammo_pool")
CID = os.environ.get("AMMO_CID", "F1-BLUEBOOK")   # 1012: 生产线多战役参数化 (EPC-BID26 等)
F1_POOL = AMMO / CID
F1_TREE = WORK / "f1_gap_tree_v2.json"
V3_LOG = Path(r"E:\AI-Station\Auto_Manus\data\epc50_corps_log.jsonl")

# ---------- 门参数: gates.json 单一权威源 (T-002B / REQ-010 / REQ-011) ----------
# 旧 v5 硬编码门 (BAR 常量, 1015 调标令: T1≥两千万 ∧ T1+T2≥五千万) 已退役:
# 改为决策时现读 E:/AI-Station/reforge_factory/config/gates.json (经 gates_loader,
# 无缓存) — 改 json 即时生效 (REQ-010.AC2). legacy 口径仅作 flags 回开分支保留
# (REQ-002 应急回滚路径, 旧数字以拆开乘式写法引用, 不作为生效常量):
#   1010令(legacy): 门槛总量 二亿 = 采集预算参考线 (legacy_total_budget_reference)
#   1015令(legacy v5): T1 报告直接 ≥ 两千万 且 T1+T2(同业对标) ≥ 五千万 才达标
#   v3 在役口径 (gates.json): T1 ≥ t1_min_chars(1000万) 单门主判 (REQ-011),
#                   T12 总门撤 (t12_total_gate=null → 「总门已撤(v3)」).
_GATES_ROOT = WORK.parents[2] / "reforge_factory"   # gates.json 属主=引擎层 (REQ-010 路径约定)
if str(_GATES_ROOT) not in sys.path:
    sys.path.insert(0, str(_GATES_ROOT))
import gates_loader  # noqa: E402  门参数单一权威源 loader (T-002 地基件)


def _pos_int(v) -> bool:
    return isinstance(v, int) and not isinstance(v, bool) and v > 0


def gate_bar(gates: dict | None = None) -> dict:
    """字数门口径 — 决策时现读 gates.json 权威源 (无缓存, T-002B/REQ-010).

    v3 在役: t1_min = t1_min_chars(1000万) 单门主判; t1t2_min = t12_total_gate,
    None 即「总门已撤(v3)」(REQ-011), 判定分支跳过 T1+T2 总门.
    flags.legacy_t12_gate=True 回旧 v5 双门口径 (REQ-002 应急回滚):
    T1 ≥ 两千万 ∧ T1+T2 ≥ 五千万 (乘式拆写保口径, 非生效常量).
    budget_chars 恒为参考线 (REQ-011: 旧 2 亿总量门保留为参考线不作主判).
    """
    g = gates if gates is not None else gates_loader.load_gates()
    budget = g.get("legacy_total_budget_reference")
    if not _pos_int(budget):
        budget = gates_loader.DEFAULTS["legacy_total_budget_reference"]
    flags = g.get("flags") if isinstance(g.get("flags"), dict) else {}
    if flags.get("legacy_t12_gate"):                   # REQ-002: 回旧 v5 双门
        return {"t1_min": 2 * 10 ** 7,                 # legacy v5 (1015令): 两千万
                "t1t2_min": 5 * 10 ** 7,               # legacy v5 (1015令): 五千万
                "budget_chars": budget, "mode": "legacy_v5"}
    t1_min = g.get("t1_min_chars")
    if not _pos_int(t1_min):
        t1_min = gates_loader.DEFAULTS["t1_min_chars"]
    t12 = g.get("t12_total_gate")
    t12 = t12 if _pos_int(t12) else None               # None = 总门已撤(v3)
    return {"t1_min": t1_min, "t1t2_min": t12,
            "budget_chars": budget, "mode": "v3"}


# ---------- T-003 / REQ-015: 完备性门 + 饱和门 (S1 出门判定, 旁挂函数) ----------
# 门参数自 gates.json 单一权威源现读 (同 gate_bar 范式, 无缓存):
#   completeness_gate = {required_axes:[T,B,D,P,C], pass_rule:"all_green_or_waived"}
#   saturation_gate   = {min_evidence:2, min_hosts:2, min_pct:80}
# 账本/数据源 (KB-COMPLETENESS-SPEC + ammo_pool.coverage 实测形态):
#   五轴账本  = ammo_pool/<campaign>/completeness_ledger.jsonl (每轴一节 jsonl)
#   饱和数据  = ammo_pool/<campaign>/question_tree.json 的 coverage 节
#               (eei_total/saturated/gap/sat_pct/checked; saturated 计数即
#                coverage() 逐 EEI 预判「≥2 证据 ∧ ≥2 独立 host」的 EEI 数)

COMPLETE_LEDGER_NAME = "completeness_ledger.jsonl"
QUESTION_TREE_NAME = "question_tree.json"


def _completeness_axes(gates: dict | None = None) -> list:
    """完备门五轴口径 — gates.json completeness_gate.required_axes 现读."""
    g = gates if gates is not None else gates_loader.load_gates()
    cg = g.get("completeness_gate")
    axes = cg.get("required_axes") if isinstance(cg, dict) else None
    if not (isinstance(axes, list) and axes
            and all(isinstance(a, str) and a for a in axes)):
        axes = gates_loader.DEFAULTS["completeness_gate"]["required_axes"]
    return list(axes)


def read_completeness_ledger(campaign: str, ammo_root=None) -> dict:
    """读五轴完备账本 ammo_pool/<campaign>/completeness_ledger.jsonl.

    KB-COMPLETENESS-SPEC: 每轴一节 (axis/sensor/green + 各轴负载数据)。
    fail-soft: 账本不存在/坏行 → 该轴缺记录 (判定时 unknown), 不抛不炸;
    同轴多行取最后一条 (S1 采集期滚动更新语义, 后行=最新态)。
    """
    root = Path(ammo_root) if ammo_root is not None else AMMO
    p = root / campaign / COMPLETE_LEDGER_NAME
    records: dict = {}
    exists = p.is_file()
    if exists:
        try:
            for line in p.read_text(encoding="utf-8").splitlines():
                line = line.strip()
                if not line:
                    continue
                try:
                    rec = json.loads(line)
                except ValueError:
                    continue                      # 坏行跳过, 不拖垮门判定
                if isinstance(rec, dict) and rec.get("axis"):
                    records[rec["axis"]] = rec
        except OSError:
            exists = False
    return {"exists": exists, "records": records, "path": str(p),
            "axes_in_ledger": sorted(records)}


def completeness_gate_verdict(ledger, gates: dict | None = None) -> dict:
    """五轴完备门: all_green_or_waived (REQ-015, 缺任一轴即 FAIL).

    每轴门态: green(记录 green==True) / waived(豁免制: 记录含 waived==True,
    green 可 False) / red(green 显式 False 且未豁免) / unknown(缺轴/账本不
    存在/记录无 green 字段)。pass = 全部 required_axes 门态 ∈ {green, waived}。
    """
    g = gates if gates is not None else gates_loader.load_gates()
    cg = g.get("completeness_gate")
    rule = (cg.get("pass_rule") if isinstance(cg, dict) else None) \
        or gates_loader.DEFAULTS["completeness_gate"]["pass_rule"]
    records: dict = {}
    if isinstance(ledger, dict):
        recs = ledger.get("records")
        records = recs if isinstance(recs, dict) else ledger  # 兼容裸记录 dict
    axes = _completeness_axes(g)
    statuses = {}
    for ax in axes:
        rec = records.get(ax)
        if not isinstance(rec, dict):
            statuses[ax] = "unknown"              # 缺轴/账本不存在
        elif rec.get("green") is True:
            statuses[ax] = "green"
        elif rec.get("waived") is True:
            statuses[ax] = "waived"               # 豁免制 (用户明示豁免在案)
        elif "green" in rec:
            statuses[ax] = "red"
        else:
            statuses[ax] = "unknown"              # 记录在但无 green 判定
    ok = {"green", "waived"}
    return {"pass": bool(statuses) and all(s in ok for s in statuses.values()),
            "pass_rule": rule, "required_axes": axes,
            "axis_statuses": statuses,
            "ledger_exists": bool(ledger.get("exists"))
            if isinstance(ledger, dict) else False,
            "green_axes": sorted(a for a, s in statuses.items() if s == "green"),
            "waived_axes": sorted(a for a, s in statuses.items() if s == "waived"),
            "failing_axes": sorted(a for a, s in statuses.items() if s not in ok)}


def saturation_gate_verdict(campaign: str, ammo_root=None,
                            gates: dict | None = None) -> dict:
    """饱和门: 每 EEI ≥2 证据 ∧ ≥2 独立 host ∧ 饱和率≥min_pct (REQ-015).

    数据源 = ammo_pool.coverage() 落在 question_tree.json 的 coverage 节
    (EEI 级「≥min_evidence 证据 ∧ ≥min_hosts 独立 host」判据由 coverage()
    逐 EEI 预判进 saturated 计数, 本门消费其聚合账)。fail-soft: 树缺/
    无 coverage 节/坏 JSON → status=unknown 且 pass=False (计入 FAIL 域,
    数据不可得不虚报 PASS)。
    """
    g = gates if gates is not None else gates_loader.load_gates()
    sg = g.get("saturation_gate")
    sg = sg if isinstance(sg, dict) else {}

    def _sgnum(k):
        v = sg.get(k, gates_loader.DEFAULTS["saturation_gate"][k])
        return (v if isinstance(v, (int, float)) and not isinstance(v, bool)
                else gates_loader.DEFAULTS["saturation_gate"][k])

    min_ev, min_host, min_pct = (_sgnum("min_evidence"),
                                 _sgnum("min_hosts"), _sgnum("min_pct"))
    root = Path(ammo_root) if ammo_root is not None else AMMO
    tp = root / campaign / QUESTION_TREE_NAME
    base = {"campaign": campaign, "source": str(tp),
            "min_evidence": min_ev, "min_hosts": min_host, "min_pct": min_pct,
            "eei_rule": (f"coverage() 逐EEI预判: >={min_ev}证据 ∧ "
                         f">={min_host}独立host 计入 saturated")}
    cov = None
    if tp.is_file():
        try:
            tree = json.loads(tp.read_text(encoding="utf-8"))
            cov = tree.get("coverage") if isinstance(tree, dict) else None
        except (OSError, ValueError):
            cov = None
    if not isinstance(cov, dict):
        return {**base, "status": "unknown", "pass": False,
                "reason": "question_tree.json 无 coverage 节 "
                          "(先跑 ammo_pool.py coverage <cid> 刷饱和账)"}
    total, sat_n = cov.get("eei_total"), cov.get("saturated")
    out = {**base, "eei_total": total, "saturated": sat_n,
           "gap": cov.get("gap"), "sat_pct": cov.get("sat_pct"),
           "checked": cov.get("checked")}
    if (not _pos_int(total)) or (not isinstance(sat_n, int)
                                 or isinstance(sat_n, bool)):
        return {**out, "status": "unknown", "pass": False,
                "reason": "coverage 节 eei_total/saturated 形态不合 (无可判 EEI)"}
    pct = cov.get("sat_pct")
    if not isinstance(pct, (int, float)) or isinstance(pct, bool):
        pct = round(100 * sat_n / max(1, total), 1)   # 同 ammo_pool 口径补算
        out["sat_pct"] = pct
    passed = pct >= min_pct
    return {**out, "status": "pass" if passed else "fail", "pass": bool(passed)}


def _load() -> dict:
    try:
        return json.loads(STATE.read_text(encoding="utf-8"))
    except Exception:
        return {"measured_at": None, "f1_corpus_chars": 0,
                "f1_pool": {}, "corps_f1": {}, "tier": None,
                "word_gate_pass": False, "quality_report": None,
                "user_approved": False, "approved_at": None,
                "approved_note": None}


def _save(st: dict) -> None:
    st.setdefault("bar", gate_bar())   # T-002B: bar 落账=实际使用口径 (measure 已写则原样保留)
    tmp = STATE.with_suffix(".tmp")
    tmp.write_text(json.dumps(st, ensure_ascii=False, indent=1),
                   encoding="utf-8")
    tmp.replace(STATE)


def cjk_of(text: str) -> int:
    return sum('\u4e00' <= c <= '\u9fff' for c in text)


def measure(st: dict) -> dict:
    # ① F1 语料存量 (inventory 实测口径, docx/文本字符)
    try:
        inv = json.loads(F1_INV.read_text(encoding="utf-8"))
        if isinstance(inv, list):                     # 67 项清单 (真源 schema)
            st["f1_corpus_chars"] = int(sum(
                x.get("words_total", 0) for x in inv))
            st["f1_corpus_dirs"] = len(inv)
        else:
            st["f1_corpus_chars"] = int(inv.get("words_total", 0))
            st["f1_corpus_dirs"] = int(inv.get("dirs", 0))
    except Exception:
        st["f1_corpus_chars"] = 0
    # ② F1 专属弹药池 (存量语料 f1_pool_build + 军团 hook_harvest 双入口)
    pool = {"exists": (F1_POOL / "pool_state.json").is_file()}
    try:
        ps = json.loads((F1_POOL / "pool_state.json").read_text(encoding="utf-8"))
        pool.update({"total_chars": ps.get("total_chars", 0),
                     "items": ps.get("items", 0),
                     "pending_chars": ps.get("pending_chars", 0),
                     "t1_chars": ps.get("t1_chars", None),
                     "t2_chars": ps.get("t2_chars", None),
                     "t3_chars": ps.get("t3_chars", None),
                     "t0_chars": ps.get("t0_chars", None),
                     "t1_items": ps.get("t1_items", None),
                     "t2_items": ps.get("t2_items", None),
                     "gate_chars": ps.get("gate_chars", None),
                     "by_engine": ps.get("by_engine", {}),
                     "last_tier_persist": ps.get("last_tier_persist")})
    except Exception:
        pass
    st["f1_pool"] = pool
    # ③ 军团 F1 树派单/收单面
    try:
        t = json.loads(F1_TREE.read_text(encoding="utf-8"))
        qs = [q for tp in t["topics"] for q in tp["questions"]]
        st["corps_f1"] = {
            "pending": sum(q["status"] == "pending" for q in qs),
            "dispatched": sum(q["status"] == "dispatched" for q in qs),
            "done": sum(q["status"] not in ("pending", "dispatched")
                        for q in qs),
            "harvested_chars": sum(q.get("chars", 0) for q in qs),
        }
    except Exception:
        st["corps_f1"] = {}
    # ④ 字数门: 只认 tier 判定过的有效数 (池 t1/t2); 无判定 = 未达标
    # T-002B/REQ-010/011: 门参数决策时现读 gates.json (经 gate_bar, 无缓存);
    #   v3 口径 T1≥t1_min_chars 单门主判, t12_total_gate=None → 总门已撤(v3)
    #   跳过 T1+T2 判定; flags.legacy_t12_gate=True 回旧 v5 双门 (REQ-002).
    t1 = pool.get("t1_chars")
    t2 = pool.get("t2_chars")
    bar = gate_bar()
    st["bar"] = bar                     # state 落账=实际使用口径值 (T-002B)
    st["tier"] = {"t1_valid": t1, "t2_valid": t2,
                  "t12_gate": ("总门已撤(v3)" if bar["t1t2_min"] is None
                               else bar["t1t2_min"]),
                  "judge": "pending" if t1 is None else "pool_state"}
    if bar["t1t2_min"] is None:         # REQ-011: 总门已撤(v3), 只判 T1
        st["word_gate_pass"] = bool(
            t1 is not None and t1 >= bar["t1_min"])
    else:                               # 旧双门判定分支保留 (legacy v5 回开)
        st["word_gate_pass"] = bool(
            t1 is not None and t2 is not None
            and t1 >= bar["t1_min"] and t1 + t2 >= bar["t1t2_min"])
    # ⑤ 完备性门 ∧ 饱和门 (T-003/REQ-015): S1 出门判定 = 三门串联
    #    字数门(T1) ∧ completeness(五轴 all_green_or_waived) ∧ saturation
    #    (EEI ≥2证据∧≥2独立host∧饱和率≥80%) — 逐门态落 state; word_gate_pass
    #    既有语义不动 (旧字段只增不覆盖), 三门串联总判落新键 s1_gate_pass.
    comp = completeness_gate_verdict(read_completeness_ledger(CID))
    satu = saturation_gate_verdict(CID)
    st["completeness"] = comp
    st["saturation"] = satu
    st["s1_gate_pass"] = bool(st.get("word_gate_pass") and comp["pass"]
                              and satu["pass"])
    st["measured_at"] = time.strftime("%Y-%m-%dT%H:%M:%S")
    return st


def _channel_ledger(by_engine: dict) -> list:
    """渠道完备门过账行: 注册表 16 渠道 × F1 池 engine 账 (静默缺席不许收官)."""
    reg_path = Path(r"E:\AI-Station\Auto_Manus\data\bus"
                    r"\channel_registry.json")
    try:
        reg = json.loads(reg_path.read_text(encoding="utf-8"))
    except Exception:
        reg = []
    rows = []
    for ch in reg:
        cid_, name = ch.get("id", "?"), ch.get("name", "?")
        if cid_ == "manus":
            contrib = by_engine.get("manus:corps", 0)
            note = "F1 缺口树派单收割 (hook_harvest 自动入池)"
        else:
            contrib = 0
            note = ("存量编译内含其历史贡献; 跨战役复用已过账"
                    "（见下方池engine cross: 行）; F1 专属新采待开火")
        rows.append((name, contrib, note))
    for tag, chars in sorted(by_engine.items(), key=lambda x: -x[1]):
        if tag == "manus:corps":                     # manus 账已挂注册行
            continue
        if tag == "cross:rss":
            note = "跨战役收割件复用入账 (data/rss_harvest RSS 常年收割面, 同尺 judge+tiers)"
        elif tag.startswith("cross:"):
            note = "跨战役收割件复用入账 (ResearchTopics 研究树, 同尺 judge+tiers)"
        else:
            note = "存量语料建池入账 (多渠道历史编译)"
        rows.append((f"[池engine] {tag}", chars, note))
    return rows


def _grade_hist() -> str:
    try:
        inv = json.loads(F1_INV.read_text(encoding="utf-8"))
        g = {}
        for x in inv:
            g[x.get("grade", "?")] = g.get(x.get("grade", "?"), 0) + 1
        return " · ".join(f"{k}级 {v} 目录" for k, v in sorted(g.items()))
    except Exception:
        return "(盘点件缺失)"


def report(st: dict) -> int:
    """质量档案生成 — 门态无关恒可出 (全部实数, 零手填)。

    门未过时本档案=进度+质量实况 (标题明示 FAIL, 非验收放行件);
    门过后同一生成器产出即为用户验收材料。approve 前置仍硬性要求
    word_gate_pass — 序列不可作弊 (1010 用户令)。
    """
    p = st.get("f1_pool", {})
    r = st.get("corps_f1", {})
    t1 = p.get("t1_chars")
    t2 = p.get("t2_chars")
    t12 = (t1 or 0) + (t2 or 0)
    t1_s = f"{t1:,}" if t1 is not None else "?"
    t2_s = f"{t2:,}" if t2 is not None else "?"
    bar = gate_bar()                    # T-002B: 决策时现读口径 (gates.json 权威源)
    t12_min = bar["t1t2_min"]
    gate = "PASS ✅" if st.get("word_gate_pass") else "FAIL ⏳"
    nature = ("用户验收材料" if st.get("word_gate_pass")
              else "**进度与质量实况 (字数门未过, 非验收放行件)**")
    if t12_min is None:                 # REQ-011: 总门已撤(v3), 单门主判 T1
        t12_desc, gap, gap_note = "总门已撤(v3)", 0, "T1 单门主判, 总门不再判"
    else:
        t12_desc = f"T1+T2≥{t12_min:,}"
        gap = max(0, t12_min - t12)
        gap_note = f"距 T1+T2 门差 {gap:,} 字待采"
    eng_lines = "\n".join(
        f"| {k} | {v:,} |" for k, v in
        sorted(p.get("by_engine", {}).items(), key=lambda x: -x[1]))
    ledger = _channel_ledger(p.get("by_engine", {}))
    ledger_lines = "\n".join(
        f"| {n} | {c:,} | {note} |" for n, c, note in ledger)
    # 缺口四面: 树话题进度 + 存量主稿对位
    try:
        t = json.loads(F1_TREE.read_text(encoding="utf-8"))
        face_rows = []
        for tp in t["topics"]:
            qs = tp["questions"]
            face_rows.append((tp["title"],
                              sum(q["status"] == "pending" for q in qs),
                              sum(q["status"] == "dispatched" for q in qs),
                              sum(q["status"] not in ("pending", "dispatched")
                                  for q in qs),
                              sum(q.get("chars", 0) for q in qs)))
        face_lines = "\n".join(
            f"| {ti} | 待派 {a} / 已派 {b} / 已收 {c} | 已收割 {d:,} 字 |"
            for ti, a, b, c, d in face_rows)
    except Exception:
        face_lines = "(树件缺失)"
    md = f"""# F1 调研搜集质量档案 — {st['measured_at']} ｜ {nature}

> 字数门: T1≥{bar['t1_min']:,} ∧ {t12_desc} 有效字符（弹药门 v3,
> tiers.json 判定, 只算新增+judge valid）
> 实绩: T1={t1_s} ｜ T2={t2_s}
> ｜ T1+T2={t12:,} ｜ **门态 {gate}**（{gap_note}）

## 1. 总量与分层账
- 存量语料盘点: {st['f1_corpus_chars']:,} 字（han+西文词口径,
  {st.get('f1_corpus_dirs', '?')} 目录, {_grade_hist()}）
- F1-BLUEBOOK 池（判定后真账）: 有效 {p.get('total_chars', 0):,} 字 /
  {p.get('items', 0)} 件 ｜ 待审 {p.get('pending_chars', 0):,}
- 分层: T1 {t1_s} ({p.get('t1_items','?')}件) ｜
  T2 {t2_s} ({p.get('t2_items','?')}件) ｜
  T3 {p.get('t3_chars', 0) or 0:,}（封顶不计门）｜ T0 {p.get('t0_chars', 0) or 0:,}（不计）
- 军团 F1 缺口树: 待派 {r.get('pending')} / 已派 {r.get('dispatched')} /
  已收 {r.get('done')} / 收割 {r.get('harvested_chars', 0):,} 字
- 池引擎账:
| engine | 字数 |
|---|---|
{eng_lines}

## 2. 渠道完备门过账（注册表逐条, 静默缺席不许收官）
| 渠道 | F1 专属贡献(字) | 态/计划 |
|---|---|---|
{ledger_lines}

## 3. 分层成色
- T1 主稿构成（按引擎分账, 不一概而论）: stock:corpus 67 件 = 我方
  编译研究报告（credibility=research → GRADE B 权威二手, 原始一手源
  在其引用链内）; cross:* 收割件 = 各渠道一手/二手资料, 按渠道
  cred 定级（gov=policy/standards 类, paper=cnki/academic 类,
  research=djyanbao 类, 其余 web）, 成稿引用照断言链 S0 门回溯
- 存量成色: {_grade_hist()}（A=单稿≥8万字可精编）
- 抽样锚点回查: 3-1 湖南打样章已过 m2_gate2 数字锚点门
  （165 去重锚点 / own_calc×5 / 源内分歧显式披露）— 方法链在位,
  全量章级回查随 M2 量产逐章执行
- 同题归并纪律: 存量建池 86 候选 docx → 71 主稿（副本/排版/中间
  成果 15 件留档不入池, 防版本虚账）; cross:* 腿内容头去重同防双计

## 4. 缺口四面覆盖（f1_gap_tree_v2 实况）
| 面 | 树进度 | 已收割 |
|---|---|---|
{face_lines}

## 5. 已知瑕疵与披露
1. **口径差**: 存量盘点 1,034.8 万 = han+西文词口径; 存量建池 71 主稿
   10,159,246 = 去空白全字符口径且剔版本副本 — 两者差异为口径定义,
   非丢失（cross:* 与军团增量腿与盘点口径无关, 全走池账）。
2. 存量为**我方自产二手编译品**（B 级）, 非一手官方源; 蓝皮书引用
   数字仍须按断言链 S0 门回溯一手出处（湖南章已示范）。
3. PDF 未入池（与盘点口径对齐防 docx+pdf 双计）, 留档可查。
4. T1/T2 分层为**标题级下界**（1005 定调词表 tiers.json）: 标题无
   EPC 族词≠内容不相关, T0 件在成稿阶段照常可引用, 只不上门账。
5. 树问 chars 为收割 raw 口径, 池门账只认 judge valid — 两账并行
   不互换。
6. 渠道完备门: 16 注册渠道中 F1 专属贡献当前仅存量编译+军团两腿,
   其余渠道 F1 专属补采**尚未开火**（首窗后按完备门逐条过账）。
7. **跨战役复用披露**（1011 两腿）: 池内 engine=cross:* 行为跨战役
   复用 — 一腿来自 ResearchTopics 研究树（EPC49/50 历史战役工作区）
   收割件, 二腿来自 data/rss_harvest/articles（PAIStation-rss-harvest
   每日 07:37/19:37 的 RSS 常年收割面, engine=cross:rss 单列可区分）。
   同一把尺（F1 词表 judge + tiers 标题分层）, 内容头去重（两腿重叠
   14,742 件已自动跳过）; 排除法院裁判文书卷宗、用户私有资料、
   >2MB 合并巨件三类; PAIStation-F1CrossIngest 计划任务 30min 增量
   重跑（幂等）。跨战役素材与 F1 专属新采在池内按 engine 可区分,
   不冒充新采。
"""
    DOSSIER.write_text(md, encoding="utf-8")
    st["quality_report"] = str(DOSSIER)
    print(f"✓ 质量档案已生成 {DOSSIER.name} (门态 {gate}, 全实数)")
    return 0


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("cmd", choices=["measure", "status", "report", "approve"])
    ap.add_argument("--note", default="")
    args = ap.parse_args()
    st = _load()
    if args.cmd == "measure":
        st = measure(st)
        _save(st)
    elif args.cmd == "report":
        rc = report(st)
        _save(st)
        return rc
    elif args.cmd == "approve":
        if not st.get("word_gate_pass"):
            print("⛔ 字数门未过, 不可批准")
            return 1
        if not st.get("quality_report"):
            print("⛔ 质量汇报未生成, 不可批准")
            return 1
        st["user_approved"] = True
        st["approved_at"] = time.strftime("%Y-%m-%dT%H:%M:%S")
        st["approved_note"] = args.note or "用户会话明示批准"
        _save(st)
        print("✓ 用户验收旗标已落 — 写作解冻 (m2_gate 守卫放行)")
        return 0
    g = st.get("word_gate_pass")
    t12g = (st.get("tier") or {}).get("t12_gate", "?")
    print(f"[F1搜集门 {st.get('measured_at')}] 语料 {st.get('f1_corpus_chars', 0):,} raw"
          f" | T1={st['tier']['t1_valid'] if st.get('tier') else '?'}"
          f" T2={st['tier']['t2_valid'] if st.get('tier') else '?'}"
          f" T12门={t12g}"
          f" | 字数门 {'PASS' if g else 'FAIL'}"
          f" | 质量汇报 {'有' if st.get('quality_report') else '无'}"
          f" | 用户批准 {'✓' if st.get('user_approved') else '✗ 未批 — 写作冻结'}")
    # T-003/REQ-015: S1 出门门态行 (五轴各轴门态 + 饱和门态; 旧 state 无键 → ?)
    comp, satu = st.get("completeness") or {}, st.get("saturation") or {}
    ax = comp.get("axis_statuses") or {}
    ax_s = " ".join(f"{k}:{v}" for k, v in ax.items()) or "?"
    satu_s = satu.get("status", "?")
    satu_pct = satu.get("sat_pct", "?")
    print(f"  S1出门判定: 字数门 {'PASS' if g else 'FAIL'}"
          f" ∧ 完备性门 {'PASS' if comp.get('pass') else ('?' if not comp else 'FAIL')}"
          f" [{ax_s}]"
          f" ∧ 饱和门 {'PASS' if satu.get('pass') else satu_s.upper()}"
          f" (饱和率 {satu_pct}% ≥ 门 {satu.get('min_pct', '?')}%)"
          f" → S1 {'PASS' if st.get('s1_gate_pass') else 'FAIL'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
