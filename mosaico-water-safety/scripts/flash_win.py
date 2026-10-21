# -*- coding: utf-8 -*-
"""Windows 侧烧录: firmware_out/*.bin → COM 口（全量, 首次必须全烧）。
用法: py scripts/flash_win.py COM7
首次裸板需手动进下载模式(关机→按住BOOT→按POWER)
"""
from __future__ import annotations

import argparse
import os
import subprocess
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.join(os.path.dirname(HERE), "firmware_out")

# 地址表: 来自 idf.py build 输出的官方烧录命令
FLASH_LAYOUT = [
    ("0x2000", "bootloader.bin"),
    ("0x8000", "partition-table.bin"),
    ("0x9000", "ota_data_claw.bin"),
    ("0x20000", "vibe-mode.bin"),
    ("0x210000", "edge_agent.bin"),
    ("0x9e0000", "ui_apps.bin"),
    ("0xcb0000", "system.bin"),
]


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("port", help="如 COM7")
    ap.add_argument("--baud", type=int, default=460800)
    a = ap.parse_args()

    # 检查文件齐备
    missing = [f for _, f in FLASH_LAYOUT if not os.path.exists(os.path.join(OUT, f))]
    if missing:
        print(f"[err] 缺件: {missing}")
        return 2

    args = ["--chip", "esp32s31", "-b", str(a.baud),
            "--before", "default-reset", "--after", "hard-reset", "--no-stub",
            "write-flash", "--flash-mode", "dio", "--flash-size", "16MB", "--flash-freq", "80m"]
    for addr, fn in FLASH_LAYOUT:
        args += [addr, os.path.join(OUT, fn)]

    cmd = [sys.executable, "-m", "esptool"] + args
    print(">", " ".join(cmd))
    return subprocess.call(cmd)


if __name__ == "__main__":
    raise SystemExit(main())
