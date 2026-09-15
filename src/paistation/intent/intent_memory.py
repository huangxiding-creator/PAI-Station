"""M7c 意图记忆：MIRIX 六类记忆 ↔ profile 五层对接（workflow 层）。

方法论栈第⑤层：时序记忆增强。意图判读落 ProfileModel workflow 层，
复用既有双时间线（同 key 新值自动封口旧值）与幂等（同值不重复）。
"""
from __future__ import annotations

from ..profile.model import ProfileModel


def record_intent(profile: ProfileModel, block: dict,
                  intent: dict):
    """意图判读 → workflow 层条目；无 activity 则跳过（None）。"""
    value = (intent.get("activity") or "").strip()
    if not value:
        return None
    return profile.record(
        layer="workflow",
        key=f"intent:{block.get('category', 'unknown')}",
        value=value,
        confidence=float(intent.get("confidence") or 0.3),
        source=str(block.get("start") or ""))


def recent_intents(profile: ProfileModel, n: int = 10) -> list:
    """最近 n 条意图条目（新→旧），供 ICL/晨报引用。"""
    rows = profile.query(layer="workflow", keyword="intent:")
    return list(reversed(rows[-n:]))
