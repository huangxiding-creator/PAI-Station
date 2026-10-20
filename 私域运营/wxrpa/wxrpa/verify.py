# -*- coding: utf-8 -*-
"""验证层：发送后"新增气泡 + 新时间戳"双证据核验。

教训（2026-10-12/13 两连败的根因复盘）：
  - 只看"存在一条目标气泡"不够——分不清历史气泡和新发送
  - 发送前后 chat_tail 区域必须出现像素差异，且新内容含目标文本
  - 最终送达以接收端（手机）确认为准；本模块只保证"客户端已发出"
"""
from __future__ import annotations

import time

from . import perceive as pc


def norm(s: str) -> str:
    """OCR 归一化：去全部空白（空格/换行/制表），供顺序无关匹配。"""
    return "".join(s.split())


def ocr_variants(ocr_text: str):
    """OCR 行序可能颠倒/换行错位——生成正序与逆序两种拼接候选。"""
    lines = [l for l in ocr_text.splitlines() if l.strip()]
    fwd = "".join(lines)
    rev = "".join(reversed(lines))
    return fwd, rev


def needle_in(needle: str, ocr_text: str) -> bool:
    n = norm(needle)
    return any(n in v for v in ocr_variants(ocr_text))


def fuzzy_title_match(expected: str, title: str, threshold: float = 0.75) -> bool:
    """标题模糊匹配（OCR 小字易误读，如 输→物；精确 in 会误杀）。"""
    import difflib
    e, t = norm(expected), norm(title)
    if e in t:
        return True
    return difflib.SequenceMatcher(None, e, t[:max(len(e) + 4, 12)]).ratio() >= threshold


def verify_sent(win, before_img, text: str, timeout: float = 6.0) -> dict:
    """在 before_img（发送前 chat_tail 截图）之后等待新气泡出现。

    返回 {ok, new_text, timestamp}: new_text 为新增区域 OCR 文本，
    timestamp 为检测到的最新时间戳（若有）。
    """
    deadline = time.time() + timeout
    reg = pc.region(win, "chat_tail")
    while time.time() < deadline:
        time.sleep(0.8)
        after = pc.shot(win, reg)
        bbox = pc.diff_bbox(before_img, after)
        if bbox is None:
            continue
        # 有变化：裁出差异区做 OCR
        x1, y1, x2, y2 = bbox
        crop = after.crop((max(0, x1 - 20), max(0, y1 - 20),
                           min(after.width, x2 + 40), min(after.height, y2 + 60)))
        new_text = pc.ocr_text(crop)
        if needle_in(text[:8], new_text):
            ts = _latest_timestamp(new_text)
            return {"ok": True, "new_text": new_text, "timestamp": ts,
                    "bbox": bbox}
    return {"ok": False, "new_text": "", "timestamp": None, "bbox": None}


def _latest_timestamp(ocr_text: str) -> str | None:
    """从 OCR 文本里抓 HH:MM 时间戳（返回最后一个）。"""
    import re
    hits = re.findall(r"\d{1,2}:\d{2}", ocr_text)
    return hits[-1] if hits else None


def read_title(win) -> str:
    return pc.ocr_text(pc.shot_region(win, "title")).strip()


def read_input(win) -> str:
    return pc.ocr_text(pc.shot_region(win, "input_box")).strip()
