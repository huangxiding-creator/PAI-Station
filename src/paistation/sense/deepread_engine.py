"""深读引擎（M10，PROPOSAL_V2.md 第 6 章）：tick 状态机 + 状态持久化。

组合安全脑（deepread.py）成可部署引擎：外部循环每分钟 tick(now)。
reader_fn(guard, watermark) 注入真实视觉读取；缺席时零动作（安全默认）。
状态：data/deepread.state.json（last_run_date/reminded_date/watermark/
tripped/streak/stopped_date）。
"""
from __future__ import annotations

import json
import logging
import os
import tempfile
from datetime import datetime, timedelta
from pathlib import Path

from .deepread import BudgetGuard, CircuitBreaker, NightWindow, Presence, Reminder

_log = logging.getLogger("paistation.deepread")

_REMIND_LEAD = timedelta(minutes=10)
_PRESENCE_IDLE = timedelta(minutes=5)


def _null_channel():
    class _Ch:
        def send(self, title, body):  # noqa: ARG002 - 占位通道
            return {"ok": False, "errcode": -1}
    return _Ch()


class DeepReadEngine:
    """每分钟 tick 一次的深读状态机（窗口/提醒/执行/水位/熔断/让路/STOP）。"""

    def __init__(self, state_path, channel=None, reader_fn=None,
                 session_hhmm: str = "00:30"):
        self.state_path = Path(state_path)
        self.channel = channel if channel is not None else _null_channel()
        self.reader_fn = reader_fn
        h, m = session_hhmm.split(":")
        self.session_min = int(h) * 60 + int(m)
        self.window = NightWindow(start=0, end=5)
        self.breaker = CircuitBreaker(threshold=2)
        self._presence_at: datetime | None = None
        self._load()

    # -- 状态 -------------------------------------------------------------

    def _default_state(self) -> dict:
        return {"last_run_date": "", "reminded_date": "", "watermark": {},
                "tripped": False, "streak": 0, "stopped_date": ""}

    def _load(self) -> None:
        st = self._default_state()
        if self.state_path.exists():
            try:
                st.update(json.loads(self.state_path.read_text(encoding="utf-8")))
            except (OSError, json.JSONDecodeError):
                pass
        self.state = st
        self.breaker._streak = st.get("streak", 0)
        self.breaker._tripped = st.get("tripped", False)

    def _save(self) -> None:
        self.state["streak"] = self.breaker._streak
        self.state["tripped"] = self.breaker._tripped
        self.state_path.parent.mkdir(parents=True, exist_ok=True)
        fd, tmp = tempfile.mkstemp(dir=str(self.state_path.parent), suffix=".tmp")
        try:
            with os.fdopen(fd, "w", encoding="utf-8") as fh:
                json.dump(self.state, fh, ensure_ascii=False, indent=1)
            os.replace(tmp, self.state_path)
        finally:
            if os.path.exists(tmp):
                os.unlink(tmp)

    # -- 用户交互 ---------------------------------------------------------

    def user_stop(self, now: datetime | None = None) -> None:
        """STOP 拦停：当夜不再执行（次日自动恢复）。"""
        at = now or datetime.now()
        self.state["stopped_date"] = at.strftime("%Y-%m-%d")
        self._save()

    def user_ack(self) -> None:
        """熔断后用户确认恢复。"""
        self.breaker.user_ack()
        self._save()

    def set_presence(self, last_input: datetime | None) -> None:
        self._presence_at = last_input

    # -- 主状态机 ---------------------------------------------------------

    def _session_at(self, now: datetime) -> datetime:
        return now.replace(hour=self.session_min // 60,
                           minute=self.session_min % 60, second=0, microsecond=0)

    def tick(self, now: datetime) -> None:
        """每分钟调用：窗口外静默；窗口内走 提醒→会话→水位 状态机。"""
        if not self.window.in_window(now) or self.breaker.tripped():
            return
        today = now.strftime("%Y-%m-%d")
        if self.state["stopped_date"] == today:
            return
        if self.state["last_run_date"] == today:
            return
        session_at = self._session_at(now)
        self._maybe_remind(now, session_at, today)
        if _mins(now) >= self.session_min:
            self._run_session(now, today)

    def _maybe_remind(self, now: datetime, session_at: datetime,
                      today: str) -> None:
        if self.state["reminded_date"] == today:
            return
        if timedelta(0) <= session_at - now <= _REMIND_LEAD:
            title = "微信深读提醒"
            body = (f"【微信深读】预计 {(session_at - now)} 后开始（夜间窗口，"
                    "近一年聊天/朋友圈/收藏增量入画像）。不需要请回复 STOP。")
            delivery = self.channel.send(title, body)
            if delivery and delivery.get("ok"):
                self.state["reminded_date"] = today   # 送达才算提醒过
                self._save()
            else:
                _log.warning("深读提醒投递失败——按 R13 本夜不执行")

    def _run_session(self, now: datetime, today: str) -> None:
        # R13 铁律闸：提醒未送达（reminded_date 非今日）→ 本夜不执行
        if self.state["reminded_date"] != today:
            return
        # 用户活跃让路：5 分钟内有键鼠 → 推迟（本 tick 不跑，等下个 tick）
        if self._presence_at is not None and \
                now - self._presence_at < _PRESENCE_IDLE:
            return
        guard = BudgetGuard(max_screens=300, max_minutes=90)
        guard.start(now)
        try:
            if self.reader_fn is not None:
                outcome = self.reader_fn(guard, dict(self.state["watermark"])) or {}
                new_wm = {**self.state["watermark"],
                          **{k: v for k, v in outcome.items()
                             if isinstance(v, str) and k != "screens"}}
                # 水位只前进（与 organ.state 同纪律）
                self.state["watermark"] = {
                    k: max(v, self.state["watermark"].get(k, ""))
                    for k, v in new_wm.items()}
            self.breaker.record_success(today)
        except Exception as exc:  # noqa: BLE001 - 读取失败→熔断计数+告警
            _log.warning("深读会话失败：%s", exc)
            self.breaker.record_failure(today)
            self.channel.send("微信深读异常",
                              f"会话失败已计数（连续 2 夜将暂停）：{exc}")
        self.state["last_run_date"] = today
        self.state["reminded_date"] = ""      # 提醒名额复位
        self._save()
        if self.breaker.tripped():
            self.channel.send("微信深读已暂停",
                              "连续 2 夜异常，已暂停深读等待您确认（回复 ACK 恢复）。")


def _mins(now: datetime) -> int:
    return now.hour * 60 + now.minute
