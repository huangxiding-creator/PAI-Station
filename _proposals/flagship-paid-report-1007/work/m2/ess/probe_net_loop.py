# -*- coding: utf-8 -*-
"""ESS 网络探针循环 (python稳版): 每10min探 NBLM unsupported 是否解除.
解除 → 拉跑者补 ch12 → 退出0; 6小时未恢复 → 退出1."""
import subprocess
import time


def probe():
    r = subprocess.run(
        ["curl.exe", "-s", "-m", "10", "-x", "http://127.0.0.1:7895",
         "-o", "NUL", "-w", "%{http_code}|%{redirect_url}",
         "https://notebooklm.google.com"],
        capture_output=True, text=True, timeout=20)
    out = r.stdout.strip()
    parts = out.split("|", 1)
    code = parts[0] if parts else "000"
    redir = parts[1] if len(parts) > 1 else ""
    return code, redir


def launch_ch12():
    r = subprocess.run(
        ["powershell.exe", "-NoProfile", "-Command",
         "$env:NBLM_PROXY='http://127.0.0.1:7895';"
         "$p=Start-Process -FilePath py -ArgumentList '-3','-X','utf8',"
         "'ess_nblm_run.py','--phase','chapters','--chapters','12' "
         "-WorkingDirectory 'E:\\AI-Station\\_proposals\\flagship-paid-report-1007\\work\\m2\\ess' "
         "-WindowStyle Hidden "
         "-RedirectStandardOutput 'E:\\AI-Station\\_proposals\\flagship-paid-report-1007\\work\\m2\\ess\\nblm_ch12.log' "
         "-RedirectStandardError 'E:\\AI-Station\\_proposals\\flagship-paid-report-1007\\work\\m2\\ess\\nblm_ch12.err.log' "
         "-PassThru; Write-Output ('RUNNER-UP:' + $p.Id)"],
        capture_output=True, text=True, timeout=30)
    print(r.stdout.strip() or r.stderr.strip()[:100], flush=True)


if __name__ == "__main__":
    for i in range(1, 37):
        if i > 1:
            time.sleep(600)
        try:
            code, redir = probe()
        except Exception as e:
            code, redir = "ERR", str(e)[:40]
        print(f"[netprobe {i} {time.strftime('%H:%M')}] http={code} redir={redir[:60]}", flush=True)
        if code in ("200", "301", "302") and "unsupported" not in redir:
            print("NET-RECOVERED! 拉跑者补ch12", flush=True)
            launch_ch12()
            raise SystemExit(0)
    print("6小时未恢复 — 等用户网络动作", flush=True)
    raise SystemExit(1)
