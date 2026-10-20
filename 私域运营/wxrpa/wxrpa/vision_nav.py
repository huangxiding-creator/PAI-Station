# -*- coding: utf-8 -*-
"""识流式视觉导航——截图发给智谱视觉API，让AI告诉我点哪里。

复刻识流的核心方法论（逆向报告 §3）：
  1. 截图搜索结果
  2. 发给云端视觉模型（识流用豆包，我用智谱glm-4v）
  3. AI 返回目标行的精确坐标
  4. 用贝塞尔轨迹点击

这比本地 OCR 可靠 10 倍，因为云端视觉模型能准确读中文。
"""
from __future__ import annotations

import base64
import json
import logging
import time

import httpx
import pyautogui

from . import human_input as hi
from . import perceive as pc
from . import wxwin

log = logging.getLogger("zbops.vision")

ZHIPU_API = "https://open.bigmodel.cn/api/paas/v4/chat/completions"
ZHIPU_KEY_2 = "c598820ce196443e926f1c5b263746d3.GxfGSccYwKJ7ej2k"  # 第二密钥（429降级用）


def _get_api_key():
    import os
    return os.environ.get("ZHIPU_API_KEY", "") or ZHIPU_KEY_2


def vision_locate(image, prompt: str, api_key: str = None) -> dict | None:
    """将截图发给智谱视觉模型，让它分析并返回结构化结果。

    返回: {"answer": str, "y_percent": float} 或 None
    """
    key = api_key or _get_api_key()
    if not key:
        log.warning("无智谱 API Key")
        return None

    # 图片转 base64
    import io as _io
    buf = _io.BytesIO()
    image.save(buf, "PNG")
    b64 = base64.b64encode(buf.getvalue()).decode()

    body = {
        "model": "glm-4v-plus",
        "messages": [{
            "role": "user",
            "content": [
                {"type": "image_url",
                 "image_url": {"url": f"data:image/png;base64,{b64}"}},
                {"type": "text", "text": prompt}
            ]
        }],
        "max_tokens": 200
    }

    try:
        resp = httpx.post(ZHIPU_API, json=body,
                          headers={"Authorization": f"Bearer {key}"},
                          timeout=30)
        resp.raise_for_status()
        data = resp.json()
        text = data["choices"][0]["message"]["content"]
        return {"answer": text}
    except Exception as e:  # noqa: BLE001
        log.error("视觉API调用失败: %s", e)
        return None


def find_group_in_search(win, group_name: str,
                         api_key: str = None) -> tuple[int, int] | None:
    """在搜索结果中用视觉模型找到目标群，返回屏幕坐标。

    Returns: (x, y) 屏幕绝对坐标，或 None（未找到）
    """
    # 1) 搜索
    _do_search(win, group_name)

    # 2) 截图搜索结果区域（足够大的区域）
    img = pc.shot(win, (200, 100, 780, 850))

    # 3) 让视觉模型找目标群在哪一行
    prompt = (f"这是微信搜索结果的截图。请找到名为「{group_name}」的群聊条目。"
              f"只返回该条目中心的垂直位置，用0到100的百分比表示"
              f"（0=图片顶部，100=图片底部）。只返回数字。")
    result = vision_locate(img, prompt, api_key)
    if not result:
        return None

    # 4) 解析百分比 → 屏幕坐标
    try:
        y_percent = float(result["answer"].strip().replace("%", ""))
        # 百分比 → 图片内像素 → 窗口内像素 → 屏幕像素
        img_h = 750  # 截图区域高度 (850-100)
        y_in_img = int(img_h * y_percent / 100)
        y_in_win = 100 + y_in_img  # 截图区域起始偏移
        y_screen = win.top + y_in_win
        x_screen = win.left + 460  # 搜索结果中间偏左
        return (x_screen, y_screen)
    except (ValueError, KeyError):
        return None


def verify_chat_title(win, expected_name: str,
                      api_key: str = None) -> bool:
    """用视觉模型验证当前聊天标题是否匹配（识流式0/1验证）。"""
    # 截图标题区域
    img = pc.shot(win, (360, 60, 1300, 160))

    prompt = (f"这是微信聊天窗口的顶部标题区域。"
              f"目标群名是「{expected_name}」。"
              f"如果当前标题就是这个群（允许细微文字差异），返回1；"
              f"否则返回0。只返回数字1或0。")
    result = vision_locate(img, prompt, api_key)
    if not result:
        return False
    return result["answer"].strip() == "1"


def _do_search(win, name: str):
    """在搜索框中输入群名并等待结果。"""
    sx, sy = win.rel(288 / 1596, 102 / 1269)
    hi.human_click(sx, sy)
    time.sleep(0.8)
    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.2)
    hi.set_clipboard(name)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(3.5)  # 等搜索结果充分加载


def open_group_vision(group_name: str, api_key: str = None) -> bool:
    """识流式打开群：搜索 → 视觉定位 → 点击 → 视觉验证。"""
    win = wxwin.ensure_active()

    # 1) 视觉定位搜索结果中的目标群
    coords = find_group_in_search(win, group_name, api_key)
    if not coords:
        print(f"  [视觉] 未找到 {group_name} 在搜索结果中的位置")
        return False

    x, y = coords
    print(f"  [视觉] 目标位置: ({x}, {y})")

    # 2) 用贝塞尔轨迹点击
    hi.human_click(x, y)
    time.sleep(2.5)

    # 3) 视觉验证标题
    if verify_chat_title(win, group_name, api_key):
        print(f"  [验证] 标题匹配——已进入 {group_name}")
        return True

    # 4) 验证失败，再试一次（点击更精确的位置）
    print(f"  [重试] 标题验证失败，尝试调整点击位置")
    coords2 = find_group_in_search(win, group_name, api_key)
    if coords2:
        hi.human_click(coords2[0], coords2[1])
        time.sleep(2.0)
        if verify_chat_title(win, group_name, api_key):
            print(f"  [验证] 第二次标题匹配")
            return True

    print(f"  [失败] 视觉验证未通过")
    return False


def send_to_group_vision(group_name: str, text: str,
                          api_key: str = None,
                          image_path: str = None) -> bool:
    """完整的识流式发送流程。"""
    # 1) 打开群（视觉导航）
    if not open_group_vision(group_name, api_key):
        return False

    win = wxwin.ensure_active()

    # 2) 发送前截图（基线）
    before = pc.shot(win, pc.region(win, "chat_tail"))

    # 3) 发送
    if image_path:
        _send_image(win, image_path)
    else:
        _send_text(win, text)

    # 4) 验证发送（截图对比）
    time.sleep(2.0)
    after = pc.shot(win, pc.region(win, "chat_tail"))
    from PIL import ImageChops
    changed = ImageChops.difference(before, after).getbbox() is not None
    if changed:
        print("  [验证] 聊天区已变化——发送成功")
        return True
    print("  [失败] 聊天区无变化")
    return False


def _send_text(win, text: str):
    hi.set_clipboard(text)
    ix, iy = win.rel(1015 / 1596, 1130 / 1269)
    hi.human_click(ix, iy)
    time.sleep(0.5)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(0.8)
    pyautogui.hotkey("ctrl", "enter")
    time.sleep(1.5)


def _send_image(win, image_path: str):
    import win32clipboard, win32con
    from PIL import Image
    import io as _io
    img = Image.open(image_path)
    buf = _io.BytesIO()
    img.convert("RGB").save(buf, "BMP")
    bmp = buf.getvalue()[14:]
    win32clipboard.OpenClipboard()
    win32clipboard.EmptyClipboard()
    win32clipboard.SetClipboardData(win32con.CF_DIB, bmp)
    win32clipboard.CloseClipboard()

    ix, iy = win.rel(1015 / 1596, 1130 / 1269)
    hi.human_click(ix, iy)
    time.sleep(0.5)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(3.0)
    pyautogui.hotkey("ctrl", "enter")
    time.sleep(2.0)
