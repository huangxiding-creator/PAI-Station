"""R5 T18 错误免疫系统 + T19 魔鬼代言人/谄媚漂移检测。"""
from paistation.soul.honesty import DevilAdvocate, sycophancy_drift
from paistation.soul.immune import ImmuneSystem


# ---- T18 错误免疫系统 ----

def test_learn_creates_rule_from_correction(tmp_path):
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="生成投标文件清单", wrong="漏掉了资质文件",
              right="清单必须含资质文件")
    rules = imm.rules()
    assert len(rules) == 1
    assert rules[0]["right"] == "清单必须含资质文件"


def test_check_matches_learned_context(tmp_path):
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="生成投标文件清单", wrong="漏掉资质", right="必含资质")
    hit = imm.check("又要生成投标文件清单了")
    assert hit and "资质" in hit["right"]


def test_check_no_match_returns_none(tmp_path):
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="写周报", wrong="格式错", right="用模板")
    assert imm.check("整理旅行计划") is None


def test_inject_prompt_suffix(tmp_path):
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="生成投标文件清单", wrong="漏掉资质", right="必含资质")
    suffix = imm.inject("生成投标文件清单")
    assert "必含资质" in suffix  # 提示词注入抗体


def test_reblock_rate_tracking(tmp_path):
    """复拦率：同一签名二次拦截要计入（≥60% 目标的度量基础）。"""
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="周报", wrong="口径不一", right="统一口径")
    imm.check("写周报")   # 首次拦截
    imm.check("写周报v2")  # 复拦
    imm.check("写周报v3")  # 复拦
    s = imm.stats()
    assert s["rules"] == 1
    assert s["reblocked_rules"] == 1
    assert s["reblock_rate"] >= 0.6


def test_monthly_report_mentions_rules(tmp_path):
    imm = ImmuneSystem(str(tmp_path / "immune.json"))
    imm.learn(context="周报", wrong="口径不一", right="统一口径")
    text = imm.monthly_report()
    assert "免疫规则" in text and "1 条" in text


def test_persistence(tmp_path):
    path = str(tmp_path / "immune.json")
    ImmuneSystem(path).learn(context="合同", wrong="金额错", right="双人复核")
    assert len(ImmuneSystem(path).rules()) == 1


# ---- T19 诚实引擎 ----

def test_devil_flags_major_claim_without_evidence():
    adv = DevilAdvocate()
    r = adv.review("这个方案一定会让业绩增长 300%，是最好的选择")
    assert r["severity"] == "major"
    assert r["challenges"]
    assert r["pass"] is False


def test_devil_passes_sober_content():
    adv = DevilAdvocate()
    r = adv.review("建议先小范围试点，根据数据（上周转化 3%）再决定是否扩大")
    assert r["pass"] is True


def test_devil_major_outbound_must_not_pass():
    """重大外发 100% 过卡：major 即拦截（过卡 = review + pass 检查）。"""
    adv = DevilAdvocate()
    outbound = "我们保证客户 100% 满意，这是业界第一的方案"
    assert adv.review(outbound)["pass"] is False


def test_devil_llm_enhanced_opinion():
    def fake_deep(prompt, **kw):
        return {"text": '["数据来源未验证", "未考虑反例"]'}

    adv = DevilAdvocate(deep_fn=fake_deep)
    r = adv.review("某方案陈述")
    assert r["challenges"] == ["数据来源未验证", "未考虑反例"]
    assert r["severity"] == "minor"  # 规则层无 major 信号 → LLM 意见属 minor


def test_sycophancy_zero_on_neutral():
    score = sycophancy_drift(["根据测试结果，方案 A 更快"])
    assert score == 0.0


def test_sycophancy_counts_agreement_phrases():
    outputs = ["你说得对，完全正确！", "好问题！", "根据数据，结论是 X"]
    score = sycophancy_drift(outputs)
    assert 0 < score < 1


def test_sycophancy_alert_threshold():
    assert sycophancy_drift(["你说得对", "完全正确", "绝对没错"]) >= 0.5
