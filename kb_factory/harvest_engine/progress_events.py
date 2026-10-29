# -*- coding: utf-8 -*-
"""施工直播事件出口 progress_events.py（FR9.1；ARCHITECTURE D6 修复新增件）。

两个出口、同一事件体：
1. JSONL 落盘（固定七列：ts/order_id/site/slot/event/progress/detail）——引擎侧
   事件件，回放/验收/小程序拉取的事实源（每事件一行，零造假：只记实发事实）；
2. 小程序施工直播通道占位（``channel_sink`` 可注入回调）——对齐
   KNOWLEDGE_BASE/kb-factory-integration.md「小程序施工直播已有；引擎进度事件接
   同一通道」：微信小程序 pages/kbfactory 已有施工直播位，本件把同一行透传给
   注入的通道回调；缺省 None=只落 JSONL（通道接线归下游集成，占位不空转）。

通道腿纪律：channel_sink 抛任何异常不得外溢主链（直播通道挂=收割/交付不停），
异常吞没并如实返回 ``channel_error`` 注记。线程口径同 RateLimiter：进程级单线程
顺序调用即可，不加锁。
"""
from __future__ import annotations

import json
import time
from collections.abc import Callable
from pathlib import Path

__all__ = [
    "EVENT_FIELDS", "MINIPROGRAM_CHANNEL", "ProgressEvents",
]

#: 事件件固定七列（任务卡契约：site/slot/event/progress/detail + ts/order_id）
EVENT_FIELDS = ("ts", "order_id", "site", "slot", "event", "progress", "detail")

#: 小程序施工直播通道名（对齐 kb-factory-integration.md「引擎进度事件接同一通道」）
MINIPROGRAM_CHANNEL = "kbfactory_build_live"


class ProgressEvents:
    """引擎进度事件件：emit 一行 JSONL + 透传直播通道占位。

    用法：``pe = ProgressEvents(path, order_id="ORD-1", channel_sink=sink)`` →
    ``pe.emit("wenku", "黄档B.pdf", "collect_done", progress="2/5", detail="...")``。
    事件名词表（orchestrator 消费序）：order_start/plan/red_reject/yellow_gate_closed/
    not_routable/collect_start/collect_done/collect_fail/need_verify/red_recheck_blocked/
    pool_exhausted/budget_stop/browser_close/dispatch_start/dispatch_done/degrade/
    wall_reject/qc/mirror/chain/order_done。
    """

    def __init__(self, path: str | Path, *, order_id: str = "",
                 channel_sink: Callable[[dict], None] | None = None,
                 now: Callable[[], str] | None = None):
        self.path = str(path)
        self.order_id = str(order_id or "")
        self.channel_sink = channel_sink
        self._now = now or (lambda: time.strftime("%Y-%m-%dT%H:%M:%S"))
        self.channel_errors: list[str] = []   # 如实：通道腿异常注记（不外溢）

    def emit(self, site: str, slot: str, event: str, progress=None,
             detail: str = "") -> dict:
        """发一件：写一行 JSONL（返回该行 dict），再透传通道占位（异常不外溢）。"""
        row = {"ts": self._now(), "order_id": self.order_id, "site": str(site or ""),
               "slot": str(slot or ""), "event": str(event or ""),
               "progress": progress, "detail": str(detail or "")}
        Path(self.path).parent.mkdir(parents=True, exist_ok=True)
        with open(self.path, "a", encoding="utf-8") as f:
            f.write(json.dumps(row, ensure_ascii=False) + "\n")
        if self.channel_sink is not None:
            try:
                self.channel_sink(row)
            except Exception as exc:  # 直播通道挂=主链不停（占位腿纪律）
                self.channel_errors.append(f"{type(exc).__name__}: {exc}")
                row["channel_error"] = True
        return row

    def rows(self) -> list:
        """回放已落盘事件（验收/断言用；坏行跳过不炸）。"""
        p = Path(self.path)
        if not p.is_file():
            return []
        out = []
        for line in p.read_text(encoding="utf-8").splitlines():
            line = line.strip()
            if not line:
                continue
            try:
                out.append(json.loads(line))
            except ValueError:
                continue
        return out
