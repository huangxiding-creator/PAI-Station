# -*- coding: utf-8 -*-
"""引擎层：高层 API——send_text / read_sessions / detect_activity。

send_text 全流程（识流"行动-验证闭环"复刻）：
  护栏检查 → 打开目标聊天(搜索+验证) → 截发送前基线 →
  剪贴板先写 → 聚焦输入框 → Ctrl+V → OCR 回读输入框 →
  回车发送 → 新气泡+时间戳双证据核验 → 恢复剪贴板 → 台账
"""
from __future__ import annotations

from . import guardrail as gr
from . import human_input as hi
from . import navigate
from . import perceive as pc
from . import verify
from . import wxwin


def send_text(chat: str, text: str, disambiguate="first",
              quiet_hours_override: bool = False) -> dict:
    """向指定聊天发送一条文本。返回核验结果 dict。

    quiet_hours_override: 静默时段豁免（仅限主理人本人在场的人工调用，
                          自动化流程禁止传 True）。
    """
    gr.check_action(chat, "send") if not quiet_hours_override else gr.check_action(chat, "manual")

    win = wxwin.ensure_active()
    navigate.open_chat(chat, disambiguate=disambiguate)

    reg = pc.region(win, "chat_tail")
    before = pc.shot(win, reg)

    # 剪贴板先写（防 tkinter 抢焦点）→ 聚焦输入框 → 纯 Ctrl+V
    backup = hi.get_clipboard()
    hi.set_clipboard(text)
    navigate.focus_input_box(win)
    hi.jitter_ms(250, 400)
    hi.pyautogui.hotkey("ctrl", "v")
    hi.jitter_ms(300, 500)

    # 输入框回读校验（OCR，容忍行序颠倒/噪声——见 verify.needle_in）
    inbox = verify.read_input(win)
    if not verify.needle_in(text[:8], inbox):
        hi.set_clipboard(backup)
        raise RuntimeError(f"输入框回读不匹配: {inbox!r}，已中止未发送")

    # 发送（本机微信发送键 = Ctrl+Enter；Enter 只会换行——2026-10-13 根因教训）
    hi.jitter_ms(300, 500)
    hi.pyautogui.hotkey("ctrl", "enter")

    # 新气泡 + 时间戳双证据
    result = verify.verify_sent(win, before, text)
    gr.record_action(chat, "send", {"text": text, "ok": result["ok"],
                                    "ts": result.get("timestamp")})
    # 恢复原剪贴板
    hi.jitter_ms(300, 500)
    hi.set_clipboard(backup)
    if not result["ok"]:
        raise RuntimeError("发送后 6s 内未检测到新气泡（可能未送达，请人工核验手机")
    return result


def read_title() -> str:
    win = wxwin.ensure_active()
    return verify.read_title(win)


def session_list_text() -> str:
    """读会话列表（OCR）——用于新消息巡检/群画像。"""
    win = wxwin.ensure_active()
    return pc.ocr_text(pc.shot_region(win, "session_list"))


def detect_activity(interval: float = 3.0, rounds: int = 1) -> list:
    """轮询会话列表区域，返回每轮的像素 diff 包围盒（非 None = 有新消息）。"""
    win = wxwin.ensure_active()
    reg = pc.region(win, "session_list")
    prev = pc.shot(win, reg)
    events = []
    for _ in range(rounds):
        import time as _t
        _t.sleep(interval)
        cur = pc.shot(win, reg)
        bbox = pc.diff_bbox(prev, cur)
        if bbox:
            events.append(bbox)
        prev = cur
    return events
