# -*- coding: utf-8 -*-
"""识流式验证发送——每步截图复核，不确定就中止。

复刻识流的"行动-验证闭环"（逆向报告 §3.3）：
  1. 打开群 → 截图标题栏 → OCR 验证群名匹配
  2. 粘贴内容 → 截图输入框 → OCR 验证内容在场
  3. 发送后 → 截图聊天区 → diff 验证新气泡出现
  4. 任何一步验证失败 → 不发送，报告失败
"""
from __future__ import annotations

import difflib
import time

import pyautogui

from . import human_input as hi
from . import perceive as pc
from . import verify
from . import wxwin


class VerifiedSender:
    """带逐步验证的消息发送器——只在用户空闲时操作，不抢鼠标。"""

    IDLE_THRESHOLD_MS = 3000  # 用户 3 秒无操作才算空闲

    def __init__(self):
        self.win = None

    @staticmethod
    def _user_is_idle() -> bool:
        """检测用户是否空闲（无键鼠操作）。"""
        import ctypes
        class LASTINPUTINFO(ctypes.Structure):
            _fields_ = [("cbSize", ctypes.c_uint),
                       ("dwTime", ctypes.c_uint)]
        info = LASTINPUTINFO()
        info.cbSize = ctypes.sizeof(LASTINPUTINFO)
        ctypes.windll.user32.GetLastInputInfo(ctypes.byref(info))
        idle_ms = ctypes.windll.kernel32.GetTickCount() - info.dwTime
        return idle_ms >= VerifiedSender.IDLE_THRESHOLD_MS

    @staticmethod
    def _wait_for_idle(timeout: float = 120.0) -> bool:
        """等待用户空闲（最多等 timeout 秒）。"""
        start = time.time()
        while time.time() - start < timeout:
            if VerifiedSender._user_is_idle():
                time.sleep(0.5)  # 再确认一次
                if VerifiedSender._user_is_idle():
                    return True
            time.sleep(1.0)
        return False

    def _ensure(self):
        if self.win is None:
            self.win = wxwin.ensure_active()
        return self.win

    def _search(self, name: str):
        """在搜索框输入群名。"""
        win = self._ensure()
        sx, sy = win.rel(288 / 1596, 102 / 1269)
        hi.human_click(sx, sy)
        time.sleep(0.8)
        pyautogui.hotkey("ctrl", "a")
        time.sleep(0.2)
        hi.set_clipboard(name)
        pyautogui.hotkey("ctrl", "v")
        time.sleep(3.0)

    def _verify_title(self, expected: str) -> float:
        """截图标题栏，OCR 读取，返回与期望群名的相似度。"""
        win = self._ensure()
        title = verify.read_title(win).strip()
        if not title:
            # 标题栏读不到，截大区域再试
            img = pc.shot(win, (360, 60, 1300, 160))
            title = pc.ocr_text(img).strip()
        if not title:
            return 0.0
        sim = difflib.SequenceMatcher(
            None, expected[:6], title[:6]).ratio()
        return sim

    def _verify_new_message(self, before_img) -> bool:
        """对比发送前后截图，验证新气泡出现。"""
        win = self._ensure()
        after = pc.shot(win, pc.region(win, "chat_tail"))
        from PIL import ImageChops
        bbox = ImageChops.difference(before_img, after).getbbox()
        return bbox is not None

    def open_group_verified(self, group_name: str) -> bool:
        """打开群并验证标题——三种策略，每种都验证。"""
        win = self._ensure()

        # 策略1：搜索 + Enter（选最佳匹配）
        self._search(group_name)
        pyautogui.press("enter")
        time.sleep(2.0)
        sim = self._verify_title(group_name)
        if sim > 0.5:
            print(f"  [策略1-Enter] 标题匹配 {sim:.0%}")
            return True

        # 策略2：重新搜索 + OCR 定位含"群"的行 + 点击
        self._search(group_name)
        time.sleep(1.0)
        img = pc.shot(win, (200, 130, 760, 800))
        lines = pc.ocr_lines(img)
        best_y, best_sim = None, 0
        for y, text, box, score in lines:
            clean = text.strip().replace(" ", "")
            if "群" not in clean:
                continue
            s = difflib.SequenceMatcher(
                None, group_name[:4], clean[:4]).ratio()
            if s > best_sim:
                best_sim = s
                best_y = y
        if best_y is not None and best_sim > 0.5:
            y_abs = win.top + 130 + int(best_y)
            hi.human_click(win.left + 460, y_abs)
            time.sleep(2.0)
            sim = self._verify_title(group_name)
            if sim > 0.5:
                print(f"  [策略2-点击] 标题匹配 {sim:.0%}")
                return True

        # 策略3：从会话列表找
        pyautogui.press("escape")
        time.sleep(0.5)
        img = pc.shot(win, (240, 130, 700, 950))
        lines = pc.ocr_lines(img)
        for y, text, box, score in lines:
            clean = text.strip().replace(" ", "")
            if group_name[:4] in clean:
                hi.human_click(win.left + 400, win.top + 130 + int(y))
                time.sleep(1.5)
                sim = self._verify_title(group_name)
                if sim > 0.5:
                    print(f"  [策略3-列表] 标题匹配 {sim:.0%}")
                    return True
                break

        print(f"  [失败] 三种策略均未验证通过 (最高相似度: {sim:.0%})")
        return False

    def send_text_verified(self, text: str) -> bool:
        """发送文本并验证新气泡出现。"""
        win = self._ensure()

        # 发送前基线截图
        before = pc.shot(win, pc.region(win, "chat_tail"))

        # 粘贴 + 发送
        hi.set_clipboard(text)
        ix, iy = win.rel(1015 / 1596, 1130 / 1269)
        hi.human_click(ix, iy)
        time.sleep(0.5)
        pyautogui.hotkey("ctrl", "v")
        time.sleep(0.8)

        # 验证输入框有内容（识流式 0/1 后验）
        inbox = verify.read_input(win)
        has_content = text[:8].replace(" ", "") in inbox.replace(" ", "")
        if not has_content:
            # OCR 可能读错，再试一次
            time.sleep(0.5)
            inbox = verify.read_input(win)
            has_content = text[:4].replace(" ", "") in inbox.replace(" ", "")

        if not has_content:
            print("  [中止] 输入框验证失败——内容未粘贴成功")
            return False

        # 发送
        pyautogui.hotkey("ctrl", "enter")
        time.sleep(1.5)

        # 验证新气泡
        if self._verify_new_message(before):
            print("  [验证] 新气泡已出现——发送成功")
            return True
        else:
            # 再等一秒重试验证
            time.sleep(1.0)
            if self._verify_new_message(before):
                print("  [验证] 新气泡已出现（延迟）——发送成功")
                return True
            print("  [失败] 未检测到新气泡——可能未发送")
            return False

    def send_image_verified(self, image_path: str) -> bool:
        """发送图片并验证。"""
        win = self._ensure()
        import win32clipboard, win32con
        from PIL import Image
        import io as _io

        # 发送前基线
        before = pc.shot(win, pc.region(win, "chat_tail"))

        # 图片到剪贴板
        img = Image.open(image_path)
        buf = _io.BytesIO()
        img.convert("RGB").save(buf, "BMP")
        bmp_data = buf.getvalue()[14:]
        win32clipboard.OpenClipboard()
        win32clipboard.EmptyClipboard()
        win32clipboard.SetClipboardData(win32con.CF_DIB, bmp_data)
        win32clipboard.CloseClipboard()

        # 聚焦 → 粘贴 → 发送
        ix, iy = win.rel(1015 / 1596, 1130 / 1269)
        hi.human_click(ix, iy)
        time.sleep(0.5)
        pyautogui.hotkey("ctrl", "v")
        time.sleep(3.0)  # 等图片预览加载

        # 验证：截图看是否有图片预览
        # （图片预览会使输入框区域变大或出现缩略图）
        mid = pc.shot(win, pc.region(win, "chat_tail"))
        from PIL import ImageChops
        has_preview = ImageChops.difference(before, mid).getbbox() is not None

        pyautogui.hotkey("ctrl", "enter")
        time.sleep(2.0)

        # 最终验证
        if self._verify_new_message(before):
            print("  [验证] 聊天区已变化——图片可能已发送")
            return True
        print("  [失败] 聊天区无变化——图片可能未发送")
        return False


# 便捷函数
def verified_send(group_name: str, text: str = None,
                  image_path: str = None,
                  wait_idle: bool = True) -> bool:
    """打开群 → 验证 → 发送 → 验证（不抢鼠标）。"""
    vs = VerifiedSender()

    # 等待用户空闲
    if wait_idle:
        print(f"等待用户空闲（最多120秒）...", end="")
        if not vs._wait_for_idle():
            print(" 超时，放弃")
            return False
        print(" 空闲，开始")

    print(f"发送到: {group_name}")

    if not vs.open_group_verified(group_name):
        return False

    if image_path:
        return vs.send_image_verified(image_path)
    elif text:
        return vs.send_text_verified(text)
    return False
