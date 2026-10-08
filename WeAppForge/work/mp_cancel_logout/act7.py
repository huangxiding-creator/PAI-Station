# -*- coding: utf-8 -*-
"""act7.py — CDP Input.dispatchMouseEvent 物理点击「取消注销」（trusted 坐标事件）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import FORCE_SHOW, DOM_PROBE, CONFIRM_SCAN, INDEX  # noqa: E402


def cdp_click(tab, x, y):
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseMoved", x=x, y=y)
    time.sleep(0.2)
    tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y,
                button="left", clickCount=1)
    time.sleep(0.1)
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y,
                button="left", clickCount=1)


def main():
    page = attach_or_launch()
    tab = page.latest_tab

    # 1) 锚点现状（act6 已强制可见，样式应仍在）
    info = json.loads(tab.run_js(FORCE_SHOW) or "{}")  # 幂等：不可见则再掀
    out("ACT7_anchor", info=info, shot=shot(tab, "act7_anchor"))
    if "ax" not in info:
        return 1
    cx = info["ax"] + info["w"] // 2
    cy = info["ay"] + info["h"] // 2

    # 2) CDP trusted 物理点击
    cdp_click(tab, cx, cy)
    time.sleep(3)
    out("ACT7_cdp_clicked", xy=[cx, cy], shot=shot(tab, "act7_clicked"))

    # 3) 确认按钮（最多三轮，物理点击）
    for rnd in (1, 2, 3):
        btns = json.loads(tab.run_js(CONFIRM_SCAN) or "[]")
        if not btns:
            break
        b = btns[0]
        cdp_click(tab, b["x"] + b["w"] // 2, b["y"] + b["h"] // 2)
        time.sleep(2.5)
        out(f"ACT7_confirm{rnd}", btn=b, shot=shot(tab, f"act7_c{rnd}"))

    # 4) 终审：全新导航 + DOM 探针
    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT7_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act7_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
