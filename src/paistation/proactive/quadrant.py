"""Eisenhower 四象限分流（提案 3.1 M5）：重要×紧急 → 行动决策。

重要 ≥0.6 且紧急 ≥0.6 → Q1 立即做；重要 → Q2 排期做；
紧急 → Q3 批量处理；其余 → Q4 丢弃。阈值取 0.6 防边界抖动。
"""

_THRESH = 0.6


def classify(item: dict) -> dict:
    """候选任务 → {"quadrant", "action", "reason"}。"""
    important = item.get("importance", 0.0) >= _THRESH
    urgent = item.get("urgency", 0.0) >= _THRESH
    if important and urgent:
        return {"quadrant": 1, "action": "立即做", "reason": "重要且紧急"}
    if important:
        return {"quadrant": 2, "action": "排期做", "reason": "重要不紧急"}
    if urgent:
        return {"quadrant": 3, "action": "批量处理", "reason": "紧急不重要"}
    return {"quadrant": 4, "action": "丢弃", "reason": "不重要不紧急"}
