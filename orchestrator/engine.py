# -*- coding: utf-8 -*-
"""Engine：注意力经济学操作系统的核心编排器。

流程: Source.poll() → Engine.intake() → Gate → Assessment → Decision
      → accept ? create Ticket : record Decision
      → Ticket → Executor (Claude Code subagent)
      → Report → Channel (WeChat/WeCom)
"""
from __future__ import annotations

import time
from typing import Optional

from domain import (
    Assignment, AssignmentState, Decision, DecisionType, Report,
    ReportType, Strength, Thread, Ticket, Trigger, now_ms,
)
from eval import Assessor, PolicyConfig, create_ticket_from_decision, evaluate
from store import Store


class Engine:
    """唯一写入者：Trigger/Thread/Decision/Ticket/Assignment。"""

    def __init__(self, db_path=None, policy: PolicyConfig = None):
        self.store = Store(db_path)
        self.policy = policy or PolicyConfig()
        self.assessor = Assessor()
        self._sources: dict[str, callable] = {}

    def register_source(self, name: str, poll_fn: callable):
        """注册一个 Source 的 poll 函数。"""
        self._sources[name] = poll_fn

    # ── Intake ─────────────────────────────────────────────────

    def intake(self, trigger: Trigger) -> Optional[Decision]:
        """接收 Trigger → 存储线程 → Eval → 可能创建 Ticket。"""
        # 存储 Trigger（幂等）
        if not self.store.save_trigger(trigger):
            return None  # 重复

        # 确保线程存在
        thread = self.store.get_thread(trigger.thread_id)
        if not thread:
            thread = Thread(id=trigger.thread_id, source=trigger.source,
                           label=trigger.metadata.get("title", trigger.content[:40]))
            self.store.save_thread(thread)

        # Subscription 扇出：将 Trigger 推给订阅了该线程的活跃 Ticket
        self._fan_out(trigger, thread)

        # Eval
        decision = evaluate(self.store, self.policy, trigger, self.assessor)
        self.store.save_decision(decision)

        if decision.type == DecisionType.ACCEPT:
            ticket = create_ticket_from_decision(
                self.store, decision, trigger,
                title=trigger.metadata.get("title", trigger.content[:50]))
            # 双向订阅：ticket→thread 已在 create 中设置，此处补 thread→ticket
            if ticket.id not in thread.subscriptions:
                thread.subscriptions.append(ticket.id)
                self.store.save_thread(thread)
            return decision

        return decision

    def _fan_out(self, trigger: Trigger, thread: Thread):
        """将 Trigger 推给订阅了该线程的活跃 Ticket 的 inputs。"""
        for ticket_id in thread.subscriptions:
            ticket = self.store.get_ticket(ticket_id)
            if ticket and ticket.is_open:
                ticket.inputs.append({
                    "trigger_id": trigger.id,
                    "content": trigger.content[:200],
                    "ts": trigger.ts,
                })
                self.store.save_ticket(ticket)

    # ── Executor 对接 ──────────────────────────────────────────

    def start_assignment(self, ticket_id: str) -> Optional[Assignment]:
        """启动 Ticket 的 Assignment（分配给 Executor）。"""
        ticket = self.store.get_ticket(ticket_id)
        if not ticket or not ticket.is_open:
            return None
        a = Assignment(
            ticket_id=ticket_id,
            state=AssignmentState.RUNNING,
            started_at=now_ms(),
        )
        ticket.assignments.append(a)
        self.store.save_ticket(ticket)
        return a

    def report(self, ticket_id: str, report: Report):
        """Executor 汇报状态。"""
        ticket = self.store.get_ticket(ticket_id)
        if not ticket:
            return
        a = ticket.latest_assignment
        if a:
            a.last_report = report.to_dict()

        # dropped → 结束 Ticket
        if report.type == ReportType.DROPPED:
            ticket.outcome = "dropped"
            ticket.ended_at = now_ms()

        # ready + 无 follow 线程 → 完成
        if report.type == ReportType.READY and not ticket.subscriptions:
            ticket.outcome = "completed"
            ticket.ended_at = now_ms()

        self.store.save_ticket(ticket)

    # ── 人工操作 ───────────────────────────────────────────────

    def stop_ticket(self, ticket_id: str, reason: str = ""):
        """用户停止 Ticket。"""
        ticket = self.store.get_ticket(ticket_id)
        if ticket:
            ticket.outcome = f"stopped:{reason}"
            ticket.ended_at = now_ms()
            self.store.save_ticket(ticket)

    def retry_ticket(self, ticket_id: str) -> Optional[Assignment]:
        """重试阻塞/失败的 Ticket。"""
        ticket = self.store.get_ticket(ticket_id)
        if not ticket or not ticket.is_open:
            return None
        rpt = ticket.latest_report
        if rpt and rpt.get("type") in ("blocked", "failed"):
            return self.start_assignment(ticket_id)
        return None

    # ── Poll 循环 ──────────────────────────────────────────────

    def poll_all(self) -> list[Decision]:
        """轮询所有 Source，处理新 Trigger。"""
        decisions = []
        for name, poll_fn in self._sources.items():
            try:
                triggers = poll_fn()
                for trigger in triggers:
                    d = self.intake(trigger)
                    if d:
                        decisions.append(d)
            except Exception as e:
                pass  # Source 失败不影响其他 Source
        return decisions

    # ── 面板数据 ───────────────────────────────────────────────

    def needs_attention(self) -> list[dict]:
        """需要人决策的 Ticket 列表。"""
        result = []
        for t in self.store.open_tickets():
            stage = t.stage()
            if stage.value.startswith("person/"):
                result.append({
                    "id": t.id, "title": t.title, "stage": stage.value,
                    "report": t.latest_report,
                })
        return result

    def working_tickets(self) -> list[dict]:
        return [
            {"id": t.id, "title": t.title, "stage": t.stage().value}
            for t in self.store.open_tickets()
            if t.stage().value in ("working", "working/queued")
        ]

    def overview(self) -> dict:
        """面板首页数据。"""
        return {
            "needs_attention": self.needs_attention(),
            "working": self.working_tickets(),
            "open_count": len(self.store.open_tickets()),
            "policy_version": self.policy.version,
        }
