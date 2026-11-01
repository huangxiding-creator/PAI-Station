# -*- coding: utf-8 -*-
"""W1-W2 完整验证：Executor+Effects+Outbox+Panel API 全链。"""
import sys, os, json, time
sys.path.insert(0, os.path.dirname(__file__))
sys.path.insert(0, os.path.join(os.path.dirname(__file__), "sources"))

from domain import *
from eval import PolicyConfig
from store import Store
from engine import Engine
from executor import Executor, WorkerSlots
from effects import Effects
from outbox import Outbox


def test_worker_slots():
    """并发槽位管理。"""
    slots = WorkerSlots(max_workers=2)
    assert slots.acquire("t1")
    assert slots.acquire("t2")
    assert not slots.acquire("t3")       # 满了
    assert slots.acquire("t3", is_human_wake=True)  # 人唤醒+1
    slots.release("t1")
    slots.release("t2")
    assert slots.acquire("t4")           # 释放后可入
    print("✅ WorkerSlots 并发控制")


def test_executor_prepare():
    """Executor 工作目录准备。"""
    db = os.path.join(os.path.dirname(__file__), "test_w12.db")
    if os.path.exists(db):
        os.remove(db)
    store = Store(db)
    engine = Engine(db_path=db)
    executor = Executor(engine.store, max_workers=2)

    # 创建 Ticket
    trigger = Trigger(source="wechat", actor="user",
                      thread_id="thr_exec_test",
                      content="开发项目管理AI工具",
                      metadata={"title": "PM AI Tool"})
    decision = engine.intake(trigger)
    assert decision and decision.type == DecisionType.ACCEPT

    # 启动
    ticket = store.get_ticket(decision.ticket_id)
    result = executor.launch(ticket.id)
    assert result["status"] == "launched"
    assert os.path.exists(result["work_dir"])
    assert os.path.exists(result["task_brief"])
    print(f"✅ Executor prepare → {result['work_dir']}")

    # 完成
    executor.complete(ticket.id, "PM AI Tool 开发完成")
    ticket = store.get_ticket(ticket.id)
    assert ticket.latest_report["type"] == "ready"
    print("✅ Executor report ready")

    store.close()
    engine.store.close()
    os.remove(db)


def test_effects_queue():
    """Effects 持久队列。"""
    db = os.path.join(os.path.dirname(__file__), "test_effects.db")
    if os.path.exists(db):
        os.remove(db)
    store = Store(db)
    effects = Effects(store)

    executed = []
    effects.register("test", lambda p: executed.append(p["value"]))

    effects.enqueue("test", "k1", {"value": "hello"})
    effects.enqueue("test", "k2", {"value": "world"})

    count = effects.process()
    assert count == 2
    assert len(executed) == 2
    assert effects.pending_count == 0
    print(f"✅ Effects 队列 → {count} 个已处理")

    # 失败重试
    fail_count = [0]
    def failing_handler(p):
        fail_count[0] += 1
        raise Exception("intentional failure")
    effects.register("fail_test", failing_handler)
    effects.enqueue("fail_test", "k3", {"value": "will_fail"})
    effects.process()  # 第1次失败
    assert fail_count[0] == 1
    print(f"✅ Effects 失败重试 → attempts={fail_count[0]}（退避后重试）")

    store.close()
    os.remove(db)


def test_outbox():
    """Outbox 消息投递。"""
    db = os.path.join(os.path.dirname(__file__), "test_outbox.db")
    if os.path.exists(db):
        os.remove(db)
    store = Store(db)
    outbox = Outbox(store)

    # console channel 测试
    mid = outbox.queue("t1", "console", "test", "Hello from Outbox!")
    sent = outbox.flush()
    assert sent == 1
    print(f"✅ Outbox 投递 → {sent} 条已发送")

    store.close()
    os.remove(db)


def test_full_integration():
    """完整集成：Trigger→Eval→Ticket→Executor→Effects→Outbox→Panel。"""
    db = os.path.join(os.path.dirname(__file__), "test_integration.db")
    if os.path.exists(db):
        os.remove(db)

    engine = Engine(db_path=db)
    engine.policy = PolicyConfig(allowed_actors=["user", "system"])
    executor = Executor(engine.store, max_workers=4)
    effects = Effects(engine.store)
    outbox = Outbox(engine.store)

    # 注册 launch handler
    launched = []
    def handle_launch(payload):
        result = executor.launch(payload["ticket_id"])
        if result and result["status"] == "launched":
            launched.append(result["title"])
    effects.register("launch", handle_launch)

    # 注册 notify handler
    notified = []
    def handle_notify(payload):
        outbox.queue(payload.get("ticket_id", ""),
                     "console", "result", payload.get("content", ""))
        notified.append(payload.get("content", ""))
    effects.register("notify", handle_notify)

    # ── 场景：viaim 录音进来 ──
    trigger = Trigger(
        source="viaim", actor="user",
        thread_id="viaim_demo_001",
        content="开发水利工程项目管理策划AI助手，基于前期资料自动分解工程",
        metadata={"title": "PM Planning AI", "record_id": "demo_r1"},
    )
    decision = engine.intake(trigger)
    assert decision.type == DecisionType.ACCEPT
    print(f"✅ viaim → Eval accept: {decision.ticket_id[:12]}")

    # Effects 启动
    effects.enqueue("launch", decision.ticket_id,
                    {"ticket_id": decision.ticket_id})
    effects.process()
    assert len(launched) == 1
    print(f"✅ Effects launch → {launched[0]}")

    # Executor 完成
    ticket = engine.store.get_ticket(decision.ticket_id)
    executor.complete(ticket.id, "PM Planning AI 开发完成，含工程分解+规范匹配")

    # Effects 通知
    effects.enqueue("notify", f"notify_{ticket.id}",
                    {"ticket_id": ticket.id,
                     "content": f"✅ {ticket.title} 已完成，请审阅"})
    effects.process()
    assert len(notified) == 1
    outbox.flush()
    print(f"✅ Outbox → 通知已投递")

    # Panel 数据
    overview = engine.overview()
    assert overview["open_count"] >= 1
    assert len(overview["needs_attention"]) >= 1  # ready 等审阅
    print(f"✅ Panel → {overview['open_count']} open, "
          f"{len(overview['needs_attention'])} 待审")

    # ── 场景2：Subscription 扇出 ──
    trigger2 = Trigger(
        source="wechat", actor="user",
        thread_id="viaim_demo_001",  # 同线程
        content="补充：要支持阿里云部署",
    )
    engine.intake(trigger2)
    # 原 Ticket 应收到新输入
    ticket = engine.store.get_ticket(decision.ticket_id)
    if ticket.is_open:
        assert len(ticket.inputs) >= 1
        print(f"✅ Subscription 扇出 → {len(ticket.inputs)} 条补充输入")

    engine.store.close()
    os.remove(db)
    print("\n========== W1-W2 全部通过 ==========")


if __name__ == "__main__":
    test_worker_slots()
    test_executor_prepare()
    test_effects_queue()
    test_outbox()
    test_full_integration()
