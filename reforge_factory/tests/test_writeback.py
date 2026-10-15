# -*- coding: utf-8 -*-
"""test_writeback — S8 变现复盘回写单测 (T-020, REQ-052 / REQ-052.AC1).

覆盖:
  ① 权重三态对拍: pay>0→需求强度权重×1.1 (evidence=payment) /
     零支付有点购→×1.05 (evidence=click_buy) / 纯访问→×1.0 不变
     (合成 3 SKU 漏斗: 1 支付 / 1 点购 / 1 纯访问)
  ② 定价建议三态: visit→pay >6.6%→test_up / 1%–6.6%→hold / <1%→test_down;
     无支付数据 SKU 不出建议
  ③ decision_ledger 落账: 权重调整→topic_select / 定价→pricing_suggest /
     纯访问选题零记录 (无动作不落账)
  ④ 零数据周: 产物文件不落盘 + 仅 1 条 note 落账 (chosen=no_change);
     有事件但零动作周 (SKU 全未映射/无支付) 同样落 1 条 note 不沉默
  ⑤ dry-run: 产物文件不落盘, decision_ledger 审计照记
  ⑥ 红线: radar_scorecards.json 源文件字节不动; out 指向源文件拒写;
     未映射 SKU 进 unmatched_skus 不炸不猜
  ⑦ 纯函数: weight_factor 三态 / pricing_suggestion 边界值 / sku_topic_for
     两层映射 (显式 overrides 优先 + 池名特征词, 泛词弃用)

红线: 全部用 tmp 夹具, 绝不触碰真实 ammo_pool/ / report_platform/ 数据.

跑法: py -m pytest reforge_factory/tests/test_writeback.py -q
"""
from __future__ import annotations

import json
import sys
from datetime import date
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
import writeback as WB                                  # noqa: E402

W42 = "2026-W42"
TS_W42 = f"{date.fromisocalendar(2026, 42, 3).isoformat()}T12:00:00+08:00"


# ------------------------------------------------ 夹具
def _card(topic: str, pool: str) -> dict:
    """最小评分卡 (与 radar_scorecards.json 同构: weights 四维齐全)."""
    return {"topic": topic, "pool": pool, "DScore": 0.5,
            "需求强度": 0.5, "支付能力": 0.5, "竞争空缺": 0.5, "语料复用度": 0.5,
            "weights": {"需求强度": 0.35, "支付能力": 0.2, "竞争空缺": 0.25,
                        "语料复用度": 0.2},
            "notes": []}


def _cards_file(tmp_path: Path, cards: list[dict]) -> Path:
    p = tmp_path / "radar_scorecards.json"
    p.write_text(json.dumps(cards, ensure_ascii=False, indent=2), encoding="utf-8")
    return p


def _seed_funnel(tmp_path: Path, rows: list[tuple[str, str, int]]) -> Path:
    """合成漏斗账本: rows = [(sku, level, n), ...] 全落 2026-W42 周三."""
    p = tmp_path / "funnel_events.jsonl"
    with open(p, "a", encoding="utf-8") as f:
        for sku, level, n in rows:
            for _ in range(n):
                f.write(json.dumps({"sku": sku, "channel": "test", "level": level,
                                    "ts": TS_W42, "ref": ""},
                                   ensure_ascii=False) + "\n")
    return p


def _reports_file(tmp_path: Path, sku_prices: dict[str, int]) -> Path:
    p = tmp_path / "report.json"
    p.write_text(json.dumps(
        {"site_name": "t", "reports": [
            {"title": f"报告 {s}", "sku": s, "price": v}
            for s, v in sku_prices.items()]}, ensure_ascii=False), encoding="utf-8")
    return p


def _no_db(tmp_path: Path) -> Path:
    return tmp_path / "no_report_platform.db"      # 不存在 → sqlite 源计 0


def _run_args(tmp_path, cards, sku_prices=None):
    """公共参数包: tmp 评分卡 + tmp 价格表 + tmp 漏斗库 + tmp 账本根."""
    return dict(
        scorecards_file=_cards_file(tmp_path, cards),
        out_path=tmp_path / "radar_weights_v2.json",
        reports_file=_reports_file(tmp_path, sku_prices or {}),
        db_path=_no_db(tmp_path),
        pool_root=tmp_path / "pools",
    )


def _ledger_rows(pool_root: Path, campaign: str) -> list[dict]:
    p = pool_root / campaign / "decision_ledger.jsonl"
    if not p.exists():
        return []
    return [json.loads(x) for x in
            p.read_text(encoding="utf-8").splitlines() if x.strip()]


# ------------------------------------------------ ⑦ 纯函数
def test_g_weight_factor_three_states():
    assert WB.weight_factor({"visit": 20, "sample_read": 10,
                             "click_buy": 4, "pay": 2}) == (1.1, "payment")
    assert WB.weight_factor({"visit": 30, "click_buy": 3, "pay": 0}) == \
        (1.05, "click_buy")
    assert WB.weight_factor({"visit": 50, "sample_read": 8}) == (1.0, "visit_only")
    assert WB.weight_factor({}) == (1.0, "no_signal")


def test_g_pricing_suggestion_edges():
    hi = WB.pricing_suggestion("X", {"visit": 1000, "pay": 67}, 1999)
    assert hi["suggestion"] == "test_up" and hi["current_price"] == 1999
    mid = WB.pricing_suggestion("X", {"visit": 1000, "pay": 66}, 1999)  # 恰 6.6%
    assert mid["suggestion"] == "hold"
    edge_down = WB.pricing_suggestion("X", {"visit": 100, "pay": 1}, 1999)  # 恰 1%
    assert edge_down["suggestion"] == "hold"
    low = WB.pricing_suggestion("X", {"visit": 200, "pay": 1}, 1999)
    assert low["suggestion"] == "test_down"
    unmeasurable = WB.pricing_suggestion("X", {"visit": 0, "pay": 3}, 1999)
    assert unmeasurable["suggestion"] == "hold" and \
        "不可测" in unmeasurable["basis"]
    assert WB.pricing_suggestion("X", {"visit": 10, "pay": 0}, 1999) is None


def test_g_sku_topic_for_two_layers():
    cards = [_card("A 选题", "TST-PAY"), _card("B 选题", "TST-CLICK"),
             _card("C 选题", "EPC-BID26")]
    # 特征词命中: 池 TST-PAY 的 PAY 特征词在 SKU 内
    assert WB.sku_topic_for("PAY-FULL", cards)["pool"] == "TST-PAY"
    # 泛词 EPC 弃用 → 不因 "EPC" 误归
    assert WB.sku_topic_for("EPC-DEMO-FULL", cards) is None
    # 显式 overrides 优先 (池名无特征词的 SKU)
    ov = {"EPC-DEMO-FULL": "C 选题"}
    assert WB.sku_topic_for("EPC-DEMO-FULL", cards, overrides=ov)["pool"] == \
        "EPC-BID26"
    assert WB.sku_topic_for("UNKNOWN-9", cards) is None


# ------------------------------------------------ ①③⑥ 权重三态 + 落账 + 红线
def test_a_weight_three_states_and_ledger(tmp_path):
    cards = [_card("甲 支付选题", "TST-PAY"), _card("乙 点购选题", "TST-CLICK"),
             _card("丙 纯访问选题", "TST-VISIT")]
    ledger = _seed_funnel(tmp_path, [
        ("PAY-FULL", "visit", 20), ("PAY-FULL", "sample_read", 10),
        ("PAY-FULL", "click_buy", 4), ("PAY-FULL", "pay", 2),
        ("CLICK-FULL", "visit", 30), ("CLICK-FULL", "click_buy", 3),
        ("VISIT-FULL", "visit", 50), ("VISIT-FULL", "sample_read", 8),
        ("ZZZ-UNKNOWN", "visit", 5),                    # 映射不上 → unmatched
    ])
    args = _run_args(tmp_path, cards, {"PAY-FULL": 100})
    src_bytes = Path(args["scorecards_file"]).read_bytes()

    s = WB.run(W42, ledger=ledger, **args)

    # --- ① 权重三态 ---
    adj = {a["pool"]: a for a in s["adjustments"]}
    assert len(adj) == 3
    assert adj["TST-PAY"]["factor"] == 1.1 and adj["TST-PAY"]["evidence"] == "payment"
    assert adj["TST-PAY"]["new_weights"]["需求强度"] == pytest.approx(0.385)
    assert adj["TST-CLICK"]["factor"] == 1.05 and \
        adj["TST-CLICK"]["evidence"] == "click_buy"
    assert adj["TST-CLICK"]["new_weights"]["需求强度"] == pytest.approx(0.3675)
    assert adj["TST-VISIT"]["factor"] == 1.0 and \
        adj["TST-VISIT"]["evidence"] == "visit_only"
    assert adj["TST-VISIT"]["new_weights"] == adj["TST-VISIT"]["old_weights"]
    # 其余三维权重不动
    assert adj["TST-PAY"]["new_weights"]["支付能力"] == 0.2

    # --- ② 定价: 仅支付 SKU 出建议 (10% > 6.6% → test_up) ---
    assert len(s["pricing"]) == 1
    assert s["pricing"][0] == {"sku": "PAY-FULL", "current_price": 100,
                               "suggestion": "test_up",
                               "basis": s["pricing"][0]["basis"]}
    assert "6.6%" in s["pricing"][0]["basis"]

    # --- ③ decision_ledger: 有动作才落账 ---
    pay_rows = _ledger_rows(args["pool_root"], "TST-PAY")
    assert [r["decision_type"] for r in pay_rows] == ["topic_select",
                                                      "pricing_suggest"]
    assert pay_rows[0]["chosen"] == "demand_strength_x1.1"
    assert pay_rows[0]["context"]["module"] == "writeback"
    assert pay_rows[1]["chosen"] == "test_up"
    assert pay_rows[1]["context"]["sku"] == "PAY-FULL"
    click_rows = _ledger_rows(args["pool_root"], "TST-CLICK")
    assert len(click_rows) == 1 and click_rows[0]["chosen"] == \
        "demand_strength_x1.05"
    assert _ledger_rows(args["pool_root"], "TST-VISIT") == []   # 纯访问零记录

    # --- ⑥ 红线: 源评分卡字节不动; 未映射 SKU 如实报告 ---
    assert Path(args["scorecards_file"]).read_bytes() == src_bytes
    assert s["unmatched_skus"] == ["ZZZ-UNKNOWN"]
    assert not (args["pool_root"] / "ZZZ-UNKNOWN").exists()

    # --- 产物文件落盘 (真跑) ---
    out = json.loads(Path(args["out_path"]).read_text(encoding="utf-8"))
    assert out["week"] == W42 and out["module"] == "writeback"
    assert len(out["adjustments"]) == 3 and len(out["pricing"]) == 1
    assert out["topics_no_data"] == []   # 三选题均有实测事件 → 无数据清单为空


def test_b_pricing_three_states(tmp_path):
    cards = [_card("高价选题", "TST-HI"), _card("中价选题", "TST-MID"),
             _card("低价选题", "TST-LOW")]
    ledger = _seed_funnel(tmp_path, [
        ("HI-PAY", "visit", 100), ("HI-PAY", "pay", 10),     # 10% → test_up
        ("MID-PAY", "visit", 100), ("MID-PAY", "pay", 3),    # 3% → hold
        ("LOW-PAY", "visit", 200), ("LOW-PAY", "pay", 1),    # 0.5% → test_down
    ])
    args = _run_args(tmp_path, cards,
                     {"HI-PAY": 1999, "MID-PAY": 698, "LOW-PAY": 98})
    s = WB.run(W42, ledger=ledger, **args)

    sug = {p["sku"]: p["suggestion"] for p in s["pricing"]}
    assert sug == {"HI-PAY": "test_up", "MID-PAY": "hold",
                   "LOW-PAY": "test_down"}
    prices = {p["sku"]: p["current_price"] for p in s["pricing"]}
    assert prices == {"HI-PAY": 1999, "MID-PAY": 698, "LOW-PAY": 98}
    # 三池各有 调权(topic_select×1.1) + 定价(pricing_suggest) 两条
    for pool in ("TST-HI", "TST-MID", "TST-LOW"):
        rows = _ledger_rows(args["pool_root"], pool)
        assert [r["decision_type"] for r in rows] == ["topic_select",
                                                      "pricing_suggest"]
    chosen = {r["chosen"] for pool in ("TST-HI", "TST-MID", "TST-LOW")
              for r in _ledger_rows(args["pool_root"], pool)}
    assert chosen == {"demand_strength_x1.1", "test_up", "hold", "test_down"}


# ------------------------------------------------ ④ 零数据周
def test_e_zero_data_week_note_only(tmp_path):
    cards = [_card("甲 支付选题", "TST-PAY")]
    args = _run_args(tmp_path, cards)
    empty_ledger = tmp_path / "empty_funnel.jsonl"        # 不存在 → 零事件

    s = WB.run(W42, ledger=empty_ledger, note_campaign="NOTE-POOL", **args)

    assert s["zero_data"] is True
    assert s["adjustments"] == [] and s["pricing"] == []
    assert not Path(args["out_path"]).exists()            # 产物不落盘
    rows = _ledger_rows(args["pool_root"], "NOTE-POOL")
    assert len(rows) == 1                                  # 只记 1 条 note
    note = rows[0]
    assert note["decision_type"] == "topic_select" and note["chosen"] == "no_change"
    assert note["context"]["module"] == "writeback"
    assert note["context"]["week"] == W42
    assert "零数据" in note["rationale"]


# ------------------------------------------------ ④b 有事件但零动作周
def test_e2_events_but_no_action_note(tmp_path):
    """真实 2026-W42 场景复刻: 仅 1 条未映射 SKU 的 visit 事件 → 零回写
    动作也要落 note (REQ-052 审计留痕), 产物照写记录实测现状."""
    cards = [_card("甲 支付选题", "TST-PAY")]
    ledger = _seed_funnel(tmp_path, [("SUB-ANNUAL-1999", "visit", 1)])
    args = _run_args(tmp_path, cards)

    s = WB.run(W42, ledger=ledger, note_campaign="NOTE-POOL", **args)

    assert s["zero_data"] is False
    assert s["adjustments"] == [] and s["pricing"] == []
    assert s["unmatched_skus"] == ["SUB-ANNUAL-1999"]
    assert Path(args["out_path"]).exists()            # 数据周产物照写 (现状留档)
    out = json.loads(Path(args["out_path"]).read_text(encoding="utf-8"))
    assert out["unmatched_skus"] == ["SUB-ANNUAL-1999"]
    assert out["topics_no_data"] == ["甲 支付选题"]
    rows = _ledger_rows(args["pool_root"], "NOTE-POOL")
    assert len(rows) == 1 and rows[0]["chosen"] == "no_change"
    assert "零回写动作" in rows[0]["rationale"]
    assert rows[0]["context"]["unmatched_skus"] == ["SUB-ANNUAL-1999"]


# ------------------------------------------------ ⑤ dry-run
def test_f_dry_run_no_artifact_but_ledger(tmp_path):
    cards = [_card("甲 支付选题", "TST-PAY")]
    ledger = _seed_funnel(tmp_path, [
        ("PAY-FULL", "visit", 20), ("PAY-FULL", "click_buy", 4),
        ("PAY-FULL", "pay", 2),
    ])
    args = _run_args(tmp_path, cards, {"PAY-FULL": 100})

    s = WB.run(W42, ledger=ledger, dry_run=True, **args)

    assert s["mode"] == "dry_run"
    assert not Path(args["out_path"]).exists()            # 产物不落盘
    # 账本照记: REQ-052 回写动作本身必须落账
    rows = _ledger_rows(args["pool_root"], "TST-PAY")
    assert [r["decision_type"] for r in rows] == ["topic_select",
                                                  "pricing_suggest"]
    assert len(s["ledger_records"]) == 2


# ------------------------------------------------ ⑥ 红线守卫
def test_h_out_cannot_target_scorecards(tmp_path):
    cards = [_card("甲 支付选题", "TST-PAY")]
    ledger = _seed_funnel(tmp_path, [("PAY-FULL", "visit", 5),
                                     ("PAY-FULL", "pay", 1)])
    args = _run_args(tmp_path, cards)
    args["out_path"] = args["scorecards_file"]        # 产物指向源评分卡 → 拒写
    with pytest.raises(ValueError, match="radar_scorecards"):
        WB.run(W42, ledger=ledger, **args)
    # 拒写后账本零残留 (校验先于任何落账)
    assert not (args["pool_root"] / "TST-PAY").exists()
