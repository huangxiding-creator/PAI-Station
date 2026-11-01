# -*- coding: utf-8 -*-
"""Executor 池：管理 Claude Code 子代理作为 Ticket 执行器。

WorkerSlots 并发控制 + 目录准备 + 报告接收。
"""
from __future__ import annotations

import os
import subprocess
from pathlib import Path
from typing import Optional

from domain import (
    Assignment, AssignmentState, Report, ReportType, Ticket, now_ms,
)
from store import Store

WORK_ROOT = Path(__file__).parent / "work"


class WorkerSlots:
    """并发槽位管理。人消息优先>新启动。"""

    def __init__(self, max_workers: int = 4):
        self.max = max_workers
        self._active: set[str] = set()  # ticket_ids

    def acquire(self, ticket_id: str, is_human_wake: bool = False) -> bool:
        if ticket_id in self._active:
            return True
        limit = self.max + (1 if is_human_wake else 0)
        if len(self._active) < limit:
            self._active.add(ticket_id)
            return True
        return False

    def release(self, ticket_id: str):
        self._active.discard(ticket_id)

    @property
    def active_count(self) -> int:
        return len(self._active)


class Executor:
    """执行器：管理 Ticket 的工作目录和子代理执行。"""

    def __init__(self, store: Store, max_workers: int = 4):
        self.store = store
        self.slots = WorkerSlots(max_workers)
        WORK_ROOT.mkdir(exist_ok=True)

    def prepare(self, ticket: Ticket) -> Path:
        """为 Ticket 创建工作目录（类似 dsh-superagent 的 prepare command）。"""
        short = ticket.id.replace("tkt_", "")[:8]
        work_dir = WORK_ROOT / f"ticket-{short}"
        work_dir.mkdir(exist_ok=True)

        # 写入任务说明书
        brief = work_dir / "TASK.md"
        trigger = self.store.get_trigger(ticket.origin_trigger_id)
        content = trigger.content if trigger else ticket.title
        brief.write_text(
            f"# {ticket.title}\n\n"
            f"## 来源\n{ticket.mandate.source if ticket.mandate else 'unknown'}\n\n"
            f"## 原始请求\n{content}\n\n"
            f"## 授权范围\n"
            f"- 强度: {ticket.mandate.strength if ticket.mandate else '?'}\n"
            f"- 范围: {ticket.mandate.scope if ticket.mandate else '?'}\n"
            f"- 规则: {ticket.mandate.matched_rules if ticket.mandate else []}\n\n"
            f"## 补充输入\n" +
            "\n".join(f"- {i.get('content', '')[:100]}" for i in ticket.inputs) +
            "\n",
            encoding="utf-8")
        return work_dir

    def launch(self, ticket_id: str) -> Optional[dict]:
        """启动 Ticket 执行（分配槽位+准备目录+返回执行指令）。"""
        ticket = self.store.get_ticket(ticket_id)
        if not ticket or not ticket.is_open:
            return None

        if not self.slots.acquire(ticket_id):
            return {"status": "queued", "reason": "no_free_slot"}

        work_dir = self.prepare(ticket)

        # 更新 Assignment 为 RUNNING
        a = ticket.latest_assignment
        if a and a.state == AssignmentState.PENDING:
            a.state = AssignmentState.RUNNING
            a.started_at = now_ms()
            self.store.save_ticket(ticket)

        # 构造子代理执行指令（由调用方 spawn Claude Code subagent）
        return {
            "status": "launched",
            "ticket_id": ticket_id,
            "title": ticket.title,
            "work_dir": str(work_dir),
            "task_brief": str(work_dir / "TASK.md"),
            "instruction": (
                f"执行任务「{ticket.title}」。"
                f"读取 {work_dir}/TASK.md 了解完整需求。"
                f"在 {work_dir} 目录内完成工作。"
                f"完成后用 executor.report() 汇报结果。"
            ),
        }

    def complete(self, ticket_id: str, summary: str, attention: str = None):
        """Executor 完成，汇报 ready。"""
        self.report(ticket_id, ReportType.READY, summary, attention)

    def report(self, ticket_id: str, rtype: ReportType,
               summary: str, attention: str = None):
        """接收 Executor 汇报。"""
        ticket = self.store.get_ticket(ticket_id)
        if not ticket:
            return
        a = ticket.latest_assignment
        if not a:
            return
        a.last_report = Report(
            assignment_id=a.id, type=rtype,
            summary=summary, attention=attention,
        ).to_dict()

        if rtype == ReportType.DROPPED:
            ticket.outcome = "dropped"
            ticket.ended_at = now_ms()
            self.slots.release(ticket_id)

        self.store.save_ticket(ticket)

    def blocked(self, ticket_id: str, reason: str):
        self.report(ticket_id, ReportType.BLOCKED, reason)

    def waiting(self, ticket_id: str):
        """Executor 空闲，释放槽位但 Ticket 保持 open。"""
        self.report(ticket_id, ReportType.WAITING, "等待新输入")
        self.slots.release(ticket_id)
