# -*- coding: utf-8 -*-
"""Eval 准入引擎：Gate（确定性）+ Assessment（模型判断）。

Gate 零 LLM 成本：检查 actor 权限/预算/优先级/时段。
Assessment 用便宜模型判断值不值得做。
"""
from __future__ import annotations

from dataclasses import dataclass, field
from typing import Optional

from domain import (
    Decision, DecisionType, Mandate, Strength, Thread, Ticket, Trigger,
)
from store import Store


# ── Policy ─────────────────────────────────────────────────────────

@dataclass
class PolicyConfig:
    """版本化的策略配置。"""
    version: str = "v1"
    allowed_actors: list[str] = field(default_factory=lambda: ["user", "system"])
    max_concurrent_tickets: int = 4
    peak_hours: tuple[int, int] = (14, 18)   # 峰谷时段（避大 Token）
    auto_accept_inferred: bool = True         # 自动接受推断工作
    priority_rules: dict = field(default_factory=dict)

    def is_actor_allowed(self, actor: str) -> bool:
        return actor in self.allowed_actors

    def to_dict(self) -> dict:
        return {
            "version": self.version,
            "allowed_actors": self.allowed_actors,
            "max_concurrent_tickets": self.max_concurrent_tickets,
            "peak_hours": list(self.peak_hours),
            "auto_accept_inferred": self.auto_accept_inferred,
        }


# ── Gate（确定性检查，零 LLM） ─────────────────────────────────────

@dataclass
class GateResult:
    passed: bool
    strength: Strength = Strength.EXPLICIT
    reason: str = ""


def gate_check(trigger: Trigger, policy: PolicyConfig,
               open_tickets: list[Ticket]) -> GateResult:
    """确定性准入检查。"""
    # 1. Actor 权限
    if not policy.is_actor_allowed(trigger.actor):
        return GateResult(False, reason=f"actor_not_allowed:{trigger.actor}")

    # 2. 并发限制
    working = [t for t in open_tickets if t.stage().value in ("working", "working/queued")]
    if len(working) >= policy.max_concurrent_tickets:
        return GateResult(False, reason=f"concurrency_limit:{len(working)}")

    # 3. 峰谷时段（推断工作避开高峰）
    import datetime
    hour = datetime.datetime.now().hour
    is_peak = policy.peak_hours[0] <= hour < policy.peak_hours[1]
    if is_peak and trigger.source in ("scheduled",):
        return GateResult(False, reason=f"peak_hour_defer:{hour}")

    # 4. 强度判定
    if trigger.is_human and trigger.source in ("wechat", "viaim", "manual", "wecom"):
        return GateResult(True, Strength.EXPLICIT, "direct_human_request")
    if trigger.source in ("scheduled", "github"):
        if not policy.auto_accept_inferred:
            return GateResult(True, Strength.INFERRED, "recorded_not_accepted")
        return GateResult(True, Strength.INFERRED, "auto_rule_match")

    return GateResult(True, Strength.INFERRED, "default_pass")


# ── Assessment（模型判断接口） ──────────────────────────────────────

class Assessor:
    """评估器接口。子类实现 assess()。"""

    def assess(self, trigger: Trigger, thread: Optional[Thread],
               related_tickets: list[Ticket]) -> Optional[str]:
        """返回评估意见（字符串），或 None 表示无法判断。
        默认实现：简单关键词匹配（生产可替换为 LLM 调用）。"""
        content = trigger.content.lower()
        if any(kw in content for kw in ("做", "开发", "生成", "创建", "修复", "清理",
                                          "报告", "分析", "调研", "部署", "发布")):
            return f"actionable_request: {trigger.content[:80]}"
        return f"informational: {trigger.content[:80]}"


# ── Eval 主流程 ─────────────────────────────────────────────────────

def evaluate(store: Store, policy: PolicyConfig,
             trigger: Trigger, assessor: Assessor = None) -> Decision:
    """完整的 Eval 流程：Gate → Assessment → Decision。"""
    # Gate
    gate = gate_check(trigger, policy, store.open_tickets())
    if not gate.passed:
        return Decision(
            trigger_id=trigger.id, thread_id=trigger.thread_id,
            type=DecisionType.IGNORE, strength=gate.strength,
            reason=gate.reason)

    # Assessment
    if assessor is None:
        assessor = Assessor()
    related = store.open_tickets()
    assessment = assessor.assess(trigger, None, related)

    # Decision
    if gate.strength == Strength.EXPLICIT or (
        gate.strength == Strength.INFERRED and policy.auto_accept_inferred
    ):
        return Decision(
            trigger_id=trigger.id, thread_id=trigger.thread_id,
            type=DecisionType.ACCEPT, strength=gate.strength,
            reason=f"gate={gate.reason}; assessment={assessment}")

    return Decision(
        trigger_id=trigger.id, thread_id=trigger.thread_id,
        type=DecisionType.IGNORE, strength=gate.strength,
        reason=f"gate_pass_but_not_accepted; assessment={assessment}")


def create_ticket_from_decision(store: Store, decision: Decision,
                                 trigger: Trigger, title: str = "") -> Ticket:
    """Accept Decision → 创建 Ticket + Mandate + 首个 Assignment。"""
    mandate = Mandate(
        policy_version="v1",
        scope="full" if decision.strength == Strength.EXPLICIT else "read",
        strength=decision.strength,
        matched_rules=[decision.reason],
        sender_id=trigger.actor,
        source=trigger.source,
    )
    ticket = Ticket(
        title=title or trigger.content[:60],
        mandate=mandate,
        origin_trigger_id=trigger.id,
        subscriptions=[trigger.thread_id],
    )
    from domain import Assignment, AssignmentState
    ticket.assignments.append(Assignment(
        ticket_id=ticket.id, state=AssignmentState.PENDING))
    store.save_ticket(ticket)
    decision.ticket_id = ticket.id
    store.save_decision(decision)
    return ticket
