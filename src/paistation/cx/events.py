"""统一事件封套：所有上下文源汇入主时间轴前的规范形态。"""

from __future__ import annotations

import json
from dataclasses import dataclass, field
from datetime import datetime, timezone
from typing import Any


class EventValidationError(ValueError):
    """事件封套不满足契约。"""


@dataclass(frozen=True)
class EventEnvelope:
    """一条用户上下文事件。

    source:      来源系统名（如 "git" / "activities_cache"）
    source_id:   源内稳定主键（重跑采集幂等）
    start:       事件开始时间（ aware UTC；naive 视为本地时间转换）
    end:         事件结束时间（瞬时事件为 None）
    type:        事件类型（命名空间.动作，如 "work.commit"）
    payload:     任意 JSON 附加字段
    """

    source: str
    source_id: str
    start: datetime
    type: str
    end: datetime | None = None
    payload: dict[str, Any] = field(default_factory=dict)

    def __post_init__(self) -> None:
        if not self.source or not self.source_id:
            raise EventValidationError("source/source_id 不能为空")
        if not self.type or "." not in self.type:
            raise EventValidationError(f"type 须为命名空间.动作形态：{self.type!r}")
        if self.end is not None and self.end < self.start:
            raise EventValidationError("end 不能早于 start")
        # frozen dataclass 的规范化赋值走 object.__setattr__
        object.__setattr__(self, "start", _to_utc(self.start))
        if self.end is not None:
            object.__setattr__(self, "end", _to_utc(self.end))
        # payload 必须可 JSON 序列化（提前炸而非入库时炸）
        json.dumps(self.payload, ensure_ascii=False)

    @property
    def idempotency_key(self) -> tuple[str, str]:
        return (self.source, self.source_id)


def _to_utc(dt: datetime) -> datetime:
    if dt.tzinfo is None:
        return dt.astimezone(timezone.utc)
    return dt.astimezone(timezone.utc)
