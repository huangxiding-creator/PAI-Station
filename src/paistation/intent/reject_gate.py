"""M7b 拒识门：xvfeng 双层拒识移植——「无关」是一等输出。

方向性取舍（有意与 xvfeng 相反）：车载语音漏识代价高 → fail-open
（默认是）；PAI 主动助理误触发代价高（打扰用户）→ fail-closed
（默认拒，宁沉默勿误报）。任何闸门异常一律保守不触发。

第一层 = L1 块统计门（本模块）；第二层 = L2 细判置信（M7c 接线，
l2_confidence 参数已留）。
"""
from __future__ import annotations

DEFAULTS = {
    "min_duration_min": 2.0,     # 过短不成任务
    "min_confidence": 0.5,       # L1 主导类别置信
    "min_coverage": 0.4,         # 主导类别样本占比
    "max_idle_share": 0.8,       # 离席样本占比上限
    "min_l2_confidence": 0.6,    # 第二层（L2 细判）
}


def gate(block, thresholds: dict | None = None,
         l2_confidence: float | None = None) -> dict:
    """活动块 → {decision: accept|irrelevant, reason, score}。"""
    try:
        th = {**DEFAULTS, **(thresholds or {})}
        verdict = _gate(block, th, l2_confidence)
    except Exception:  # noqa: BLE001 - fail-closed：闸门异常不触发
        return {"decision": "irrelevant", "reason": "闸门异常，保守不触发",
                "score": 0.0}
    return verdict


def _gate(block, th: dict, l2_confidence) -> dict:
    if not isinstance(block, dict):
        return _no("输入非活动块")
    counts = block.get("category_counts") or {}
    total = sum(counts.values()) or 1
    if block.get("category") == "idle":
        return _no("离席段", 0.0)
    if (block.get("duration_min") or 0.0) < th["min_duration_min"]:
        return _no(f"时长过短（<{th['min_duration_min']}min）")
    if (block.get("confidence") or 0.0) < th["min_confidence"]:
        return _no("L1 置信不足")
    if counts.get("idle", 0) / total >= th["max_idle_share"]:
        return _no("以离席为主")
    if (block.get("coverage") or 0.0) < th["min_coverage"]:
        return _no("主导类别占比不足（混杂段）")
    if l2_confidence is not None and l2_confidence < th["min_l2_confidence"]:
        return _no(f"L2 细判置信不足（<{th['min_l2_confidence']}）")
    score = round((block.get("confidence") or 0.0)
                  * (block.get("coverage") or 0.0), 3)
    return {"decision": "accept", "reason": "通过 L1 统计门", "score": score}


def _no(reason: str, score: float | None = None) -> dict:
    return {"decision": "irrelevant", "reason": reason,
            "score": score if score is not None else 0.0}
