# -*- coding: utf-8 -*-
"""诊断2: composer 祖先链 button 结构 (只读, 不点击) — 定位发送按钮漂移."""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
print(f"[diag2] url = {page.url}")
box = page.ele("xpath://*[@contenteditable='true']", timeout=5)
if not box:
    print("[diag2] composer 不在")
    sys.exit(0)

anc = box
for depth in range(1, 8):
    try:
        anc = anc.parent()
    except Exception:
        print(f"[diag2] depth{depth} 无父层")
        break
    cls = ""
    try:
        cls = (anc.attr("class") or "")[:60]
    except Exception:
        pass
    btns = anc.eles("tag:button")
    print(f"[diag2] 祖先{depth} class={cls!r} buttons={len(btns)}")
    for b in btns:
        try:
            txt = (b.text or "").strip()[:16]
            dis = b.attr("disabled")
            aria = b.attr("aria-label") or ""
            vis = b.states.is_displayed
            tag_html = b.html[:80].replace("\n", " ") if not txt else ""
            print(f"   btn text={txt!r} disabled={dis} aria={aria!r} "
                  f"vis={vis} {tag_html}")
        except Exception as e:
            print(f"   btn err {type(e).__name__}")
    if btns:
        break   # 与 send_task 同款: 找到第一层有 button 的祖先即停
