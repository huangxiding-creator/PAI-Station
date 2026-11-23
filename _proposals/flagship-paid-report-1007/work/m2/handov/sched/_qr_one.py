# -*- coding: utf-8 -*-
"""_qr_one — 单号弹码(纯观察): 手工起Chrome → 登录页(一次性加载出码) → 被动检测跳转.
用户令: 二维码不要刷新太快 — 本脚本只在启动时加载一次登录页, 之后绝不刷新.
用法: py -X utf8 _qr_one.py <acct05|acct01|acct07> [超时秒=600]
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
PORTS = {"acct05": 9351, "acct01": 9352, "acct07": 9353}
NAMES = {"acct05": "总包之声", "acct01": "总包说", "acct07": "工程行业大脑"}

acct = sys.argv[1]
TIMEOUT = int(sys.argv[2]) if len(sys.argv) > 2 else 600
port = PORTS[acct]
name = NAMES[acct]

# 清该号残留 (旧窗口码已过期)
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
print(f"[qr] {name} 新窗口已弹 (pid={proc.pid}) — 二维码已出, 此后不刷新", flush=True)
time.sleep(8)
try:
    co = ChromiumOptions()
    co.set_local_port(port)
    page = ChromiumPage(co)
except Exception as e:
    print(f"[err] 连接失败: {str(e)[:80]}", flush=True)
    raise SystemExit(1)

t0 = time.time()
last = 0
while time.time() - t0 < TIMEOUT:
    try:
        src = page.html or ""
        url = page.url or ""
        if "新的创作" in src or "草稿箱" in src or re.search(r"token=\d+", url):
            print(f"[ok] {name} 登录成功! 登录态已存盘 ({int(time.time()-t0)}s)", flush=True)
            time.sleep(3)
            try:
                page.quit()
            except Exception:
                pass
            raise SystemExit(0)
        if "登录超时" in src or "请重新登录" in src:
            print("[note] 页面提示登录超时(未成功)", flush=True)
    except Exception:
        pass
    now = time.time() - t0
    if now - last >= 20:
        print(f"[wait] {name} 已等 {int(now)}s — 码不动, 请扫", flush=True)
        last = now
    time.sleep(4)
print(f"[timeout] {name} {TIMEOUT}s 未检测到登录, 窗口保留", flush=True)
raise SystemExit(1)
