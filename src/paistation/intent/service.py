"""M8 意图常驻服务：事件流 → 段 → 拒识门 → L2 → 画像（增量断点续跑）。

服务契约与 SignalService 同款（name/started/tick(paused)/stop），
由 Daemon 心跳环驱动。管线（xvfeng 粗筛→细判顺序，省 token）：
  1. 事件流 → blocks_from_events（分段+资源绑定）
  2. gate L1 统计门（拒掉的块不烧 LLM）
  3. L2 summarize（有网关才烧；simple 档直判）
  4. gate 二次门（仅当 LLM 出品，l2_confidence 细判）
  5. record_intent 落画像 workflow 层（有 profile 才写）

增量游标按块 end（ISO 字典序可比），同批事件重复 tick 零重复产出。
降级矩阵：无 profile/无网关/坏事件 → 各自缺席不崩。
"""
from __future__ import annotations

import logging
import time
from datetime import datetime

from .flywheel import IntentSampleStore, build_icl
from .intent_memory import record_intent
from .l2_slow import summarize_block
from .reject_gate import gate
from .segmenter import blocks_from_events

_log = logging.getLogger("paistation.intent.service")

DEFAULT_INTERVAL = 60.0            # 意图提取周期（秒）
_MAX_INTENTS = 200                 # 内存意图窗上限


class IntentService:
    """M8 意图层常驻件（tick 由 daemon 驱动）。"""

    name = "intent"

    def __init__(self, stream=None, events_fn=None, profile=None,
                 gateway=None, store: IntentSampleStore | None = None,
                 interval: float = DEFAULT_INTERVAL, *, now_fn=None,
                 mono_fn=None):
        if events_fn is None:
            def events_fn():
                return stream.read_today() if stream else []
        self._events_fn = events_fn
        self._profile = profile
        self._gateway = gateway
        self._store = store
        self._interval = float(interval)
        self._now = now_fn or datetime.now
        self._mono = mono_fn or time.monotonic
        self._last_end: str | None = None    # 增量游标（最近已处理块 end）
        self._next_due: float | None = None
        self.started = False
        self.intents: list[dict] = []

    # ---- 服务契约（daemon）----

    def start(self) -> None:
        self.started = True

    def stop(self) -> None:
        self.started = False

    def tick(self, paused: bool = False) -> None:
        if paused or not self.started:
            return
        mono = self._mono()
        if self._next_due is not None and mono < self._next_due:
            return
        self._next_due = mono + self._interval
        self._cycle()

    def latest(self, n: int = 10) -> list[dict]:
        """最近 n 条意图判读（新→旧）。"""
        return list(reversed(self.intents[-n:]))

    # ---- 管线 ----

    def _cycle(self) -> None:
        try:
            events = self._events_fn() or []
        except Exception as exc:  # noqa: BLE001 - 读流失败不杀服务
            _log.warning("意图层读事件流失败（跳过本轮）: %s", exc)
            return
        try:
            blocks = blocks_from_events(list(events))
        except Exception as exc:  # noqa: BLE001 - 纯逻辑兜底
            _log.warning("意图层分段失败（跳过本轮）: %s", exc)
            return
        icl = build_icl(self._store) if self._store else ""
        for b in blocks:
            key = str(b["end"])
            if self._last_end is not None and key <= self._last_end:
                continue                       # 增量：已处理过的块
            self._last_end = key
            self._process(b, icl)

    def _process(self, b: dict, icl: str) -> None:
        try:
            if gate(b)["decision"] != "accept":
                return                         # L1 门拒 → 不烧 LLM
            intent = summarize_block(b, self._gateway, icl=icl)
            l2_conf = intent["confidence"] if intent.get("llm") else None
            final = gate(b, l2_confidence=l2_conf)
            if final["decision"] != "accept":
                return                         # LLM 出品但细判没底 → 弃
            self.intents.append({"ts": self._now().isoformat(
                timespec="milliseconds"), "block": b, "intent": intent,
                "decision": final["decision"], "score": final["score"]})
            del self.intents[:-_MAX_INTENTS]
            if self._profile:
                record_intent(self._profile, b, intent)
        except Exception as exc:  # noqa: BLE001 - 单块失败不杀整轮
            _log.warning("意图层处理块失败（跳过该块）: %s", exc)
