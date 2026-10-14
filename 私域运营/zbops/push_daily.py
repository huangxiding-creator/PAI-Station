# -*- coding: utf-8 -*-
"""每日海报推送主脚本——识流式视觉导航 + We-AIPO 内容。

用法: py -I push_daily.py [--groups 3] [--dry]
  --groups N  推送到前 N 个群（默认 3，逐步放量）
  --dry       只生成海报，不发送
"""
from __future__ import annotations

import asyncio
import base64
import io as _io
import json
import os
import sys
import time

import httpx
import pyautogui
from PIL import Image, ImageChops

# 路径设置
WXRPA_PATH = os.path.join(os.path.dirname(__file__), "..", "wxrpa")
sys.path.insert(0, os.path.abspath(WXRPA_PATH))
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from wxrpa import human_input as hi
from wxrpa import perceive as pc
from wxrpa import wxwin

# ── 配置 ──
ZHIPU_KEY = "c598820ce196443e926f1c5b263746d3.GxfGSccYwKJ7ej2k"
ZHIPU_MODEL = "glm-4v-flash"
WEAIPO_PUBLISH = r"F:\We-AIPO\data\state\channels_publish_detail.json"
POSTER_DIR = r"C:\zb-ops\posters"
GROUP_INTERVAL = 8  # 每群间隔秒数


def vision_ask(image, prompt, retries=3):
    """智谱免费视觉模型（带重试）。"""
    buf = _io.BytesIO()
    image.save(buf, "PNG")
    b64 = base64.b64encode(buf.getvalue()).decode()
    body = {
        "model": ZHIPU_MODEL,
        "messages": [{"role": "user", "content": [
            {"type": "image_url",
             "image_url": {"url": f"data:image/png;base64,{b64}"}},
            {"type": "text", "text": prompt}
        ]}],
        "max_tokens": 100
    }
    for attempt in range(retries):
        try:
            resp = httpx.post(
                "https://open.bigmodel.cn/api/paas/v4/chat/completions",
                json=body,
                headers={"Authorization": f"Bearer {ZHIPU_KEY}"},
                timeout=30)
            if resp.status_code == 429:
                wait = 2 ** (attempt + 1)
                print(f"    429, 等{wait}s...")
                time.sleep(wait)
                continue
            resp.raise_for_status()
            return resp.json()["choices"][0]["message"]["content"]
        except Exception as e:
            if attempt < retries - 1:
                time.sleep(2)
            else:
                print(f"    视觉API失败: {e}")
    return None


def get_latest_article():
    """从 We-AIPO 获取最新文章标题。"""
    data = json.load(open(WEAIPO_PUBLISH, encoding="utf-8"))
    recent = [d for d in data if d.get("status") == "success"][-10:]
    for d in reversed(recent):
        title = d.get("title", "")
        if len(title) >= 8:
            return title
    return None


def generate_poster(title):
    """生成海报。"""
    from PIL import ImageDraw, ImageFont
    W, H = 750, 1200
    BG = (18, 42, 76)
    ACCENT = (0, 168, 255)
    WHITE = (255, 255, 255)
    LIGHT = (200, 210, 220)

    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)

    try:
        f_brand = ImageFont.truetype("C:/Windows/Fonts/msyhbd.ttc", 36)
        f_title = ImageFont.truetype("C:/Windows/Fonts/msyhbd.ttc", 32)
        f_body = ImageFont.truetype("C:/Windows/Fonts/msyh.ttc", 26)
        f_cta = ImageFont.truetype("C:/Windows/Fonts/msyh.ttc", 24)
    except Exception:
        f_brand = f_title = f_body = f_cta = None

    # 顶部品牌
    draw.rectangle([0, 0, W, 100], fill=ACCENT)
    if f_brand:
        draw.text((W//2, 50), "总包AI顾问", font=f_brand, fill=WHITE, anchor="mm")

    # 标题
    y = 160
    title_lines = _wrap(title, f_title, W - 80) if f_title else [title[:20]]
    for line in title_lines[:3]:
        if f_title:
            draw.text((40, y), line, font=f_title, fill=WHITE)
        y += 48

    # 分隔线
    y += 20
    draw.line([40, y, W-40, y], fill=ACCENT, width=2)
    y += 40

    # 摘要
    summary = "每日精选工程行业资讯\n关注总包AI顾问\n获取更多专业内容"
    if f_body:
        for line in summary.split("\n"):
            draw.text((40, y), line, font=f_body, fill=LIGHT)
            y += 38

    # 底部
    y_bottom = H - 120
    draw.rectangle([0, y_bottom, W, H], fill=(12, 28, 52))
    if f_cta:
        draw.text((W//2, y_bottom+40), "打开总包AI顾问小程序阅读全文",
                 font=f_cta, fill=ACCENT, anchor="mm")
        draw.text((W//2, y_bottom+75), "AI秒答工程问题·附规范出处",
                 font=f_cta, fill=LIGHT, anchor="mm")

    os.makedirs(POSTER_DIR, exist_ok=True)
    path = os.path.join(POSTER_DIR, f"poster_{time.strftime('%Y%m%d_%H%M')}.png")
    img.save(path, "PNG")
    return path


def _wrap(text, font, max_w):
    lines = []
    cur = ""
    for ch in text:
        test = cur + ch
        if font and font.getbbox(test)[2] > max_w:
            if cur:
                lines.append(cur)
            cur = ch
        else:
            cur = test
    if cur:
        lines.append(cur)
    return lines


def open_group_vision(win, group_name):
    """识流式视觉导航打开群（精确匹配）。"""
    # 搜索（用完整群名，不用截断）
    hi.set_clipboard(group_name)
    sx, sy = win.rel(288 / 1596, 102 / 1269)
    hi.human_click(sx, sy)
    time.sleep(0.8)
    pyautogui.hotkey("ctrl", "a")
    time.sleep(0.2)
    pyautogui.hotkey("ctrl", "v")
    time.sleep(3.5)

    # 视觉定位（要求精确匹配群名，不是模糊匹配）
    img = pc.shot(win, (200, 100, 780, 850))
    answer = vision_ask(img,
        f"这是微信搜索结果。精确找到群名为「{group_name}」的条目"
        f"（注意区分编号：-1群、-2群、-3群是不同的群）。"
        f"返回该条目中心的垂直位置（0=顶部，100=底部）。只返回数字。")
    if not answer:
        return False
    try:
        y_pct = float(answer.strip().replace("%", ""))
    except ValueError:
        return False

    y_screen = win.top + 100 + int(750 * y_pct / 100)
    x_screen = win.left + 460
    hi.human_click(x_screen, y_screen)
    time.sleep(2.5)

    # 视觉验证标题
    title_img = pc.shot(win, (360, 60, 1300, 160))
    verify = vision_ask(title_img,
        f"这是微信聊天标题。是否在「{group_name[:6]}」相关的群中？是=1否=0。只返回数字。")
    return verify and "1" in verify


def send_image(win, image_path):
    """发送图片。"""
    import win32clipboard, win32con
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


def main(dry=False, max_groups=3):
    print("=== 每日海报推送 ===")

    # 1) 获取最新文章
    title = get_latest_article()
    if not title:
        print("ERROR: We-AIPO 无可用文章")
        return
    print(f"文章: {title[:40]}")

    # 2) 生成海报
    poster = generate_poster(title)
    print(f"海报: {poster}")

    if dry:
        print("[dry] 只生成，不发送")
        return

    # 3) 推送
    win = wxwin.ensure_active()
    groups = ["总包千问AI-1群", "项目总包实战交流②群", "总包沙龙-成都"]
    groups = groups[:max_groups]
    sent = 0

    for g in groups:
        print(f"\n推送: {g}")
        if open_group_vision(win, g):
            send_image(win, poster)
            print(f"  已发送")
            sent += 1
        else:
            print(f"  跳过")
        time.sleep(GROUP_INTERVAL)

    print(f"\n完成: {sent}/{len(groups)} 群")


if __name__ == "__main__":
    dry = "--dry" in sys.argv
    n = 3
    if "--groups" in sys.argv:
        i = sys.argv.index("--groups")
        n = int(sys.argv[i + 1])
    main(dry=dry, max_groups=n)
