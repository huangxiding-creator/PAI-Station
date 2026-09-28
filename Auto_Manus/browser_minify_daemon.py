# -*- coding: utf-8 -*-
"""浏览器窗口最小化守护 — 0928 用户令「本项目所有浏览器窗口全部最小化运行,
最大程度不干扰用户操作电脑」.

60s 一轮: 扫自动化 Chrome (cmdline 带 --remote-debugging-port, 用户手开永不带)
可见且非最小化 → 最小化. 复用 minimize_project_browsers.ps1; 本进程与子进程
全程 CREATE_NO_WINDOW (铁律: 守护自己绝不弹窗).

日志: 只记 MINIMIZED 行 (ok-hidden 静默防刷屏); pid 文件防多实例.
"""
import os
import subprocess
import sys
import time
from pathlib import Path

ROOT = Path(__file__).resolve().parent
PS1 = ROOT / "minimize_project_browsers.ps1"
LOG = ROOT / "data" / "browser_minify.log"
PIDF = ROOT / "data" / "browser_minify.pid"
INTERVAL = 60


def _already_running() -> bool:
    if not PIDF.exists():
        return False
    old = PIDF.read_text(encoding="utf-8").strip()
    if not old:
        return False
    out = subprocess.run(
        ["tasklist", "/FI", f"PID eq {old}"],
        capture_output=True, text=True, creationflags=0x08000000,
    ).stdout
    return old in out


if _already_running():
    print("[minify] 已在跑, 单实例退出", flush=True)
    sys.exit(0)
PIDF.write_text(str(os.getpid()), encoding="utf-8")

try:
    while True:
        r = subprocess.run(
            ["powershell", "-NoProfile", "-ExecutionPolicy", "Bypass",
             "-File", str(PS1)],
            capture_output=True, text=True, encoding="utf-8",
            errors="replace", creationflags=0x08000000,
        )
        hits = [ln for ln in (r.stdout or "").splitlines()
                if ln.startswith("MINIMIZED")]
        if hits:
            stamp = time.strftime("%m-%d %H:%M:%S")
            with open(LOG, "a", encoding="utf-8") as f:
                for h in hits:
                    f.write(f"[{stamp}] {h}\n")
        time.sleep(INTERVAL)
finally:
    PIDF.unlink(missing_ok=True)
