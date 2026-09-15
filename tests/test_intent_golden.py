"""M7c 金标准（M7_PLAN 验收）：L1 ≥30 条准确 ≥90%；拒识 ≥8 场景零漏放。

金标准即验收红线 C12：数字必须来自真实跑批，不许编。
"""
import json
from pathlib import Path

import pytest

from paistation.intent.l1_fast import classify
from paistation.intent.reject_gate import gate

_FIXTURE = Path(__file__).parent / "fixtures" / "intent_golden.jsonl"


def _rows():
    text = _FIXTURE.read_text(encoding="utf-8")
    return [json.loads(line) for line in text.splitlines() if line.strip()]


def test_golden_size_meets_plan():
    rows = _rows()
    l1 = [r for r in rows if r["kind"] == "l1"]
    rejects = [r for r in rows if r["kind"] == "reject"]
    assert len(l1) >= 30, "M7_PLAN 验收：意图版金标准 ≥30 条"
    assert len(rejects) >= 8, "M7_PLAN 验收：拒识样本 ≥8 条"


def test_l1_golden_accuracy():
    rows = [r for r in _rows() if r["kind"] == "l1"]
    wrong = [(r["name"], classify(r["sample"])["category"], r["expect"])
             for r in rows if classify(r["sample"])["category"] != r["expect"]]
    acc = 1 - len(wrong) / len(rows)
    assert acc >= 0.9, f"L1 金标准准确率 {acc:.2f} < 0.90，错判: {wrong}"


def test_reject_golden_zero_false_positive():
    """拒识场景全数拒掉（零漏放）；接受场景全数放行。"""
    for r in _rows():
        if r["kind"] == "reject":
            got = gate(r["block"], l2_confidence=r["block"].get(
                "l2_confidence") if r["block"] else None)["decision"]
            assert got == "irrelevant", f"漏放: {r['name']}"
        elif r["kind"] == "accept":
            got = gate(r["block"])["decision"]
            assert got == "accept", f"误拒: {r['name']}"
