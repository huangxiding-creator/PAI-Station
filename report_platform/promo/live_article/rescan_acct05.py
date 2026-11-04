# -*- coding: utf-8 -*-
"""rescan_acct05 — 错号污染后重扫 (清会话→新码→手机选号提醒→身份硬验)."""
from __future__ import annotations

import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = "acct05"
PORT = 19852
USER_DIR = str(Path(r"F:\We-AIPO\autopub\data\browser_profiles") / PROFILE)


def log(m: str) -> None:
    print(f"[rescan {time.strftime('%H:%M:%S')}] {m}", flush=True)


def main() -> int:
    proc = subprocess.Popen([
        CHROME, f"--remote-debugging-port={PORT}",
        f"--user-data-dir={USER_DIR}",
        "--window-size=560,800", "--window-position=120,120",
        "--no-first-run", "--no-default-browser-check",
        "--disable-infobars", "--new-window", "https://mp.weixin.qq.com/",
    ])
    time.sleep(9)
    from DrissionPage import Chromium
    b = Chromium(addr_or_opts=f"127.0.0.1:{PORT}")
    tab = b.get_tab(b.tab_ids[-1])
    time.sleep(4)
    url = tab.url or ""
    log(f"初始 url: {url[:70]}")
    if "cgi-bin/home" in url or "token=" in url:
        log("会话活(错号残留) → CDP 清 cookie 强制出码")
        import json as _json
        import urllib.request
        with urllib.request.urlopen(
                f"http://127.0.0.1:{PORT}/json/version", timeout=5) as r:
            ver = _json.loads(r.read())
        from websocket import create_connection
        ws = create_connection(ver["webSocketDebuggerUrl"], timeout=10,
                               suppress_origin=True)
        ws.send(_json.dumps({"id": 1, "method": "Storage.clearCookies"}))
        ws.recv()
        ws.close()
        tab.get("https://mp.weixin.qq.com/")
        time.sleep(5)
        log(f"清后 url: {(tab.url or '')[:70]}")

    # 置顶窗口
    import ctypes
    ctypes.windll.shcore.SetProcessDpiAwareness(2)
    import win32gui, win32con, win32process
    r2 = subprocess.run(
        ["wmic", "process", "where", "name='chrome.exe'", "get",
         "ProcessId,CommandLine", "/format:csv"],
        capture_output=True, text=True, timeout=15, errors="replace")
    pids = set()
    for line in (r2.stdout or "").splitlines():
        if f"remote-debugging-port={PORT}" in line and "--type=" not in line:
            try:
                pids.add(int(line.rstrip().split(",")[-1]))
            except ValueError:
                pass
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
    import threading
    stop_at = time.monotonic() + 15 * 60

    def _pin():
        while time.monotonic() < stop_at:
            for hwnd in found:
                try:
                    if win32gui.IsIconic(hwnd):
                        win32gui.ShowWindow(hwnd, win32con.SW_RESTORE)
                    win32gui.SetWindowPos(
                        hwnd, win32con.HWND_TOPMOST, 0, 0, 0, 0,
                        win32con.SWP_NOMOVE | win32con.SWP_NOSIZE
                        | win32con.SWP_SHOWWINDOW)
                except Exception:
                    pass
            time.sleep(2)
    threading.Thread(target=_pin, daemon=True).start()
    log("★ 窗口已置顶 — 请扫码, 手机确认页务必选「工程行业大脑」!")

    deadline = time.monotonic() + 15 * 60
    while time.monotonic() < deadline:
        time.sleep(3)
        try:
            u = tab.url or ""
        except Exception:
            u = ""
        if "cgi-bin/home" in u or ("token=" in u and "mp.weixin" in u):
            time.sleep(6)                       # cookie 落盘
            name = tab.run_js("""
                return (function(){
                    var sels = ['.weui-desktop_account_name',
                                '.account_box .nickname',
                                'a.title.ant-dropdown-link',
                                '[class*=nickname]'];
                    for (var i=0;i<sels.length;i++){
                        var els = document.querySelectorAll(sels[i]);
                        for (var j=0;j<els.length;j++){
                            var t = (els[j].innerText||'').trim();
                            if (t && t.length>1 && t.length<20) return t;
                        }
                    }
                    return '';
                })();
            """)
            log(f"登录成功, 身份={name!r}")
            if str(name) == "工程行业大脑":
                log("✓✓✓ 身份正确 — 会话干净可用")
                try:
                    b.quit()
                except Exception:
                    proc.terminate()
                return 0
            log(f"✗✗ 又是错号 ({name!r}) — 放弃, 不污染流程")
            return 3
    log("✗ 15分钟超时未扫")
    return 2


if __name__ == "__main__":
    sys.exit(main())
