# -*- coding: utf-8 -*-
"""让路守护保活器 — 30min 巡检, 守护不在即拉起 (幂等, schtask 挂载).

0924 H6 双启事故后改 PID 闸: 判据=data/yield_guard.pid 里的 pid 活着
且宿主是 python (进程名模糊查询当晚两次间歇空手, 不可靠). 守护侧
claim_or_exit() 同闸双保险 — 竞态窗口内第二实例自退.
"""
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).parent
PY311 = r"C:\Users\91216\AppData\Local\Programs\Python\Python311\python.exe"
LOG = ROOT / "data" / "yield_guard_daemon.log"
PID_FILE = ROOT / "data" / "yield_guard.pid"


def pid_is_guard(pid: int) -> bool:
    import ctypes
    k = ctypes.windll.kernel32
    h = k.OpenProcess(0x1000, False, pid)
    if not h:
        return False
    try:
        buf = ctypes.create_unicode_buffer(512)
        n = ctypes.c_uint32(512)
        if not k.QueryFullProcessImageNameW(h, 0, buf, ctypes.byref(n)):
            return False
        return "python" in buf.value.lower()
    finally:
        k.CloseHandle(h)


def guard_alive() -> bool:
    try:
        pid = int(PID_FILE.read_text().strip())
        return pid_is_guard(pid)
    except (FileNotFoundError, ValueError):
        return False
    except Exception:
        return True   # 查不清 = 不拉, 下轮再看


def main() -> int:
    if guard_alive():
        return 0
    LOG.parent.mkdir(parents=True, exist_ok=True)
    with LOG.open("a", encoding="utf-8", errors="replace") as f:
        f.write(f"[keeper] {time.strftime('%m-%d %H:%M')} 守护不在, 拉起\n")
    subprocess.Popen(
        [PY311, str(ROOT / "epc50_yield_guard.py")],
        cwd=str(ROOT),
        stdout=open(LOG, "ab"),
        stderr=subprocess.STDOUT,
        creationflags=0x08000008)   # DETACHED_PROCESS | CREATE_NO_WINDOW
    return 0


if __name__ == "__main__":
    sys.exit(main())
