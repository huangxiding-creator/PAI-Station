# -*- coding: utf-8 -*-
"""键盘导航模式——不用 OCR，纯键盘操作搜索并进入聊天。

方法：搜索群名 → 按↓跳过搜索建议 → 按 Enter 选择第一个群
这比 OCR 识别搜索结果可靠 10 倍，因为完全绕过了视觉识别。
"""
from __future__ import annotations

import time

import pyautogui

from . import human_input as hi
from . import wxwin


def search_and_enter(chat_name: str, win=None) -> bool:
    """搜索群名并用键盘选择第一个群结果（零 OCR）。

    步骤：
    1. 点搜索框
    2. Ctrl+A 清空 → 粘贴群名
    3. 等待搜索结果加载
    4. 按↓跳过"搜索网络结果"
    5. 按 Enter 选择第一个群
    """
    if win is None:
        win = wxwin.ensure_active()

    # 1) 点搜索框
    sx, sy = win.rel(288 / 1596, 102 / 1269)
    hi.human_click(sx, sy)
    time.sleep(0.8)

    # 2) 清空旧文本 → 粘贴新搜索词
    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.2)
    hi.set_clipboard(chat_name)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(2.5)  # 等搜索结果加载

    # 3) 按↓跳过搜索建议，然后 Enter 选择第一个群
    pyautogui.press("down")   # 跳过"搜索网络结果"
    time.sleep(0.3)
    pyautogui.press("enter")  # 选择第一个结果（通常是最匹配的群）
    time.sleep(2.0)          # 等聊天窗口打开

    return True


def send_and_verify(text: str, win=None) -> bool:
    """在当前聊天中发送消息（Ctrl+V → Ctrl+Enter）→ 截图验证。"""
    if win is None:
        win = wxwin.ensure_active()

    # 发送前截图（基线）
    from . import perceive as pc
    before = pc.shot(win, pc.region(win, "chat_tail"))

    # 剪贴板先写 → 聚焦输入框 → Ctrl+V → Ctrl+Enter
    hi.set_clipboard(text)
    ix, iy = win.rel(1015 / 1596, 1130 / 1269)
    hi.human_click(ix, iy)
    time.sleep(0.5)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(0.6)
    pyautogui.hotkey("ctrl", "enter")
    time.sleep(1.5)

    # 验证：chat_tail 区域应有变化（新气泡出现）
    after = pc.shot(win, pc.region(win, "chat_tail"))
    from PIL import ImageChops
    changed = ImageChops.difference(before, after).getbbox() is not None
    return changed
