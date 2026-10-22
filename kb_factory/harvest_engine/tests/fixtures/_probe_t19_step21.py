# -*- coding: utf-8 -*-
"""T19 网络诊断2：launch args 是否落到 Chromium 进程 + 各旁路形态 goto 对照。"""
import subprocess
import time

from playwright.sync_api import sync_playwright

CASES = {
    "noproxy": {"args": ["--no-proxy-server"]},
    "direct_arg": {"args": ["--proxy-server=direct://"]},
}
for name, kw in CASES.items():
    with sync_playwright() as pw:
        b = pw.chromium.launch(headless=True, **kw)
        time.sleep(1.5)
        out = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
             "Where-Object {$_.CommandLine -match 'headless'} | "
             "ForEach-Object { $_.CommandLine }"],
            capture_output=True, text=True)
        lines = [l for l in (out.stdout or "").splitlines() if "proxy" in l.lower() or "headless" in l.lower()]
        print(f"--- {name}: cmdline proxy flags:")
        for l in lines[:3]:
            seg = [x for x in l.split() if "proxy" in x.lower()]
            print("   ", seg if seg else "(no proxy flag on this line)")
        pg = b.new_page()
        try:
            r = pg.goto("https://www.baidu.com/", timeout=15000)
            print(f"--- {name}: goto ->", r.status if r else None)
        except Exception as e:
            print(f"--- {name}: goto FAIL", str(e)[:100])
        b.close()
