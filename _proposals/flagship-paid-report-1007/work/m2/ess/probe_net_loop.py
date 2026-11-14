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


def runner_alive() -> bool:
    r = subprocess.run(
        ["powershell.exe", "-NoProfile", "-Command",
         "(Get-CimInstance Win32_Process -Filter \"Name like 'python%'\" | "
         "Where-Object {$_.CommandLine -match 'ess_nblm_run'}).Count"],
        capture_output=True, text=True, timeout=60)
    try:
        return int((r.stdout or "0").strip()) > 0
    except ValueError:
        return False


def launch_ch12():
    if runner_alive():
        print("跑者已在位, 不重复拉起 (防双开)", flush=True)
        return
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
        capture_output=True, text=True, timeout=120)
    print((r.stdout or r.stderr[:100]).strip(), flush=True)


if __name__ == "__main__":
    for i in range(1, 37):
        if i > 1:
            time.sleep(600)
        try:
            code, redir = probe()
        except Exception as e:
            code, redir = "ERR", str(e)[:40]
        mark = ""
        if code in ("200", "301", "302") and "unsupported" not in redir:
            mark = " [GOOD窗口]"
        print(f"[netprobe {i} {time.strftime('%H:%M')}] http={code} redir={redir[:60]}{mark}", flush=True)
        if mark:
            try:
                launch_ch12()
            except Exception as e:
                print("launch 异常:", str(e)[:80], flush=True)
        # 章账12 = 终局
        try:
            import json as _j
            st = _j.load(open("sched/nblm_state.json", encoding="utf-8"))
            if len(st.get("chapters", {})) >= 12:
                print("ALL-12! ch12 已落账, 哨兵收岗", flush=True)
                raise SystemExit(0)
        except SystemExit:
            raise
        except Exception:
            pass
    print("6小时窗口哨耗尽 — 等用户网络动作", flush=True)
    raise SystemExit(1)
