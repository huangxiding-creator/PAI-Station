# -*- coding: utf-8 -*-
"""每日海报推送：总包AI顾问朋友圈最新咨询 → 生成海报 → 推送到所有总包群。

流程：
  1. 获取小程序朋友圈最新一条咨询（API/手动输入）
  2. PIL 生成精美海报（标题+摘要+品牌+引导语）
  3. wxrpa 发送图片到所有总包群（图片比文字更吸引眼球）
"""
from __future__ import annotations

import asyncio
import logging
import time
from pathlib import Path

from PIL import Image, ImageDraw, ImageFont

log = logging.getLogger("zbops.poster")

WXRPA_PATH = Path(r"e:\AI-Station\私域运营\wxrpa")
POSTER_DIR = Path(r"C:\zb-ops\posters")
POSTER_DIR.mkdir(parents=True, exist_ok=True)

# 字体路径（Windows 自带）
FONT_BOLD = "C:/Windows/Fonts/msyhbd.ttc"    # 微软雅黑粗体
FONT_REG = "C:/Windows/Fonts/msyh.ttc"       # 微软雅黑


def generate_poster(title: str, content: str, output_path: str = None) -> str:
    """生成一张精美的咨询海报。

    尺寸 750×1200（微信朋友圈标准比例），深蓝配色。
    """
    W, H = 750, 1200
    BG = (18, 42, 76)         # 深蓝背景
    ACCENT = (0, 168, 255)     # 亮蓝
    WHITE = (255, 255, 255)
    LIGHT = (200, 210, 220)

    img = Image.new("RGB", (W, H), BG)
    draw = ImageDraw.Draw(img)

    # 顶部品牌条
    draw.rectangle([0, 0, W, 100], fill=ACCENT)
    try:
        f_brand = ImageFont.truetype(FONT_BOLD, 36)
        draw.text((W//2, 50), "总包AI顾问", font=f_brand, fill=WHITE,
                 anchor="mm")
    except Exception:
        draw.text((W//2, 50), "总包AI顾问", fill=WHITE)

    # 标题区域
    y = 160
    try:
        f_title = ImageFont.truetype(FONT_BOLD, 34)
        # 标题自动换行
        title_lines = _wrap_text(title, f_title, W - 80)
        for line in title_lines[:3]:  # 最多3行
            draw.text((40, y), line, font=f_title, fill=WHITE)
            y += 48
    except Exception:
        draw.text((40, y), title[:30], fill=WHITE)
        y += 48

    # 分隔线
    y += 20
    draw.line([40, y, W-40, y], fill=ACCENT, width=2)
    y += 30

    # 内容区域
    try:
        f_body = ImageFont.truetype(FONT_REG, 26)
        body_lines = _wrap_text(content, f_body, W - 80)
        for line in body_lines[:12]:  # 最多12行
            draw.text((40, y), line, font=f_body, fill=LIGHT)
            y += 38
    except Exception:
        draw.text((40, y), content[:100], fill=LIGHT)
        y += 200

    # 底部引导
    y = H - 120
    draw.rectangle([0, y, W, H], fill=(12, 28, 52))
    try:
        f_cta = ImageFont.truetype(FONT_REG, 24)
        draw.text((W//2, y+40), "🔍 更多工程咨询，请打开总包AI顾问小程序",
                 font=f_cta, fill=ACCENT, anchor="mm")
        draw.text((W//2, y+75), "AI 秒答工程问题 · 附规范出处",
                 font=f_cta, fill=LIGHT, anchor="mm")
    except Exception:
        pass

    # 保存
    if not output_path:
        ts = time.strftime("%Y%m%d_%H%M%S")
        output_path = str(POSTER_DIR / f"poster_{ts}.png")
    img.save(output_path, "PNG")
    log.info("海报已生成: %s", output_path)
    return output_path


def _wrap_text(text: str, font, max_width: int) -> list[str]:
    """按像素宽度自动换行。"""
    lines = []
    current = ""
    for ch in text:
        test = current + ch
        bbox = font.getbbox(test)
        if bbox[2] - bbox[0] > max_width:
            if current:
                lines.append(current)
            current = ch
        else:
            current = test
    if current:
        lines.append(current)
    return lines


def send_image_to_group(group_name: str, image_path: str) -> bool:
    """通过 wxrpa 发送图片到群（剪贴板 → Ctrl+V → Ctrl+Enter）。"""
    import sys
    sys.path.insert(0, str(WXRPA_PATH))

    import win32clipboard
    import win32con
    import pyautogui
    import time as _t
    import difflib

    from wxrpa import wxwin, perceive as pc
    from wxrpa.human_input import set_clipboard, human_click
    from wxrpa.keyboard_nav import search_and_enter

    # 1) 打开目标群
    win = wxwin.ensure_active()
    if not search_and_enter(group_name, win):
        return False

    # 2) 将图片复制到剪贴板（CF_DIB 格式）
    img = Image.open(image_path)
    import io as _io
    buf = _io.BytesIO()
    img.convert("RGB").save(buf, "BMP")
    bmp_data = buf.getvalue()[14:]  # 跳过 BMP 文件头

    win32clipboard.OpenClipboard()
    win32clipboard.EmptyClipboard()
    win32clipboard.SetClipboardData(win32con.CF_DIB, bmp_data)
    win32clipboard.CloseClipboard()

    # 3) 聚焦输入框 → Ctrl+V → 等待预览 → Ctrl+Enter
    ix, iy = win.rel(1015 / 1596, 1130 / 1269)
    human_click(ix, iy)
    _t.sleep(0.5)
    pyautogui.hotkey("ctrl", "v")
    _t.sleep(2.0)  # 等图片预览加载
    pyautogui.hotkey("ctrl", "enter")
    _t.sleep(1.5)

    return True


# ── 每日推送主流程 ──

async def daily_poster_push(groups: list[str] = None):
    """生成海报并推送到所有总包群。"""
    # 1) 获取最新咨询内容（当前用示例，后续接API）
    title = "EPC工程总承包项目风险预警与专场分析"
    content = ("EPC模式下造价超支平均是传统模式的1.8倍。\n\n"
               "关键风险点包括：\n"
               "· 合同条款不明确导致的变更争议\n"
               "· 设计与施工接口管理失控\n"
               "· 业主需求变更频繁引发的工期延误\n"
               "· 分包管理不善的质量隐患\n\n"
               "建议建立风险矩阵，每月更新风险等级。")

    # 2) 生成海报
    poster_path = generate_poster(title, content)
    print(f"海报: {poster_path}")

    # 3) 推送到群
    if not groups:
        groups = ["总包千问AI-1群", "项目总包实战交流②群"]  # 测试用
    sent = 0
    for g in groups:
        print(f"推送: {g}", end=" → ")
        ok = send_image_to_group(g, poster_path)
        print("OK" if ok else "FAIL")
        if ok:
            sent += 1
        time.sleep(5)  # 每群间隔5秒

    print(f"\n完成: {sent}/{len(groups)} 群")
    return sent


if __name__ == "__main__":
    # 单独运行：生成海报 + 推送
    asyncio.run(daily_poster_push())
