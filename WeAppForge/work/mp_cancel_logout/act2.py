# -*- coding: utf-8 -*-
"""act2.py — 登录后取消注销定点执行（可见元素过滤 + by_js 点击兜底）。"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = Path(__file__).parent
sys.path.insert(0, str(HERE))
from driver import attach_or_launch, shot, out, FILING  # noqa: E402


def visible_els(tab, locator):
    """返回所有匹配中『有位置有大小』的元素。"""
    res = []
    try:
        els = tab.eles(locator)
    except Exception:
        return res
    for e in els:
        try:
            if e.rect.size and (e.rect.size[0] > 0 and e.rect.size[1] > 0):
                res.append(e)
        except Exception:
            continue
    return res


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    url = tab.url or ""
    if "wxamp" not in url:
        out("ERROR", msg=f"not_logged_in url={url[:120]}")
        return 1

    # 1) 开弹窗：可见的「查看详情」（红横幅内）
    opened = False
    for e in visible_els(tab, 'text:查看详情'):
        try:
            e.click(by_js=True)
            time.sleep(2)
            opened = True
            break
        except Exception:
            continue
    if not opened:
        for e in visible_els(tab, 'text:注意'):
            try:
                e.click(by_js=True)
                time.sleep(2)
                opened = True
                break
            except Exception:
                continue
    out("ACT2_dialog_open_attempt", opened=opened, shot=shot(tab, "dialog_open"))

    # 2) 点「取消注销」：找有位置的链接
    cancels = visible_els(tab, '@data-msgid=取消注销')
    if not cancels:
        cancels = visible_els(tab, 'text:取消注销')
    if not cancels:
        out("NEED_USER", note="no_visible_cancel_link", shot=shot(tab, "nocancel2"))
        return 0
    c = cancels[0]
    out("ACT2_cancel_visible", rect=str(c.rect.size), shot=shot(tab, "cancel_visible"))
    try:
        c.click(by_js=True)
        time.sleep(3)
    except Exception as e:
        out("ACT2_cancel_click_err", msg=str(e)[:200], shot=shot(tab, "cancel_err2"))
        return 1

    # 3) 确认弹窗（若有）
    for label in ("确定", "确认", "是"):
        try:
            for b in visible_els(tab, f'text:{label}'):
                b.click(by_js=True)
                time.sleep(2)
                break
        except Exception:
            pass

    # 4) 验证：重载首页看红条
    tab.get(tab.url)
    time.sleep(3)
    html = tab.html or ""
    gone = ("自主注销" not in html) and ("账号冻结中" not in html)
    out("RESTORED" if gone else "ACT2_STILL_PRESENT",
        url=(tab.url or "")[:160], shot=shot(tab, "verify"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
