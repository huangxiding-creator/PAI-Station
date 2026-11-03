# -*- coding: utf-8 -*-
"""picker_harvest.py — 终版：触发脱壳 → 检测系统DocumentsUI(出料选择器) → UIA精确定位确定钮 → 落盘
关键洞察: BlackDex 的"脱壳文件列表"= Android SAF 文件选择器(documentsui), 系统UI有完整无障碍节点
"""
import re
import subprocess
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\evidence")
BD = "top.niunaijun.blackdexa64"
DUMP = "/data/media/0/Download/dexDump"


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout.decode("utf-8", "replace")


def tap(x, y, wait=1.5):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def focus():
    return sh("shell", "dumpsys window | grep mCurrentFocus")


def picker_up():
    return "documentsui" in focus() or "filepicker" in focus().lower()


def dump_ui():
    return sh("shell", "uiautomator dump /sdcard/ui.xml > /dev/null; cat /sdcard/ui.xml")


def find_and_tap_save():
    xml = dump_ui()
    # 找 保存/确定/SAVE 按钮节点
    for label in ["保存", "确定", "SAVE", "Save", "仅一次", "总是允许"]:
        pat = re.compile(
            r'text="%s"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"' % re.escape(label))
        m = pat.search(xml)
        if not m:
            pat2 = re.compile(
                r'text="[^"]*"[^>]*content-desc="%s"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"'
                % re.escape(label))
            m = pat2.search(xml)
        if m:
            x = (int(m.group(1)) + int(m.group(3))) // 2
            y = (int(m.group(2)) + int(m.group(4))) // 2
            print(f"[*] 找到「{label}」@ ({x},{y}) → 点击", flush=True)
            tap(x, y, 3)
            return True
    # 全选 checkbox
    m = re.search(r'text="全选"[^>]*bounds="\[(\d+),(\d+)\]\[(\d+),(\d+)\]"', xml)
    if m:
        x = (int(m.group(1)) + int(m.group(3))) // 2
        y = (int(m.group(2)) + int(m.group(4))) // 2
        print(f"[*] 找到「全选」@ ({x},{y}) → 点击", flush=True)
        tap(x, y, 2)
    return False


def has_dex():
    return ".dex" in sh("shell", f"ls {DUMP}/")


def main():
    for attempt in range(8):
        print(f"=== 周期 {attempt + 1} ===", flush=True)
        # 确保列表页 + 触发
        if "blackdex" not in focus():
            sh("shell", "am", "start", "-n",
               f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
            time.sleep(8)
            tap(1280, 115, 2)
            sh("shell", "input", "text", "rokid")
            time.sleep(2)
        tap(1000, 655, 2)
        # 等选择器出现（解壳几分钟）
        t0 = time.time()
        rescued = False
        while time.time() - t0 < 420:
            if has_dex():
                print("[✓] dexDump 出料！", flush=True)
                return 0
            f = focus()
            if picker_up():
                print(f"[★] 文件选择器出现！({time.strftime('%H:%M:%S')})", flush=True)
                time.sleep(2)
                find_and_tap_save()
                time.sleep(3)
                find_and_tap_save()   # 全选后再点保存
                time.sleep(5)
                if has_dex():
                    print("[✓] 导出成功！", flush=True)
                    return 0
                # 可能还有确认弹层
                find_and_tap_save()
                time.sleep(5)
            elif "blackdex" in f and not rescued and time.time() - t0 > 100:
                # 卡日志面板 → 自救
                print("[*] 自救 …", flush=True)
                tap(1280, 1120, 3)
                sh("shell", "input", "swipe", "500", "650", "500", "650", "1200")
                time.sleep(3)
                tap(1380, 895, 5)
                rescued = True
            time.sleep(6)
    print("[✗] 8 周期未成", flush=True)
    return 1


if __name__ == "__main__":
    sys.exit(main())
