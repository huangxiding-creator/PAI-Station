# -*- coding: utf-8 -*-
"""ldapp_driver.py — 雷电模拟器微信读书 UIA 驱动件（adb 直驱，零弹窗）

子命令（全部批处理友好）：
  dump                 当前 UI 元素表（text/clickable/bounds 一行一个）
  shot [name]          截屏到 evidence/emu_<name>.png
  tap <x> <y>          点坐标
  tap-text <regex>     按文本找控件点中心（uiautomator dump → bounds）
  deeplink <url>       am start VIEW deeplink（weread://web/bookDetail?bookId=…）
  back / home          返回键 / 回桌面
  focus                当前前台 Activity
  shell <cmd>          透传 adb shell
  pull <remote> <local> 透传 adb pull
  launch               拉起微信读书
设备固定 emulator-5554（雷电9）。
"""
import io
import os
import re
import subprocess
import sys
import time

ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "evidence")


def sh(*args, binary=False, timeout=60):
    r = subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True, timeout=timeout)
    return r.stdout if binary else r.stdout.decode("utf-8", "replace")


def dump_nodes():
    xml = sh("shell", "uiautomator", "dump", "/sdcard/ui.xml > /dev/null && cat /sdcard/ui.xml",
             timeout=90) if False else sh("shell",
                                          "uiautomator dump /sdcard/ui.xml > /dev/null; cat /sdcard/ui.xml",
                                          timeout=90)
    out = []
    for m in re.finditer(r'<node[^>]*text="([^"]*)"[^>]*clickable="true"[^>]*bounds="(\[\d+,\d+\]\[\d+,\d+\])"', xml):
        t, b = m.group(1), m.group(2)
        if t:
            out.append((t, b))
    if not out:  # clickable-true 在 text 之后的属性顺序兜底
        for m in re.finditer(r'text="([^"]+)"[^>]*?clickable="true"', xml):
            out.append((m.group(1), "?"))
    return out, xml


def bounds_center(b):
    nums = re.findall(r"\d+", b)
    if len(nums) == 4:
        return (int(nums[0]) + int(nums[2])) // 2, (int(nums[1]) + int(nums[3])) // 2
    return None


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "dump"
    if cmd == "dump":
        nodes, _ = dump_nodes()
        for t, b in nodes:
            print("%-6s %s" % (b, t))
    elif cmd == "shot":
        name = sys.argv[2] if len(sys.argv) > 2 else ("s%d" % time.time())
        os.makedirs(EV, exist_ok=True)
        p = os.path.join(EV, "emu_%s.png" % name)
        open(p, "wb").write(sh("exec-out", "screencap", "-p", binary=True))
        print(p)
    elif cmd == "tap":
        print(sh("shell", "input", "tap", sys.argv[2], sys.argv[3]).strip() or "ok")
    elif cmd == "tap-text":
        pat = re.compile(sys.argv[2])
        nodes, _ = dump_nodes()
        for t, b in nodes:
            if pat.search(t):
                c = bounds_center(b)
                if c:
                    print("tap %s at %s" % (t, c))
                    print(sh("shell", "input", "tap", str(c[0]), str(c[1])).strip() or "ok")
                    return 0
        print("NOT_FOUND", pat.pattern)
        return 1
    elif cmd == "deeplink":
        print(sh("shell", "am", "start", "-a", "android.intent.action.VIEW", "-d", sys.argv[2]).strip())
    elif cmd == "back":
        print(sh("shell", "input", "keyevent", "4").strip() or "ok")
    elif cmd == "home":
        print(sh("shell", "input", "keyevent", "3").strip() or "ok")
    elif cmd == "focus":
        for line in sh("shell", "dumpsys", "window").splitlines():
            if "mCurrentFocus" in line:
                print(line.strip())
    elif cmd == "shell":
        print(sh("shell", *sys.argv[2:]))
    elif cmd == "pull":
        print(sh("pull", sys.argv[2], sys.argv[3]).strip())
    elif cmd == "launch":
        print(sh("shell", "monkey", "-p", "com.tencent.weread",
                 "-c", "android.intent.category.LAUNCHER", "1").strip())
    else:
        print(__doc__)
        return 2
    return 0


if __name__ == "__main__":
    sys.exit(main())
