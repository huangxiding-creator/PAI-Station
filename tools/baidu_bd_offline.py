# -*- coding: utf-8 -*-
"""baidu_bd_offline.py — BDUSS 落地后一键收口: 登录 BaiduPCS-Go + 提交
102G 裁判文书磁力链云端离线下载 + 验证任务列表.

纪律: bduss/stoken 只从 data/secrets/baidu_bduss.ini 读入本进程内存,
绝不打印/绝不写日志(BaiduPCS-Go 自身的 login 子命令输出不含凭据原文).
"""
import configparser
import subprocess
import sys
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")

ROOT = Path(r"E:\AI-Station")
SECRETS = ROOT / "data" / "secrets" / "baidu_bduss.ini"
EXE = (ROOT / "tools" / "baidupcs" / "BaiduPCS-Go-v4.0.2-windows-x64"
       / "BaiduPCS-Go.exe")
MAGNET_FILE = ROOT / "tools" / "wenshu_magnet.txt"


def run(*args: str) -> subprocess.CompletedProcess:
    return subprocess.run([str(EXE), *args], capture_output=True,
                          timeout=120, cwd=str(EXE.parent))


def main() -> int:
    cp = configparser.ConfigParser()
    cp.read(SECRETS, encoding="utf-8")
    bduss = cp.get("baidu", "bduss", fallback="").strip()
    stoken = cp.get("baidu", "stoken", fallback="").strip()
    if not bduss:
        print("NO_BDUSS_IN_INI")
        return 1
    print(f"[0] ini ok: bduss_len={len(bduss)} stoken_len={len(stoken)}")

    r = run("login", f"-bduss={bduss}", f"-stoken={stoken}")
    out = (r.stdout or b"").decode("utf-8", "replace")
    print("[1] login rc=", r.returncode)
    print(out[:600])

    r2 = run("loglist")
    out2 = (r2.stdout or b"").decode("utf-8", "replace")
    print("[2] loglist rc=", r2.returncode)
    print(out2[:600])

    if "uid: 0" in out2:
        print("STILL_NOT_LOGGED_IN — 停, 不提交离线任务")
        return 2

    magnet = MAGNET_FILE.read_text(encoding="utf-8").strip()
    print(f"[3] magnet len={len(magnet)} btih=…"
          f"{magnet[magnet.find('btih:') + 5:][:8]}")
    r3 = run("offlinedl", "add", "-path=/wenshu", magnet)
    out3 = (r3.stdout or b"").decode("utf-8", "replace")
    err3 = (r3.stderr or b"").decode("utf-8", "replace")
    print("[4] offlinedl add rc=", r3.returncode)
    print((out3 + err3)[:900])

    r4 = run("offlinedl", "list")
    out4 = (r4.stdout or b"").decode("utf-8", "replace")
    print("[5] offlinedl list rc=", r4.returncode)
    print(out4[:900])
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
