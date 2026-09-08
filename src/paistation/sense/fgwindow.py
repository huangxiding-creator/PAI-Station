"""前台窗口轮询（注意力状态判定）：ctypes 取活动窗口标题+进程名。

纯标准库；失败静默返回空串（服务环境可能无交互会话）。
"""
import ctypes
import ctypes.wintypes
import os

_kernel32 = ctypes.windll.kernel32
_user32 = ctypes.windll.user32


def active_window() -> dict:
    """当前前台窗口 {"title", "process"}；任何失败返回空串字段。"""
    try:
        hwnd = _user32.GetForegroundWindow()
        if not hwnd:
            return {"title": "", "process": ""}
        buf = ctypes.create_unicode_buffer(512)
        _user32.GetWindowTextW(hwnd, buf, 512)
        title = buf.value
        pid = ctypes.wintypes.DWORD()
        _user32.GetWindowThreadProcessId(hwnd, ctypes.byref(pid))
        process = _process_name(pid.value)
        return {"title": title, "process": process}
    except Exception:
        return {"title": "", "process": ""}


def _process_name(pid: int) -> str:
    """PID → 进程可执行名（QueryFullProcessImageNameW）。"""
    PROCESS_QUERY_LIMITED_INFORMATION = 0x1000
    handle = _kernel32.OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, False, pid)
    if not handle:
        return ""
    try:
        buf = ctypes.create_unicode_buffer(1024)
        size = ctypes.wintypes.DWORD(1024)
        if _kernel32.QueryFullProcessImageNameW(handle, 0, buf, ctypes.byref(size)):
            return os.path.basename(buf.value)
        return ""
    finally:
        _kernel32.CloseHandle(handle)


def classify_attention(window: dict, deepwork_apps: tuple) -> str:
    """前台窗口 → 注意力状态：idle（无窗口）/ deepwork / focus。"""
    process = (window.get("process") or "").strip()
    title = (window.get("title") or "").strip()
    if not process and not title:
        return "idle"
    if process.upper() in {a.upper() for a in deepwork_apps}:
        return "deepwork"
    return "focus"
