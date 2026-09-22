# -*- coding: utf-8 -*-
"""ECS 远程执行/上传小工具 — paramiko 封装 (0922).

用法:
  python ecs_exec.py "命令"            # 远程执行
  python ecs_exec.py --put 本地 远程    # 上传
凭据只从 data/secrets/aliyun_ecs_password.json 读取, 绝不打印.
"""
import json
import sys
from pathlib import Path

import paramiko

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
CREDS = json.loads(
    (Path(__file__).resolve().parent.parent / "data" / "secrets" / "aliyun_ecs_password.json")
    .read_text(encoding="utf-8"))
HOST, USER, PW = "47.120.43.20", "root", CREDS["password"]


def run(cmd: str, timeout: int = 60) -> None:
    cli = paramiko.SSHClient()
    cli.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        cli.connect(HOST, username=USER, password=PW, timeout=15)
        _, out, err = cli.exec_command(cmd, timeout=timeout)
        o = out.read().decode("utf-8", "replace")
        e = err.read().decode("utf-8", "replace")
        if o:
            print(o)
        if e:
            print("[stderr]", e)
    finally:
        cli.close()


def put(local: str, remote: str) -> None:
    cli = paramiko.SSHClient()
    cli.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    try:
        cli.connect(HOST, username=USER, password=PW, timeout=15)
        sftp = cli.open_sftp()
        sftp.put(local, remote)
        print(f"[put] {local} -> {remote}")
        sftp.close()
    finally:
        cli.close()


def main() -> None:
    if sys.argv[1] == "--put":
        put(sys.argv[2], sys.argv[3])
    else:
        run(sys.argv[1], timeout=int(sys.argv[4]) if len(sys.argv) > 4 else 60)


if __name__ == "__main__":
    main()
