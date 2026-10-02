# -*- coding: utf-8 -*-
"""恢复监视器 — 自媒永动机跑完后自动接续 Manus 采集 (用户令 09-22).

时序: 15:00 Manus 采集暂停让路 → We-AIPO 日引擎 15:00 起跑/NB 19:00
齐发 → 本进程监视其心跳文件 → 空闲确认 (stale>20min ×2 次, 10min
间隔) → 启动 harvest_all.py 断点续采 (CREATE_NO_WINDOW) → 自退.

兜底: 20:00 前心跳从未出现 (自媒永动机当日未跑) → 直接恢复采集.
日志: harvest_sessions/resume_watch.log
"""
import subprocess
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

try:
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")
except AttributeError:
    pass  # pythonw 无 stdout — 静默模式

HEARTBEAT = Path(r"E:\CPOPC\We-AIPO\data\state\production_heartbeat")
LOG = Path("harvest_sessions/resume_watch.log")
DEADLINE_NO_SHOW = datetime.now().replace(hour=20, minute=0, second=0)
CREATIONFLAGS = 0x08000000  # CREATE_NO_WINDOW


def log(msg):
    stamp = time.strftime("%m-%d %H:%M:%S")
    LOG.parent.mkdir(exist_ok=True)
    with LOG.open("a", encoding="utf-8") as fh:
        fh.write(f"[{stamp}] {msg}\n")


def heartbeat_age_s():
    """心跳年龄秒数; 文件不存在 = None (空闲/未起跑)."""
    try:
        return time.time() - HEARTBEAT.stat().st_mtime
    except OSError:
        return None


def main():
    log("watcher 启动: 等待自媒永动机心跳出现…")
    saw_beat = False
    while True:
        age = heartbeat_age_s()
        now = datetime.now()
        if age is not None and age < 600:
            if not saw_beat:
                log("心跳在线 (自媒永动机运行中)")
                saw_beat = True
            time.sleep(120)
            continue
        if age is not None and 600 <= age < 1200:
            time.sleep(60)  # 边界抖动, 短查一次
            continue
        # 心跳不存在或 stale>=1200s
        if not saw_beat:
            if now < DEADLINE_NO_SHOW:
                time.sleep(300)  # 还没起跑, 5 分钟后再看
                continue
            log(f"{DEADLINE_NO_SHOW:%H:%M} 前心跳从未出现 — 兜底直接恢复")
            break
        # 见过心跳 → 空闲候选, 双重确认防间歇
        log("心跳消失/stale, 10 分钟后复查确认…")
        time.sleep(600)
        age2 = heartbeat_age_s()
        if age2 is None or age2 >= 1200:
            log(f"二次确认空闲 (age={age2}) → 恢复采集")
            break
        log(f"复查心跳又在线 (age={age2:.0f}s) — 回监视")
        time.sleep(120)

    log("启动 harvest_all.py 断点续采 (后台无窗)")
    console = LOG.parent / "harvest_all_console.log"
    with console.open("ab") as fh:
        r = subprocess.run([sys.executable, "harvest_all.py"],
                           stdout=fh, stderr=subprocess.STDOUT,
                           creationflags=CREATIONFLAGS)
    log(f"harvest_all.py 退出码 {r.returncode} — watcher 结束")


if __name__ == "__main__":
    main()
