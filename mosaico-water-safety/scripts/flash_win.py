# -*- coding: utf-8 -*-
"""Windows 侧烧录: firmware_out/*.bin → COM 口。首次需板子进下载模式(关机按住BOOT再按POWER)。
用法: py scripts/flash_win.py COM7 [--full]
  --full: 全量烧录(bootloader+partition+app+system+storage, 出厂CDC在位时通常不需要)
"""
from __future__ import annotations

import argparse
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(os.path.dirname(HERE), "firmware_out")


def esptool(args: list[str]) -> int:
    cmd = [sys.executable, "-m", "esptool", "--chip", "esp32s31"] + args
    print(">", " ".join(cmd))
    return subprocess.call(cmd)


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("port")
    ap.add_argument("--full", action="store_true")
    ap.add_argument("--baud", type=int, default=921600)
    a = ap.parse_args()

    app = os.path.join(OUT, "esp_mosaico-claw.bin")
    if not os.path.exists(app):
        apps = [f for f in os.listdir(OUT) if f.endswith(".bin") and "esp_mosaico" in f] if os.path.isdir(OUT) else []
        if not apps:
            print("[err] 未找到应用 bin, 先跑 build_wsl.sh")
            return 2
        app = os.path.join(OUT, apps[0])

    if a.full:
        args = ["--port", a.port, "--baud", str(a.baud), "write-flash",
                "0x2000", os.path.join(OUT, "bootloader.bin"),
                "0x9000", os.path.join(OUT, "partition-table.bin"),
                "0x20000", app,
                ]
        for name, off in (("system.bin", "0xa20000"), ("storage.bin", "0xcaa000")):
            p = os.path.join(OUT, name)
            if os.path.exists(p):
                args += [off, p]
        return esptool(args)
    return esptool(["--port", a.port, "--baud", str(a.baud), "write-flash", "0x20000", app])


if __name__ == "__main__":
    raise SystemExit(main())
