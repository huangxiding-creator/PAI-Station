# -*- coding: utf-8 -*-
"""act6.py — 强制可见 + CDP 物理点击「取消注销」（trusted 事件路线）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

# 找到含「取消注销」锚点的对话框wrapper，强制可见并置顶；返回锚点新坐标
FORCE_SHOW = """
var all = document.querySelectorAll('a, div[data-msgid]');
var anchor = null;
for (var i = 0; i < all.length; i++) {
  var el = all[i];
  var t = (el.innerText || el.textContent || '').trim();
  var mid = el.getAttribute && (el.getAttribute('data-msgid') || '');
  if (t === '取消注销' || mid === '取消注销') {
    var r = el.getBoundingClientRect();
    if (r.width > 0 && r.height > 0) { anchor = el; break; }
    if (!anchor) anchor = el;
  }
}
if (!anchor) return JSON.stringify({err: 'no_anchor'});
var wrp = anchor.closest('.weui-desktop-dialog__wrp') || anchor.closest('.weui-desktop-dialog') || anchor.parentElement;
var chain = [];
var n = wrp;
while (n && n !== document.body) {
  chain.push(n);
  n = n.parentElement;
}
for (var j = 0; j < chain.length; j++) {
  var st = chain[j].style;
  st.setProperty('display', 'block', 'important');
  st.setProperty('visibility', 'visible', 'important');
  st.setProperty('opacity', '1', 'important');
  st.setProperty('position', 'fixed', 'important');
  st.setProperty('left', '220px', 'important');
  st.setProperty('top', '140px', 'important');
  st.setProperty('z-index', '2147483000', 'important');
  st.setProperty('transform', 'none', 'important');
  st.setProperty('pointer-events', 'auto', 'important');
}
var r2 = anchor.getBoundingClientRect();
var at = document.elementFromPoint(r2.x + r2.width / 2, r2.y + r2.height / 2);
return JSON.stringify({ax: Math.round(r2.x), ay: Math.round(r2.y), w: Math.round(r2.width), h: Math.round(r2.height),
  cover: at ? (at.tagName + '/' + (at.innerText || '').trim().slice(0, 16)) : 'null',
  same: at === anchor, wrp_cls: wrp.className.toString().slice(0, 50)});
"""

DOM_PROBE = """
var h = document.documentElement.outerHTML;
var els = document.querySelectorAll('p[data-msgid]');
var live = [];
for (var i = 0; i < els.length; i++) {
  var t = (els[i].textContent || '').trim();
  if (t.indexOf('\u51bb\u7ed3\u671f') >= 0 || t.indexOf('\u6ce8\u9500\u6d41\u7a0b') >= 0) live.push(t.slice(0, 40));
}
return JSON.stringify({real0: h.indexOf('\u5269\u4f59\u51bb\u7ed3\u671f0\u5929') >= 0, live_texts: live.slice(0, 3)});
"""

CONFIRM_SCAN = """
var btns = document.querySelectorAll('a, button, .weui-desktop-btn');
var res = [];
for (var i = 0; i < btns.length; i++) {
  var el = btns[i];
  var t = (el.innerText || '').trim();
  if (t !== '确定' && t !== '确认' && t !== '是') continue;
  var r = el.getBoundingClientRect();
  if (r.width <= 0 || r.height <= 0) continue;
  var st = window.getComputedStyle(el);
  if (st.display === 'none' || st.visibility === 'hidden' || parseFloat(st.opacity) === 0) continue;
  res.push({text: t, x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)});
  if (res.length >= 4) break;
}
return JSON.stringify(res);
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    tab.get(INDEX)
    time.sleep(4)

    info = json.loads(tab.run_js(FORCE_SHOW) or "{}")
    out("ACT6_force_show", info=info, shot=shot(tab, "act6_shown"))
    if "err" in info:
        return 1

    # elementFromPoint 不是锚点本身 → 有遮挡，掀掉顶层遮罩再试一次
    if not info.get("same"):
        tab.run_js("""
for (var k = 0; k < 4; k++) {
  var el = document.elementFromPoint(arguments[0], arguments[1]);
  if (!el || el.tagName === 'A') break;
  el.style.setProperty('display', 'none', 'important');
}
return true;
""", info["ax"] + info["w"] // 2, info["ay"] + info["h"] // 2)
        info2 = json.loads(tab.run_js(FORCE_SHOW) or "{}")
        out("ACT6_force_show2", info=info2, shot=shot(tab, "act6_shown2"))
        if "ax" in info2:
            info = info2

    cx = info["ax"] + info["w"] // 2
    cy = info["ay"] + info["h"] // 2
    # CDP Input 物理点击（trusted）
    tab.actions.move_to(cx, cy).hold().release().perform()
    time.sleep(3)
    out("ACT6_phys_clicked", xy=[cx, cy], shot=shot(tab, "act6_clicked"))

    # 确认按钮（最多两轮，物理点击）
    for rnd in (1, 2):
        btns = json.loads(tab.run_js(CONFIRM_SCAN) or "[]")
        if not btns:
            break
        b = btns[0]
        bx = b["x"] + b["w"] // 2
        by = b["y"] + b["h"] // 2
        tab.actions.move_to(bx, by).hold().release().perform()
        time.sleep(2.5)
        out(f"ACT6_confirm{rnd}", btn=b, shot=shot(tab, f"act6_c{rnd}"))

    # 终审：全新导航 + DOM 探针
    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT6_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act6_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
