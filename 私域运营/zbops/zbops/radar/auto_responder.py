# -*- coding: utf-8 -*-
"""安全自动应答器——参数直接复刻识流逆向报告的已验证数值。

识流（商业产品，大量用户验证安全）的实际参数（逆向报告 §5-§7）：
  同群回复间隔：  10-15 分钟（不是4小时）
  同群每小时：    2-3 条
  全局日限：      ~20-30 条
  营业时段：      8:30-20:30
  动作间随机延迟： 300-500ms（粘贴后）、600-900ms（发送前）
  跨群最小间隔：  45-180 秒随机
  点击按住时长：  60-120ms 随机
  内容去重：      相似内容不发第二次
  风控对策：      不前台聚焦 + 贝塞尔轨迹 + 剪贴板协议
"""
from __future__ import annotations

import asyncio
import hashlib
import logging
import random
import time
from dataclasses import dataclass
from pathlib import Path

log = logging.getLogger("zbops.responder")

WXRPA_PATH = Path(r"e:\AI-Station\私域运营\wxrpa")

# ── 参数：识流已验证 + 用户硬约束 ──
MAX_PER_CHAT_DAILY = 3        # 同群每日最多 3 条（用户硬约束）
MAX_GLOBAL_DAILY = 20         # 全局日限（识流实战级别）
CHAT_COOLDOWN = 30 * 60       # 同群冷却 30 分钟（3条自然分散全天）
BUSINESS_START, BUSINESS_END = 8, 21  # 营业 8:00-21:00
QUEUE_DELAY_MIN = 60          # 跨群最小间隔 60 秒（识流 45-180s）
QUEUE_DELAY_MAX = 180         # 跨群最大间隔 180 秒
PASTE_DELAY = (0.3, 0.5)      # 粘贴后 300-500ms（识流 §6.1）
SEND_DELAY = (0.6, 0.9)       # 发送前 600-900ms（识流 §6.1）


@dataclass
class PendingMessage:
    chat_name: str
    text: str
    priority: int = 5
    created_at: float = 0.0
    metadata: dict = None


class SafeAutoResponder:
    """识流参数级安全应答器。"""

    def __init__(self):
        self.queue: list[PendingMessage] = []
        self._sent_today = 0
        self._sent_date = ""
        self._sent_hashes: set[str] = set()
        self._dedup_keys: set[str] = set()   # 显式 dedup_key 幂等集（API_DESIGN §1）
        self._chat_daily: dict[str, int] = {}        # chat → 今日发送数
        self._chat_last_sent: dict[str, float] = {}   # chat → 最后发送时间
        self._running = False
        self._risk_detected = False
        self._start_time = time.time()

    @property
    def daily_limit(self) -> int:
        """直接使用识流验证级别，无渐进期。"""
        return MAX_GLOBAL_DAILY

    def _reset_counters(self):
        today = time.strftime("%Y-%m-%d")
        if self._sent_date != today:
            self._sent_date = today
            self._sent_today = 0
            self._chat_daily = {}

    def _in_business_hours(self) -> bool:
        import datetime
        return BUSINESS_START <= datetime.datetime.now().hour < BUSINESS_END

    def _is_duplicate(self, text: str) -> bool:
        return hashlib.md5(text[:50].encode()).hexdigest() in self._sent_hashes

    def enqueue(self, chat_name: str, text: str, priority: int = 5,
                **metadata):
        """入队（每群日限3条 + 冷却30分钟 + 全局限额）。返回 True=已入队 / False=被安全网拒绝。"""
        self._reset_counters()

        if self._risk_detected:
            log.warning("[风控熔断] 拒绝新消息")
            return False

        # 全局日限
        if self._sent_today >= self.daily_limit:
            return False

        # 每群日限 3 条（用户硬约束）
        if self._chat_daily.get(chat_name, 0) >= MAX_PER_CHAT_DAILY:
            return False

        # 同群冷却 30 分钟
        if time.time() - self._chat_last_sent.get(chat_name, 0) < CHAT_COOLDOWN:
            return False

        # 内容去重（显式 dedup_key 提供时以其为幂等键，否则按正文 md5 前50字）
        dedup_key = metadata.get("dedup_key")
        if dedup_key:
            if dedup_key in self._dedup_keys:
                return False
        elif self._is_duplicate(text):
            return False

        msg = PendingMessage(chat_name=chat_name, text=text, priority=priority,
                            created_at=time.time(), metadata=metadata or {})
        self.queue.append(msg)
        self.queue.sort(key=lambda m: m.priority)
        if dedup_key:
            self._dedup_keys.add(dedup_key)
        return True

    def report_risk_signal(self, signal: str):
        """外部报告风控信号。"""
        self._risk_detected = True
        self.queue.clear()
        log.critical("[风控熔断] %s", signal)

    async def start(self):
        """启动发送循环。"""
        self._running = True
        log.info("应答器启动（日限%d，群冷却%.0f分，跨群%d-%ds）",
                self.daily_limit, CHAT_COOLDOWN / 60,
                QUEUE_DELAY_MIN, QUEUE_DELAY_MAX)

        while self._running:
            if self.queue and not self._risk_detected:
                await self._process_one()
                # 跨群间隔（识流 45-180 秒随机）
                delay = random.uniform(QUEUE_DELAY_MIN, QUEUE_DELAY_MAX)
                await asyncio.sleep(delay)
            else:
                await asyncio.sleep(5)

    def stop(self):
        self._running = False

    async def _process_one(self):
        """发送一条。"""
        self._reset_counters()

        if not self._in_business_hours():
            self.queue.clear()
            return

        if self._sent_today >= self.daily_limit:
            return

        msg = self.queue.pop(0)
        if not msg.text:
            return

        # 发送侧同群冷却复核（T-076：入队侧冷却可能被队列积压绕过）
        if time.time() - self._chat_last_sent.get(msg.chat_name, 0) < CHAT_COOLDOWN:
            self.queue.append(msg)   # 冷却未到，压回队尾稍后重试
            return

        success = await self._send_via_wxrpa(msg.chat_name, msg.text)

        if success:
            self._sent_today += 1
            self._chat_daily[msg.chat_name] = \
                self._chat_daily.get(msg.chat_name, 0) + 1
            self._chat_last_sent[msg.chat_name] = time.time()
            self._sent_hashes.add(
                hashlib.md5(msg.text[:50].encode()).hexdigest())
            from . import audit_log  # T-048/REQ-019: 发送即审计
            audit_log.record("B", msg.chat_name, msg.text,
                             chat_count=self._chat_daily.get(msg.chat_name, 0),
                             global_count=self._sent_today)
            log.info("[发送 %d/%d 全局 | %d/%d 群] → %s",
                    self._sent_today, self.daily_limit,
                    self._chat_daily.get(msg.chat_name, 0),
                    MAX_PER_CHAT_DAILY, msg.chat_name[:12])

    async def _send_via_wxrpa(self, chat_name: str, text: str) -> bool:
        """wxrpa 安全发送（识流拟人化参数）。"""
        try:
            import sys
            sys.path.insert(0, str(WXRPA_PATH))
            from wxrpa import wxwin, navigate, human_input as hi
            import pyautogui

            win = wxwin.ensure_active()
            navigate.open_chat(chat_name)

            # 剪贴板协议（识流 §6.1：先写→再聚焦→纯 Ctrl+V）
            hi.set_clipboard(text)
            navigate.focus_input_box(win)

            # 粘贴后延迟（识流 300-500ms）
            await asyncio.sleep(random.uniform(*PASTE_DELAY))
            pyautogui.hotkey("ctrl", "v")

            # 发送前延迟（识流 600-900ms）
            await asyncio.sleep(random.uniform(*SEND_DELAY))
            pyautogui.hotkey("ctrl", "enter")

            # 发送后等待（拟人化）
            await asyncio.sleep(random.uniform(1.0, 2.0))
            return True

        except Exception as e:  # noqa: BLE001
            log.error("[wxrpa] %s: %s", chat_name[:12], e)
            return False


# 全局单例
responder = SafeAutoResponder()
