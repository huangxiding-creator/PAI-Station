"""M7b 拒识门：xvfeng 双层思想移植——「无关」是一等输出。

方向性取舍：xvfeng 车载场景漏识代价高 → fail-open（默认是）；
PAI 主动助理误触发代价高 → fail-closed（默认拒，宁沉默勿打扰）。
"""
from paistation.intent.reject_gate import gate


def _block(**kw):
    b = {"category": "project", "confidence": 0.8, "coverage": 0.75,
         "duration_min": 10.0, "samples": 12,
         "category_counts": {"project": 9, "research": 3}}
    b.update(kw)
    return b


def test_accept_good_block():
    r = gate(_block())
    assert r["decision"] == "accept"
    assert r["score"] == round(0.8 * 0.75, 3)
    assert r["reason"]


def test_reject_too_short():
    r = gate(_block(duration_min=0.5))
    assert r["decision"] == "irrelevant"
    assert "过短" in r["reason"]


def test_reject_low_confidence():
    r = gate(_block(confidence=0.3))
    assert r["decision"] == "irrelevant"
    assert "置信" in r["reason"]


def test_reject_low_coverage():
    """主导类别占比不足 → 混杂段不是任务。"""
    r = gate(_block(coverage=0.3))
    assert r["decision"] == "irrelevant"
    assert "占比" in r["reason"]


def test_reject_idle_block():
    r = gate(_block(category="idle",
                    category_counts={"idle": 12}))
    assert r["decision"] == "irrelevant"
    assert "离席" in r["reason"]


def test_reject_idle_dominant_share():
    r = gate(_block(category_counts={"project": 2, "idle": 8},
                    coverage=0.2))
    assert r["decision"] == "irrelevant"


def test_fail_safe_on_garbage():
    """闸门异常 → 保守不触发（fail-closed）。"""
    r = gate(None)
    assert r["decision"] == "irrelevant"
    r2 = gate("不是块")
    assert r2["decision"] == "irrelevant"


def test_l2_tier_low_confidence_rejects():
    """第二层（L2 细判置信，M7c 接线）：低置信 → 拒。"""
    r = gate(_block(), l2_confidence=0.2)
    assert r["decision"] == "irrelevant"
    assert "L2" in r["reason"]
    assert gate(_block(), l2_confidence=0.9)["decision"] == "accept"


def test_thresholds_injectable():
    r = gate(_block(duration_min=0.5),
             thresholds={"min_duration_min": 0.2})
    assert r["decision"] == "accept"
