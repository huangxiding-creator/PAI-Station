# -*- coding: utf-8 -*-
"""auto_export.py — 视觉驱动自动导出：等脱壳结果面板 → 像素定位全选/确定按钮 → 点击 → 验证落盘
按钮定位法：扫描对话框右列的色块（非背景的实心圆角矩形=按钮/复选框）
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
DUMP_DIR = "/data/media/0/Download/dexDump"


def sh(*args, timeout=60):
    return subprocess.run([ADB, "-s", DEV] + list(args), capture_output=True,
                          timeout=timeout).stdout


def shot(name) -> Image.Image:
    p = EV / f"ae_{name}.png"
    open(p, "wb").write(sh("exec-out", "screencap", "-p", timeout=60))
    return Image.open(p).convert("RGB")


def dump_has_dex():
    out = sh("shell", f"ls {DUMP_DIR}/").decode("utf-8", "replace")
    return ".dex" in out


def dialog_up(im: Image.Image) -> bool:
    """检测脱壳文件列表面板：画面中部出现大量深色卡片区(与列表页区分)。
    简化判据：中央区域平均亮度显著低于全屏（暗色对话框覆盖）"""
    w, h = im.size
    center = im.crop((w // 4, h // 4, 3 * w // 4, 3 * h // 4))
    px = list(center.getdata())
    avg = sum(sum(p) for p in px) / (len(px) * 3)
    full = im.resize((64, 36))
    fpx = list(full.getdata())
    favg = sum(sum(p) for p in fpx) / (len(fpx) * 3)
    return avg < favg * 0.72 and avg < 110


def find_button(im: Image.Image, region, color_bias="accent"):
    """在 region(x0,y0,x1,y1) 找实心色块(按钮)中心：非灰、饱和度高的连通色块。
    返回最大色块的中心坐标"""
    x0, y0, x1, y1 = region
    crop = im.crop(region)
    w, h = crop.size
    px = crop.load()
    mask = [[False] * h for _ in range(w)]
    for y in range(h):
        for x in range(w):
            r, g, b = px[x, y]
            mx, mn = max(r, g, b), min(r, g, b)
            if mx - mn > 40 and mx > 90:  # 有色彩(非灰/黑/白)
                mask[x][y] = True
    # 最大连通块(BFS)
    best = None
    seen = [[False] * h for _ in range(w)]
    for x in range(w):
        for y in range(h):
            if mask[x][y] and not seen[x][y]:
                stack = [(x, y)]
                seen[x][y] = True
                pts = []
                while stack:
                    cx, cy = stack.pop()
                    pts.append((cx, cy))
                    for dx, dy in ((1, 0), (-1, 0), (0, 1), (0, -1)):
                        nx, ny = cx + dx, cy + dy
                        if 0 <= nx < w and 0 <= ny < h and mask[nx][ny] and not seen[nx][ny]:
                            seen[nx][ny] = True
                            stack.append((nx, ny))
                if best is None or len(pts) > len(best):
                    best = pts
    if not best:
        return None
    bx = sum(p[0] for p in best) / len(best)
    by = sum(p[1] for p in best) / len(best)
    if len(best) < 400:  # 太小不是按钮
        return None
    return (int(x0 + bx), int(y0 + by)), len(best)


def tap(x, y):
    sh("shell", "input", "tap", str(x), str(y))


def main():
    print("[*] 等待脱壳结果面板（最长15分钟）…", flush=True)
    t0 = time.time()
    dialog_seen = 0
    while time.time() - t0 < 900:
        if dump_has_dex():
            print("[✓] dexDump 已出料！", flush=True)
            break
        im = shot("poll")
        if dialog_up(im):
            dialog_seen += 1
            print(f"[*] 面板出现({dialog_seen}) — 视觉定位按钮 …", flush=True)
            im.save(EV / "ae_dialog.png")
            # 1) 全选：列表头右侧
            sel = find_button(im, (1900, 300, 2560, 600))
            if sel:
                print("[*] 全选候选:", sel, flush=True)
                tap(*sel[0])
                time.sleep(1.5)
            # 2) 确定：底部右侧区
            ok = find_button(shot("after_sel"), (1100, 900, 2560, 1440))
            if ok:
                print("[*] 确定候选:", ok, flush=True)
                tap(*ok[0])
                time.sleep(4)
            if dump_has_dex():
                print("[✓] 导出成功！", flush=True)
                break
        else:
            dialog_seen = 0
        time.sleep(12)
    out = sh("shell", f"su -c 'ls -la {DUMP_DIR}/'").decode("utf-8", "replace")
    print(out, flush=True)


if __name__ == "__main__":
    main()
