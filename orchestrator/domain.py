# -*- coding: utf-8 -*-
"""注意力经济学操作系统 · 核心领域模型

移植自 dsh-superagent-prototype（MIT），适配 Claude Code + Python。

领域概念（按依赖顺序）:
  Source → Trigger → Thread → Eval → Mandate → Ticket → Assignment → Executor

核心原则: Take as little human attention as possible, give as much value as possible.
"""
from __future__ import annotations

import time
import uuid
from dataclasses import dataclass, field
from enum import Enum
from typing import Any, Optional


def now_ms() -> int:
    return int(time.time() * 1000)


def new_id(prefix: str = "") -> str:
    return f"{prefix}{uuid.uuid4().hex[:16]}"


# ── 枚举 ──────────────────────────────────────────────────────────

class DecisionType(str, Enum):
    ACCEPT = "accept"
    STOP = "stop"
    IGNORE = "ignore"
    UNAVAILABLE = "unavailable"


class Strength(str, Enum):
    EXPLICIT = "explicit"      # 明确指令（用户直接说）
    INFERRED = "inferred"      # 推断（定时任务/自动触发）


class TicketStage(str, Enum):
    PERSON_DELIVERY = "person/delivery"    # Input 未送达
    PERSON_ANSWER = "person/answer"        # 有 Attention 等人回答
    PERSON_REVIEW = "person/review"        # ready 等审阅
    PERSON_BLOCKED = "person/blocked"      # blocked/failed
    WORKING_QUEUED = "working/queued"      # 排队
    IDLE = "idle"                          # 等 Trigger
    WORKING = "working"                    # 执行中
    ENDED = "ended"                        # 已结束


class AssignmentState(str, Enum):
    PENDING = "pending"
    RUNNING = "running"
    ENDED = "ended"


class ReportType(str, Enum):
    PROGRESS = "progress"
    WAITING = "waiting"
    READY = "ready"
    BLOCKED = "blocked"
    FAILED = "failed"
    DROPPED = "dropped"


class Outcome(str, Enum):
    COMPLETED = "completed"
    MERGED = "merged"
    CLOSED = "closed"
    STOPPED = "stopped"
    DROPPED = "dropped"


# ── 数据类 ─────────────────────────────────────────────────────────

@dataclass
class Trigger:
    """一个不可变事件。审计与幂等的最小单位。"""
    id: str = field(default_factory=lambda: new_id("trg_"))
    source: str = ""                    # Source 名称（viaim/wechat/wecom/github/scheduled/manual）
    actor: str = ""                     # 谁触发的（用户ID/系统名）
    thread_id: str = ""                 # 所属线程
    content: str = ""                   # 内容
    metadata: dict = field(default_factory=dict)
    ts: int = field(default_factory=now_ms)
    is_human: bool = True              # 人类消息 vs 系统/CI

    def to_dict(self) -> dict:
        return {
            "id": self.id, "source": self.source, "actor": self.actor,
            "thread_id": self.thread_id, "content": self.content,
            "metadata": self.metadata, "ts": self.ts, "is_human": self.is_human,
        }

    @classmethod
    def from_dict(cls, d: dict) -> "Trigger":
        return cls(**d)


@dataclass
class Thread:
    """按时间排序的 Trigger 流。Eval 的执行单位。"""
    id: str = field(default_factory=lambda: new_id("thr_"))
    source: str = ""
    label: str = ""                     # 显示名
    subscriptions: list[str] = field(default_factory=list)  # ticket_ids
    queued_triggers: list[str] = field(default_factory=list)
    metadata: dict = field(default_factory=dict)
    created_at: int = field(default_factory=now_ms)

    def to_dict(self) -> dict:
        return {
            "id": self.id, "source": self.source, "label": self.label,
            "subscriptions": self.subscriptions,
            "queued_triggers": self.queued_triggers,
            "metadata": self.metadata, "created_at": self.created_at,
        }


@dataclass
class Mandate:
    """Eval 接受时授予的权限。不可变。"""
    policy_version: str = ""
    scope: str = ""                     # read/write/deploy/full
    strength: Strength = Strength.EXPLICIT
    matched_rules: list[str] = field(default_factory=list)
    sender_id: str = ""
    source: str = ""
    granted_at: int = field(default_factory=now_ms)

    def to_dict(self) -> dict:
        strength_val = self.strength.value if hasattr(self.strength, "value") else str(self.strength)
        return {
            "policy_version": self.policy_version, "scope": self.scope,
            "strength": strength_val, "matched_rules": self.matched_rules,
            "sender_id": self.sender_id, "source": self.source,
            "granted_at": self.granted_at,
        }


@dataclass
class Assignment:
    """Ticket 与 Executor 的绑定。独立于 Ticket 的生命周期。"""
    id: str = field(default_factory=lambda: new_id("asg_"))
    ticket_id: str = ""
    executor_id: str = ""
    state: AssignmentState = AssignmentState.PENDING
    started_at: Optional[int] = None
    ended_at: Optional[int] = None
    last_report: Optional[dict] = None  # 最新 Report

    def to_dict(self) -> dict:
        state_val = self.state.value if hasattr(self.state, "value") else str(self.state)
        return {
            "id": self.id, "ticket_id": self.ticket_id,
            "executor_id": self.executor_id,
            "state": state_val,
            "started_at": self.started_at, "ended_at": self.ended_at,
            "last_report": self.last_report,
        }


@dataclass
class Report:
    """Executor 向 Ticket 汇报的状态。"""
    assignment_id: str = ""
    type: ReportType = ReportType.PROGRESS
    summary: str = ""
    attention: Optional[str] = None     # 需要人回答的问题
    ts: int = field(default_factory=now_ms)

    def to_dict(self) -> dict:
        return {
            "assignment_id": self.assignment_id,
            "type": self.type.value, "summary": self.summary,
            "attention": self.attention, "ts": self.ts,
        }


@dataclass
class Ticket:
    """一个被授权的工作单元。"""
    id: str = field(default_factory=lambda: new_id("tkt_"))
    title: str = ""
    mandate: Optional[Mandate] = None
    origin_trigger_id: str = ""
    assignments: list[Assignment] = field(default_factory=list)
    subscriptions: list[str] = field(default_factory=list)  # thread_ids
    inputs: list[dict] = field(default_factory=list)         # 送达的 Trigger
    outcome: Optional[str] = None                            # ended 时的结果
    created_at: int = field(default_factory=now_ms)
    ended_at: Optional[int] = None

    @property
    def is_open(self) -> bool:
        return self.ended_at is None

    @property
    def latest_assignment(self) -> Optional[Assignment]:
        return self.assignments[-1] if self.assignments else None

    @property
    def latest_report(self) -> Optional[dict]:
        a = self.latest_assignment
        return a.last_report if a else None

    def stage(self) -> TicketStage:
        """从上到下首个匹配的行生效。"""
        if not self.is_open:
            return TicketStage.ENDED
        rpt = self.latest_report
        if rpt:
            if rpt.get("type") == ReportType.READY.value:
                return TicketStage.PERSON_REVIEW
            if rpt.get("type") in (ReportType.BLOCKED.value, ReportType.FAILED.value):
                return TicketStage.PERSON_BLOCKED
            if rpt.get("type") == ReportType.WAITING.value:
                return TicketStage.IDLE
            if rpt.get("attention"):
                return TicketStage.PERSON_ANSWER
        a = self.latest_assignment
        if a is None or a.state == AssignmentState.PENDING:
            return TicketStage.WORKING_QUEUED
        if a.state == AssignmentState.ENDED:
            return TicketStage.IDLE
        return TicketStage.WORKING

    def to_dict(self) -> dict:
        return {
            "id": self.id, "title": self.title,
            "mandate": self.mandate.to_dict() if self.mandate else None,
            "origin_trigger_id": self.origin_trigger_id,
            "assignments": [a.to_dict() for a in self.assignments],
            "subscriptions": self.subscriptions,
            "inputs": self.inputs,
            "outcome": self.outcome,
            "created_at": self.created_at, "ended_at": self.ended_at,
        }


@dataclass
class Decision:
    """Eval 的判断结果。"""
    id: str = field(default_factory=lambda: new_id("dec_"))
    trigger_id: str = ""
    thread_id: str = ""
    type: DecisionType = DecisionType.IGNORE
    strength: Strength = Strength.EXPLICIT
    reason: str = ""
    ticket_id: Optional[str] = None     # accept 时创建的 Ticket
    ts: int = field(default_factory=now_ms)

    def to_dict(self) -> dict:
        return {
            "id": self.id, "trigger_id": self.trigger_id,
            "thread_id": self.thread_id, "type": self.type.value,
            "strength": self.strength.value, "reason": self.reason,
            "ticket_id": self.ticket_id, "ts": self.ts,
        }


# ── 状态机辅助 ─────────────────────────────────────────────────────

def ticket_stage(ticket: Ticket) -> str:
    """供外部调用的便捷函数。"""
    return ticket.stage().value


def waits_for_person(ticket: Ticket) -> bool:
    """最新 Report 是 blocked/failed 且无人类消息。"""
    rpt = ticket.latest_report
    if not rpt:
        return False
    return rpt.get("type") in (ReportType.BLOCKED.value, ReportType.FAILED.value)
