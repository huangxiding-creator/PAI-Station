# -*- coding: utf-8 -*-
"""_qr_login_three — 三号依次弹码登录恢复 (用户令「弹码」).
每号: 手工起Chrome(反检测) → mp登录页(二维码可见) → 轮询登录成功 → 下一号.
成功判定: 页面出现「新的创作」或 URL 带 token.
用法: py -X utf8 _qr_login_three.py [超时秒/号=180]
"""
import os
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

CHROME = r"C:\Program Files\Google\Chrome\Application\chrome.exe"
PROFILE = r"F:\We-AIPO\autopub\data\browser_profiles"
ACCOUNTS = [
    ("acct05", 9351, "总包之声"),
    ("acct01", 9352, "总包说"),
    ("acct07", 9353, "工程行业大脑"),
]
TIMEOUT = int(sys.argv[1]) if len(sys.argv) > 1 else 180


def alive_marker(page) -> str:
    try:
        src = page.html or ""
        if "新的创作" in src or "草稿箱" in src:
            return "ui"
        m = re.search(r"token=(\d+)", page.url or "")
        if m:
            return "token"
        if "登录超时" in src or "请重新登录" in src:
            return "dead"
        return ""
    except Exception:
        return "err"


def main() -> int:
    ok = 0
    for acct, port, name in ACCOUNTS:
        print(f"\n===== {acct} ({name}) =====", flush=True)
        # 清该号残留
        subprocess.run(["powershell", "-NoProfile", "-Command",
                        f"Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
                        f"Where-Object {{$_.CommandLine -match '{acct}'}} | "
                        "ForEach-Object { Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue }"],
                       capture_output=True, timeout=30)
        time.sleep(2)
        proc = subprocess.Popen(
            [CHROME, f"--remote-debugging-port={port}",
             f"--user-data-dir={os.path.join(PROFILE, acct)}",
             "--window-size=1100,850", "--window-position=80,80",
             "--disable-blink-features=AutomationControlled", "--no-first-run",
             "--no-default-browser-check", "--disable-infobars",
             "https://mp.weixin.qq.com/"],
            stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"[qr] 浏览器已弹 (pid={proc.pid}) — 请用{name}绑定的微信扫码", flush=True)
        time.sleep(8)
        try:
            co = ChromiumOptions()
            co.set_local_port(port)
            page = ChromiumPage(co)
        except Exception as e:
            print(f"[err] 连接失败: {str(e)[:80]}", flush=True)
            continue
        t0 = time.time()
        success = False
        # 纯观察模式: 绝不 page.get/刷新 (1122用户令: 二维码不要刷新太快——
        # 强刷会作废正在扫的码). 登录成功后页面自动跳转, 只被动读 url/html.
        last_print = 0
        while time.time() - t0 < TIMEOUT:
            mk = alive_marker(page)
            if mk in ("ui", "token"):
                success = True
                break
            now = time.time() - t0
            if now - last_print >= 15:
                print(f"[wait] {acct} 已等 {int(now)}s (码不动, 请扫) mk={mk}", flush=True)
                last_print = now
            time.sleep(4)
        if success:
            print(f"[ok] {acct} 登录成功 ({mk}) — 登录态已存盘", flush=True)
            ok += 1
            try:
                page.quit()  # 关浏览器, cookie 落盘
            except Exception:
                pass
        else:
            print(f"[timeout] {acct} {TIMEOUT}s 未扫 — 浏览器保留, 可稍后手扫", flush=True)
            # 不关浏览器, 让用户可继续扫
        time.sleep(3)
    print(f"\n[result] {ok}/{len(ACCOUNTS)} 恢复", flush=True)
    return 0 if ok == len(ACCOUNTS) else 1


if __name__ == "__main__":
    raise SystemExit(main())
