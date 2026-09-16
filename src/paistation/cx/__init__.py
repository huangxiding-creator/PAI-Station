"""CX · 用户上下文极致收集工程（PROPOSAL_CX）。

统一事件封套 + 全源主时间轴（P2 融合架构核心件）。
设计契约：
- 事件封套：{source, source_id, start, end, type, payload}，幂等键=(source, source_id)
- 双时态：事件时间(start/end) 与 入库时间(ingested_at) 分列
- 只增不删：同键事件首写优先（ADD-only），重跑采集零重复
"""

from paistation.cx.events import EventEnvelope
from paistation.cx.timeline import TimelineStore

__all__ = ["EventEnvelope", "TimelineStore"]
