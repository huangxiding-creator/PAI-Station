# -*- coding: utf-8 -*-
"""商机雷达测试：信号检测 + 商机评估 + 中间件。"""
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).parent.parent))

from zbops.radar.detector import SignalDetector, SignalType
from zbops.radar.evaluator import OpportunityEvaluator


def test_project_signal_high():
    d = SignalDetector()
    text = "我们在做一个浙江省水库EPC总承包项目，最近要招标"
    sigs = d.detect(text, "user1", "chat1")
    assert any(s.type == SignalType.PROJECT for s in sigs), f"未检测到项目信号: {sigs}"
    proj = [s for s in sigs if s.type == SignalType.PROJECT][0]
    assert proj.confidence >= 0.7, f"置信度过低: {proj.confidence}"
    assert proj.province == "浙江", f"省份识别错误: {proj.province}"
    assert proj.industry == "水利", f"行业识别错误: {proj.industry}"
    print("PASS: 高价值项目信号检测（浙江水利EPC）")


def test_help_signal():
    d = SignalDetector()
    text = "请问EPC合同中索赔条款怎么处理？有什么规范依据吗"
    sigs = d.detect(text, "user2", "chat1")
    assert any(s.type == SignalType.HELP for s in sigs), f"未检测到求助信号: {sigs}"
    help_sig = [s for s in sigs if s.type == SignalType.HELP][0]
    assert help_sig.confidence >= 0.5
    print("PASS: 求助信号检测（EPC索赔咨询）")


def test_purchase_signal():
    d = SignalDetector()
    text = "有谁知道湖南哪家设计院做灌区改造比较好？求推荐"
    sigs = d.detect(text, "user3", "chat2")
    assert any(s.type == SignalType.PURCHASE for s in sigs), f"未检测到采购信号: {sigs}"
    print("PASS: 采购信号检测（寻找设计院）")


def test_no_signal():
    d = SignalDetector()
    text = "今天天气真好，大家周末愉快"
    sigs = d.detect(text, "user4", "chat3")
    assert len(sigs) == 0, f"闲聊不应产生信号: {sigs}"
    print("PASS: 闲聊不误报")


def test_evaluator_priority():
    d = SignalDetector()
    e = OpportunityEvaluator()
    text = "广东某高速公路EPC总承包项目，投资约50亿，下个月招标"
    sigs = d.detect(text, "user5", "chat5")
    assert sigs, "应检测到信号"
    for sig in sigs:
        opp = e.evaluate(sig)
        if sig.type == SignalType.PROJECT:
            assert opp.score > 50, f"高速EPC评分过低: {opp.score}"
            assert opp.est_value_yuan > 10000000, f"预估价值过低: {opp.est_value_yuan}"
    print("PASS: 商机评估（高速EPC高价值）")


def test_evaluator_low_priority():
    d = SignalDetector()
    e = OpportunityEvaluator()
    text = "预算和定额有什么区别"
    sigs = d.detect(text, "user6", "chat6")
    for sig in sigs:
        opp = e.evaluate(sig)
        if sig.type == SignalType.HELP:
            assert opp.score < 70, f"简单求助不应高优先级: {opp.score}"
    print("PASS: 低价值信号不误报高优先级")


if __name__ == "__main__":
    test_project_signal_high()
    test_help_signal()
    test_purchase_signal()
    test_no_signal()
    test_evaluator_priority()
    test_evaluator_low_priority()
    print("\n=== 雷达测试全部通过 ===")
