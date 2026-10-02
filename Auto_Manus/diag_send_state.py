# -*- coding: utf-8 -*-
"""诊断: send_task 无 sid 现场 — 只读接管 9333 实例, 抓页面残留态.

绝不点击/输入 (corps 正在跑, 只读 URL/文本/截图/composer 态).
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()   # 同端口+同 profile = 接管现有实例
print(f"[diag] url = {page.url}")
try:
    print(f"[diag] title = {page.title}")
except Exception as e:
    print(f"[diag] title err {type(e).__name__}")

# composer 是否在、内容是否残留
try:
    box = page.ele("xpath://*[@contenteditable='true']", timeout=3)
    if box:
        txt = (box.text or "")[:120].replace("\n", "\\n")
        print(f"[diag] composer 在, 内容残留: {txt!r}")
    else:
        print("[diag] composer 不在 (页面非主界面?)")
except Exception as e:
    print(f"[diag] composer err {type(e).__name__}: {str(e)[:60]}")

# 可见文本头部 (找模态框/引导层/报错)
try:
    body = page.ele("tag:body")
    vis = (body.text or "")[:600].replace("\n", " | ")
    print(f"[diag] body头600: {vis}")
except Exception as e:
    print(f"[diag] body err {type(e).__name__}")

# 按钮 disabled 态 (send_task 同款 JS)
try:
    print(f"[diag] 继续-btn disabled = {lib._btn_continue_disabled(page)}")
except Exception:
    pass

# 顶层 dialog / modal 探测
try:
    for sel in ("tag:dialog", "css:[role='dialog']",
                "css:div[class*='modal']", "css:div[class*='overlay']"):
        el = page.ele(sel, timeout=1)
        if el:
            t = (el.text or "")[:200].replace("\n", " | ")
            print(f"[diag] 模态 {sel}: {t!r}")
            break
except Exception:
    pass

try:
    page.get_screenshot("diag_send_state.png", full_page=True)
    print("[diag] 截图 diag_send_state.png ✓")
except Exception as e:
    print(f"[diag] 截图失败 {type(e).__name__}: {str(e)[:60]}")
