"""Fogg B=MAP 打分 + 注意力状态（提案 3.1 M4 / 4.6 L5）。

B = M × A × P：动机(任务价值) × 能力(用户当下可切换性) × 提示(时机得分)。
深工作态 A 压至 0.05——除非 Q1（重要且紧急 ≥0.9）破门，一律不打扰。
"""

# 注意力状态 → 能力系数（切换成本越高能力越低）
_ABILITY = {"idle": 1.0, "focus": 0.7, "deepwork": 0.05}


class FoggScorer:
    """B=MAP 乘积模型（0-1）。"""

    @staticmethod
    def score(motivation: float, ability: float, prompt: float) -> float:
        m = min(max(motivation, 0.0), 1.0)
        a = min(max(ability, 0.0), 1.0)
        p = min(max(prompt, 0.0), 1.0)
        return round(m * a * p, 4)


def should_interrupt(item: dict, attention: str = "focus") -> dict:
    """候选任务 + 注意力状态 → {interrupt, score, reason}。"""
    attention = attention if attention in _ABILITY else "focus"
    motivation = min(max(item.get("importance", 0.0), 0.0), 1.0)
    prompt = min(max(item.get("urgency", 0.0), 0.0), 1.0)
    ability = _ABILITY[attention]
    q1_breakthrough = (attention == "deepwork" and motivation >= 0.9
                       and prompt >= 0.9)
    if attention == "deepwork" and not q1_breakthrough:
        return {"interrupt": False, "score": 0.0, "reason": "深工作保护：非 Q1 不打扰"}
    score = FoggScorer.score(motivation, ability, prompt)
    interrupt = score >= 0.35
    reason = (f"B=MAP={score:.2f}（M={motivation:.1f} A={ability:.1f} "
              f"P={prompt:.1f}）")
    if q1_breakthrough:
        interrupt = True
        reason += "；Q1 破门"
    return {"interrupt": interrupt, "score": score, "reason": reason}
