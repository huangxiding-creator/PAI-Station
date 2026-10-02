# -*- coding: utf-8 -*-
"""让路全暂停执行器（0929 用户令沉淀：定时死命令必须 OS 级可执行，不依赖 Claude 会话活着）.

背景事故：0929 用户令「14:40 全暂停给自媒让路」，当时只挂了会话级 cron，
会话重启后触发器蒸发，让路令 2h15m 未执行。本件=根治件：暂停动作本身
沉淀为独立脚本，任何人任何时候可用 schtasks 注册一次性任务调它，与
Claude 会话生死无关。

用法:
    pythonw yield_pause_all.py             # 立即全暂停(杀研究进程+挂研究schtasks+落usn旗标)
    pythonw yield_pause_all.py --status    # 只读巡检(不动任何东西)
    pythonw yield_pause_all.py --resume    # 一键恢复(按 hold_state.json 最近账回滚)

行为:
    1. 杀研究域进程: cmdline 匹配 epc100|shunt_|corps_v3|epc50_collector|
       browser_minify|SouGouWeDown2|EngOpp-Mining (绝不碰 We-AIPO/CPOPC/clash)
    2. 挂研究域 schtasks (白名单制, 见 TASK_WHITELIST; Access denied 容忍跳过)
    3. 落 usn_watch_task.PAUSE 旗标 (usn-watch 是提权任务动不了, 旗标闸在脚本层)
    4. 账本 hold_state.json 只增不删, --resume 按最近一条回滚

恢复说明: EPC100-AlwaysOn-Keepalive/Shunt-AlwaysOn 重启用即自动拉起工厂与分流腿;
    ChannelConductor 重启用即恢复调度; 旗标删除后 usn-watch 下一跳即恢复。
"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from pathlib import Path

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(__file__).resolve().parent
STATE = ROOT / "hold_state.json"
USN_PAUSE = ROOT / "usn_watch_task.PAUSE"

# 研究域进程指纹（正则，大小写不敏感）。红线排除: WeAIPO 全域 / CPOPC / clash。
PROC_PATTERN = (r"epc100|shunt_|corps_v3|epc50_collector|browser_minify|"
                r"SouGouWeDown2|EngOpp-Mining")
PROC_EXCLUDE = r"We-AIPO|CPOPC|clash"

# 研究域 schtask 白名单（挂起目标; 23 个=0929 实战全集, 死信任务不列）。
TASK_WHITELIST = [
    "AutoManus-CorpsV3", "EngOppRetroDaily",
    "EPC100-AlwaysOn-Keepalive", "EPC100-AlwaysOn-Logon", "EPC100-Shunt-AlwaysOn",
    "PAIStation-EPC50-ImaTopup", "PAIStation-EPC50-R50-Resume",
    "PAIStation-EPC50-SougoNight", "PAIStation-EPC50-WereadNight",
    "PAIStation-EPC50-Yield1500", "PAIStation-EPC50-YieldGuard-Keeper",
    "RQSv3_DistillFDrive",
    "AnhuiSupervisor2", "JiangsuSupervisor2", "NJSupervisor2",
    "LayaServerKeepalive", "PAIStation-ChannelConductor",
    "PAIStation-chat-ingest", "PAIStation-fusion-refresh",
    "PAIStation-night-report", "PAIStation-signal-ingest",
    "PAIStation-test-suite", "PAIStation-rss-harvest", "WeChatBriefDaily",
]
NO_WINDOW = 0x08000000  # CREATE_NO_WINDOW


def _ps(script: str) -> str:
    r = subprocess.run(
        ["powershell", "-NoProfile", "-Command",
         "[Console]::OutputEncoding=[Text.Encoding]::UTF8; " + script],
        capture_output=True, creationflags=NO_WINDOW, timeout=180)
    return r.stdout.decode("utf-8", errors="replace")


def research_pids() -> list[tuple[int, str]]:
    out = _ps(
        "Get-CimInstance Win32_Process | Where-Object { $_.CommandLine -match "
        f"'{PROC_PATTERN}' -and $_.CommandLine -notmatch '{PROC_EXCLUDE}' "
        "-and $_.Name -notmatch '^(bash|sh|pwsh|powershell)' "  # 壳自匹配=误杀自己父进程
        "-and $_.ProcessId -ne $PID } | ForEach-Object { "
        '"{0}|{1}" -f $_.ProcessId, $_.CommandLine.Substring(0,[Math]::Min(110,$_.CommandLine.Length)) }')
    rows = []
    for line in out.splitlines():
        line = line.strip()
        if line and line[0].isdigit():
            pid_, _, cmd = line.partition("|")
            rows.append((int(pid_), cmd))
    return rows


def kill_all() -> list[int]:
    killed = []
    for pid_, _cmd in research_pids():
        subprocess.run(["taskkill", "/PID", str(pid_), "/T", "/F"],
                       capture_output=True, creationflags=NO_WINDOW)
        killed.append(pid_)
    return killed


def _task_state(name: str) -> str | None:
    out = _ps(f"(Get-ScheduledTask -TaskName '{name}' -ErrorAction SilentlyContinue).State")
    return out.strip() or None


def disable_all() -> dict[str, str]:
    result = {}
    for name in TASK_WHITELIST:
        st = _task_state(name)
        if st is None:
            result[name] = "not_found"
            continue
        r = subprocess.run(["schtasks", "/change", "/tn", name, "/disable"],
                           capture_output=True, creationflags=NO_WINDOW)
        result[name] = "disabled" if r.returncode == 0 else "denied"
    return result


def enable_from(last: dict) -> dict[str, str]:
    result = {}
    for name in last.get("tasks", {}):
        r = subprocess.run(["schtasks", "/change", "/tn", name, "/enable"],
                           capture_output=True, creationflags=NO_WINDOW)
        result[name] = "enabled" if r.returncode == 0 else "failed"
    return result


def load_state() -> dict:
    if STATE.exists():
        return json.loads(STATE.read_text(encoding="utf-8"))
    return {"entries": []}


def append_entry(kind: str, payload: dict) -> None:
    st = load_state()
    st["entries"].append({
        "ts": time.strftime("%Y-%m-%d %H:%M:%S"), "kind": kind, **payload})
    STATE.write_text(json.dumps(st, ensure_ascii=False, indent=1), encoding="utf-8")


def main(argv: list[str]) -> int:
    if "--status" in argv:
        procs = research_pids()
        print(f"研究域活进程 {len(procs)} 个:")
        for pid_, cmd in procs:
            print(f"  {pid_}|{cmd[:100]}")
        live = [n for n in TASK_WHITELIST if _task_state(n) == "Ready"]
        print(f"白名单任务 Ready {len(live)} 个: {', '.join(live) or '无'}")
        print(f"usn 旗标: {'在(暂停中)' if USN_PAUSE.exists() else '无(运行中)'}")
        return 0

    if "--resume" in argv:
        st = load_state()
        if not st["entries"]:
            print("无 hold 账可回滚")
            return 1
        last = next((e for e in reversed(st["entries"]) if e["kind"] == "pause"), None)
        if not last:
            print("无 pause 账可回滚")
            return 1
        tasks = enable_from(last)
        if USN_PAUSE.exists():
            USN_PAUSE.unlink()
            print("usn 旗标已撤, 下一跳恢复")
        append_entry("resume", {"tasks": tasks})
        print(f"已恢复 {sum(1 for v in tasks.values() if v == 'enabled')} 个任务; "
              "工厂/分流由 AlwaysOn 自行拉起")
        return 0

    killed = kill_all()
    tasks = disable_all()
    USN_PAUSE.touch()
    append_entry("pause", {"killed_pids": killed, "tasks": tasks})
    print(f"已杀 {len(killed)} 进程; 任务禁用 "
          f"{sum(1 for v in tasks.values() if v == 'disabled')}, 拒访 "
          f"{sum(1 for v in tasks.values() if v == 'denied')}; usn 旗标已落")
    return 0


if __name__ == "__main__":
    raise SystemExit(main(sys.argv[1:]))
