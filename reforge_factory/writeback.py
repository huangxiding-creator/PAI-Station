# -*- coding: utf-8 -*-
"""S8 变现复盘回写 (T-020 / REQ-052): 漏斗实测 → 雷达权重 v2 + 定价建议 + 决策落账.

地基复用 (只读他人产物, 只增不删):
    T-010 demand_radar   superline/radar_scorecards.json (权重调整对象, 永不覆盖)
    T-005 decision_ledger.record_decision  (回写动作落账, ammo_pool/<池>/decision_ledger.jsonl)
    T-018 funnel_query   report_platform/funnel_events.jsonl + report_platform.db
                         (等价 `funnel_query --week <W> --json` 的双源汇聚)

链条:
    漏斗周数据 ──┬─→ 需求强度权重系数调权 → radar_weights_v2.json (新文件)
                 ├─→ 定价建议 (仅支付 SKU, visit→pay 对标行业中位)
                 └─→ 每个回写动作落 decision_ledger (topic_select / pricing_suggest)

调权规则 (漏斗实测三态, 只作用于「需求强度」一维):
    pay > 0       ×1.10  evidence=payment    (真金白银验证选题需求)
    click_buy > 0 ×1.05  evidence=click_buy  (点购未付=购买意向)
    纯访问/更浅   ×1.00  evidence=visit_only  (无新证据不动)
  同一选题多 SKU 聚合取最强信号; 多维其余三维权重不动 (v2 只回写有实测支撑的一维).

定价建议 (有支付数据 SKU 才出; visit→pay 总转化, 数字零造假=漏斗实测):
    > 6.6%  → test_up   (行业中位之上, Unbounce 5,700 万样本口径, 同 funnel_query 对标)
    < 1%    → test_down (强流量弱转化, 价格阻力假设)
    其间或 visit=0 不可测 → hold

SKU→选题映射 (两层, 映射不上如实进 unmatched_skus 不猜):
    1. SKU_TOPIC_OVERRIDES 显式登记 (池名无特征词的 SKU, 如 CNNC-EPC)
    2. 池名特征词命中: 池名按 -/_ 切词, 弃泛词 EPC/DEMO/AUX 后特征词
       (≥2 字符) 大写子串命中 SKU 即归属, 多池命中取命中词数最多者

零回写动作的周 (两类, 都不沉默): ①零数据周 (漏斗 per-SKU 空) — 不写产物
    文件, 只落 1 条 note 决策; ②有事件但零动作周 (SKU 全未映射/无支付数据/
    纯访问不动权) — 产物照写 (记录实测现状), 同样落 1 条 note 决策
    (decision_type=topic_select, chosen=no_change) — 无回写动作也要留痕.

--dry-run: 不写产物文件 (radar_weights_v2.json 不落盘); decision_ledger
    审计照记 — 「回写动作本身落 decision_ledger」是 REQ-052 硬要求, 预演也留痕.

产物: superline/radar_weights_v2.json (新文件; radar_scorecards.json /
       radar_signals.jsonl 一字不动). 重复对同一周真跑会重复落账 (账本只增
       不删, 幂等性由「每周一次」调用纪律保障).

用法:
    py reforge_factory/writeback.py --week 2026-W42            # 真跑
    py reforge_factory/writeback.py --week 2026-W42 --dry-run  # 预演
    py reforge_factory/writeback.py --week 2026W42              # 周格式宽容归一
"""
from __future__ import annotations

import argparse
import json
import sys
from datetime import datetime, timezone
from pathlib import Path

REPO_ROOT = Path(__file__).resolve().parents[1]
SUPERLINE_DIR = REPO_ROOT / "reforge_factory" / "superline"
REPORT_PLATFORM_DIR = REPO_ROOT / "report_platform"

sys.path.insert(0, str(REPORT_PLATFORM_DIR))      # funnel_query (无包结构)
sys.path.insert(0, str(Path(__file__).resolve().parent))
import decision_ledger as DL                      # noqa: E402
import funnel_query as FQ                         # noqa: E402

# ---------- 常量唯一事实源 ----------

SCORECARDS_PATH = SUPERLINE_DIR / "radar_scorecards.json"
WEIGHTS_V2_PATH = SUPERLINE_DIR / "radar_weights_v2.json"
REPORTS_PATH = REPORT_PLATFORM_DIR / "content" / "report.json"   # SKU 现价 (实盘)
FUNNEL_LEDGER = REPORT_PLATFORM_DIR / "funnel_events.jsonl"
FUNNEL_DB = REPORT_PLATFORM_DIR / "report_platform.db"

#: 需求强度权重系数 (漏斗实测三态)
FACTORS = {"payment": 1.10, "click_buy": 1.05, "visit_only": 1.00}
#: 证据档强度序 (聚合取最强)
EVIDENCE_ORDER = ("payment", "click_buy", "visit_only", "no_signal")
#: 调权只作用的一维 (demand_radar.WEIGHTS 四维之一)
STRENGTH_KEY = "需求强度"

#: 定价阈值: visit→pay 总转化 (行业中位 6.6% = Unbounce 5,700 万样本, 与
#: funnel_query._fmt_sku_report 同口径); 强流量弱转化 1% 线
CONV_TEST_UP = 0.066
CONV_TEST_DOWN = 0.01

#: 零数据周 note 落账池 (主战役; 该周无 SKU 可归属, 需要一个确定的账本家)
DEFAULT_NOTE_CAMPAIGN = "EPC-BID26"

#: 池名切词后弃用的无区分力泛词
GENERIC_POOL_TOKENS = {"EPC", "DEMO", "AUX"}

#: SKU→选题显式登记 (池名特征词覆盖不到的实盘 SKU)
SKU_TOPIC_OVERRIDES = {
    # CNNC-EPC (中国核电系企业研究, ¥1,999) 属 EPC49 电力/新能源选题
    # (radar_topics.json sku_match=核电); 池名 EPC49-SEPDC 无 CNNC 特征词.
    "CNNC-EPC": "EPC49 电力/新能源 EPC 企业研究 (四川院系)",
}


def _now_ts() -> str:
    return datetime.now(timezone.utc).isoformat(timespec="seconds")


# ---------- 纯函数核心 ----------

def _pool_tokens(pool) -> list[str]:
    """池名 → 特征词 (大写, 弃泛词/短词; TST-PAY → [TST, PAY])."""
    return [t for t in str(pool or "").upper().replace("_", "-").split("-")
            if len(t) >= 2 and t not in GENERIC_POOL_TOKENS]


def sku_topic_for(sku, cards, overrides=None):
    """SKU → 评分卡 (选题). 显式 overrides 优先, 其次池名特征词命中.

    返回命中的 card 或 None (映射不上=如实 None, 不猜).
    """
    if overrides is None:
        overrides = SKU_TOPIC_OVERRIDES
    if sku in overrides:
        want = str(overrides[sku])
        for c in cards:
            if c.get("topic") == want or c.get("pool") == want:
                return c
        return None
    s = str(sku or "").upper()
    best, best_hits = None, 0
    for c in cards:
        hits = sum(1 for t in _pool_tokens(c.get("pool")) if t in s)
        if hits > best_hits:
            best, best_hits = c, hits
    return best


def weight_factor(levels) -> tuple[float, str]:
    """漏斗四级计数 → (需求强度权重系数, 证据档). 三态规则纯函数."""
    lv = levels or {}
    if int(lv.get("pay") or 0) > 0:
        return FACTORS["payment"], "payment"
    if int(lv.get("click_buy") or 0) > 0:
        return FACTORS["click_buy"], "click_buy"
    if int(lv.get("visit") or 0) > 0 or int(lv.get("sample_read") or 0) > 0:
        return FACTORS["visit_only"], "visit_only"
    return 1.0, "no_signal"


def pricing_suggestion(sku, levels, current_price=None):
    """有支付数据 SKU → 定价建议 dict; 无支付数据返回 None (不出建议).

    输出契约 (恰好四键, 数字全部漏斗实测):
        {sku, current_price, suggestion: hold|test_up|test_down, basis}
    转化值与 pay/visit 明细进 basis 文本; 原始计数经漏斗 per_sku 另在
    adjustments[].skus 与账本 context 留档.
    """
    lv = levels or {}
    pay, visit = int(lv.get("pay") or 0), int(lv.get("visit") or 0)
    if pay <= 0:
        return None
    conv = (pay / visit) if visit > 0 else None
    if conv is None:
        suggestion = "hold"
        basis = (f"pay={pay} 但 visit=0 (访问未记账/渠道外成交), "
                 f"漏斗口径不可测, 不动价")
    elif conv > CONV_TEST_UP:
        suggestion = "test_up"
        basis = (f"visit→pay={conv:.2%} (pay={pay}/visit={visit}) > 行业中位 "
                 f"6.6% (Unbounce 5,700 万样本), 需求强于流量, 可试提价")
    elif conv < CONV_TEST_DOWN:
        suggestion = "test_down"
        basis = (f"visit→pay={conv:.2%} (pay={pay}/visit={visit}) < 1%, "
                 f"强流量弱转化, 价格阻力假设成立, 可试降价")
    else:
        suggestion = "hold"
        basis = (f"visit→pay={conv:.2%} (pay={pay}/visit={visit}) 处于 "
                 f"1%–6.6% 行业常带, 持平观察")
    return {"sku": sku, "current_price": current_price,
            "suggestion": suggestion, "basis": basis}


# ---------- 汇聚辅助 ----------

def _load_prices(reports_file) -> dict:
    """report.json 实盘 SKU 清单 → {sku: 现价} (只读)."""
    p = Path(reports_file)
    if not p.exists():
        return {}
    data = json.loads(p.read_text(encoding="utf-8"))
    return {str(r.get("sku")): r.get("price")
            for r in data.get("reports", []) if r.get("sku")}


def _aggregate(per_sku, cards, overrides=None):
    """per_sku 漏斗计数 → (按评分卡序的选题分组, 未映射 SKU 清单).

    组内多 SKU 取最强证据档 (payment > click_buy > visit_only > no_signal).
    """
    order = {id(c): i for i, c in enumerate(cards)}
    groups: dict[str, dict] = {}
    unmatched = []
    for sku in sorted(per_sku):
        card = sku_topic_for(sku, cards, overrides)
        if card is None:
            unmatched.append(sku)
            continue
        g = groups.setdefault(card.get("topic"),
                              {"card": card, "skus": {}})
        g["skus"][sku] = per_sku[sku]
    ordered = [groups[k] for k in
               sorted(groups, key=lambda t: order.get(id(groups[t]["card"]), 1 << 30))]
    for g in ordered:
        best_key, factor, evidence = (-1.0, False), 1.0, "no_signal"
        for lv in g["skus"].values():
            f, e = weight_factor(lv)
            cand = (f, e != "no_signal")
            if cand > best_key:
                best_key, factor, evidence = cand, f, e
        g["factor"], g["evidence"] = factor, evidence
    return ordered, unmatched


# ---------- 主流程 ----------

def run(week_label, scorecards_file=None, out_path=None, reports_file=None,
        ledger=None, db_path=None, pool_root=None, dry_run=False,
        note_campaign=DEFAULT_NOTE_CAMPAIGN, overrides=None) -> dict:
    """S8 变现复盘回写主流程 → 摘要 dict (全部实测, 不手填).

    步骤: ①读该周漏斗 (funnel_query.collect 双源) ②选题调权 (三态)
          ③定价建议 ④回写动作落 decision_ledger ⑤dry-run 只差产物文件.
    """
    week = FQ.norm_week(week_label)
    cards_path = Path(scorecards_file or SCORECARDS_PATH)
    cards = json.loads(cards_path.read_text(encoding="utf-8"))
    if isinstance(cards, dict):            # 容错: {"cards"/"topics": [...]}
        cards = cards.get("cards") or cards.get("topics") or []
    out_target = Path(out_path) if out_path else WEIGHTS_V2_PATH
    if out_target.resolve() == cards_path.resolve():
        raise ValueError(
            f"out 不能指向 radar_scorecards.json (红线: 原卡永不覆盖): {out_target}")

    r = FQ.collect(week=week, ledger=ledger or FUNNEL_LEDGER,
                   db_path=db_path or FUNNEL_DB)
    per_sku = r.get("per_sku") or {}
    summary = {"week": week, "module": "writeback",
               "mode": "dry_run" if dry_run else "run",
               "zero_data": not per_sku,
               "sources": r["sources"], "levels": r["levels"],
               "skus_with_events": sorted(per_sku),
               "out_path": None, "adjustments": [], "pricing": [],
               "unmatched_skus": [], "ledger_records": [], "note": None}

    def _record(campaign, decision_type, context, options, chosen, rationale):
        rec = DL.record_decision(campaign=campaign, decision_type=decision_type,
                                 context=context, options=options, chosen=chosen,
                                 rationale=rationale, pool_root=pool_root)
        summary["ledger_records"].append(
            {"id": rec["id"], "campaign": campaign,
             "decision_type": decision_type, "chosen": chosen})

    # -- 零数据周: 不写产物, 只记 note (无回写动作也要留痕) --
    if not per_sku:
        reason = "零数据周: 漏斗 per-SKU 空, 无回写动作, note 落账"
        _record(
            note_campaign, "topic_select",
            {"week": week, "module": "writeback", "levels": r["levels"],
             "sources": r["sources"], "note": reason},
            [{"k": "no_change", "v": "零数据不动权重"},
             {"k": "postpone", "v": "下周复盘再看"}],
            "no_change",
            f"S8 回写 {week}: {reason} (writeback)")
        summary["note"] = reason
        return summary

    groups, unmatched = _aggregate(per_sku, cards, overrides)
    summary["unmatched_skus"] = unmatched

    # -- ② 选题调权 (新文件, 不动原卡) + ④ 权重变化落账 --
    adjustments = []
    for g in groups:
        card, factor, evidence = g["card"], g["factor"], g["evidence"]
        old_w = dict(card.get("weights") or {})
        new_w = dict(old_w)
        if STRENGTH_KEY in new_w:
            new_w[STRENGTH_KEY] = round(old_w[STRENGTH_KEY] * factor, 4)
        adjustments.append({
            "topic": card.get("topic"), "pool": card.get("pool"),
            "factor": factor, "evidence": evidence,
            "old_weights": old_w, "new_weights": new_w,
            "weights_sum": round(sum(new_w.values()), 4),
            "skus": [{"sku": s, "levels": g["skus"][s]}
                     for s in sorted(g["skus"])]})
        if factor != 1.0:
            _record(
                card.get("pool"), "topic_select",
                {"week": week, "module": "writeback", "topic": card.get("topic"),
                 "dimension": STRENGTH_KEY, "factor": factor,
                 "evidence": evidence, "old_weights": old_w,
                 "new_weights": new_w, "skus": sorted(g["skus"])},
                [{"k": "no_change", "v": "维持 v1 权重"},
                 {"k": f"demand_strength_x{factor:g}",
                  "v": f"需求强度权重 ×{factor:g} (evidence={evidence})"}],
                f"demand_strength_x{factor:g}",
                f"S8 回写 {week}: 选题「{card.get('topic')}」漏斗实测 "
                f"{evidence} 信号, {STRENGTH_KEY}权重 "
                f"{old_w.get(STRENGTH_KEY)}→{new_w.get(STRENGTH_KEY)} "
                f"(×{factor:g}, writeback)")
    summary["adjustments"] = adjustments

    # -- ③ 定价建议 (仅支付 SKU) + ④ 建议落账 --
    prices = _load_prices(reports_file or REPORTS_PATH)
    for sku in sorted(per_sku):
        sug = pricing_suggestion(sku, per_sku[sku], prices.get(sku))
        if sug is None:
            continue
        summary["pricing"].append(sug)
        card = sku_topic_for(sku, cards, overrides)
        campaign = card.get("pool") if card else note_campaign
        lv = per_sku[sku]
        conv = (int(lv.get("pay") or 0) / int(lv.get("visit") or 0)) \
            if int(lv.get("visit") or 0) > 0 else None
        conv_str = f"{conv:.2%}" if conv is not None else "不可测"
        _record(
            campaign, "pricing_suggest",
            {"week": week, "module": "writeback", "sku": sku,
             "current_price": sug["current_price"], "conversion": conv,
             "levels": lv, "mapped_pool": card is not None},
            [{"k": "hold", "v": "持平观察"},
             {"k": "test_up", "v": "小步提价实验"},
             {"k": "test_down", "v": "小步降价实验"}],
            sug["suggestion"],
            f"S8 回写 {week}: SKU {sku} visit→pay {conv_str}, "
            f"{sug['basis']} (writeback)")

    # -- 零动作周兜底: 有事件但无映射/无支付/纯访问 → 0 条回写记录也要留痕 --
    if not summary["ledger_records"]:
        reason = (f"本周 {len(per_sku)} 个 SKU 有事件但零回写动作 "
                  f"(未映射: {', '.join(unmatched) if unmatched else '无'}; "
                  f"无支付数据), note 落账")
        _record(
            note_campaign, "topic_select",
            {"week": week, "module": "writeback", "levels": r["levels"],
             "sources": r["sources"], "skus_with_events": sorted(per_sku),
             "unmatched_skus": unmatched, "note": reason},
            [{"k": "no_change", "v": "无实测支付/点购信号不动权重"},
             {"k": "postpone", "v": "下周复盘再看"}],
            "no_change",
            f"S8 回写 {week}: {reason} (writeback)")
        summary["note"] = reason

    # -- ⑤ 产物落盘 (dry-run 不落) --
    payload = {
        "generated_at": _now_ts(), "week": week, "module": "writeback",
        "mode": summary["mode"], "source_scorecards": cards_path.as_posix(),
        "rule": {"dimension": STRENGTH_KEY, **FACTORS,
                 "aggregate": "topic 内多 SKU 取最强信号",
                 "thresholds": {"test_up": "visit→pay > 6.6%",
                                "test_down": "visit→pay < 1%",
                                "benchmark": "Unbounce 5,700 万样本行业中位"}},
        "adjustments": adjustments,
        "topics_no_data": [c.get("topic") for c in cards
                           if c.get("topic") not in
                           {a["topic"] for a in adjustments}],
        "unmatched_skus": unmatched,
        "pricing": summary["pricing"],
    }
    if not dry_run:
        out_target.parent.mkdir(parents=True, exist_ok=True)
        out_target.write_text(json.dumps(payload, ensure_ascii=False, indent=2),
                              encoding="utf-8")
        summary["out_path"] = str(out_target)
    return summary


# ---------- CLI ----------

def _fmt(summary: dict) -> str:
    lines = [f"S8 变现复盘回写 {summary['week']} ({summary['mode']}, "
             f"module=writeback)"]
    if summary["zero_data"]:
        lines.append(summary["note"] or "零数据周, 无回写动作, note 落账")
    else:
        for a in summary["adjustments"]:
            mark = "" if a["factor"] == 1.0 else \
                f" 需求强度 {a['old_weights'].get(STRENGTH_KEY)}→" \
                f"{a['new_weights'].get(STRENGTH_KEY)}"
            lines.append(f"  权重 [{a['evidence']:>10}] ×{a['factor']:g} "
                         f"{a['topic']}{mark}")
        for p in summary["pricing"]:
            price = p["current_price"] if p["current_price"] is not None else "?"
            lines.append(f"  定价 {p['sku']} 现价¥{price} → {p['suggestion']} "
                         f"({p['basis']})")
        if summary["unmatched_skus"]:
            lines.append(f"  未映射 SKU (不猜): {', '.join(summary['unmatched_skus'])}")
        if summary["note"]:
            lines.append(f"  {summary['note']}")
        out = summary["out_path"] or "未写 (dry-run)"
        lines.append(f"  产物 radar_weights_v2: {out}")
    for rec in summary["ledger_records"]:
        lines.append(f"  账本 {rec['campaign']} {rec['id']} "
                     f"{rec['decision_type']}/{rec['chosen']}")
    return "\n".join(lines)


def main(argv=None) -> int:
    ap = argparse.ArgumentParser(
        description="S8 变现复盘回写 (REQ-052): 漏斗周数据→雷达权重v2+定价建议+决策落账")
    ap.add_argument("--week", required=True, help="ISO 周, 如 2026-W42")
    ap.add_argument("--dry-run", action="store_true",
                    help="不写产物文件 (decision_ledger 审计照记)")
    ap.add_argument("--scorecards", default=str(SCORECARDS_PATH))
    ap.add_argument("--out", default=str(WEIGHTS_V2_PATH))
    ap.add_argument("--reports", default=str(REPORTS_PATH))
    ap.add_argument("--ledger", default=str(FUNNEL_LEDGER))
    ap.add_argument("--db", default=str(FUNNEL_DB))
    ap.add_argument("--pool-root", default=None,
                    help="decision_ledger 池根 (缺省真实 ammo_pool/)")
    ap.add_argument("--note-campaign", default=DEFAULT_NOTE_CAMPAIGN,
                    help="零数据周 note 落账池")
    ns = ap.parse_args(argv)
    s = run(ns.week, scorecards_file=ns.scorecards, out_path=ns.out,
            reports_file=ns.reports, ledger=ns.ledger, db_path=ns.db,
            pool_root=Path(ns.pool_root) if ns.pool_root else None,
            dry_run=ns.dry_run, note_campaign=ns.note_campaign)
    if hasattr(sys.stdout, "reconfigure"):
        sys.stdout.reconfigure(encoding="utf-8", errors="replace")
    print(_fmt(s))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
