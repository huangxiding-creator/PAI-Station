# -*- coding: utf-8 -*-
"""护栏层（每动作强制）：熔断文件 / 静默时段 / 冷却 / 动作台账。

对应 ARCHITECTURE.md §5.5 Guardian 的进程内快速检查层
（完整版 Guardian 是独立进程+票据，本层是 worker 侧的最后防线）。
"""
from __future__ import annotations

import json
import time
from datetime import datetime, time as dtime
from pathlib import Path

# ---- 可配置（保守默认，只允许收紧） ----
KILL_FILE = Path(r"C:\zb-ops\runtime\breaker.on")   # 存在即熔断（任何人可建）
JOURNAL = Path(r"C:\zb-ops\logs\rpa_actions.jsonl")  # append-only 动作台账
QUIET_START, QUIET_END = dtime(20, 30), dtime(8, 30)  # 静默时段（默认禁输入动作）
CHAT_COOLDOWN_SEC = 300          # 同一会话两次动作最小间隔
MAX_ACTIONS_PER_DAY = 25         # 全局日上限（架构裁定 §7）

# ---- 永不做清单（能力不存在，任何配置不可解锁） ----
FORBIDDEN = (
    "点赞", "评论他人", "自动加好友", "群发陌生人",
    "朋友圈自动发表", "处理验证码/滑块",
)


class Blocked(Exception):
    """护栏拒绝（含原因）。"""


def check_kill_switch() -> None:
    if KILL_FILE.exists():
        raise Blocked(f"熔断文件存在: {KILL_FILE}（删除该文件并人工 re-arm 后恢复）")


def check_quiet_hours(now=None) -> None:
    t = (now or datetime.now()).time()
    in_quiet = t >= QUIET_START or t < QUIET_END
    if in_quiet:
        raise Blocked(f"静默时段 {QUIET_START}-{QUIET_END}，输入动作禁止")


def check_action(chat: str, action: str = "send") -> None:
    """发送前的全套检查：熔断→静默→冷却→日限额→禁词。"""
    check_kill_switch()
    text = f"{chat} {action}"
    for w in FORBIDDEN:
        if w in text:
            raise Blocked(f"永不做清单命中: {w}")
    if action == "send":
        check_quiet_hours()
        st = _state()
        today = datetime.now().strftime("%Y-%m-%d")
        if st.get("day") != today:
            st.update(day=today, count=0, chats={})
        if st["count"] >= MAX_ACTIONS_PER_DAY:
            raise Blocked(f"全局日上限 {MAX_ACTIONS_PER_DAY} 已达")
        last = st["chats"].get(chat, 0)
        if time.time() - last < CHAT_COOLDOWN_SEC:
            raise Blocked(f"会话 {chat} 冷却中（剩余 {int(CHAT_COOLDOWN_SEC - (time.time() - last))}s）")


def record_action(chat: str, action: str, detail: dict) -> None:
    """登记动作（通过检查后、执行前调用；结果字段事后回填）。"""
    JOURNAL.parent.mkdir(parents=True, exist_ok=True)
    row = {"ts": datetime.now().isoformat(timespec="seconds"),
           "chat": chat, "action": action, **detail}
    with JOURNAL.open("a", encoding="utf-8") as f:
        f.write(json.dumps(row, ensure_ascii=False) + "\n")
    st = _state()
    st["count"] = st.get("count", 0) + 1
    st["chats"] = st.get("chats", {})
    st["chats"][chat] = time.time()
    _save_state(st)


_STATE = Path(r"C:\zb-ops\runtime\rpa_state.json")


def _state() -> dict:
    if _STATE.exists():
        return json.loads(_STATE.read_text(encoding="utf-8"))
    return {"day": "", "count": 0, "chats": {}}


def _save_state(st: dict) -> None:
    _STATE.parent.mkdir(parents=True, exist_ok=True)
    _STATE.write_text(json.dumps(st, ensure_ascii=False), encoding="utf-8")
