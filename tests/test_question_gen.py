"""M9.1 问题清单生成器 TDD（PROPOSAL_V2.md 5.2③，自研难点①）。

毛选问题定义法的管线化：master_framework 节点 × 5W1H × 利益相关方
→ 自然语言问题 → 去重 → 分级（必答/应答/可答）→ ≥300 出厂硬门槛。
"""
import pytest

from paistation.foundry.question_gen import (
    Question,
    check_gate,
    generate_questions,
)


NODES = [
    {"id": "ch1.s1", "title": "合同风险识别", "frequency": 0.9},
    {"id": "ch1.s2", "title": "索赔程序", "frequency": 0.6},
    {"id": "ch2.s1", "title": "设计变更管理", "frequency": 0.3},
]


def test_generate_questions_cross_product_and_dedup():
    qs = generate_questions(NODES)
    # 3 节点 × 6 问式 × 8 视角 = 144 原始 → 去重后 ≤144 且每问字段齐
    assert len(qs) <= 144
    assert all(isinstance(q, Question) for q in qs)
    texts = {q.text for q in qs}
    assert len(texts) == len(qs)  # 无重复文本
    assert all(q.node_id and q.w1h and q.stakeholder for q in qs)


def test_question_text_mentions_node_and_stakeholder():
    qs = generate_questions(NODES[:1])
    sample = qs[0]
    assert "合同风险识别" in sample.text
    assert sample.stakeholder in sample.text


def test_grading_by_node_frequency():
    qs = generate_questions(NODES)
    levels = {q.level for q in qs}
    assert levels == {"must", "should", "may"}
    must = [q for q in qs if q.level == "must"]
    assert all(q.node_id == "ch1.s1" for q in must)  # 频次 0.9 → 必答


def test_check_gate_three_hundred_floor():
    ok, count = check_gate(generate_questions(NODES))
    assert ok is False and count < 300  # 3 节点不够门槛
    big = generate_questions(NODES + [
        {"id": f"ch3.s{i}", "title": f"主题{i}", "frequency": 0.8}
        for i in range(10)])
    ok2, count2 = check_gate(big)
    assert ok2 is True and count2 >= 300


def test_min_nodes_rejected():
    with pytest.raises(ValueError):
        generate_questions([])


def test_cap_default():
    big = generate_questions(
        [{"id": f"ch.s{i}", "title": f"节{i}", "frequency": 0.9}
         for i in range(50)])
    assert len(big) <= 900  # max_questions 默认 600 的上限保护（50节点超供）
