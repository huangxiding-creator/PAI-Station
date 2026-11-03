# -*- coding: utf-8 -*-
"""full_auto.py — BlackDex 脱壳导出终局状态机（全自动闭环）
状态流: 重启BD → 搜rokid → 开始脱壳 → 卡镜像>90s则(关闭+卡片长按启动镜像) →
        等脱壳完成 → 点卡片查看 → 暗面板几何定位(全选/确定) → 验证dexDump出料
"""
import subprocess
import sys
import time
from pathlib import Path

from PIL import Image

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ADB = r"E:\AI-Station\rea-tools\platform-tools\adb.exe"
DEV = "emulator-5554"
EV = Path(r"E:\AI-Station\逆向工程\rokid-rebrand\evidence")
DUMP = "/data/media/0/Download/dexDump"
BD = "top.niunaijun.blackdexa64"


def sh(*args, timeout=90):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def tap(x, y, wait=1.2):
    sh("shell", "input", "tap", str(x), str(y))
    time.sleep(wait)


def shot(name):
    p = EV / f"fa_{name}.png"
    open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
    return Image.open(p).convert("RGB")


def has_dex():
    return ".dex" in sh("shell", f"ls {DUMP}/").decode("utf-8", "replace")


def dark_box(im):
    """返回暗色对话框的包围盒 (x0,y0,x1,y1)（大块连续暗区）"""
    w, h = im.size
    sm = im.resize((w // 8, h // 8))
    sw, sh_ = sm.size
    px = sm.load()
    dark = [[sum(px[x, y]) / 3 < 70 for y in range(sh_)] for x in range(sw)]
    xs = [x for x in range(sw) for y in range(sh_) if dark[x][y]]
    ys = [y for y in range(sh_) for x in range(sw) if dark[x][y]]
    if not xs:
        return None
    return (min(xs) * 8, min(ys) * 8, (max(xs) + 1) * 8, (max(ys) + 1) * 8)


def dialog_dark_ratio(im):
    w, h = im.size
    c = im.crop((w // 4, h // 3, 3 * w // 4, 2 * h // 3)).resize((40, 24))
    px = list(c.getdata())
    dark = sum(1 for p in px if sum(p) / 3 < 75)
    return dark / len(px)


def main():
    print("[1] 重启 BlackDex", flush=True)
    sh("shell", "am", "force-stop", BD)
    time.sleep(3)
    sh("shell", "am", "start", "-n", f"{BD}/top.niunaijun.blackdex.view.base.WelcomeActivity")
    time.sleep(10)
    print("[2] 搜索 rokid", flush=True)
    tap(1280, 115, 2)
    sh("shell", "input", "text", "rokid")
    time.sleep(3)
    print("[3] 点开始脱壳", flush=True)
    im = shot("s")
    tap(1000, 655, 3)
    # 等镜像阶段：若 90s 仍卡（画面=脱壳日志暗面板）则自救
    t0 = time.time()
    escaped = False
    print("[4] 监控镜像阶段（自救阈值90s）…", flush=True)
    while time.time() - t0 < 600:
        if has_dex():
            print("[✓] 意外出料！", flush=True)
            break
        im = shot("m")
        # 镜像卡死特征：暗日志面板持续
        stuck_time = time.time() - t0
        if stuck_time > 90 and dialog_dark_ratio(im) > 0.5 and not escaped:
            print("[4b] 卡镜像自救：关闭 → 长按卡片 → 启动镜像", flush=True)
            tap(1280, 1120, 3)  # 关闭按钮区
            im2 = shot("esc")
            sh("shell", "input", "swipe", "500", "650", "500", "650", "1200")
            time.sleep(3)
            im3 = shot("menu")
            # 启动镜像：动作单第二项（列表头下方 y~1135 之前实测）
            tap(1380, 895, 5)
            escaped = True
            print("[4c] 已触发启动镜像，等待完成…", flush=True)
            t0 = time.time() + 480  # 给完成阶段 8 分钟
            continue
        time.sleep(10)
    # 等脱壳完成状态（卡片文本变化）或直接等面板
    print("[5] 等结果面板（自动全选+确定）…", flush=True)
    t0 = time.time()
    tries = 0
    while time.time() - t0 < 600 and not has_dex():
        im = shot("p")
        if dialog_dark_ratio(im) > 0.55:
            tries += 1
            print(f"[5.{tries}] 面板在位 — 几何定位并点击", flush=True)
            box = dark_box(im)
            print("    dark box:", box, flush=True)
            if box:
                x0, y0, x1, y1 = box
                # 全选：面板右上内侧
                tap(x1 - 140, y0 + 140, 1.5)
                # 确定：面板右下内侧
                im = shot("sel")
                box = dark_box(im) or box
                x0, y0, x1, y1 = box
                tap(x1 - 200, y1 - 70, 4)
            if has_dex():
                break
            if tries >= 6:
                print("    重开面板重试", flush=True)
                tap(950, 653, 3)  # 点卡片重开
        time.sleep(8)
    out = sh("shell", f"su -c 'ls -la {DUMP}/'").decode("utf-8", "replace")
    print("[终] dexDump:", flush=True)
    print(out, flush=True)


if __name__ == "__main__":
    main()
