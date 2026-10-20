# -*- coding: utf-8 -*-
"""感知层：窗口截图 / 区域裁剪 / 本地 OCR / 像素 diff（新消息检测）。

对应识流的"截屏→视觉理解"，但全部本地化（RapidOCR onnx，零云端、零 API）。
"""
from __future__ import annotations

import time
from pathlib import Path

_OCR = None


def _ocr():
    global _OCR
    if _OCR is None:
        from rapidocr_onnxruntime import RapidOCR
        _OCR = RapidOCR()
    return _OCR


def shot(win, region=None) -> "Image":
    """截微信窗口（region=(x1,y1,x2,y2) 窗口相对像素，可省略截全窗）。"""
    from PIL import ImageGrab
    if region:
        box = (win.left + region[0], win.top + region[1],
               win.left + region[2], win.top + region[3])
    else:
        box = (win.left, win.top, win.right, win.bottom)
    return ImageGrab.grab(bbox=box)


def ocr_text(img) -> str:
    """对 PIL Image 做本地 OCR，返回拼接文本（按 y 排序，行间换行）。"""
    import numpy as np
    arr = np.array(img.convert("RGB"))
    result, _ = _ocr()(arr)
    if not result:
        return ""
    lines = sorted(result, key=lambda r: r[0][0][1])  # 按左上角 y 排序
    return "\n".join(t for _, t, _ in lines)


def ocr_lines(img):
    """返回 [(y, text, box)] 列表，供精确坐标定位（如搜索结果行）。"""
    import numpy as np
    arr = np.array(img.convert("RGB"))
    result, _ = _ocr()(arr)
    if not result:
        return []
    out = []
    for box, text, score in result:
        ys = [p[1] for p in box]
        out.append((sum(ys) / 4, text, box, float(score)))
    out.sort(key=lambda r: r[0])
    return out


def diff_bbox(img_a, img_b):
    """两图差异包围盒；相同返回 None。用于新气泡检测/会话列表变化检测。"""
    from PIL import ImageChops
    a = img_a.convert("RGB")
    b = img_b.convert("RGB")
    if a.size != b.size:
        return (0, 0, max(a.width, b.width), max(a.height, b.height))
    return ImageChops.difference(a, b).getbbox()


# ---- 命名区域（窗口相对像素，按 1596x1269 基准标定；wxrpa.calibrate 可重标） ----
BASE_W, BASE_H = 1596, 1269
REGIONS = {
    "search_box":   (240, 88, 340, 120),    # 搜索框
    "session_list": (240, 130, 700, 950),   # 会话列表
    "title":        (380, 60, 1300, 160),   # 聊天标题栏
    "chat_tail":    (360, 760, 1600, 1030), # 聊天区底部（最新气泡）——止于1030，
                                            # 不得与输入框(起于1035)重叠：
                                            # 重叠会把"粘贴进输入框"误判成"新气泡"(实测踩坑)
    "input_box":    (360, 1040, 1600, 1200),# 输入框
}


def region(win, name: str):
    """把基准区域按当前窗口尺寸等比缩放，返回窗口相对像素矩形。"""
    x1, y1, x2, y2 = REGIONS[name]
    sx, sy = win.w / BASE_W, win.h / BASE_H
    return (int(x1 * sx), int(y1 * sy), int(x2 * sx), int(y2 * sy))


def shot_region(win, name: str):
    return shot(win, region(win, name))


def wait_still(sec: float = 1.2, interval: float = 0.4) -> bool:
    """等待画面静止（无动画/弹窗过渡）。超时返回 False。"""
    from . import wxwin
    w = wxwin.find_wechat()
    if not w:
        return False
    prev = shot(w)
    deadline = time.time() + sec
    while time.time() < deadline:
        time.sleep(interval)
        cur = shot(w)
        if diff_bbox(prev, cur) is None:
            return True
        prev = cur
    return False
