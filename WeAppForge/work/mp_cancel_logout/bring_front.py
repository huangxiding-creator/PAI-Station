# -*- coding: utf-8 -*-
"""bring_front.py — 把「微信公众平台」Chrome 窗口拉到最前（管理员扫码用）。"""
import ctypes
import sys
from ctypes import wintypes, create_unicode_buffer

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
u32 = ctypes.windll.user32
WNDENUMPROC = ctypes.WINFUNCTYPE(ctypes.c_bool, wintypes.HWND, wintypes.LPARAM)
TARGET = "微信公众平台"  # 微信公众平台

mp_hwnds = []


def cb(hwnd, _l):
    if u32.IsWindowVisible(hwnd):
        buf = create_unicode_buffer(256)
        u32.GetWindowTextW(hwnd, buf, 256)
        if TARGET in buf.value:
            mp_hwnds.append((hwnd, buf.value))
    return True


u32.EnumWindows(WNDENUMPROC(cb), 0)
for h, t in mp_hwnds[:3]:
    u32.ShowWindow(h, 9)  # SW_RESTORE
    u32.SetForegroundWindow(h)
print("found:", mp_hwnds[:5] if mp_hwnds else "NONE", "fronted:", min(len(mp_hwnds), 3))
