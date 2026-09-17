# -*- coding: utf-8 -*-
"""提取完→马上全套测试（一次性衔接器，2026-09-17 用户指令）。

时序：22:00 extract loop 启动 → 队列清空进程退出 → 本 watcher 立即跑
全套 pytest（写 test_suite_latest.log，晨报自动读取）。04:00 原定时任务
保留作兜底，由 run_test_suite.cmd 的 3 小时幂等守卫防双跑。

规则：
- 22:00~23:59 等 extract 进程出现（没出现=今晚任务没跑，退出留痕）
- 进程出现后等退出，最晚等到 03:50（再晚让 04:00 兜底，避免抢跑）
- pythonw 静默运行，全链无窗口（Windows 不弹窗铁律）
"""
import subprocess
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

ROOT = Path(r"E:\AI-Station")
LOG = ROOT / "data" / "local_index" / "watcher_extract2test.log"
PY = ROOT / ".venv" / "Scripts" / "pythonw.exe"
NO_WINDOW = 0x08000000  # CREATE_NO_WINDOW

PS_CMD = (
    "Get-CimInstance Win32_Process -Filter \"Name='pythonw.exe'\" | "
    "Where-Object {$_.CommandLine -match 'localfiles' "
    "-and $_.CommandLine -match 'extract'} | Measure-Object | "
    "Select-Object -ExpandProperty Count"
)


def log(msg: str) -> None:
    stamp = datetime.now().strftime("%m-%d %H:%M:%S")
    with LOG.open("a", encoding="utf-8") as fh:
        fh.write(f"[{stamp}] {msg}\n")


def extract_running() -> bool:
    try:
        r = subprocess.run(
            ["powershell", "-NoProfile", "-Command", PS_CMD],
            capture_output=True, text=True,
            creationflags=NO_WINDOW, timeout=60)
    except subprocess.TimeoutExpired:
        return True  # 探测超时按“还在跑”处理，保守不误触发
    if r.returncode != 0:
        return True
    return r.stdout.strip() != "0"


def main() -> int:
    now = datetime.now()
    deadline_appear = now.replace(hour=23, minute=59, second=0)
    deadline_gone = now.replace(hour=3, minute=50, second=0)
    if deadline_gone <= deadline_appear:  # 跨午夜：03:50 是次日
        deadline_gone += timedelta(days=1)
    log(f"watcher 启动：等 extract 出现至 {deadline_appear:%H:%M}")
    seen = False
    while datetime.now() < (deadline_gone if seen else deadline_appear):
        if extract_running():
            if not seen:
                seen = True
                log("extract 进程在跑，等它退出…")
        elif seen:
            break
        time.sleep(60)
    if not seen:
        log("到 23:59 未见 extract 进程——今晚任务没跑，watcher 退出")
        return 1
    if datetime.now() >= deadline_gone:
        log("03:50 extract 仍未完——让位 04:00 兜底任务，watcher 退出")
        return 1
    log("extract 已收工，立即全套测试")
    try:
        r = subprocess.run(
            [str(PY), "-m", "pytest", "--tb=short", "-p", "no:cacheprovider"],
            cwd=str(ROOT), capture_output=True, text=True,
            creationflags=NO_WINDOW, timeout=7200)
    except subprocess.TimeoutExpired as e:
        out = ((e.stdout or b"").decode("utf-8", "replace")
               if isinstance(e.stdout, bytes) else (e.stdout or "")) \
            + "\n[watcher] pytest 2 小时超时被杀\n"
        dest = ROOT / "data" / "local_index" / "test_suite_latest.log"
        dest.write_text(out, encoding="utf-8", errors="replace")
        log("pytest 超时（2h）——log 已落盘，让 04:00 兜底")
        return 1
    out = (r.stdout or "") + (r.stderr or "")
    dest = ROOT / "data" / "local_index" / "test_suite_latest.log"
    dest.write_text(out, encoding="utf-8", errors="replace")
    tail = [ln for ln in out.splitlines() if ln.startswith(("=", "F", "E"))][-1:]
    log(f"测试收口 rc={r.returncode} {tail[:1]}")
    return r.returncode


if __name__ == "__main__":
    sys.exit(main())
