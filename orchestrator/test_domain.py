# -*- coding: utf-8 -*-
"""注意力经济学操作系统 · 快速验证"""
import sys, os
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "sources"))

from domain import *
from eval import PolicyConfig, evaluate, create_ticket_from_decision, GateResult, gate_check
from store import Store
from engine import Engine

def test_domain_model():
    """领域模型完整性。"""
    t = Trigger(source="viaim", actor="user", content="开发项目管理AI工具",
                thread_id="thr_test", metadata={"record_id": "r1"})
    assert t.source == "viaim"
    assert t.is_human == True

    ticket = Ticket(title="测试", mandate=Mandate(scope="full"))
    assert ticket.is_open
    assert ticket.stage() == TicketStage.WORKING_QUEUED
    print("✅ 领域模型")

def test_gate():
    """Gate 确定性检查。"""
    policy = PolicyConfig(allowed_actors=["user", "system"])
    t = Trigger(source="wechat", actor="user", content="做一份报告", is_human=True)
    g = gate_check(t, policy, [])
    assert g.passed and g.strength == Strength.EXPLICIT

    t2 = Trigger(source="wechat", actor="intruder", content="hack")
    g2 = gate_check(t2, policy, [])
    assert not g2.passed
    print("✅ Gate 准入")

def test_full_pipeline():
    """完整管线：Trigger → Eval → Ticket → Stage → Report → End。"""
    db = os.path.join(os.path.dirname(__file__), "test_state.db")
    if os.path.exists(db):
        os.remove(db)

    engine = Engine(db_path=db)
    engine.policy = PolicyConfig(allowed_actors=["user"])

    # 1. 模拟微信消息进来
    trigger = Trigger(
        source="wechat", actor="user",
        thread_id="wx_test_001",
        content="帮我做一份EPC招投标合规研究报告",
        metadata={"chat_id": "test_chat"},
    )

    decision = engine.intake(trigger)
    assert decision is not None
    assert decision.type == DecisionType.ACCEPT
    assert decision.ticket_id is not None
    print(f"✅ Eval accept → Ticket {decision.ticket_id[:12]}")

    # 2. 检查 Ticket 状态
    ticket = engine.store.get_ticket(decision.ticket_id)
    assert ticket.is_open
    assert ticket.stage() == TicketStage.WORKING_QUEUED

    # 3. 启动 Assignment
    a = engine.start_assignment(ticket.id)
    assert a.state == AssignmentState.RUNNING
    ticket = engine.store.get_ticket(ticket.id)  # 重新取
    assert ticket.stage() == TicketStage.WORKING
    print(f"✅ Assignment 启动 → {ticket.stage().value}")

    # 4. Executor 汇报 ready
    engine.report(ticket.id, Report(
        assignment_id=a.id, type=ReportType.READY,
        summary="报告完成"))
    ticket = engine.store.get_ticket(ticket.id)
    assert ticket.stage() == TicketStage.PERSON_REVIEW
    print(f"✅ Report ready → {ticket.stage().value}")

    # 5. 面板显示需要审阅
    overview = engine.overview()
    assert len(overview["needs_attention"]) == 1
    print(f"✅ 面板: {len(overview['needs_attention'])} 待审")

    # 6. 完成
    ticket.outcome = "completed"
    ticket.ended_at = now_ms()
    engine.store.save_ticket(ticket)
    ticket = engine.store.get_ticket(ticket.id)
    assert not ticket.is_open
    print("✅ Ticket 完成")

    # 7. Subscription 扇出测试
    trigger2 = Trigger(
        source="viaim", actor="user",
        thread_id="wx_test_001",  # 同一线程
        content="补充：还要包含2026年新规",
    )
    # 先建一个活跃 Ticket 订阅该线程（双向：ticket→thread + thread→ticket）
    t3 = Ticket(title="BID26", subscriptions=["wx_test_001"])
    engine.store.save_ticket(t3)
    thread = engine.store.get_thread("wx_test_001")
    if thread:
        thread.subscriptions.append(t3.id)
        engine.store.save_thread(thread)
    engine.intake(trigger2)
    t3 = engine.store.get_ticket(t3.id)
    assert len(t3.inputs) >= 1  # 扇出已推入
    print(f"✅ Subscription 扇出 → {len(t3.inputs)} 条 input")

    engine.store.close()
    os.remove(db)
    print("\n========== 全部通过 ==========")


if __name__ == "__main__":
    test_domain_model()
    test_gate()
    test_full_pipeline()
