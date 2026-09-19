# -*- coding: utf-8 -*-
"""调研浏览器最小化看门狗 (当日兜底, 15:00 自灭).

用户令 2026-09-19: 调研打开的浏览器窗口请全部最小化运行.
生产补丁已落三处 (--start-minimized): channels/_dp_helper.py /
djyanbao_drission.py / video_publisher/channels_publisher.py;
本看门狗只兜一件事 —— 补丁前已 import 旧代码的常驻 cli 进程,
今日再开出来的可见窗口, 一律最小化.
"""
import ctypes
import subprocess
import time
from ctypes import wintypes
from datetime import datetime, time as dtime

END = dtime(15, 0)          # 与工厂窗口同步收摊
SW_MINIMIZE = 6

user32 = ctypes.windll.user32
EnumWindowsProc = ctypes.WINFUNCTYPE(wintypes.BOOL, wintypes.HWND, wintypes.LPARAM)


def _research_chrome_pids() -> set[int]:
    """DrissionPage 系 chrome: 带调试端口+独立 user-data-dir; 排除 superpowers MCP 实例."""
    try:
        out = subprocess.run(
            ["wmic", "process", "where", "name='chrome.exe'",
             "get", "ProcessId,CommandLine"],
            capture_output=True, text=True, timeout=15).stdout or ""
    except Exception:
        return set()
    pids: set[int] = set()
    for ln in out.splitlines():
        ln = ln.strip()
        if "--remote-debugging-port" not in ln or "--user-data-dir" not in ln:
            continue
        if "superpowers" in ln:
            continue
        try:
            pids.add(int(ln.split()[-1]))
        except ValueError:
            pass
    return pids


def _minimize_pid_windows(pids: set[int]) -> int:
    """最小化属于目标 pid 的可见顶层窗口, 返回处理数."""
    n = 0

    def cb(hwnd, _l):
        nonlocal n
        pid = wintypes.DWORD()
        user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
        if pid.value in pids and user32.IsWindowVisible(hwnd):
            user32.ShowWindow(hwnd, SW_MINIMIZE)
            n += 1
        return True

    user32.EnumWindows(EnumWindowsProc(cb), 0)
    return n


def main() -> None:
    while datetime.now().time() < END:
        pids = _research_chrome_pids()
        if pids:
            _minimize_pid_windows(pids)
        time.sleep(60)


if __name__ == "__main__":
    main()
