# -*- coding: utf-8 -*-
"""需求雷达 v1 (superline.demand_radar) — REQ-030 / Engine B · S-1 段.

KB-DEMAND-RADAR-SPEC 落地件: 对候选选题出四维评分卡, 原始信号逐条落盘可回放.

    DScore = 0.25·需求强度 + 0.20·支付能力 + 0.25·竞争空缺 + 0.20·语料复用度
             + 0.10·决策紧迫度  (各维 0-1; V4 第五维 0.10 自需求强度匀出, 五维和=1)

四维 v1 实现口径 (规格同源, 防伪=原始信号全落 radar_signals.jsonl):
  需求强度  三快源归一化: bidding_volume(0.45) + wechat_pain(0.45) + policy_pulse(0.10),
            按在场源重归一 (缺源=该源内部权重让出, 即"缺源降权"; 全缺=0 分并如实报覆盖).
            归一化用 log1p 分位: log1p(v)/log1p(批次最大值), 压制跨选题数量级差.
  支付能力  v1 规则表: 买家画像字典 (企业战略部 > 投标团队 > 咨询 > 中小设计院 > 个人);
            接口留 persona_hook, v2 接真实买家行为数据后替换.
  竞争空缺  v1 规则表: 现有 SKU 清单比对 (report.json 实盘标题 × 选题匹配词),
            命中数越多=市面覆盖越厚=空缺越小; 接口留 competition_hook.
  语料复用度 池内存量字符 log1p 分位 (复用高=边际成本低), 源=pool_state.json total_chars.

v1 三快源信号 (全部为代理量, jsonl 中 source=proxy_pool_chars, 引擎分解随行 meta 可回放):
  bidding_volume  池内比地/招投标类引擎字符量 (engine 名含 bidding/bidcut/bid26)
  policy_pulse    政策管线引擎字符量 (engine 名含 policy)
  wechat_pain     公众号引擎字符量 × 痛点关键词表因子 (engine 名含 wechat/微信;
                  因子 0.8/0.9/1.0 按池 kws 命中痛点词 0/1/≥2 档, 关键词表见 PAIN_KEYWORDS)
  引擎归类优先级 wechat > bidding > policy (cross:wechat_rss:bidcut 归公众号渠道).

run() 批量出卡: superline/radar_scorecards.json + superline/radar_signals.jsonl.
雷达只建议不决策 (人工闸照旧); S8 漏斗数据回写校准权重属 v2.

用法:
  py reforge_factory/superline/demand_radar.py --topics reforge_factory/superline/radar_topics.json
  from superline.demand_radar import score, run
"""
from __future__ import annotations

import argparse
import json
import math
import sys
from datetime import datetime, timezone
from pathlib import Path

SUPERLINE_DIR = Path(__file__).resolve().parent
REPO_ROOT = SUPERLINE_DIR.parents[1]

# ---------- 常量唯一事实源 ----------

WEIGHTS = {"需求强度": 0.25, "支付能力": 0.20, "竞争空缺": 0.25,
           "语料复用度": 0.20, "决策紧迫度": 0.10}

# V4 第五维 (REQ-023 / KB-V4-SPEC 决策反推): 0.10 自需求强度(0.35→0.25)匀出,
# 五维和恒 1.0; v1 四维口径 (0.35/0.20/0.25/0.20) 见 git 历史, 公式演进只增不改.
DECISION_DIM = "决策紧迫度"

# 需求强度内部源权重 (规格: 公告量分位+痛点聚类频次为主, 政策窗口为辅)
DEMAND_SOURCE_WEIGHTS = {"bidding_volume": 0.45, "wechat_pain": 0.45, "policy_pulse": 0.10}
DEMAND_SOURCES = tuple(DEMAND_SOURCE_WEIGHTS)

# 支付能力规则表 (买家画像字典, v1; hook 可整体替换)
BUYER_PERSONA_TABLE = {
    "enterprise_strategy": 0.95,   # 企业战略部/经营班底 (最高支付力)
    "enterprise_bid_team": 0.85,   # 投标/合规团队 (刚需型采购)
    "consultant": 0.65,            # 独立咨询/顾问
    "sme_design_institute": 0.60,  # 中小设计院/工程公司
    "individual_learner": 0.35,    # 个人学习者
}
DEFAULT_PERSONA_SCORE = 0.50       # 画像未登记时的保守缺省 (note 如实标注)

# 竞争空缺规则表: 现有 SKU 命中数 -> 空缺分 (覆盖越厚空缺越小)
# ((命中上限(含), 空缺分), ...) 逐档取第一个满足档; 超出末档按 0.25
COMPETITION_RULE = ((0, 1.00), (1, 0.85), (2, 0.65), (3, 0.45))
COMPETITION_FLOOR = 0.25           # 命中 >=4: 红海

# 公众号痛点关键词表 (v1 代理因子; 命中池 kws 计数)
PAIN_KEYWORDS = ("怎么办", "求教", "踩坑", "痛点", "合规", "风险", "规避", "指南")

# 池引擎归类 (pool_state.json by_engine 键匹配; 优先级自上而下)
ENGINE_KEYS = {
    "wechat_pain": ("wechat", "微信"),
    "bidding_volume": ("bidding", "bidcut", "bid26"),
    "policy_pulse": ("policy",),
}

# 交接契约 DoD 字段 (v1 规则建议档: 由 DScore 分档, 非市场实测)
PRODUCT_BANDS = (
    (0.75, {"建议产品形态": "企业版定制报告+全本高客单", "建议价档": "¥1,999–¥9,999",
            "预期收入区间": "¥50k–¥200k/战役"}),
    (0.55, {"建议产品形态": "全本+单章中档", "建议价档": "¥498–¥1,999",
            "预期收入区间": "¥10k–¥50k/战役"}),
    (0.35, {"建议产品形态": "试读引流+单章", "建议价档": "¥98–¥498",
            "预期收入区间": "¥2k–¥10k/战役"}),
    (0.00, {"建议产品形态": "观察池(不建议立项)", "建议价档": "—",
            "预期收入区间": "—"}),
)

SKILLS_FILE = REPO_ROOT / "report_platform" / "content" / "report.json"  # 现有 SKU 清单 (实盘)
TOPICS_FILE_DEFAULT = SUPERLINE_DIR / "radar_topics.json"
SCORECARDS_PATH = SUPERLINE_DIR / "radar_scorecards.json"
SIGNALS_PATH = SUPERLINE_DIR / "radar_signals.jsonl"

# ---------- 第五维: 决策反推 decision_hook (REQ-023 / KB-V4-SPEC 高度) ----------

#: 四问字段 (缺任一 ValueError 退回, 不猜)
DECISION_QUESTIONS = ("read_then_decide", "decision_deadline", "wrong_cost",
                      "success_criteria")

# 错拍代价量级启发表 (v1 规则; 命中即档, 先重后轻)
COST_MAG_RULES = (
    (("亿", "千万", "百万", "致命", "生死", "停业", "吊销"), 1.00),
    (("万", "高", "严重", "赔偿", "违约金"), 0.70),
)
COST_MAG_DEFAULT = 0.40          # 有定性描述无量化词 → 保底档

# 决策期限紧迫启发表 (先紧后松)
DEADLINE_RULES = (
    (("分钟",), 1.00),
    (("小时", "当天", "当日", "即时", "立刻"), 0.90),
    (("本周", "周内", "日内"), 0.80),
    (("月",), 0.50),
    (("季", "年"), 0.30),
)
DEADLINE_DEFAULT = 0.50
COST_URGENCY_W = (0.60, 0.40)    # 代价紧迫度 = 0.6·代价量级 + 0.4·期限紧迫


def _first_rule(text: str, rules, default: float) -> float:
    for words, score in rules:
        if any(w in text for w in words):
            return score
    return default


def decision_hook(topic: str, buyer_persona: dict) -> dict:
    """第五维决策反推: 四问 → {decision_urgency 0-1, verb_frame}.

    buyer_persona 四问 (缺任一 ValueError, 退回不猜):
      read_then_decide    读完拍什么板 (动作句)
      decision_deadline   何时必须拍 (期限表述)
      wrong_cost          错拍代价多少 (量化/定性)
      success_criteria    成功判断标准
    可选 role 字段: 决策人 (动词帧主语, 缺省「决策人」).

    decision_urgency = 四问完备度 × 代价紧迫度
      四问完备度   四问全答=1.0 (缺任一已在入口 ValueError 拦下, 不半猜)
      代价紧迫度   0.6·错拍代价量级 + 0.4·决策期限紧迫 (启发规则表, 同源可回放)
    verb_frame = 动词化重述句: 「让{role}在{deadline}内敢决定{read_then_decide}」
    """
    if not isinstance(buyer_persona, dict):
        raise ValueError(f"buyer_persona 须为 dict (四问), 得到 {type(buyer_persona).__name__}")
    missing = [q for q in DECISION_QUESTIONS
               if not str(buyer_persona.get(q) or "").strip()]
    if missing:
        raise ValueError(f"决策四问缺: {','.join(missing)} — 缺任一退回, 不猜")

    completeness = 1.0                                   # 全答=1 (缺已被拦)
    cost_mag = _first_rule(str(buyer_persona["wrong_cost"]),
                           COST_MAG_RULES, COST_MAG_DEFAULT)
    deadline = _first_rule(str(buyer_persona["decision_deadline"]),
                           DEADLINE_RULES, DEADLINE_DEFAULT)
    cost_urgency = (COST_URGENCY_W[0] * cost_mag + COST_URGENCY_W[1] * deadline)
    urgency = round(_clamp01(completeness * cost_urgency), 4)

    role = str(buyer_persona.get("role") or "决策人").strip() or "决策人"
    verb_frame = (f"让{role}在{str(buyer_persona['decision_deadline']).strip()}"
                  f"内敢决定{str(buyer_persona['read_then_decide']).strip()}")
    return {"decision_urgency": urgency, "verb_frame": verb_frame,
            "cost_urgency": round(cost_urgency, 4),
            "cost_mag": cost_mag, "deadline_urgency": deadline,
            "four_q_completeness": completeness, "role": role}


# ---------- 纯函数核心 ----------

def _norm(value: float, ref: float | None) -> float:
    """log1p 分位归一: v→[0,1]. 无批次基准(单卡直评)时正值视为满格(无分位可依)."""
    if value is None or value <= 0:
        return 0.0
    if not ref or ref <= 0:
        return 1.0
    return min(1.0, math.log1p(value) / math.log1p(ref))


def _clamp01(x: float) -> float:
    return max(0.0, min(1.0, float(x)))


def buyer_score(persona: str | None) -> tuple[float, list[str]]:
    """支付能力: 规则表查画像; 未登记→保守缺省并 note. (v1, hook 可替换)"""
    if persona in BUYER_PERSONA_TABLE:
        return BUYER_PERSONA_TABLE[persona], []
    return DEFAULT_PERSONA_SCORE, [f"买家画像未登记({persona!r}), 用保守缺省 {DEFAULT_PERSONA_SCORE}"]


def competition_score(sku_hits: int | None) -> tuple[float, list[str]]:
    """竞争空缺: 现有 SKU 清单比对反向分. (v1, hook 可替换)"""
    hits = int(sku_hits or 0)
    for cap, gap in COMPETITION_RULE:
        if hits <= cap:
            return gap, []
    return COMPETITION_FLOOR, []


def _band_fields(dscore: float) -> dict:
    for floor, fields in PRODUCT_BANDS:
        if dscore >= floor:
            return dict(fields)
    return dict(PRODUCT_BANDS[-1][1])


def score(topic, signals, norms=None, persona_hook=None, competition_hook=None):
    """单选题评分 (纯函数, 不落盘不触网).

    topic:   选题名
    signals: {bidding_volume, policy_pulse, wechat_pain, corpus_chars (原始量),
              buyer_persona (画像键), sku_hits (现有 SKU 命中数),
              decision (V4 可选: 四问 dict → 第五维 decision_hook 反推)}
    norms:   批次基准 {同信号名: 批内最大值}; 缺省=单卡直评(正值满格)
    hook:    persona_hook/competition_hook(topic, signals)->0-1, 返回有效值则整体替换规则表
    返回:    {topic, DScore, 四维分, weights, 覆盖与在场源, notes, signals_ref(None, run 补)}
    """
    norms = norms or {}
    notes: list[str] = []

    # -- 需求强度: 在场源加权归一 (缺源让权=降权; 全缺=0) --
    present, missing = [], []
    weighted = total_w = 0.0
    for src in DEMAND_SOURCES:
        raw = signals.get(src)
        if raw is None or float(raw) <= 0:    # 无存量=无源 (缺源降权, 不猜)
            missing.append(src)
            continue
        present.append(src)
        n = _norm(float(raw), norms.get(src))
        weighted += DEMAND_SOURCE_WEIGHTS[src] * n
        total_w += DEMAND_SOURCE_WEIGHTS[src]
    strength = weighted / total_w if total_w > 0 else 0.0
    if missing:
        notes.append(f"需求强度缺源降权: {','.join(missing)} 内部权重让出在场源")
    if not present:
        notes.append("三快源全缺, 需求强度=0 (如实报, 不猜)")

    # -- 支付能力 / 竞争空缺: v1 规则表, hook 优先 --
    if persona_hook is not None:
        pay = _clamp01(persona_hook(topic, signals))
        notes.append("支付能力取 persona_hook (v2 数据接口)")
    else:
        pay, ns = buyer_score(signals.get("buyer_persona"))
        notes.extend(ns)
    if competition_hook is not None:
        gap = _clamp01(competition_hook(topic, signals))
        notes.append("竞争空缺取 competition_hook (v2 数据接口)")
    else:
        gap, ns = competition_score(signals.get("sku_hits"))
        notes.extend(ns)

    # -- 语料复用度: 池存量字符分位 --
    reuse = _norm(signals.get("corpus_chars"), norms.get("corpus_chars"))

    # -- 决策紧迫度 (第五维): signals["decision"] 四问 → decision_hook 反推 --
    # 无四问信号/四问不全 → 0 分 fail-soft + note 如实报 (不猜).
    decision = signals.get("decision")
    urgency, verb_frame = 0.0, ""
    if isinstance(decision, dict) and any(
            str(decision.get(q) or "").strip() for q in DECISION_QUESTIONS):
        try:
            dh = decision_hook(topic, decision)
            urgency = dh["decision_urgency"]
            verb_frame = dh["verb_frame"]
            notes.append("第五维决策紧迫度取 decision_hook 四问反推")
        except ValueError as e:
            notes.append(f"决策四问不全({e}), 决策紧迫度=0 (不猜)")
    else:
        notes.append("无决策四问信号, 决策紧迫度=0 (v1 只在有买家反推时计分)")

    dims = {"需求强度": round(_clamp01(strength), 4), "支付能力": round(_clamp01(pay), 4),
            "竞争空缺": round(_clamp01(gap), 4), "语料复用度": round(_clamp01(reuse), 4),
            DECISION_DIM: round(_clamp01(urgency), 4)}
    dscore = round(sum(WEIGHTS[k] * dims[k] for k in WEIGHTS), 4)
    return {
        "topic": topic,
        "DScore": dscore,
        **dims,
        "verb_frame": verb_frame,
        "weights": dict(WEIGHTS),
        "demand_sources_present": present,
        "demand_sources_missing": missing,
        "signal_coverage": round(len(present) / len(DEMAND_SOURCES), 6),
        "suggested": _band_fields(dscore),
        "notes": notes,
        "signals_ref": None,   # run() 落盘后回填
    }


# ---------- 池信号采集 (只读) ----------

def _classify_engines(by_engine: dict) -> dict:
    """按 ENGINE_KEYS 优先级把 by_engine 字符量归类到三快源, 保留引擎分解供回放."""
    buckets = {src: {} for src in DEMAND_SOURCES}
    for eng, chars in (by_engine or {}).items():
        for src in ENGINE_KEYS:                          # 声明序即优先级 (wechat 先于 bidding)
            if any(k in eng for k in ENGINE_KEYS[src]):
                buckets[src][eng] = buckets[src].get(eng, 0) + int(chars or 0)
                break
    return buckets


def collect_pool_signals(pool_dir):
    """读一池 pool_state.json (只读, 绝不写池) → 原始信号 + 回放 meta."""
    state = json.loads((Path(pool_dir) / "pool_state.json").read_text(encoding="utf-8"))
    by_engine = state.get("by_engine") or {}
    buckets = _classify_engines(by_engine)
    kws = " ".join(state.get("kws") or [])
    pain_hits = sum(1 for kw in PAIN_KEYWORDS if kw in kws)
    wechat_factor = 1.0 if pain_hits >= 2 else (0.9 if pain_hits == 1 else 0.8)
    raw = {
        "bidding_volume": sum(buckets["bidding_volume"].values()),
        "policy_pulse": sum(buckets["policy_pulse"].values()),
        "wechat_pain": round(sum(buckets["wechat_pain"].values()) * wechat_factor),
        "corpus_chars": int(state.get("total_chars") or 0),
    }
    meta = {"pool": Path(pool_dir).name, "campaign": state.get("campaign"),
            "engine_breakdown": buckets, "pain_kw_hits": pain_hits,
            "wechat_factor": wechat_factor, "pool_kws": (state.get("kws") or [])[:10]}
    return raw, meta


def count_sku_hits(sku_titles, patterns):
    """现有 SKU 清单比对: 标题命中任一匹配词的 SKU 数 (实盘比对, 非手填)."""
    return sum(1 for t in sku_titles if any(p in t for p in patterns))


# ---------- 批量出卡 ----------

def run(topics_file, out_dir=None, sku_file=None):
    """批量评分并落盘. 返回 (cards, 信号行数).

    topics_file: {"topics":[{topic, pool, persona, sku_match:[...]}, ...]} 或裸列表
    产物: <out_dir>/radar_scorecards.json + <out_dir>/radar_signals.jsonl
    """
    topics_file = Path(topics_file)
    out_dir = Path(out_dir) if out_dir else topics_file.parent
    payload = json.loads(topics_file.read_text(encoding="utf-8"))
    topics = payload["topics"] if isinstance(payload, dict) else payload
    sku_titles = [r.get("title", "") for r in json.loads(
        Path(sku_file or SKILLS_FILE).read_text(encoding="utf-8")).get("reports", [])]

    ts = datetime.now(timezone.utc).isoformat(timespec="seconds")
    collected = []
    for t in topics:
        raw, meta = collect_pool_signals(t["pool"])
        sku_hits = count_sku_hits(sku_titles, t.get("sku_match") or [])
        raw["buyer_persona"] = t.get("persona")
        raw["sku_hits"] = sku_hits
        if t.get("decision"):                 # V4: 选题配置可带四问反推 (只增)
            raw["decision"] = t["decision"]
        collected.append({"cfg": t, "raw": raw, "meta": meta})

    # 批次基准 (log1p 分位用): 各信号取批内最大原始值
    norms = {k: max((c["raw"][k] for c in collected), default=0) for k in DEMAND_SOURCES}
    norms["corpus_chars"] = max((c["raw"]["corpus_chars"] for c in collected), default=0)

    signals_rows, cards = [], []
    for c in collected:
        card = score(c["cfg"]["topic"], c["raw"], norms=norms)
        card["pool"] = c["meta"]["pool"]
        card["generated_at"] = ts
        card["norms_ref"] = {k: v for k, v in norms.items()}
        for name, val in (("bidding_volume", c["raw"]["bidding_volume"]),
                          ("policy_pulse", c["raw"]["policy_pulse"]),
                          ("wechat_pain", c["raw"]["wechat_pain"]),
                          ("corpus_chars", c["raw"]["corpus_chars"])):
            signals_rows.append({"topic": c["cfg"]["topic"], "source": "proxy_pool_chars",
                                 "signal": name, "value": val, "ts": ts, "meta": c["meta"]})
        signals_rows.append({"topic": c["cfg"]["topic"], "source": "rule_config_v1",
                             "signal": "buyer_persona", "value": c["cfg"].get("persona"),
                             "ts": ts, "meta": {"table": "BUYER_PERSONA_TABLE"}})
        signals_rows.append({"topic": c["cfg"]["topic"], "source": "sku_inventory_v1",
                             "signal": "sku_hits", "value": c["raw"]["sku_hits"],
                             "ts": ts, "meta": {"sku_file": str(SKILLS_FILE),
                                                "patterns": c["cfg"].get("sku_match") or []}})
        card["signals_ref"] = {"file": (out_dir / "radar_signals.jsonl").as_posix(),
                                "rows": 6}
        cards.append(card)

    out_dir.mkdir(parents=True, exist_ok=True)
    (out_dir / "radar_scorecards.json").write_text(
        json.dumps(cards, ensure_ascii=False, indent=2), encoding="utf-8")
    with open(out_dir / "radar_signals.jsonl", "w", encoding="utf-8") as f:
        for row in signals_rows:
            f.write(json.dumps(row, ensure_ascii=False) + "\n")
    return cards, len(signals_rows)


def main(argv=None):
    ap = argparse.ArgumentParser(description="需求雷达 v1: 三快源评分卡批量出卡")
    ap.add_argument("--topics", default=str(TOPICS_FILE_DEFAULT))
    ap.add_argument("--out-dir", default=None)
    ap.add_argument("--sku-file", default=None)
    args = ap.parse_args(argv)
    cards, n_rows = run(args.topics, out_dir=args.out_dir, sku_file=args.sku_file)
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8")
    for c in sorted(cards, key=lambda x: -x["DScore"]):
        print(f"{c['DScore']:.4f}  {c['topic']}  强度{c['需求强度']} 支付{c['支付能力']} "
              f"空缺{c['竞争空缺']} 复用{c['语料复用度']} 覆盖{c['signal_coverage']}")
    print(f"--> {SCORECARDS_PATH if not args.out_dir else args.out_dir} | cards={len(cards)} signal_rows={n_rows}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
