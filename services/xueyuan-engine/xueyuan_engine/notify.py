# -*- coding: utf-8 -*-
"""企微推送域——上新/退款日报/熔断告警（ARCHITECTURE §六 notify.py；NFR-12 日报腿）。

非路由域（引擎外呼腿）。webhook URL 从 env XY_WECOM_WEBHOOK 读，无配置=静默
跳过（记日志）绝不硬编码；日报线程开关 XY_NOTIFY_DAILY=1 默认关（生产由
systemd 环境显式开）。外呼失败只记日志，绝不抛错阻塞业务响应。
"""
from __future__ import annotations

import logging
import os
import threading
import time
from datetime import datetime, timedelta, timezone

from curl_cffi import requests as cr

from . import store

logger = logging.getLogger("xueyuan.notify")

WEBHOOK_ENV = "XY_WECOM_WEBHOOK"   # 企微群机器人 webhook URL（密钥外置，绝不入码）
DAILY_ENV = "XY_NOTIFY_DAILY"      # 日报线程开关（默认关；systemd 生产显式开）
DAILY_HOUR = 9                     # 日报时刻（NFR-12：09:30 前到达）
DAILY_MINUTE = 30

_TZ8 = timezone(timedelta(hours=8))
_daily_lock = threading.Lock()
_daily_thread: threading.Thread | None = None
_daily_stop: threading.Event | None = None


def _webhook() -> str:
    return os.environ.get(WEBHOOK_ENV, "").strip()


def push(text: str) -> bool:
    """企微文本推送（日报/告警同通道）。无配置=静默跳过返回 False；失败只记日志。"""
    url = _webhook()
    if not url:
        logger.info("[notify] %s 未配置，跳过推送：%.80s", WEBHOOK_ENV, text)
        return False
    try:
        r = cr.post(url, json={"msgtype": "text", "text": {"content": text[:2000]}},
                    timeout=10)
        try:
            errcode = (r.json() or {}).get("errcode")
        except Exception:  # noqa: BLE001 —— 非JSON回执按失败处理
            errcode = None
        ok = r.status_code == 200 and errcode == 0
        if not ok:
            logger.warning("[notify] webhook 回执异常 %s errcode=%s", r.status_code, errcode)
        return ok
    except Exception as exc:  # noqa: BLE001 —— 外呼腿绝不抛错阻塞业务
        logger.warning("[notify] webhook 失败: %s", exc)
        return False


def alert(text: str) -> None:
    """告警钩子（NFR-05 限流/熔断 R-05/黑名单 R-04）：日志必落，企微尽力，绝不抛错。"""
    logger.warning("[alert] %s", text)
    try:
        push(text)
    except Exception:  # noqa: BLE001 —— 告警腿绝不抛错阻塞业务响应
        logger.exception("[alert] push 异常（不影响业务）")


# ── 退款/批评日报（NFR-12：含熔断字段；金额口径=orders/refunds/vouchers 汇总）──
def build_daily_report() -> str:
    """构造日报文本（纯读库，不外呼；send_daily_report 负责推送）。"""
    store.init()
    today = datetime.now(_TZ8).strftime("%Y-%m-%d")
    with store._db() as c:
        crit_total = c.execute("SELECT COUNT(*) n FROM criticisms").fetchone()["n"]
        crit_status = dict(c.execute(
            "SELECT status, COUNT(*) n FROM criticisms GROUP BY status"
        ).fetchall())
        crit_today = c.execute(
            "SELECT COUNT(*) n FROM criticisms WHERE created_at>=?", (today,)
        ).fetchone()["n"]
        ref_today = c.execute(
            "SELECT COUNT(*) n, COALESCE(SUM(amount_fen),0) amt FROM refunds"
            " WHERE created_at>=? AND status!='failed'", (today,)
        ).fetchone()
        ref_week = c.execute(
            "SELECT COUNT(*) n, COALESCE(SUM(amount_fen),0) amt FROM refunds"
            " WHERE created_at>=? AND status!='failed'",
            ((datetime.now(_TZ8) - timedelta(days=7)).isoformat(timespec="seconds"),)
        ).fetchone()
        by_method = c.execute(
            "SELECT method, COUNT(*) n FROM refunds WHERE status!='failed'"
            " GROUP BY method"
        ).fetchall()
        fuses = c.execute(
            "SELECT key, reason FROM fuse_state WHERE opened=1"
        ).fetchall()
        vouch = c.execute(
            "SELECT source, COUNT(*) n, COALESCE(SUM(amount_fen),0) amt FROM vouchers"
            " GROUP BY source"
        ).fetchall()
    lines = [
        f"[总包学园·退款日报] {today}",
        f"批评：今日新增 {crit_today}，累计 {crit_total}"
        f"（scored {crit_status.get('scored', 0)} / manual_pending"
        f" {crit_status.get('manual_pending', 0)} / pending_score"
        f" {crit_status.get('pending_score', 0)}）",
        f"退款：今日 {ref_today['n']} 笔 {ref_today['amt']} 分；"
        f"近7日 {ref_week['n']} 笔 {ref_week['amt']} 分",
        "执行方式：" + ("；".join(f"{r['method']}×{r['n']}" for r in by_method) or "无"),
        "书券发放：" + ("；".join(
            f"{r['source']}×{r['n']}={r['amt']}分" for r in vouch) or "无"),
        "熔断：" + ("；".join(f"{r['key']}（{r['reason']}）" for r in fuses) or "全部关闭"),
    ]
    return "\n".join(lines)


def send_daily_report() -> str:
    """构造并推送日报（幂等可重跑；返回文本供测试与日志核对）。"""
    text = build_daily_report()
    push(text)
    return text


# ── 日报线程（默认关；XY_NOTIFY_DAILY=1 时 import 即启，systemd 生产腿）──
def _seconds_until_daily(now_ts: float) -> float:
    n = datetime.fromtimestamp(now_ts, _TZ8)
    target = n.replace(hour=DAILY_HOUR, minute=DAILY_MINUTE, second=0, microsecond=0)
    if n >= target:
        target = target + timedelta(days=1)
    return (target - n).total_seconds()


def _daily_loop(stop: threading.Event) -> None:
    while not stop.wait(_seconds_until_daily(time.time())):
        try:
            send_daily_report()
        except Exception:  # noqa: BLE001 —— 日报失败不杀线程，次日重试
            logger.exception("daily report failed")


def start_daily_thread() -> bool:
    """启动日报线程（幂等）。返回是否本次启动（已活→False）。"""
    global _daily_thread, _daily_stop
    with _daily_lock:
        if _daily_thread is not None and _daily_thread.is_alive():
            return False
        _daily_stop = threading.Event()
        _daily_thread = threading.Thread(
            target=_daily_loop, args=(_daily_stop,), daemon=True,
            name="xueyuan-daily-report")
        _daily_thread.start()
        return True


def stop_daily_thread() -> None:
    """停日报线程（测试/运维复位；join 确保线程退出）。"""
    global _daily_thread
    with _daily_lock:
        stop = _daily_stop
        thread = _daily_thread
        _daily_thread = None
    if stop is not None:
        stop.set()
    if thread is not None and thread.is_alive():
        thread.join(timeout=2)


def _maybe_autostart() -> None:
    """XY_NOTIFY_DAILY=1 时 import 即启（默认关——生产由 systemd 环境显式开）。"""
    if os.environ.get(DAILY_ENV) == "1":
        start_daily_thread()


_maybe_autostart()
