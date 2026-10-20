# -*- coding: utf-8 -*-
"""拟人输入层：贝塞尔鼠标轨迹 / 不规则延迟 / 随机点击 / 剪贴板粘贴协议。

算法与参数全部照抄识流逆向报告 §6.1（helper/mouse-trajectory.js 源码级公式）：
  - generateBezierPath:  步数=clamp(dist/40+rand3, 5,15)，双随机控制点，
                         二次 easeInOut 时间轴取样，±0.75px 抖动，终点精确落位
  - generateIrregularDelay: Box-Muller 正态 N(base, 0.4*base)，
                         10% 长停顿×(2+U(0,3)) 下限10ms，5% 加速×0.3 下限5ms
  - 点击: 按住 60-120ms，连击间隔 30-70ms
  - 剪贴板协议（pasteTextViaClipboard 实测时序）:
    备份→U(200,300)→写入+回读校验→U(300,500)→Ctrl+V→U(300,500)→恢复→U(300,500)

本文件教训固化（2026-10-13）：剪贴板写入必须发生在"聚焦目标控件之前"，
 tkinter 写剪贴板会瞬间抢焦点——顺序错了文字会落到别的输入框。
"""
from __future__ import annotations

import math
import random
import time

import pyautogui

pyautogui.FAILSAFE = True   # 鼠标甩到左上角(0,0)即熔断——保留这条人肉急停通道
pyautogui.PAUSE = 0


# ---------------- 延迟体系 ----------------

def irregular_delay(base_ms: float) -> None:
    """识流 generateIrregularDelay：正态延迟+长停顿/加速双尾巴。"""
    u1, u2 = random.random(), random.random()
    if u1 <= 0:
        u1 = 1e-9
    z0 = math.sqrt(-2 * math.log(u1)) * math.cos(2 * math.pi * u2)
    d = base_ms + z0 * base_ms * 0.4
    r = random.random()
    if r < 0.10:
        d = max(10, d * (2 + random.random() * 3))
    elif r < 0.15:
        d = max(5, d * 0.3)
    time.sleep(max(5, d) / 1000)


def jitter_ms(a: float, b: float) -> None:
    time.sleep(random.uniform(a, b) / 1000)


# ---------------- 鼠标 ----------------

def _ease_in_out(t: float) -> float:
    return 2 * t * t if t < 0.5 else 1 - ((-2 * t + 2) ** 2) / 2


def bezier_move(x: int, y: int, human: bool = True) -> None:
    """贝塞尔轨迹移动到屏幕绝对坐标（识流 generateBezierPath 公式复刻）。"""
    cx, cy = pyautogui.position()
    dx, dy = x - cx, y - cy
    dist = math.hypot(dx, dy)
    if dist < 1:
        pyautogui.moveTo(x, y)
        return
    if not human:
        pyautogui.moveTo(x, y, duration=0.3)
        return
    steps = max(5, min(15, int(dist / 40) + random.randint(0, 3)))
    off = dist * 0.2
    c1 = (cx + dx * random.uniform(0, 0.5) + random.uniform(-0.5, 0.5) * off,
          cy + dy * random.uniform(0, 0.5) + random.uniform(-0.5, 0.5) * off)
    c2 = (cx + dx * (0.5 + random.uniform(0, 0.5)) + random.uniform(-0.5, 0.5) * off,
          cy + dy * (0.5 + random.uniform(0, 0.5)) + random.uniform(-0.5, 0.5) * off)
    for i in range(1, steps + 1):
        t = _ease_in_out(i / steps)
        bx = (1 - t) ** 3 * cx + 3 * (1 - t) ** 2 * t * c1[0] + 3 * (1 - t) * t * t * c2[0] + t ** 3 * x
        by = (1 - t) ** 3 * cy + 3 * (1 - t) ** 2 * t * c1[1] + 3 * (1 - t) * t * t * c2[1] + t ** 3 * y
        jx = random.uniform(-0.75, 0.75)
        jy = random.uniform(-0.75, 0.75)
        if i < steps:
            pyautogui.moveTo(bx + jx, by + jy)
        else:
            pyautogui.moveTo(x, y)   # 终点精确落位，抖动不污染点击目标
        irregular_delay(10)


def human_click(x: int, y: int, hold_ms: tuple = (60, 120)) -> None:
    """拟人点击：贝塞尔移动 + 随机按住时长。"""
    bezier_move(x, y)
    jitter_ms(80, 150)
    pyautogui.mouseDown()
    time.sleep(random.uniform(*hold_ms) / 1000)
    pyautogui.mouseUp()
    jitter_ms(50, 150)


# ---------------- 剪贴板 ----------------

def set_clipboard(text: str) -> None:
    import tkinter
    r = tkinter.Tk()
    r.withdraw()
    r.clipboard_clear()
    r.clipboard_append(text)
    r.update()
    r.destroy()


def get_clipboard() -> str:
    import tkinter
    r = tkinter.Tk()
    r.withdraw()
    try:
        return r.clipboard_get()
    except Exception:
        return ""
    finally:
        r.destroy()


def clipboard_paste_into_focused(text: str, restore: bool = True) -> None:
    """剪贴板粘贴协议（目标控件必须已获得焦点）。

    调用顺序约定：先 set_clipboard() → 再聚焦目标 → 再调本函数只发 Ctrl+V。
    （若在此函数内写剪贴板，tkinter 抢焦点会导致粘贴落空——实战踩坑）
    """
    pyautogui.hotkey("ctrl", "v")
    jitter_ms(300, 500)
    if restore:
        pass  # 恢复由调用方在发送完成后统一执行（见 engine._restore_clipboard_later）
