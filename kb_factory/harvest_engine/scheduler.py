# -*- coding: utf-8 -*-
"""周任务 runner（cron 式，D2 修复新增件）：probe 周任务 + harvest 台账轮转（FR1.3 调度腿）。

CRON_SCHEDULE（v1 固定两张，均周频，执行序=元组序）：
- probe@weekly          全域健康探针 → registry {site:{status,last_probe,reason}} 三键持久化
                        + 周报行 JSONL（week/site/status/reason/http_code/requests/ip/ts，
                        每站一行，dead 站必入报）；dead 站移出调度
                        （HealthRegistry.scheduled_sites 不含 dead）。
- ledger_rotate@weekly  harvest_audit.jsonl 轮转归档：os.replace 改名保数据（零删除纪律，
                        归档位已占则加序号后缀绝不覆盖；无文件 no-op）。

registry/周报/台账路径全部必填参数化（不落仓库默认位；测试写 tests/fixtures/）。
probe 实弹腿默认注入 probe.health.probe_site（真网络），测试可注入确定性 prober
（时间/网络注入点，工人公约 §3）；本件自身不发网络请求。
"""
from __future__ import annotations

import json
import os
from datetime import datetime
from pathlib import Path

from .probe.health import (STATUS_ALIVE, STATUS_DEAD, STATUS_REDIRECT, HealthRegistry,
                           SiteHealth, probe_site)

CRON_SCHEDULE = ("probe@weekly", "ledger_rotate@weekly")

_REPORT_KEYS = ("week", "site", "status", "reason", "http_code", "requests", "ip", "ts")


def iso_week(now=None) -> str:
    """ISO 周标签（周报行/轮转名共用）：如 2026-W43；now 可传 datetime 或无参 callable（注入点）。"""
    stamp = now if now is not None else datetime.now()
    if callable(stamp):
        stamp = stamp()
    year, week, _weekday = stamp.isocalendar()
    return f"{year}-W{week:02d}"


def rotate_ledger(ledger_path, backup_path):
    """台账轮转=改名归档（零删除纪律）：内容原样保留仅换名；源不存在→None；归档位已占→.N 序号。"""
    src = Path(ledger_path)
    if not src.exists():
        return None
    dst = Path(backup_path)
    serial = 1
    while dst.exists():  # 绝不覆盖既有归档
        dst = Path(f"{backup_path}.{serial}")
        serial += 1
    os.replace(src, dst)
    return dst


class WeeklyRunner:
    """周任务 runner：run_week 按 CRON_SCHEDULE 序执行 probe → ledger_rotate。"""

    def __init__(self, *, registry_path, report_path, ledger_path=None, prober=None, now=None):
        self.registry_path = Path(registry_path)
        self.report_path = Path(report_path)
        self.ledger_path = Path(ledger_path) if ledger_path else None
        self._prober = prober or probe_site          # 网络注入点：实弹默认真探针
        self._now = now or datetime.now              # 时间注入点：周标签/时间戳确定性
        self.registry = HealthRegistry(self.registry_path)
        self.registry.load()

    def run_probe(self, sites) -> dict:
        """probe@weekly：逐域探针 → registry 三键 upsert + 周报行（每站一行 JSONL）。"""
        week = iso_week(self._now)
        rows = []
        alive = dead = redirect = requests = 0
        for site in sites:
            health = self._prober(site)
            if not isinstance(health, SiteHealth):
                raise TypeError(f"prober 必须返回 SiteHealth：{site} → {type(health).__name__}")
            self.registry.upsert(health, now=self._now)
            requests += health.requests  # 数字零造假：实测请求数累加
            rows.append({"week": week, "site": health.site, "status": health.status,
                         "reason": health.reason, "http_code": health.http_code,
                         "requests": health.requests, "ip": health.ip,
                         "ts": iso_now(self._now)})
            if health.status == STATUS_DEAD:
                dead += 1
            elif health.status == STATUS_REDIRECT:
                redirect += 1
            else:
                alive += 1
        self.report_path.parent.mkdir(parents=True, exist_ok=True)
        with self.report_path.open("a", encoding="utf-8") as f:  # 周报 append 型（跨周累积）
            for row in rows:
                f.write(json.dumps(row, ensure_ascii=False) + "\n")
        return {"week": week, "cron": "probe@weekly", "probed": len(rows),
                "alive": alive, "dead": dead, "redirect": redirect,
                "requests": requests, "report_rows": len(rows),
                "dead_sites": self.registry.dead_sites()}

    def run_ledger_rotate(self, week=None):
        """ledger_rotate@weekly：harvest 台账改名归档（week 缺省取当前 ISO 周）；无台账/未配置→None。"""
        if not self.ledger_path:
            return None
        week = week or iso_week(self._now)
        backup = self.ledger_path.with_name(
            f"{self.ledger_path.stem}.{week}{self.ledger_path.suffix}")
        return rotate_ledger(self.ledger_path, backup)

    def run_week(self, sites) -> dict:
        """cron 全周跑批：CRON_SCHEDULE 序 probe@weekly → ledger_rotate@weekly。"""
        summary = self.run_probe(sites)                     # CRON_SCHEDULE[0]
        rotated = self.run_ledger_rotate(summary["week"])   # CRON_SCHEDULE[1]
        summary["cron_run"] = list(CRON_SCHEDULE)
        summary["rotated_to"] = str(rotated) if rotated else ""
        return summary


def iso_now(now) -> str:
    """周报行时间戳（秒精度 ISO）；now 可传 datetime 或无参 callable（与 iso_week 同口径）。"""
    stamp = now if now is not None else datetime.now()
    if callable(stamp):
        stamp = stamp()
    return stamp.isoformat(timespec="seconds")
