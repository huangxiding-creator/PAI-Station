"""M3.2 打扰预算+置信分档（04 卷）：打扰是成本，晨报是默认出口。

时机与内容分离（FingerTip20K 洞见）：内容置信度决定建不建卡，
急迫度（deadline 距今）+当日剩余预算决定"现在打扰"还是"进晨报"。
日预算硬顶：宁可晚四小时，不可一天骚扰五次以上。
"""
from __future__ import annotations

from datetime import datetime


class InterruptionBudget:
    def __init__(self, daily_immediate_cap: int = 5,
                 urgent_hours: float = 24.0, min_confidence: float = 0.6):
        self._cap = daily_immediate_cap
        self._urgent_hours = urgent_hours
        self._min_conf = min_confidence
        self._day = None
        self._used = 0

    def should_notify_now(self, card, now: datetime | None = None) -> bool:
        now = now or datetime.now()
        today = now.date()
        if self._day != today:  # 跨天重置
            self._day, self._used = today, 0
        if self._used >= self._cap:
            return False                    # 日预算硬顶
        if card.confidence < self._min_conf:
            return False                    # 低置信只进晨报
        if card.deadline is None:
            return False                    # 无截止=不急迫
        hours = (card.deadline - now).total_seconds() / 3600
        if hours <= self._urgent_hours:     # 含已逾期
            self._used += 1
            return True
        return False

    def build_digest(self, cards: list, now: datetime | None = None) -> str:
        now = now or datetime.now()
        pending = sorted(
            (c for c in cards if c.status == "proposed"),
            key=lambda c: (c.deadline is None, c.deadline or now, -c.confidence))
        if not pending:
            return ""
        lines = [f"📰 PAI 晨报 · {now:%Y-%m-%d}", f"今天待确认 {len(pending)} 件：", ""]
        for i, c in enumerate(pending, start=1):
            if c.deadline:
                lines.append(f"{i}. [截止 {c.deadline:%m-%d %H:%M}] "
                             f"{c.title}（{c.owner}｜置信 {c.confidence:.2f}）")
            else:
                lines.append(f"{i}. [无截止] {c.title}"
                             f"（{c.owner}｜置信 {c.confidence:.2f}）")
        lines += ["", "回复序号确认执行（如「1 3」），回复「x 序号」拒绝。"]
        return "\n".join(lines)
