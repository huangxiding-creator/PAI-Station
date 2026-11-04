# -*- coding: utf-8 -*-
"""scan_driver — 公众号扫码续命驱动器 (1104, 亲手接管版).

取代空转的 scan_login: 逐号起可见 Chrome(profile) → mp.weixin.qq.com 出码 →
窗口置顶 → URL 轮询确认登录(绝不导航) → cookie 自然落 profile → 下一位.

用法: F:/We-AIPO/.venv/Scripts/python.exe -X utf8 scan_driver.py acct05 acct07
"""
from __future__ import annotations

import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROF_ROOT = Path(r"F:\We-AIPO\autopub\data\browser_profiles")
MP = "https://mp.weixin.qq.com/"

NICKNAMES = {"acct01": "总包说", "acct05": "工程行业大脑",
             "acct07": "总包之声", "acct08": "总包说"}
PORTS = {"acct01": 19841, "acct05": 19842, "acct07": 19843, "acct08": 19844}


def log(m: str) -> None:
    print(f"[scan {time.strftime('%H:%M:%S')}] {m}", flush=True)


def pin_forever(hwnd: int, seconds: float = 25) -> None:
    """持续置顶窗口 seconds 秒 (扫码窗口常驻可见)."""
    import win32gui
    import win32con
    import threading

    stop = time.monotonic() + seconds

    def _loop():
        while time.monotonic() < stop:
            try:
                if not win32gui.IsWindow(hwnd):
                    return
                if win32gui.IsIconic(hwnd):
                    win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
                win32gui.SetWindowPos(hwnd, win32con.HWND_TOPMOST,
                                      0, 0, 0, 0,
                                      win32con.SWP_NOMOVE | win32con.SWP_NOSIZE
                                      | win32con.SWP_SHOWWINDOW)
            except Exception:
                return
            time.sleep(2)

    threading.Thread(target=_loop, daemon=True).start()


def find_hwnd_by_port(port: int):
    """从 CDP /json 拿不到 hwnd → 用进程树找主窗口."""
    import win32gui
    import win32process
    # 通过命令行找该端口的 chrome 主进程 pid
    r = subprocess.run(
        ["wmic", "process", "where", "name='chrome.exe'", "get",
         "ProcessId,CommandLine", "/format:csv"],
        capture_output=True, text=True, timeout=15, errors="replace")
    pids = set()
    for line in (r.stdout or "").splitlines():
        if f"remote-debugging-port={port}" in line and "--type=" not in line:
            try:
                pids.add(int(line.rstrip().split(",")[-1]))
            except ValueError:
                pass
    if not pids:
        return None
    found = []

    def cb(hwnd, _):
        if win32gui.IsWindowVisible(hwnd):
            try:
                _, pid = win32process.GetWindowThreadProcessId(hwnd)
            except Exception:
                return
            if pid in pids and win32gui.GetWindowText(hwnd):
                found.append(hwnd)
    win32gui.EnumWindows(cb, None)
    return found[0] if found else None


def scan_one(profile: str, timeout_min: int = 12) -> bool:
    port = PORTS[profile]
    user_dir = str(PROF_ROOT / profile)
    log(f"══ {profile} ({NICKNAMES.get(profile)}) 启动可见浏览器 port={port}")
    proc = subprocess.Popen([
        CHROME,
        f"--remote-debugging-port={port}",
        f"--user-data-dir={user_dir}",
        "--window-size=560,760",
        "--window-position=120,120",
        "--no-first-run", "--no-default-browser-check",
        "--disable-infobars", "--disable-popup-blocking",
        "--hide-crash-renderer-prompts", "--new-window", MP,
    ])
    time.sleep(8)

    from DrissionPage import Chromium
    try:
        b = Chromium(addr_or_opts=f"127.0.0.1:{port}")
    except Exception as exc:
        log(f"✗ attach 失败: {exc}")
        proc.terminate()
        return False
    tabs = b.tab_ids
    tab = b.get_tab(tabs[-1]) if tabs else None
    if tab is None:
        log("✗ 无tab")
        proc.terminate()
        return False

    hwnd = find_hwnd_by_port(port)
    if hwnd:
        pin_forever(hwnd, seconds=timeout_min * 60)
        log(f"✓ 窗口已置顶 (hwnd={hwnd}) — 请用 {NICKNAMES.get(profile)} 管理员微信扫码")
    else:
        log("⚠ 未找到窗口句柄 (窗口应已在任务栏)")

    deadline = time.monotonic() + timeout_min * 60
    logged_in = False
    while time.monotonic() < deadline:
        time.sleep(3)
        try:
            u = tab.url or ""
        except Exception:
            u = ""
        if "cgi-bin/home" in u or ("token=" in u and "mp.weixin.qq.com" in u):
            logged_in = True
            break
        # 会话可能直接活着 (免扫码)
        if "mp.weixin.qq.com" in u and "/cgi-bin/" in u:
            logged_in = True
            break
    if logged_in:
        time.sleep(5)                       # cookie 收尾落盘
        u = tab.url or ""
        log(f"✓✓ {profile} 登录成功 ({u[:70]}) — cookie 已落 profile")
        # 二次验证: 活检 (nickname 探测)
        try:
            nick = tab.run_js("""
                return (function(){
                    var el = document.querySelector('.weui-desktop_account_name, .account_box .nickname, [class*=account_nickname]');
                    return el ? (el.innerText||'').trim() : '';
                })();
            """)
            log(f"  活检昵称: {nick!r}")
        except Exception:
            pass
    else:
        log(f"✗ {profile} {timeout_min}分钟未见扫码 — 放弃本号 (窗口保留可手扫)")
        return False
    # 关浏览器 (cookie 已持久化在 profile)
    try:
        b.quit()
    except Exception:
        proc.terminate()
    time.sleep(3)
    return True


def main() -> int:
    profiles = sys.argv[1:] or ["acct05", "acct07"]
    results = {}
    for p in profiles:
        try:
            results[p] = scan_one(p)
        except Exception as exc:
            log(f"✗ {p} 异常: {exc}")
            results[p] = False
        if not results.get(p):
            break                            # 一号失败不再盲进 (用户逐一扫码令)
    log(f"══ 收工: {results}")
    return 0 if all(results.values()) else 1


if __name__ == "__main__":
    sys.exit(main())
