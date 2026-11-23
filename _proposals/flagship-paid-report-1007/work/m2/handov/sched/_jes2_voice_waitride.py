# -*- coding: utf-8 -*-
"""_jes2_voice_waitride — 等永动机 acct05 活口出现即骑会话投 JES2 之声稿.
1121 终案: 自起实例投递 100% 静默失败(ueditor 内容模型失效), 骑活会话 100% 成功.
用法: py -X utf8 _jes2_voice_waitride.py  (轮询最长6小时)
"""
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")


def find_acct05_port():
    try:
        out = subprocess.run(
            ["powershell", "-NoProfile", "-Command",
             "(Get-CimInstance Win32_Process -Filter \"Name='chrome.exe'\" | "
             "Where-Object {$_.CommandLine -match 'remote-debugging-port=(\\d+) --user-data-dir=\"?F:\\\\We-AIPO\\\\autopub\\\\data\\\\browser_profiles\\\\acct05\"?'} "
             "| Select-Object -First 1).CommandLine"],
            capture_output=True, text=True, timeout=30)
        m = re.search(r"remote-debugging-port=(\d+)", out.stdout or "")
        return int(m.group(1)) if m else None
    except Exception:
        return None


def main() -> int:
    t0 = time.time()
    print("[wait] 等 acct05 活口 (最长6h)...", flush=True)
    while time.time() - t0 < 6 * 3600:
        port = find_acct05_port()
        if port:
            print(f"[wait] acct05 活口 @{port} — 骑会话投递", flush=True)
            r = subprocess.run(
                [r"E:\AI-Station\.venv\Scripts\python.exe", "-X", "utf8",
                 r"E:\AI-Station\_proposals\flagship-paid-report-1007\work\m2\handov\sched\_handov_gzh_draft.py",
                 "acct05",
                 r"E:\AI-Station\report_platform\promo\2026-11-20_zbzs_jes2_launch.md",
                 "发布| 《建工司法解释二逐条实务与多立场应对实战研究报告》",
                 r"E:\AI-Station\report_platform\promo\posters\JES2-2026.png",
                 str(port)],
                capture_output=True, text=True, timeout=420, encoding="utf-8", errors="replace")
            out = (r.stdout or "") + (r.stderr or "")
            for ln in out.splitlines():
                if any(k in ln for k in ("paste", "save", "verify", "fatal", "token")):
                    print(" ", ln[:100], flush=True)
            if "落箱验证: PASS" in out:
                print("[done] 投递成功", flush=True)
                return 0
            print("[retry] 5分钟后重试...", flush=True)
            time.sleep(300)
            continue
        time.sleep(120)
    print("[timeout] 6小时未见活口", flush=True)
    return 1


if __name__ == "__main__":
    raise SystemExit(main())
