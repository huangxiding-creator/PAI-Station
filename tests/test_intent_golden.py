"""意图金标准（M7c 立项 54 条 → M8 扩 81 → 09-16 扩 219）：
L1 162 条十类全覆盖准确 ≥90%；拒识 43 场景零漏放；接受 14 场景零误拒。

金标准即验收红线 C12：数字必须来自真实跑批，不许编。
样本作者纪律：每行 expect 与 l1_fast 级联 / reject_gate 门规则一致
（生成器 data/gen_intent_golden.py 逐行自校验后才写盘）。
"""
import json
from pathlib import Path

import pytest

from paistation.intent.l1_fast import classify
from paistation.intent.reject_gate import gate

_FIXTURE = Path(__file__).parent / "fixtures" / "intent_golden.jsonl"

# 十类每类下限：锁定类别均衡，防单类膨胀刷总数
_MIN_PER_CATEGORY = 4


def _rows():
    text = _FIXTURE.read_text(encoding="utf-8")
    return [json.loads(line) for line in text.splitlines() if line.strip()]


def test_golden_size_meets_plan():
    rows = _rows()
    l1 = [r for r in rows if r["kind"] == "l1"]
    rejects = [r for r in rows if r["kind"] == "reject"]
    accepts = [r for r in rows if r["kind"] == "accept"]
    # M7_PLAN 原验收下限 ≥30/≥8 已于 09-15 达成；09-16 增长线抬至 150/30/10
    assert len(l1) >= 150, "意图金标准 L1 ≥150 条（09-16 扩表后下限）"
    assert len(rejects) >= 30, "拒识样本 ≥30 条"
    assert len(accepts) >= 10, "接受样本 ≥10 条"
    assert len(rows) >= 200, "金标准总量 ≥200 行"


def test_l1_category_coverage():
    counts = {}
    for r in _rows():
        if r["kind"] == "l1":
            counts[r["expect"]] = counts.get(r["expect"], 0) + 1
    assert len(counts) == 10, f"十类须齐（当前 {sorted(counts)}）"
    thin = {c: n for c, n in counts.items() if n < _MIN_PER_CATEGORY}
    assert not thin, f"类别过薄: {thin}"


def test_l1_golden_accuracy():
    rows = [r for r in _rows() if r["kind"] == "l1"]
    wrong = [(r["name"], classify(r["sample"])["category"], r["expect"])
             for r in rows if classify(r["sample"])["category"] != r["expect"]]
    acc = 1 - len(wrong) / len(rows)
    assert acc >= 0.9, f"L1 金标准准确率 {acc:.2f} < 0.90，错判: {wrong}"


def test_reject_golden_zero_false_positive():
    """拒识场景全数拒掉（零漏放）；接受场景全数放行。

    reject 行的 block 允许非 dict（null/字符串/数字 → 非活动块分支），
    l2_confidence 提取须 isinstance 防御。
    """
    for r in _rows():
        if r["kind"] == "reject":
            block = r["block"]
            l2 = block.get("l2_confidence") if isinstance(block, dict) else None
            got = gate(block, l2_confidence=l2)["decision"]
            assert got == "irrelevant", f"漏放: {r['name']}"
        elif r["kind"] == "accept":
            got = gate(r["block"])["decision"]
            assert got == "accept", f"误拒: {r['name']}"
