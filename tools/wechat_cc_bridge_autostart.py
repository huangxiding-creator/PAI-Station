# -*- coding: utf-8 -*-
"""wechat-claude-code 桥 Windows 自启/看护器（schtasks 调 pythonw，零弹窗）。

幂等：发现 node.exe 命令行含本 skill 的 dist/main.js 即视为在跑、退出；
否则 DETACHED|CREATE_NO_WINDOW 拉起守护进程，PATH 前置 VSCode 扩展原生
claude.exe 目录（按版本 glob 择新——扩展升级换目录不失效）。

计划任务（MSYS_NO_PATHCONV=1 schtasks /create）：
  PAIStation-wechat-cc-bridge-logon    /sc onlogon   登录即启
  PAIStation-wechat-cc-bridge-watchdog /sc minute /mo 5  崩溃≤5min 拉回
"""
import glob
import os
import shutil
import subprocess
import time
from pathlib import Path

SKILL = Path.home() / ".claude" / "skills" / "wechat-claude-code"
DATA = Path.home() / ".wechat-claude-code"
LOGS = DATA / "logs"
MAIN_JS = SKILL / "dist" / "main.js"


def _creationflags() -> int:
    return subprocess.CREATE_NO_WINDOW | subprocess.DETACHED_PROCESS


def alive_pid():
    """按 Windows 命令行探测守护进程（与 MSYS pid 无关）。"""
    try:
        out = subprocess.run(
            ["wmic", "process", "where", "name='node.exe'",
             "get", "ProcessId,CommandLine"],
            capture_output=True, text=True, timeout=15,
            creationflags=_creationflags()).stdout
    except Exception:
        return None
    for line in out.splitlines():
        if "wechat-claude-code" in line and "main.js" in line:
            tail = line.strip().split()[-1]
            if tail.isdigit():
                return int(tail)
    return None


def claude_bin_dir():
    """VSCode 扩展原生 claude.exe，版本 glob 择新（升级换目录不失效）。"""
    hits = sorted(glob.glob(str(
        Path.home() / r".vscode\extensions\anthropic.claude-code-*"
        r"\resources\native-binary")))
    return hits[-1] if hits else ""


def pid_alive(pid: str) -> bool:
    """pid 文件探活（tasklist）——双实例下 wmic 命令行匹配无法区分
    两个 main.js，各自 DATA 目录的 pid 文件才是实例身份。"""
    if not (pid or "").isdigit():
        return False
    try:
        out = subprocess.run(
            ["tasklist", "/FI", f"PID eq {pid}"],
            capture_output=True, text=True, timeout=10,
            creationflags=_creationflags()).stdout
    except Exception:
        return False
    return pid in out


def main():
    import argparse

    ap = argparse.ArgumentParser()
    ap.add_argument("--data-dir", default=str(DATA),
                    help="桥数据目录（第二实例传 ~/.wechat-claude-code-b）")
    args = ap.parse_args()
    data = Path(args.data_dir)
    pidf = data / "wechat-claude-code.pid"
    if pidf.exists() and pid_alive(pidf.read_text().strip()):
        return  # 本实例已在跑（pid 文件制，双实例互不误判）
    data.mkdir(parents=True, exist_ok=True)
    (data / "logs").mkdir(parents=True, exist_ok=True)
    node = shutil.which("node")
    if not node:
        return
    env = os.environ.copy()
    env["WCC_DATA_DIR"] = str(data)  # constants.js 原生支持
    cbd = claude_bin_dir()
    if cbd:
        env["PATH"] = cbd + os.pathsep + env.get("PATH", "")
    with open(data / "logs" / "stdout.log", "ab") as so, \
            open(data / "logs" / "stderr.log", "ab") as se:
        proc = subprocess.Popen(
            [node, str(MAIN_JS), "start"],
            cwd=str(SKILL), env=env, stdin=subprocess.DEVNULL,
            stdout=so, stderr=se, creationflags=_creationflags())
    time.sleep(2)
    pidf.write_text(str(proc.pid), encoding="utf-8")


if __name__ == "__main__":
    main()
