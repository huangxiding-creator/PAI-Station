"""用户在场探测（M10.2a）：GetLastInputInfo 零依赖只读查询。

夜间深读让路（R 系红线）：最近键鼠 <5 分钟 → 让路。只查询系统输入
空闲时长，不挂钩、不注入。探测失败 → None（不让路不熔断，安全默认）。
"""
from __future__ import annotations

import ctypes
from datetime import datetime, timedelta


def _tick_ms() -> int:
    return ctypes.windll.kernel32.GetTickCount()


def _last_input_ms() -> int:
    class LASTINPUTINFO(ctypes.Structure):
        _fields_ = [("cbSize", ctypes.c_uint), ("dwTime", ctypes.c_uint)]

    info = LASTINPUTINFO()
    info.cbSize = ctypes.sizeof(LASTINPUTINFO)
    if not ctypes.windll.user32.GetLastInputInfo(ctypes.byref(info)):
        raise OSError("GetLastInputInfo 调用失败")
    return int(info.dwTime)


def last_input_at(now_fn=datetime.now, tick_fn=_tick_ms,
                  last_fn=_last_input_ms) -> datetime | None:
    """最近一次键鼠输入时刻；异常环境返回 None（调用方按不在场处理）。"""
    try:
        idle_ms = max(0, tick_fn() - last_fn())
    except Exception:  # noqa: BLE001 - 非 Windows / API 失败 → None
        return None
    return now_fn() - timedelta(milliseconds=idle_ms)
