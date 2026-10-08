# -*- coding: utf-8 -*-
"""act8.py — 正道链：红条「查看详情」→Vue 开弹窗→「取消注销」→确认。全程 CDP 物理点击。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import DOM_PROBE, CONFIRM_SCAN, INDEX  # noqa: E402

# 找指定文本锚点；force=true 时掀开祖先链让它可见；返回所有候选坐标
ANCHORS = """
var word = arguments[0];
var force = arguments[1];
var all = document.querySelectorAll('a, span, button');
var cands = [];
for (var i = 0; i < all.length; i++) {
  var el = all[i];
  var t = (el.innerText || '').trim();
  if (t !== word) continue;
  var r = el.getBoundingClientRect();
  cands.push(el);
}
if (force) {
  for (var k = 0; k < cands.length; k++) {
    var chain = [];
    var n = cands[k];
    while (n && n !== document.body) { chain.push(n); n = n.parentElement; }
    for (var j = 0; j < chain.length; j++) {
      var st = chain[j].style;
      st.setProperty('display', 'block', 'important');
      st.setProperty('visibility', 'visible', 'important');
      st.setProperty('opacity', '1', 'important');
      st.setProperty('pointer-events', 'auto', 'important');
    }
  }
}
var res = [];
for (var m = 0; m < cands.length; m++) {
  var r2 = cands[m].getBoundingClientRect();
  var at = null;
  if (r2.width > 0) at = document.elementFromPoint(r2.x + r2.width / 2, r2.y + r2.height / 2);
  res.push({x: Math.round(r2.x), y: Math.round(r2.y), w: Math.round(r2.width), h: Math.round(r2.height),
            cover: at ? at.tagName + '/' + (at.innerText || '').trim().slice(0, 12) : null,
            same: at === cands[m]});
}
return JSON.stringify(res);
"""


def cdp_click(tab, x, y):
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseMoved", x=x, y=y)
    time.sleep(0.15)
    tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y,
                button="left", clickCount=1)
    time.sleep(0.08)
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y,
                button="left", clickCount=1)


def pick(tab, word, force=False):
    """返回第一个可点候选（rect>0 且 elementFromPoint 即自身或其子）。"""
    res = json.loads(tab.run_js(ANCHORS, word, force) or "[]")
    for r in res:
        if r.get("w", 0) > 0 and r.get("h", 0) > 0:
            return r
    return None


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    tab.get(INDEX)  # 全新导航：清掉此前 style hack，状态机复位
    time.sleep(4)

    # 1) 红条「查看详情」（必要时掀可见）
    d = pick(tab, "查看详情", force=True)
    out("ACT8_detail_anchor", anchor=d, shot=shot(tab, "act8_strip"))
    if d:
        cdp_click(tab, d["x"] + d["w"] // 2, d["y"] + d["h"] // 2)
        time.sleep(3)
        out("ACT8_detail_clicked", shot=shot(tab, "act8_dialog"))
    else:
        d = pick(tab, "注意", force=True)
        out("ACT8_notice_anchor", anchor=d, shot=shot(tab, "act8_strip2"))
        if not d:
            out("NEED_USER", note="no_detail_anchor")
            return 1
        cdp_click(tab, d["x"] + d["w"] // 2, d["y"] + d["h"] // 2)
        time.sleep(3)

    # 2) 弹窗开了吗：找可见的「取消注销」
    c = pick(tab, "取消注销", force=False)  # 只认自然可见的
    out("ACT8_cancel_anchor", anchor=c, shot=shot(tab, "act8_cancelpos"))
    if not c:
        # 弹窗没开成：也试一下强制可见版本（兼容）
        c = pick(tab, "取消注销", force=True)
        out("ACT8_cancel_forced", anchor=c, shot=shot(tab, "act8_cancelforce"))
        if not c:
            out("NEED_USER", note="cancel_not_reachable", shot=shot(tab, "act8_dead"))
            return 1
    cdp_click(tab, c["x"] + c["w"] // 2, c["y"] + c["h"] // 2)
    time.sleep(3)
    out("ACT8_cancel_clicked", shot=shot(tab, "act8_aftercancel"))

    # 3) 确认按钮（最多三轮）
    for rnd in (1, 2, 3):
        btns = json.loads(tab.run_js(CONFIRM_SCAN) or "[]")
        if not btns:
            break
        b = btns[0]
        cdp_click(tab, b["x"] + b["w"] // 2, b["y"] + b["h"] // 2)
        time.sleep(2.5)
        out(f"ACT8_confirm{rnd}", btn=b, shot=shot(tab, f"act8_c{rnd}"))

    # 4) 终审
    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT8_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act8_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
