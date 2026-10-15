# -*- coding: utf-8 -*-
"""superline.demand_radar 单测——REQ-030 需求雷达 v1 三快源评分卡.

不碰真池真 SKU: 合成信号+tmp 池验证. 覆盖:
权重和=1 (0.35/0.20/0.25/0.20)/合成信号→已知 DScore (norms=e-1 使 log1p 分位=指数)/
缺源降权不炸 (内部权重让出+覆盖如实报)/三快源全缺=强度0 仍有卡/
画像未登记保守缺省/hook 接口替换规则表/引擎归类优先级 (wechat_rss:bidcut 归公众号)/
run() 批量落盘 (评分卡+信号 jsonl 可回放, 零源池不炸).
"""
import json
import math
import sys
from pathlib import Path

import pytest

sys.path.insert(0, str(Path(__file__).resolve().parents[1]))
from superline import demand_radar as R  # noqa: E402


def test_weights_sum_to_one():
    """四维权重与 KB-DEMAND-RADAR-SPEC 逐值同源, 和恰为 1."""
    assert R.WEIGHTS == {"需求强度": 0.35, "支付能力": 0.20, "竞争空缺": 0.25, "语料复用度": 0.20}
    assert sum(R.WEIGHTS.values()) == pytest.approx(1.0)


def test_synthetic_signals_known_dscore():
    """合成信号→已知 DScore: norms 全取 e-1 (log1p=1), 分位=指数倍, 手算闭环."""
    E = math.e - 1.0
    norms = {"bidding_volume": E, "policy_pulse": E, "wechat_pain": E, "corpus_chars": E}
    signals = {
        "bidding_volume": math.e ** 0.5 - 1,   # 分位 0.50
        "policy_pulse": math.e ** 0.25 - 1,    # 分位 0.25
        "wechat_pain": math.e ** 1.0 - 1,      # 分位 1.00
        "corpus_chars": math.e ** 0.75 - 1,    # 分位 0.75
        "buyer_persona": "enterprise_strategy",  # 0.95
        "sku_hits": 0,                           # 空缺 1.00
    }
    card = R.score("合成选题", signals, norms=norms)
    strength = 0.45 * 0.5 + 0.45 * 1.0 + 0.10 * 0.25   # = 0.70 (三源在场, 无让权)
    expected = 0.35 * strength + 0.20 * 0.95 + 0.25 * 1.0 + 0.20 * 0.75  # = 0.835
    assert card["需求强度"] == pytest.approx(strength, abs=1e-4)
    assert card["支付能力"] == pytest.approx(0.95, abs=1e-4)
    assert card["竞争空缺"] == pytest.approx(1.0, abs=1e-4)
    assert card["语料复用度"] == pytest.approx(0.75, abs=1e-4)
    assert card["DScore"] == pytest.approx(expected, abs=1e-4)
    assert card["signal_coverage"] == 1.0


def test_missing_source_downweights_no_crash():
    """信号缺源: 不炸, 缺源内部权重让出在场源 (单源在场→强度=该源分位), 覆盖如实报."""
    E = math.e - 1.0
    signals = {"wechat_pain": math.e ** 0.6 - 1, "buyer_persona": "consultant", "sku_hits": 2}
    card = R.score("缺源选题", signals, norms={"wechat_pain": E})
    assert card["demand_sources_missing"] == ["bidding_volume", "policy_pulse"]
    assert card["signal_coverage"] == pytest.approx(1 / 3)
    assert card["需求强度"] == pytest.approx(0.6, abs=1e-4)     # 唯一在场源=满权重
    assert 0.0 <= card["DScore"] <= 1.0
    assert any("缺源降权" in n for n in card["notes"])


def test_all_sources_missing_zero_strength():
    """三快源全缺: 强度=0 (不猜), 其余维照常出卡."""
    card = R.score("零源选题", {"buyer_persona": "sme_design_institute", "sku_hits": 5})
    assert card["需求强度"] == 0.0
    assert card["signal_coverage"] == 0.0
    assert card["语料复用度"] == 0.0
    assert card["竞争空缺"] == pytest.approx(R.COMPETITION_FLOOR)   # 命中5 ≥4 → 红海档
    assert card["DScore"] == pytest.approx(0.20 * 0.60 + 0.25 * 0.25, abs=1e-4)
    assert any("三快源全缺" in n for n in card["notes"])


def test_unknown_persona_default_with_note():
    """画像未登记: 保守缺省 0.5, note 如实标注, 不炸."""
    card = R.score("陌生画像", {"buyer_persona": "government_buyer", "sku_hits": 0})
    assert card["支付能力"] == pytest.approx(R.DEFAULT_PERSONA_SCORE)
    assert any("未登记" in n for n in card["notes"])


def test_hooks_override_rule_tables():
    """v2 数据接口 hook: 返回有效 0-1 值则整体替换规则表并在 note 留痕."""
    signals = {"buyer_persona": "consultant", "sku_hits": 0}
    card = R.score("hook选题", signals,
                   persona_hook=lambda t, s: 0.77,
                   competition_hook=lambda t, s: 0.33)
    assert card["支付能力"] == pytest.approx(0.77)
    assert card["竞争空缺"] == pytest.approx(0.33)
    assert any("persona_hook" in n for n in card["notes"])
    assert any("competition_hook" in n for n in card["notes"])


def test_classify_engine_priority():
    """引擎归类优先级: cross:wechat_rss:bidcut 是公众号渠道 (wechat 先于 bidding)."""
    buckets = R._classify_engines({
        "cross:wechat_rss:bidcut": 100, "cross:bidding": 200,
        "rss:bid26deep": 50, "cross:policy": 30, "20_微信文章": 40, "own:gov": 999,
    })
    assert buckets["wechat_pain"] == {"cross:wechat_rss:bidcut": 100, "20_微信文章": 40}
    assert buckets["bidding_volume"] == {"cross:bidding": 200, "rss:bid26deep": 50}
    assert buckets["policy_pulse"] == {"cross:policy": 30}
    assert "own:gov" not in str(buckets)          # 不匹配任何快源=不计入


def _mk_pool(root, name, engines, kws, total):
    d = root / name
    d.mkdir()
    (d / "pool_state.json").write_text(
        json.dumps({"campaign": name, "kws": kws, "total_chars": total,
                    "by_engine": engines}, ensure_ascii=False), encoding="utf-8")
    return str(d)


def test_run_batch_end_to_end(tmp_path):
    """run() 批量: 合成双池 (一全源一零源) → 双卡落盘 + 信号 jsonl 逐条可回放."""
    pool_a = _mk_pool(tmp_path, "POOL-A",
                      {"cross:bidding": 1000, "cross:policy": 500, "wechat:sogou": 800},
                      ["招投标合规", "怎么办"], 2300)
    pool_b = _mk_pool(tmp_path, "POOL-B", {"own:gov": 100}, ["水利"], 100)
    sku_file = tmp_path / "skus.json"
    sku_file.write_text(json.dumps(
        {"reports": [{"title": "工程总承包招投标合规工作指南"},
                     {"title": "水利工程EPC总承包模式实施效果全景分析研究报告"}]},
        ensure_ascii=False), encoding="utf-8")
    topics_file = tmp_path / "topics.json"
    topics_file.write_text(json.dumps({"topics": [
        {"topic": "合成-招投标合规", "pool": pool_a, "persona": "enterprise_bid_team",
         "sku_match": ["招投标"]},
        {"topic": "合成-水利观察", "pool": pool_b, "persona": "sme_design_institute",
         "sku_match": ["水利"]},
    ]}, ensure_ascii=False), encoding="utf-8")

    cards, n_rows = R.run(topics_file, out_dir=tmp_path / "out", sku_file=sku_file)

    assert len(cards) == 2 and n_rows == 12                    # 每选题 6 行信号
    by_topic = {c["topic"]: c for c in cards}
    a, b = by_topic["合成-招投标合规"], by_topic["合成-水利观察"]
    assert a["需求强度"] > 0 and a["竞争空缺"] == pytest.approx(0.85)   # SKU 命中 1 → 0.85 档
    assert b["需求强度"] == 0.0 and b["demand_sources_missing"] == list(R.DEMAND_SOURCES)
    for c in cards:
        assert 0.0 <= c["DScore"] <= 1.0
        assert c["signals_ref"]["rows"] == 6
        assert c["signals_ref"]["file"].endswith("radar_signals.jsonl")

    out = tmp_path / "out"
    assert (out / "radar_scorecards.json").exists() and (out / "radar_signals.jsonl").exists()
    disk_cards = json.loads((out / "radar_scorecards.json").read_text(encoding="utf-8"))
    assert {c["topic"] for c in disk_cards} == {c["topic"] for c in cards}
    rows = [json.loads(x) for x in
            (out / "radar_signals.jsonl").read_text(encoding="utf-8").splitlines()]
    assert len(rows) == 12
    assert all({"topic", "source", "signal", "value", "ts", "meta"} <= set(r) for r in rows)
    proxy = [r for r in rows if r["source"] == "proxy_pool_chars"]
    assert len(proxy) == 8                                     # 2 选题 × 4 池信号
    wechat_rows = [r for r in proxy if r["signal"] == "wechat_pain"
                   and r["topic"] == "合成-招投标合规"]
    assert wechat_rows[0]["meta"]["pain_kw_hits"] == 2            # 命中 怎么办+合规
    assert wechat_rows[0]["value"] == pytest.approx(800 * 1.0)   # 痛点词命中≥2 → 因子1.0
    assert wechat_rows[0]["meta"]["engine_breakdown"]["wechat_pain"] == {"wechat:sogou": 800}
