# -*- coding: utf-8 -*-
"""诊断3: composer 区 4 button 的 rect/html — 用坐标+svg 判哪个是真发送 (只读)."""
import sys

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
box = page.ele("xpath://*[@contenteditable='true']", timeout=5)
anc = box.parent().parent()   # 祖先2 = div.contents (diag2 实证按钮在此层)
btns = anc.eles("tag:button")
for i, b in enumerate(btns):
    try:
        r = b.run_js("function(){var r=this.getBoundingClientRect();"
                     "return JSON.stringify({x:r.x,y:r.y,w:r.width,h:r.height});}")
        print(f"btn[{i}] rect={r}")
        print(f"   html: {b.html[:200].replace(chr(10), ' ')}")
    except Exception as e:
        print(f"btn[{i}] err {type(e).__name__}: {str(e)[:50]}")
print("---")
# composer 自身 rect 对照 (发送键应在输入框右缘)
try:
    r = box.rect
    print(f"composer x={r.viewport_x} y={r.viewport_y} "
          f"w={r.viewport_width} h={r.viewport_height}")
except Exception:
    pass
