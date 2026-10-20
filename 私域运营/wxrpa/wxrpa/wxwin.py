# -*- coding: utf-8 -*-
"""窗口层：微信 4.x 主窗口发现 / 矩形 / 最小化恢复 / 前台化。

教训（2026-10-13 实战）：窗口整夜最小化会导致会话假死——
本地渲染消息但服务器收不到。ensure_active() 强制先恢复窗口。
"""
from __future__ import annotations

import time

WX_WINDOW_CLASS = "Qt51514QWindowIcon"   # 微信 4.x 主窗口类（实测 4.1.8.107）
WX_WINDOW_CLASS_OLD = "WeChatMainWndForPC"  # 微信 3.9 主窗口类（兼容）


class WindowState:
    def __init__(self, left, top, right, bottom, hwnd, minimized):
        self.left, self.top, self.right, self.bottom = left, top, right, bottom
        self.hwnd = hwnd
        self.minimized = minimized

    @property
    def w(self):
        return self.right - self.left

    @property
    def h(self):
        return self.bottom - self.top

    def rel(self, fx: float, fy: float):
        """窗口相对坐标 → 屏幕绝对坐标（fx/fy 为 0~1 比例）。"""
        return int(self.left + self.w * fx), int(self.top + self.h * fy)


def find_wechat() -> WindowState | None:
    """枚举顶层窗口找微信主窗。返回 None 表示未找到（未登录/未启动）。"""
    import uiautomation as u

    root = u.GetRootControl()
    for w in root.GetChildren():
        try:
            if w.ClassName in (WX_WINDOW_CLASS, WX_WINDOW_CLASS_OLD):
                r = w.BoundingRectangle
                mini = (r.right - r.left) <= 0 or (r.bottom - r.top) <= 0
                return WindowState(r.left, r.top, r.right, r.bottom,
                                   w.NativeWindowHandle, mini)
        except Exception:
            continue
    return None


def ensure_active(wait_sec: float = 1.5) -> WindowState:
    """确保微信窗口可见且未最小化（最小化则恢复）。失败抛异常。"""
    st = find_wechat()
    if st is None:
        raise RuntimeError("未找到微信主窗口：请确认微信已启动并登录")
    if st.minimized:
        import ctypes
        u32 = ctypes.windll.user32
        u32.ShowWindow(st.hwnd, 9)   # SW_RESTORE
        time.sleep(wait_sec)
        u32.SetForegroundWindow(st.hwnd)
        time.sleep(0.6)
        st = find_wechat()
        if st is None or st.minimized:
            raise RuntimeError("微信窗口恢复失败")
    return st
