# M7.3 反馈返钱账本 + 免疫沉淀（提案 M7 §5.2）
import json
import os

from paistation.foundry.feedback import (
    deposit_immune_rule,
    load_immune_rules,
    refund_tier,
    score_feedback,
)


class TestScoreFeedback:
    def test_rule_baseline_scores_concrete_feedback(self):
        text = ("我花了25分钟读完第3章。3.2节的WBS表缺责任人和工期两列，"
                "建议补上并给出填写示例；数据化看板的指标没有计算公式，没法照抄。")
        r = score_feedback(text)  # 无 LLM → 规则兜底
        assert set(r) >= {"sincerity", "specificity", "actionability", "quality"}
        assert all(0 <= r[k] <= 10 for k in
                   ("sincerity", "specificity", "actionability", "quality"))
        assert r["specificity"] >= 6  # 有数字有细节
        assert r["actionability"] >= 5  # 有建议动作

    def test_rule_baseline_fluffs_score_low(self):
        r = score_feedback("写得不错，加油")
        assert r["quality"] < 4  # 灌水拿不到高质量分

    def test_llm_scoring_used_when_fast_fn_given(self):
        import json as _json

        def fake_fast(prompt, context=""):
            return {"text": _json.dumps({"sincerity": 8, "specificity": 9,
                                         "actionability": 7})}

        r = score_feedback("任意反馈文本", fast_fn=fake_fast)
        assert r["sincerity"] == 8 and r["quality"] >= 7

    def test_llm_garbage_falls_back_to_rules(self):
        def fake_fast(prompt, context=""):
            return {"text": "模型抽风了"}

        r = score_feedback("我读了20分钟，4.1节公式有误，建议改为 X=Y×Z",
                           fast_fn=fake_fast)
        assert 0 <= r["quality"] <= 10  # 兜底不崩，仍有分


class TestRefundTier:
    def test_ladder_by_minutes(self, ):
        assert refund_tier(10, price=498)["amount"] == 0
        assert refund_tier(16, price=498)["amount"] == 100
        assert refund_tier(31, price=498)["amount"] == 200
        assert refund_tier(61, price=498)["amount"] == 400
        assert refund_tier(75, price=498)["amount"] == 498  # >70 分钟全退

    def test_quality_modulates_amount(self):
        base = refund_tier(20, price=498, quality=8)
        mid = refund_tier(20, price=498, quality=5)
        fluff = refund_tier(20, price=498, quality=3)
        assert base["amount"] == 100  # 高质量拿满档
        assert mid["amount"] == 60    # 中质六折
        assert fluff["amount"] == 30  # 低质三折（防刷）

    def test_tier_labels(self):
        assert "¥100" in refund_tier(20, price=498)["tier"]
        assert "全退" in refund_tier(80, price=498)["tier"]


class TestImmuneSediment:
    def test_deposit_and_load_roundtrip(self, tmp_path):
        rule = deposit_immune_rule("epc-fde-ai", "3.2节WBS表必须含责任人与工期两列",
                                   quality=8, ledger_dir=str(tmp_path))
        assert "责任人" in rule
        rules = load_immune_rules("epc-fde-ai", ledger_dir=str(tmp_path))
        assert any("责任人" in r for r in rules)

    def test_load_missing_slug_empty(self, tmp_path):
        assert load_immune_rules("no-such", ledger_dir=str(tmp_path)) == []

    def test_deposit_same_rule_text_dedup(self, tmp_path):
        """同文本规则只入一条——两位买家反馈同一问题时，注入清单不重复。"""
        deposit_immune_rule("epc-fde-ai", "WBS 表必须含责任人与工期两列",
                            quality=8.3, ledger_dir=str(tmp_path))
        deposit_immune_rule("epc-fde-ai", "WBS 表必须含责任人与工期两列",
                            quality=7.7, ledger_dir=str(tmp_path))
        rules = load_immune_rules("epc-fde-ai", ledger_dir=str(tmp_path))
        assert len(rules) == 1  # 文本相同仅一条，质量分不同也不重复入库

    def test_ledger_appended(self, tmp_path):
        deposit_immune_rule("epc-fde-ai", "规则甲", quality=8, ledger_dir=str(tmp_path),
                            minutes=25, refund_amount=100)
        ledger = os.path.join(str(tmp_path), "feedback_ledger.jsonl")
        assert os.path.exists(ledger)
        entry = json.loads(open(ledger, encoding="utf-8").readlines()[-1])
        assert entry["slug"] == "epc-fde-ai" and entry["refund_amount"] == 100
        assert entry["minutes"] == 25 and entry["quality"] == 8
