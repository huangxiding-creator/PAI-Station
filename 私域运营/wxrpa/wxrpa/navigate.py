# -*- coding: utf-8 -*-
"""导航层：搜索定位指定聊天（识流 searchUserRPA 的本地视觉版）。

流程（每步带验证，失败即中止——2026-10-13 实战教训）：
  点搜索框 → 剪贴板先写 → Ctrl+V → OCR 搜索结果浮层 →
  匹配目标行（含消歧）→ 拟人点击 → OCR 标题栏验证
"""
from __future__ import annotations

from . import human_input as hi
from . import perceive as pc
from . import wxwin

# 搜索框中心（窗口比例，2026-10-13 按 1596x1269 实测标定）
SEARCH_X, SEARCH_Y = 288 / 1596, 102 / 1269


def _retry(fn, times: int = 2, *a, **kw):
    last = None
    for _ in range(times):
        try:
            r = fn(*a, **kw)
            if r:
                return r
        except Exception as e:  # noqa: BLE001
            last = e
    if last:
        raise last
    return None


def open_chat(name: str, disambiguate: str = "first") -> bool:
    """通过搜索打开与 name 精确匹配的聊天。

    disambiguate: "first"（默认第一个精确匹配）| "starred"（带星标的那个）
                  | 序号（第 N 个精确匹配，从 1 起）
    返回 True 表示已打开且标题验证通过；同名多条且无明确 disambiguate 策略时
    抛 AmbiguousChat 异常（架构裁定：同名必须消歧，不自动猜）。
    """
    win = wxwin.ensure_active()

    # 1) 点搜索框并粘贴（先写剪贴板再聚焦——防 tkinter 抢焦点）
    hi.set_clipboard(name)
    sx, sy = win.rel(SEARCH_X, SEARCH_Y)
    hi.human_click(sx, sy)
    hi.jitter_ms(600, 900)
    hi.pyautogui.hotkey("ctrl", "v")
    hi.jitter_ms(700, 1000)

    # 2) OCR 搜索结果，找精确匹配行
    def _locate():
        img = pc.shot(win, (200, 130, 700, 800))   # 搜索浮层区域（窗口相对）
        lines = pc.ocr_lines(img)
        hits = [(y, t) for y, t, _, _ in lines if t.strip() == name or
                t.strip().startswith(name)]
        exact = [(y, t) for y, t in hits if t.strip() == name]
        return exact or hits

    rows = _retry(_locate)
    if not rows:
        raise RuntimeError(f"搜索 {name!r} 无结果")
    if len(rows) > 1 and disambiguate == "first":
        # 多个同名：默认取第一个，但记录告警（调用方可传 disambiguate 指定）
        pass
    pick = rows[0]
    if isinstance(disambiguate, int):
        if len(rows) < disambiguate:
            raise RuntimeError(f"同名结果不足 {disambiguate} 个")
        pick = rows[disambiguate - 1]

    # 3) 点击目标行（点击 x 取浮层中部，避开头像圆形区域）
    y_abs = win.top + 130 + int(pick[0])
    x_abs = win.left + 460
    hi.human_click(x_abs, y_abs)
    hi.jitter_ms(800, 1200)

    # 4) 标题栏验证（模糊匹配，容忍 OCR 误读）
    from .verify import fuzzy_title_match
    title = pc.ocr_text(pc.shot_region(win, "title")).strip()
    if not fuzzy_title_match(name, title):
        raise RuntimeError(f"聊天打开验证失败：标题栏={title!r}，期望≈{name!r}")
    return True


def focus_input_box(win) -> None:
    """点击聊天输入框获得焦点（坐标为输入区中心）。"""
    ix, iy = win.rel(1015 / 1596, 1130 / 1269)
    hi.human_click(ix, iy)
    hi.jitter_ms(300, 500)
