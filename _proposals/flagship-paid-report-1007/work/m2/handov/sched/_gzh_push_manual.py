# -*- coding: utf-8 -*-
"""_gzh_push_manual — 手工 subprocess 起 Chrome(反检测flags) → DrissionPage connect → 投稿.
等价于骑永动机活会话 (非 DrissionPage 自启, 无 automation 启动指纹).
用法: py -X utf8 _gzh_push_manual.py <acct> <md> <title> <img>
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
PORTS = {"acct01": 9352, "acct05": 9351, "acct07": 9353}


def main() -> int:
    acct, md, title, img = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
    port = PORTS[acct]
    profile = os.path.join(PROFILE, acct)
    proc = subprocess.Popen(
        [CHROME, f"--remote-debugging-port={port}", f"--user-data-dir={profile}",
         "--window-position=-32000,-32000", "--window-size=1280,800", "--new-window",
         "--disable-blink-features=AutomationControlled", "--no-first-run",
         "--no-default-browser-check", "--disable-infobars", "about:blank"])
    print(f"[launch] chrome pid={proc.pid} port={port}", flush=True)
    time.sleep(6)
    co = ChromiumOptions()
    co.set_local_port(port)
    page = ChromiumPage(co)
    try:
        # 复用投稿脚本的投递逻辑: 以骑活会话模式调它 (第5参=端口)
        r = subprocess.run(
            [r"E:\AI-Station\.venv\Scripts\python.exe", "-X", "utf8",
             r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\handov\sched\_handov_gzh_draft.py",
             acct, md, title, img, str(port)],
            capture_output=True, text=True, timeout=420, encoding="utf-8", errors="replace")
        out = (r.stdout or "") + (r.stderr or "")
        # 全量输出尾部 (排障), 不再关键词过滤
        for ln in out.splitlines()[-14:]:
            if "verify] 期望" in ln:
                continue
            print("  ", ln[:110], flush=True)
        ok = "落箱验证: PASS" in out
    finally:
        try:
            page.quit()
        except Exception:
            pass
        try:
            proc.terminate()
        except Exception:
            pass
    print("[done]", "PASS" if ok else "FAIL", flush=True)
    return 0 if ok else 1


if __name__ == "__main__":
    raise SystemExit(main())
