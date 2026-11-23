# -*- coding: utf-8 -*-
"""_qr_watch_three — 纯观察监视: 三号已弹的登录窗口(9351/9352/9353)被动检测,
任何一号登录成功 → 企微通知. 绝不刷新页面. 最长2小时.
"""
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium, ChromiumOptions  # noqa: E402

PORTS = {9351: "acct05/总包之声", 9352: "acct01/总包说", 9353: "acct07/工程行业大脑"}


def state(cdp):
    try:
        b = Chromium(cdp)
        t = b.latest_tab
        src = t.html or ""
        url = t.url or ""
        if "新的创作" in src or "草稿箱" in src or re.search(r"token=\d+", url):
            return "LOGIN"
        if "登录超时" in src:
            return "dead"
        return "wait"
    except Exception:
        return "down"


def main() -> int:
    t0 = time.time()
    logged = set()
    print("[watch] 监视三号登录窗口 (纯观察)...", flush=True)
    while time.time() - t0 < 7200:
        for port, name in PORTS.items():
            if port in logged:
                continue
            s = state(f"127.0.0.1:{port}")
            if s == "LOGIN":
                logged.add(port)
                print(f"[HIT] {name} 登录成功!", flush=True)
                import subprocess
                subprocess.run([r"E:\AI-Station\.venv\Scripts\python.exe", "-X", "utf8",
                                r"E:\AI-Station\tools\notify_wecom.py",
                                f"公众号登录恢复: {name}",
                                f"{name} 扫码登录成功, 登录态已落盘。共{len(logged)}/3。全部恢复后自动接力投4篇稿。"],
                               capture_output=True, timeout=60)
        if len(logged) == 3:
            print("[done] 三号全恢复", flush=True)
            return 0
        time.sleep(20)
    print(f"[end] {len(logged)}/3 恢复, 窗口仍开可续扫", flush=True)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
