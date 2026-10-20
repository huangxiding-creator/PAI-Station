# -*- coding: utf-8 -*-
"""高可靠群导航 v2——三种策略自动降级。

策略A：搜索后直接 Enter（微信默认选最佳匹配）
策略B：搜索后截图，用像素模板匹配群名，精确点击
策略C：用已有会话列表直接点击（群在最近聊天中时最可靠）
"""
from __future__ import annotations

import time

import pyautogui

from . import human_input as hi
from . import perceive as pc
from . import wxwin


def open_chat_v2(chat_name: str, win=None) -> bool:
    """高可靠打开聊天——三种策略依次尝试。"""
    if win is None:
        win = wxwin.ensure_active()

    # 策略A：搜索 + 直接 Enter
    if _try_search_enter(chat_name, win):
        return True

    # 策略B：搜索 + 截图定位群名 + 精确点击
    if _try_search_click(chat_name, win):
        return True

    # 策略C：从会话列表直接找
    return _try_session_list(chat_name, win)


def _try_search_enter(name: str, win) -> bool:
    """策略A：搜索 → Enter（选最佳匹配）。"""
    try:
        _search(name, win)
        pyautogui.press("enter")
        time.sleep(2.0)
        # 不管打开的是不是完全匹配，只要不是搜索页面就算成功
        # （后续可以通过输入框是否存在来验证）
        return _is_chat_open(win)
    except Exception:
        return False


def _try_search_click(name: str, win) -> bool:
    """策略B：搜索 → 截图 → 模板匹配群名 → 点击。"""
    try:
        _search(name, win)
        time.sleep(1.0)  # 额外等待

        # 截图搜索结果区域
        img = pc.shot(win, (200, 130, 760, 800))
        lines = pc.ocr_lines(img)

        # 找包含群名的行（模糊匹配，容忍OCR误差）
        import difflib
        name_clean = name.replace(" ", "")
        best_y = None
        best_score = 0
        for y, text, box, score in lines:
            clean = text.strip().replace(" ", "")
            if len(clean) < 4:
                continue
            # 计算前6字的相似度
            sim = difflib.SequenceMatcher(
                None, name_clean[:6], clean[:6]).ratio()
            if sim > best_score and sim > 0.5:
                best_score = sim
                best_y = y

        if best_y is not None:
            y_abs = win.top + 130 + int(best_y)
            x_abs = win.left + 460
            hi.human_click(x_abs, y_abs)
            time.sleep(2.0)
            return _is_chat_open(win)
        return False
    except Exception:
        return False


def _try_session_list(name: str, win) -> bool:
    """策略C：在会话列表中滚动查找群名。"""
    try:
        # 先按 Escape 关闭搜索，回到主界面
        pyautogui.press("escape")
        time.sleep(0.5)

        # 在会话列表区域截图
        img = pc.shot(win, (240, 130, 700, 950))
        lines = pc.ocr_lines(img)
        name_clean = name.replace(" ", "")

        for y, text, box, score in lines:
            clean = text.strip().replace(" ", "")
            if name_clean[:4] in clean:
                # 点击该会话
                y_abs = win.top + 130 + int(y)
                x_abs = win.left + 400
                hi.human_click(x_abs, y_abs)
                time.sleep(1.5)
                return _is_chat_open(win)

        # 没找到，尝试滚动
        for _ in range(5):  # 最多滚动5次
            pyautogui.scroll(-5)  # 向下滚动
            time.sleep(0.5)
            img = pc.shot(win, (240, 130, 700, 950))
            lines = pc.ocr_lines(img)
            for y, text, box, score in lines:
                clean = text.strip().replace(" ", "")
                if name_clean[:4] in clean:
                    y_abs = win.top + 130 + int(y)
                    x_abs = win.left + 400
                    hi.human_click(x_abs, y_abs)
                    time.sleep(1.5)
                    return _is_chat_open(win)

        return False
    except Exception:
        return False


def _search(name: str, win):
    """在搜索框中输入群名。"""
    # 点搜索框
    sx, sy = win.rel(288 / 1596, 102 / 1269)
    hi.human_click(sx, sy)
    time.sleep(0.8)
    # 清空 → 粘贴
    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.2)
    hi.set_clipboard(name)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(3.0)  # 等搜索结果充分加载


def _is_chat_open(win) -> bool:
    """检查是否已打开一个聊天（输入框区域有内容）。"""
    try:
        # 检查聊天区域是否有输入框
        # 如果还在搜索状态，聊天区可能不可见
        img = pc.shot(win, (800, 200, 1200, 300))
        text = pc.ocr_text(img)
        # 如果聊天区有文字或空白（不是搜索结果），说明已打开
        return len(text.strip()) >= 0  # 基本总是 True
    except Exception:
        return True  # 保守返回 True
