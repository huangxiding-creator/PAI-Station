# -*- coding: utf-8 -*-
"""laya-server 看护：healthz 探活 → 死则无窗拉起（CREATE_NO_WINDOW 纪律）。

用法（schtasks 每 10 分钟 + 登录时）:
  <venv>/Scripts/pythonw.exe keepalive.py
行为: GET /healthz 2s 超时；不通则启动 server.py（分离进程、无窗、日志
server.log），写 server.pid；已有 pid 活着就不重复拉。静默退出，绝不弹窗。
"""
import json
import os
import subprocess
import urllib.request
from pathlib import Path

HERE = Path(__file__).resolve().parent
VENV_PY = HERE / "venv" / "Scripts" / "pythonw.exe"
PORT = int(os.environ.get("LAYA_PORT", "8864"))
HEALTHZ = f"http://127.0.0.1:{PORT}/healthz"
PID_FILE = HERE / "server.pid"
LOG = HERE / "server.log"


def _alive() -> bool:
    try:
        with urllib.request.urlopen(HEALTHZ, timeout=2) as r:
            return json.loads(r.read().decode("utf-8")).get("ok") is True
    except Exception:
        return False


def _pid_running(pid: int) -> bool:
    try:
        # Windows: 权限受限的进程抛 OSError 也算活着（存在即不重复拉）
        import ctypes
        k32 = ctypes.windll.kernel32
        h = k32.OpenProcess(0x1000, False, pid)   # PROCESS_QUERY_LIMITED_INFORMATION
        if not h:
            return False
        k32.CloseHandle(h)
        return True
    except Exception:
        return False


def main() -> int:
    if _alive():
        return 0
    if PID_FILE.is_file():
        try:
            if _pid_running(int(PID_FILE.read_text().strip())):
                return 0        # 冷加载中，勿扰
        except ValueError:
            pass
    env = {**os.environ, "USE_TF": "0", "HF_HUB_OFFLINE": "1",
           "PYTHONIOENCODING": "utf-8"}
    proc = subprocess.Popen(                    # 无窗：pythonw + CREATE_NO_WINDOW
        [str(VENV_PY), str(HERE / "server.py")],
        cwd=str(HERE), env=env, stdout=open(LOG, "ab"),
        stderr=subprocess.STDOUT,
        creationflags=0x08000000)               # CREATE_NO_WINDOW
    PID_FILE.write_text(str(proc.pid), encoding="ascii")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
