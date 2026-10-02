# -*- coding: utf-8 -*-
"""probe2: dump 发送键完整HTML + 依次试 Enter / 坐标点击, 只认创建类请求."""
import json as _json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import manus_lib as lib

page = lib.make_page()
print(f"[p2] url = {page.url}")
box = page.ele("xpath://*[@contenteditable='true']", timeout=5)
if not box:
    print("[p2] composer 不在")
    sys.exit(1)
anc = box.parent().parent()
btns = anc.eles("tag:button")
send = btns[-1]
print(f"[p2] 发送键完整html:\n{send.html}\n---")

CREATE = re.compile(r"create|session|task", re.I)


def watch(label, act, wait_s=15):
    page.listen.start("api.manus.im")
    act()
    deadline = time.time() + wait_s
    seen, sid = [], None
    while time.time() < deadline:
        m = re.search(r"/app/([A-Za-z0-9_-]{8,})", page.url or "")
        if m:
            sid = m.group(1)
            break
        try:
            pkt = page.listen.wait(timeout=1)
            if pkt and not pkt.is_failed:
                u = pkt.url.split("?")[0]
                if u not in seen:
                    seen.append(u)
                    mark = " ←创建类!" if CREATE.search(u) else ""
                    print(f"[p2:{label}] {pkt.response.status} {u}{mark}")
        except Exception:
            pass
        if sid:
            break
    page.listen.stop()
    if sid:
        print(f"[p2:{label}] ✓✓✓ 创建成功 sid={sid}")
    return sid


sid = watch("Enter", lambda: (box.click(),
                              page.actions.key_down("enter").key_up("enter")))
if not sid:
    geo = _json.loads(send.run_js(
        "function(){var r=this.getBoundingClientRect();"
        "return JSON.stringify({x:r.x+r.width/2,y:r.y+r.height/2});}"))
    sid = watch("坐标点", lambda: page.actions.click((geo["x"], geo["y"])))
if not sid:
    sid = watch("JSclick", lambda: send.run_js("function(){this.click();}"))
print(f"[p2] 终态: {page.url}")
print(f"[p2] 结论: {'创建链路通 → 修复 send_task 即可' if sid else '三法全灭 → 更深形态'}")
