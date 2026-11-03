# -*- coding: utf-8 -*-
"""mumu_lottery.py v3 — MuMu A15 全量重置彩票机（mv 秒杀重置法）"""
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
D = "127.0.0.1:16384"
LOG = r"E:\AI-Station\逆向工程\rokid-rebrand\evidence\mumu_lottery.log"
DUMP = "/storage/emulated/0/Download/dexDump"
BD = "top.niunaijun.blackdexa64"
STAMP = str(int(time.time()))[-5:]


def sh(cmd, timeout=60):
    try:
        return subprocess.run([ADB, "-s", D, "shell", cmd], capture_output=True,
                              timeout=timeout).stdout.decode("utf-8", "replace")
    except Exception:
        return ""


def tap(x, y, wait=1.5):
    sh(f"input tap {x} {y}")
    time.sleep(wait)


def log(msg):
    line = f"[{time.strftime('%H:%M:%S')}] {msg}"
    print(line, flush=True)
    with open(LOG, "a", encoding="utf-8") as fh:
        fh.write(line + "\n")


def has_dex():
    return ".dex" in sh(f"ls {DUMP}/ 2>/dev/null", 30)


def main():
    log("v3 彩票机启动（mv 重置法）")
    for rnd in range(20):
        sh(f"am force-stop {BD}", 30)
        time.sleep(3)
        # mv 秒杀重置（改名即重置，删除交给下一轮垃圾回收）
        sh("mv /data/data/top.niunaijun.blackdexa64/virtual "
           f"/data/data/top.niunaijun.blackdexa64/virtual.old{STAMP} 2>/dev/null", 30)
        sh("mv /data/data/top.niunaijun.blackdexa64/code_cache "
           f"/data/data/top.niunaijun.blackdexa64/cc.old{STAMP} 2>/dev/null", 30)
        sh(f"rm -rf {DUMP} 2>/dev/null", 30)
        sh("rm -rf /data/data/top.niunaijun.blackdexa64/virtual.old* "
           "/data/data/top.niunaijun.blackdexa64/cc.old* 2>/dev/null", 45)
        time.sleep(2)
        sh(f"am start -n {BD}/top.niunaijun.blackdex.view.base.WelcomeActivity", 30)
        time.sleep(11)
        tap(1280, 115, 2)
        sh("input text rokid", 20)
        time.sleep(3)
        pc = sh("ps -A | grep -c ':p[0-9]'", 20).strip()
        log(f"轮{rnd + 1}: 点脱壳 (p={pc})")
        tap(1000, 655, 3)
        t0 = time.time()
        best = 0
        while time.time() - t0 < 420:
            try:
                best = max(best, int(sh("ps -A | grep -c ':p[0-9]'", 20).strip() or 0))
            except ValueError:
                pass
            if has_dex():
                files = sh(f"ls -la {DUMP}/", 30)
                log(f"★★★ 命中！轮{rnd + 1} p峰={best}:\n{files}")
                return 0
            time.sleep(15)
        log(f"轮{rnd + 1}: 未中 (p峰={best})")
    log("20轮全灭")
    return 1


if __name__ == "__main__":
    sys.exit(main())
