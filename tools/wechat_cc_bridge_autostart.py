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


def main():
    if not MAIN_JS.exists():
        return
    if alive_pid():
        return
    LOGS.mkdir(parents=True, exist_ok=True)
    node = shutil.which("node")
    if not node:
        return
    env = os.environ.copy()
    cbd = claude_bin_dir()
    if cbd:
        env["PATH"] = cbd + os.pathsep + env.get("PATH", "")
    with open(LOGS / "stdout.log", "ab") as so, \
            open(LOGS / "stderr.log", "ab") as se:
        subprocess.Popen(
            [node, str(MAIN_JS), "start"],
            cwd=str(SKILL), env=env, stdin=subprocess.DEVNULL,
            stdout=so, stderr=se, creationflags=_creationflags())
    time.sleep(2)
    pid = alive_pid()
    (DATA / "wechat-claude-code.pid").write_text(str(pid or ""), encoding="utf-8")


if __name__ == "__main__":
    main()
