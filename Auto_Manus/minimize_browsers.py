# -*- coding: utf-8 -*-
"""我方浏览器窗口全量最小化 + 看护 (0924, 用户令: 打开的浏览器全部最小化运行).

识别=进程命令行含我方标记 (chrome_profile / 端口 9333/19825/19826 / headless),
绝不碰用户默认 profile 的浏览器. 看护模式 --watch: 每 20s 重扫重最小化
(军团 7-9h 切号会开新窗口).
用法: python minimize_browsers.py [--watch] [--interval 20]
"""
import argparse
import ctypes
import io
import subprocess
import sys
import time

sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding="utf-8",
                              errors="replace")

MARKERS = ("chrome_profile", "remote-debugging-port=9333",
           "remote-debugging-port=19825", "remote-debugging-port=19826",
           "headless")
SW_MINIMIZE = 6


def our_pids() -> set:
    """chrome/msedge 进程中命令行带我方标记的 PID 集."""
    out = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "Get-CimInstance Win32_Process -Filter "
         "\"Name='chrome.exe' or Name='msedge.exe' or "
         "Name='chromium.exe'\" | "
         "Select-Object ProcessId,CommandLine | "
         "ConvertTo-Json -Compress"],
        capture_output=True, text=True, timeout=30).stdout
    import json
    try:
        rows = json.loads(out)
    except Exception:
        return set()
    if isinstance(rows, dict):
        rows = [rows]
    pids = set()
    for r in rows:
        cl = r.get("CommandLine") or ""
        if any(m in cl for m in MARKERS):
            pids.add(int(r["ProcessId"]))
    return pids


def enum_minimize(pids: set) -> int:
    """枚举顶层窗口, 属于目标 PID 且可见的 → 最小化. 返回最小化数."""
    user32 = ctypes.windll.user32
    count = 0
    seen = []

    @ctypes.WINFUNCTYPE(ctypes.c_bool, ctypes.c_void_p, ctypes.c_void_p)
    def cb(hwnd, _):
        nonlocal count
        if not user32.IsWindowVisible(hwnd):
            return True
        pid = ctypes.c_ulong()
        user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
        if pid.value in pids:
            if user32.ShowWindow(hwnd, SW_MINIMIZE):
                count += 1
                seen.append(pid.value)
        return True

    user32.EnumWindows(cb, 0)
    return count


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--watch", action="store_true")
    ap.add_argument("--interval", type=int, default=20)
    args = ap.parse_args()
    while True:
        try:
            pids = our_pids()
            n = enum_minimize(pids) if pids else 0
            print(f"[{time.strftime('%H:%M:%S')}] 我方浏览器进程 {len(pids)} "
                  f"| 最小化窗口 {n}", flush=True)
        except Exception as e:
            print(f"[!] {type(e).__name__}: {str(e)[:60]}", flush=True)
        if not args.watch:
            break
        time.sleep(args.interval)


if __name__ == "__main__":
    main()
