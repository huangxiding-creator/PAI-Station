# -*- coding: utf-8 -*-
"""shot.py <tag> — 三窗截图助手: 全屏 + 上半 + 下半(1:1原尺寸)"""
import subprocess
import sys
from pathlib import Path
from PIL import Image

ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\evidence")


def main():
    tag = sys.argv[1] if len(sys.argv) > 1 else "s"
    p = EV / f"{tag}.png"
    subprocess.run([ADB, "-s", DEV, "exec-out", "screencap", "-p"],
                   stdout=open(p, "wb"), timeout=60)
    im = Image.open(p)
    w, h = im.size
    top = im.crop((0, 0, w, h // 2))
    bot = im.crop((0, h // 2, w, h))
    top.save(EV / f"{tag}_top.png")
    bot.save(EV / f"{tag}_bot.png")
    print(f"{p} | full={w}x{h} → {tag}_top/{tag}_bot (1:1)")


if __name__ == "__main__":
    main()
