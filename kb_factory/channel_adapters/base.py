# -*- coding: utf-8 -*-
"""渠道适配器元数据层基座（W5）。

用户令（铁律）：免费层只取元数据（目录结构+文件名），零文件下载——
本包任何模块不得出现 join/download/落盘类调用。

- FileMeta：与 catalog_engine 槽位字段对齐（title/format→fmt/pages/badge/perm/
  source_url/extra），badge/perm 枚举沿用 catalog_engine.metadata 口径。
- ChannelAdapter：渠道抽象，metadata() 只产 FileMeta 列表。
- RateLimiter：进程级频控（间隔 + 日上限熔断 + 连续错误熔断，日切重置）。
- AuditLog：统一审计 audit.jsonl，每次请求如实一行（零造假：只记实发事实）。
"""
import json
import os
import threading
import time
from dataclasses import dataclass, field

AUDIT_DEFAULT_PATH = os.path.join(os.path.dirname(os.path.abspath(__file__)), "audit.jsonl")

# 审计落盘锁：渠道编排池（pool.py）并发后多渠道线程共写同一 audit.jsonl，
# 行级加锁保每行 JSON 完整（单线程路径行为不变，纯增量不改既有语义）
_AUDIT_LOCK = threading.Lock()


@dataclass
class FileMeta:
    """单条渠道元数据（对应蓝图一个文件槽的真实值）。"""
    title: str
    fmt: str                                   # 规范格式名: doc/pdf/ppt/xls/txt/epub/ebook/kb
    pages: int | None = None                   # 页数；渠道无此字段时如实 None
    badge: str = "green_free"                  # catalog_engine.metadata.BADGES 子集
    perm: str = "green"                        # green/yellow
    source_url: str | None = None              # 详情页；响应无 URL 时 None（不造假）
    extra: dict = field(default_factory=dict)  # doc_id/views/downloads 等渠道原始事实


class ChannelAdapter:
    """渠道适配器抽象：只读元数据，不 join、不下载。"""
    channel = "abstract"

    def metadata(self, query: str, limit: int) -> list:
        """按查询词取 ≤limit 条 FileMeta；不可用/降级时返回 []（不崩溃）。"""
        raise NotImplementedError

    def available(self) -> bool:
        """运行时可用性（无副作用检查：不登录、不请求）。"""
        return True

    def reason(self) -> str:
        """不可用原因（进审计）。"""
        return getattr(self, "_reason", "")


class RateLimitExceeded(Exception):
    """日上限熔断：超出单进程日请求数，抛出后同日不再放行。"""


class CircuitOpenError(Exception):
    """连续错误熔断：连续失败达阈值后熔断开启，reset() 或日切恢复。"""


def _default_today() -> str:
    return time.strftime("%Y-%m-%d", time.localtime())


class RateLimiter:
    """进程级频控：min_interval 间隔 + daily_limit 日上限 + 连续错误熔断。

    线程安全不要求（进程级单线程顺序调用即可）；时钟/睡眠可注入便于确定性测试。
    """

    def __init__(self, min_interval: float = 3.0, daily_limit: int = 500,
                 error_threshold: int = 5, name: str = "limiter",
                 clock=None, sleep=None, today=None):
        self.name = name
        self.min_interval = float(min_interval)
        self.daily_limit = int(daily_limit)
        self.error_threshold = int(error_threshold)
        self._clock = clock or time.monotonic
        self._sleep = sleep or time.sleep
        self._today = today or _default_today
        self._day = self._today()
        self._count = 0
        self._last = -1e18
        self._consecutive_errors = 0
        self._open = False

    def acquire(self) -> None:
        """取一次请求额度：先熔断检查，再日切重置，再日上限熔断，再间隔。"""
        if self._open:
            raise CircuitOpenError(f"{self.name} 熔断开启(连续错误>={self.error_threshold})，需 reset() 或日切")
        day = self._today()
        if day != self._day:
            self._day, self._count, self._open = day, 0, False
        if self._count >= self.daily_limit:
            raise RateLimitExceeded(
                f"{self.name} 日上限熔断: {self._count}/{self.daily_limit} (今日)")
        wait = self.min_interval - (self._clock() - self._last)
        if wait > 0:
            self._sleep(wait)
        self._last = self._clock()
        self._count += 1

    def record_error(self) -> None:
        self._consecutive_errors += 1
        if self._consecutive_errors >= self.error_threshold:
            self._open = True

    def record_success(self) -> None:
        self._consecutive_errors = 0

    def reset(self) -> None:
        """手动复位熔断（运维/测试用；日计数不清零）。"""
        self._open = False
        self._consecutive_errors = 0

    def status(self) -> dict:
        return {"name": self.name, "count_today": self._count, "daily_limit": self.daily_limit,
                "min_interval": self.min_interval, "consecutive_errors": self._consecutive_errors,
                "circuit_open": self._open}


class AuditLog:
    """统一审计 audit.jsonl：每请求一行 JSON（ts/channel/event/query/count/...）。

    零造假：字段值只来自实测事实（elapsed_ms 实测、count 实数、detail 原样异常）。
    线程安全：渠道编排池并发下多线程共写，行级加锁（单线程行为不变）。
    """

    def __init__(self, path: str = AUDIT_DEFAULT_PATH):
        self.path = path

    def log(self, **fields) -> None:
        rec = {"ts": time.strftime("%Y-%m-%dT%H:%M:%S", time.localtime())}
        rec.update(fields)
        with _AUDIT_LOCK:
            with open(self.path, "a", encoding="utf-8") as f:
                f.write(json.dumps(rec, ensure_ascii=False) + "\n")
