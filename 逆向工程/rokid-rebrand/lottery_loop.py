# -*- coding: utf-8 -*-
"""lottery_loop.py — 脱壳彩票循环机（配置已改自动落盘）：循环触发→轮询dexDump→命中即停
"""
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
LOG = r"E:\AI-Station\逆向工程\rokid-rebrand\evidence\lottery.log"
DUMP = "/storage/emulated/0/Download/dexDump"


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", "emulator-5554"] + list(args),
                          capture_output=True, timeout=timeout).stdout.decode("utf-8", "replace")


def tap(x, y, wait=1.5):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def has_dex():
    return sh("shell", f"su -c 'ls {DUMP}/*.dex 2>/dev/null | head -3'").strip().endswith(".dex")


def focus():
    return sh("shell", "dumpsys window | grep mCurrentFocus")


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, "a", encoding="utf-8") as fh:
        fh.write(line + "\n")


def main():
    log("彩票循环机启动（最多16轮/每轮10分钟）")
    for rnd in range(16):
        # 确保列表
        if "blackdex" not in focus():
            sh("shell", "am", "force-stop", "top.niunaijun.blackdexa64")
            time.sleep(4)
            sh("shell", "am", "start", "-n",
               "top.niunaijun.blackdexa64/top.niunaijun.blackdex.view.base.WelcomeActivity")
            time.sleep(10)
            tap(1280, 115, 2)
            sh("shell", "input", "text", "rokid")
            time.sleep(3)
        log(f"轮{rnd + 1}: 点开始脱壳")
        tap(1000, 655, 3)
        # 等 9 分钟，每 20s 查一次
        t0 = time.time()
        hit = False
        while time.time() - t0 < 540:
            if has_dex():
                hit = True
                break
            time.sleep(20)
        if hit:
            files = sh("shell", f"su -c 'ls -la {DUMP}/ | head -25'")
            log(f"★★★ 命中！轮{rnd + 1}:\n{files}")
            return 0
        log(f"轮{rnd + 1}: 未中，重启应用再战")
    log("16轮未中，退出")
    return 1


if __name__ == "__main__":
    sys.exit(main())
