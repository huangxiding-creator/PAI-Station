# -*- coding: utf-8 -*-
"""orchestrator_bridge — 派活引擎 ↔ 注意力经济学操作系统 桥接层。

使命: mission-engine 的所有信号→先走 orchestrator Eval（准入判断），
      通过后才走原有派活链路；审批闸升级为 orchestrator Attention。
      面板/决策历史/Subscription 扇出全部由 orchestrator 提供。

用法:
  # 作为模块被 mission-engine 主循环调用
  from orchestrator_bridge import Bridge
  bridge = Bridge()
  bridge.process_signals()        # 信号→Eval→可能开 Ticket
  bridge.check_organs()           # 器官健康→不健康开 Ticket
  bridge.push_overview()          # 面板数据→企微/微信

  # 命令行
  py orchestrator_bridge.py --loop           # 持续运行(30s轮询)
  py orchestrator_bridge.py --status        # 查看状态
  py orchestrator_bridge.py --demo          # 演示: 信号→Eval→Ticket→执行
"""
from __future__ import annotations

import json
import os
import subprocess
import sys
import time
from pathlib import Path

# 导入 orchestrator
ORCH_ROOT = Path(__file__).resolve().parent.parent / "orchestrator"
sys.path.insert(0, str(ORCH_ROOT))
sys.path.insert(0, str(ORCH_ROOT / "sources"))

from domain import DecisionType, Report, ReportType, Trigger, TicketStage
from engine import Engine
from executor import Executor
from effects import Effects
from outbox import Outbox
from eval import PolicyConfig
from store import Store

# Mission Engine 路径
ME_ROOT = Path(__file__).resolve().parent
ME_ORGANS = ME_ROOT / "organs.json"
ME_LEDGER = ME_ROOT / "ledger" / "run-ledger.jsonl"


def me_log(event: str, detail: dict):
    """写入 mission-engine run-ledger。"""
    ME_LEDGER.parent.mkdir(exist_ok=True)
    row = {"ts": time.strftime("%Y-%m-%d %H:%M:%S"),
           "event": event, "detail": detail}
    with ME_LEDGER.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")


class Bridge:
    """派活引擎 ↔ 注意力经济学操作系统 桥接器。"""

    def __init__(self, max_workers: int = 4):
        self.engine = Engine(policy=PolicyConfig(
            allowed_actors=["user", "system", "signal_bus", "organ_probe"],
            max_concurrent_tickets=max_workers,
        ))
        self.executor = Executor(self.engine.store, max_workers)
        self.effects = Effects(self.engine.store)
        self.outbox = Outbox(self.engine.store)

        # 注册 Effects handlers
        self.effects.register("launch", self._handle_launch)
        self.effects.register("notify", self._handle_notify)
        self.effects.register("organ_restart", self._handle_organ_restart)

        # 注册 Sources
        self._register_signal_source()
        self._register_organ_source()
        self._register_viaim_source()

    # ── Source 注册 ───────────────────────────────────────────

    def _register_signal_source(self):
        """mission-engine 信号总线 → Trigger。"""
        try:
            sig_root = ME_ROOT / "signals"
            if sig_root.exists():
                sys.path.insert(0, str(sig_root))
                from signals.bus import SignalBus
                from signals.adapters import ADAPTERS

                def poll_signals():
                    triggers = []
                    try:
                        bus = SignalBus()
                        for name, adapter_cls in ADAPTERS.items():
                            try:
                                sig = bus.pull(adapter_cls())
                                if sig and sig.get("priority", 0) > 0:
                                    triggers.append(Trigger(
                                        source=f"signal:{name}",
                                        actor="signal_bus",
                                        thread_id=f"sig_{name}",
                                        content=json.dumps(sig, ensure_ascii=False)[:500],
                                        metadata={"signal": sig},
                                        is_human=False,
                                    ))
                            except Exception:
                                pass
                    except Exception:
                        pass
                    return triggers

                self.engine.register_source("signals", poll_signals)
            else:
                # 降级：读取信号快照文件
                snap = ME_ROOT / "ledger" / "signals_snapshot.json"
                def poll_snapshot():
                    if not snap.exists():
                        return []
                    try:
                        data = json.loads(snap.read_text(encoding="utf-8"))
                        return [Trigger(
                            source="signal:snapshot",
                            actor="signal_bus",
                            thread_id="sig_snapshot",
                            content=json.dumps(data)[:500],
                            is_human=False,
                        )]
                    except Exception:
                        return []
                self.engine.register_source("signals", poll_snapshot)
        except ImportError:
            pass

    def _register_organ_source(self):
        """器官健康检查 → 不健康时产生 Trigger。"""
        def poll_organs():
            if not ME_ORGANS.exists():
                return []
            try:
                reg = json.loads(ME_ORGANS.read_text(encoding="utf-8"))
            except (json.JSONDecodeError, OSError):
                return []
            sys.path.insert(0, str(ME_ROOT))
            try:
                from organ_probe import probe_organ
            except ImportError:
                return []
            triggers = []
            for organ in reg.get("organs", []):
                try:
                    result = probe_organ(organ)
                    if not result.get("healthy"):
                        triggers.append(Trigger(
                            source="organ_probe",
                            actor="system",
                            thread_id=f"organ_{organ['id']}",
                            content=f"器官 {organ['id']} 不健康: {result.get('verdict', '?')}",
                            metadata={"organ": organ, "probe": result},
                            is_human=False,
                        ))
                except Exception:
                    pass
            return triggers
        self.engine.register_source("organs", poll_organs)

    def _register_viaim_source(self):
        """viaim 耳机录音 → Trigger。"""
        try:
            from sources.viaim_source import poll as viaim_poll
            self.engine.register_source("viaim", viaim_poll)
        except ImportError:
            pass

    # ── Effects Handlers ──────────────────────────────────────

    def _handle_launch(self, payload: dict):
        """Effect: 启动 Ticket 执行。"""
        ticket_id = payload.get("ticket_id", "")
        result = self.executor.launch(ticket_id)
        if result and result.get("status") == "launched":
            me_log("orch_launch", {
                "ticket_id": ticket_id,
                "title": result["title"],
                "work_dir": result["work_dir"],
            })

    def _handle_notify(self, payload: dict):
        """Effect: 发送通知（走企微/微信）。"""
        self.outbox.queue(
            payload.get("ticket_id", ""),
            payload.get("channel", "wecom"),
            payload.get("purpose", "result"),
            payload.get("content", ""),
        )
        me_log("orch_notify", {"content": payload.get("content", "")[:100]})

    def _handle_organ_restart(self, payload: dict):
        """Effect: 重启不健康器官。"""
        organ = payload.get("organ", {})
        if not organ:
            return
        sys.path.insert(0, str(ME_ROOT))
        try:
            from organ_start import start_organ
            result = start_organ(organ)
            me_log("orch_organ_restart", result)
        except Exception as e:
            me_log("orch_organ_restart_failed", {"error": str(e)[:200]})

    # ── 主循环 ────────────────────────────────────────────────

    def tick(self) -> dict:
        """一轮完整循环：轮询Sources→处理Effects→投递Outbox→返回面板数据。"""
        decisions = self.engine.poll_all()
        self.effects.process()
        self.outbox.flush()

        # accept 的 Ticket 自动入 launch 队列
        for d in decisions:
            if d.type == DecisionType.ACCEPT and d.ticket_id:
                # 器官不健康 → 走 organ_restart 而非普通 launch
                trigger = self.engine.store.get_trigger(d.trigger_id)
                if trigger and trigger.source == "organ_probe":
                    self.effects.enqueue(
                        "organ_restart", d.ticket_id,
                        {"organ": trigger.metadata.get("organ", {})})
                else:
                    self.effects.enqueue(
                        "launch", d.ticket_id,
                        {"ticket_id": d.ticket_id})

        return self.engine.overview()

    def status(self) -> dict:
        """当前状态。"""
        return self.engine.overview()

    def report_complete(self, ticket_id: str, summary: str):
        """外部执行器完成后调用。"""
        self.executor.complete(ticket_id, summary)
        # 自动发通知
        ticket = self.engine.store.get_ticket(ticket_id)
        if ticket:
            self.effects.enqueue("notify", f"done_{ticket_id}", {
                "ticket_id": ticket_id,
                "content": f"✅ {ticket.title} 已完成，请审阅",
            })
            self.effects.process()
            self.outbox.flush()


def run_loop(interval_sec: int = 30):
    """持续运行模式。"""
    bridge = Bridge()
    print(f"🧠 派活引擎×注意力经济学桥接已启动（{interval_sec}s 轮询）")
    print(f"   Sources: {list(bridge.engine._sources.keys())}")
    while True:
        try:
            ov = bridge.tick()
            att = len(ov.get("needs_attention", []))
            wrk = len(ov.get("working", []))
            print(f"  [{time.strftime('%H:%M:%S')}] 待审={att} 执行中={wrk} "
                  f"总计={ov.get('open_count', 0)}")
        except KeyboardInterrupt:
            print("\n👋 桥接已停止")
            break
        except Exception as e:
            print(f"  [error] {e}")
        time.sleep(interval_sec)


def show_status():
    """显示当前状态。"""
    bridge = Bridge()
    ov = bridge.status()
    print(json.dumps(ov, ensure_ascii=False, indent=2))


def demo():
    """演示：模拟信号→Eval→Ticket→执行→完成→通知。"""
    bridge = Bridge()
    print("═══ 演示：信号→Eval→Ticket→执行→通知 ═══\n")

    # 1. 模拟一个信号进来
    trigger = Trigger(
        source="signal:radar", actor="signal_bus",
        thread_id="sig_demo_radar",
        content='{"topic": "EPC培训市场", "priority": 8, "dscore": 0.82}',
        metadata={"title": "雷达信号:EPC培训", "priority": 8},
        is_human=False,
    )
    print(f"1️⃣  信号进来: {trigger.content[:60]}")

    decision = bridge.engine.intake(trigger)
    print(f"2️⃣  Eval: {decision.type.value} ({decision.reason[:60]})")

    if decision.type == DecisionType.ACCEPT:
        bridge.effects.enqueue("launch", decision.ticket_id,
                               {"ticket_id": decision.ticket_id})
        bridge.effects.process()
        print(f"3️⃣  Ticket: {decision.ticket_id[:12]} → 已入执行队列")

        bridge.report_complete(decision.ticket_id, "EPC培训市场调研完成")
        print(f"4️⃣  完成 + 通知已入 Outbox")

    ov = bridge.status()
    print(f"5️⃣  面板: {ov['open_count']} open, "
          f"{len(ov['needs_attention'])} 待审")
    print("\n═══ 演示完毕 ═══")


if __name__ == "__main__":
    import argparse
    ap = argparse.ArgumentParser()
    ap.add_argument("--loop", action="store_true")
    ap.add_argument("--status", action="store_true")
    ap.add_argument("--demo", action="store_true")
    ap.add_argument("--interval", type=int, default=30)
    args = ap.parse_args()

    if args.demo:
        demo()
    elif args.status:
        show_status()
    elif args.loop:
        run_loop(args.interval)
    else:
        ap.print_help()
