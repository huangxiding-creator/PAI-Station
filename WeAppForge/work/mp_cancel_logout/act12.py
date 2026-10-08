# -*- coding: utf-8 -*-
"""act12.py — SET_DIALOG_FORBID 正式打开弹窗 → 点取消注销 → 跟踪后续。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402
from act6 import INDEX  # noqa: E402

SETUP = """
var els = document.querySelectorAll('*');
var vueEls = [];
for (var j = 0; j < els.length; j++) { if (els[j].__vue__) vueEls.push(els[j].__vue__); }
var idx = null, mpd = null, msg = null, anchor = null;
for (var k = 0; k < vueEls.length; k++) {
  var c = vueEls[k];
  if (!idx && c.$options.methods && c.$options.methods.SET_DIALOG_FORBID) idx = c;
  if (!mpd && (c.$options.name || '') === 'mp-dialog' && String(c.$el.className).indexOf('forbid') >= 0) mpd = c;
}
var aa = document.querySelectorAll('a[data-msgid]');
for (var q = 0; q < aa.length; q++) { if ((aa[q].getAttribute('data-msgid') || '') === '\\u53d6\\u6d88\\u6ce8\\u9500') { anchor = aa[q]; break; } }
if (!idx) return JSON.stringify({err: 'no_index'});
try { idx.SET_DIALOG_FORBID({show: true}); } catch (e) { return JSON.stringify({err: 'set_fail: ' + String(e).slice(0, 80)}); }
var r = {set_done: true, mpd_visible: null};
if (mpd) r.mpd_visible = mpd._data.visible;
if (anchor) { var rc = anchor.getBoundingClientRect(); r.anchor = {x: Math.round(rc.x), y: Math.round(rc.y), w: Math.round(rc.width), h: Math.round(rc.height)}; }
// 弹窗开着的话，把 wrapper 层也确认可见
var wrps = document.querySelectorAll('.weui-desktop-dialog__wrp');
r.wrp_visible = [];
for (var w = 0; w < wrps.length; w++) {
  var st = window.getComputedStyle(wrps[w]);
  var t = (wrps[w].innerText || '').slice(0, 24);
  if (t.indexOf('\\u6ce8\\u9500') >= 0 || t.indexOf('\\u6682\\u505c') >= 0) r.wrp_visible.push({disp: st.display, w: Math.round(wrps[w].getBoundingClientRect().width), t: t});
}
return JSON.stringify(r);
"""

POLL = """
var t = document.body.innerText || '';
var res = {succ: t.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500\\u6210\\u529f') >= 0,
  fail: t.indexOf('\\u53d6\\u6d88\\u6ce8\\u9500\\u5931\\u8d25') >= 0,
  confirm_dialog: false};
var btns = document.querySelectorAll('a, button');
for (var i = 0; i < btns.length; i++) {
  var bt = (btns[i].innerText || '').trim();
  if ((bt === '\\u786e\\u5b9a' || bt === '\\u786e\\u8ba4') && btns[i].getBoundingClientRect().width > 0) {
    res.confirm_dialog = true;
    var rc = btns[i].getBoundingClientRect();
    res.confirm_btn = {t: bt, x: Math.round(rc.x), y: Math.round(rc.y), w: Math.round(rc.width), h: Math.round(rc.height)};
    break;
  }
}
return JSON.stringify(res);
"""

QUERY = """
async function main() {
  try {
    var resp = await fetch('/publicpoc/wxaacctclose?action=querycloseinfo&token=91558662&lang=zh_CN', {method: 'GET', credentials: 'same-origin'});
    return JSON.stringify({q: (await resp.text()).slice(0, 200)});
  } catch (e) { return JSON.stringify({err: String(e).slice(0, 80)}); }
}
return main();
"""

DOM_PROBE = """
var h = document.documentElement.outerHTML;
var els = document.querySelectorAll('p[data-msgid]');
var live = [];
for (var i = 0; i < els.length; i++) {
  var t = (els[i].textContent || '').trim();
  if (t.indexOf('\\u51bb\\u7ed3\\u671f') >= 0) live.push(t.slice(0, 40));
}
return JSON.stringify({real0: h.indexOf('\\u5269\\u4f59\\u51bb\\u7ed3\\u671f0\\u5929') >= 0, live_texts: live.slice(0, 3)});
"""


def cdp_click(tab, x, y):
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseMoved", x=x, y=y)
    time.sleep(0.15)
    tab.run_cdp("Input.dispatchMouseEvent", type="mousePressed", x=x, y=y,
                button="left", clickCount=1)
    time.sleep(0.08)
    tab.run_cdp("Input.dispatchMouseEvent", type="mouseReleased", x=x, y=y,
                button="left", clickCount=1)


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    if "wxamp" not in (tab.url or ""):
        tab.get(INDEX)
        time.sleep(4)

    r = json.loads(tab.run_js(SETUP) or "{}")
    out("ACT12_setup", r=r, shot=shot(tab, "act12_setup"))
    if "err" in r or not r.get("anchor"):
        return 1

    a = r["anchor"]
    if a.get("w", 0) > 0:
        cdp_click(tab, a["x"] + a["w"] // 2, a["y"] + a["h"] // 2)
    else:
        # 弹窗开但锚点仍0宽：JS click 兜底
        tab.run_js("""
var aa = document.querySelectorAll('a[data-msgid]');
for (var i = 0; i < aa.length; i++) { if ((aa[i].getAttribute('data-msgid') || '') === '\\u53d6\\u6d88\\u6ce8\\u9500') { aa[i].click(); break; } }
return true;
""")
    time.sleep(2.5)
    out("ACT12_clicked", shot=shot(tab, "act12_click"))

    # 轮询后续：确认框 / toast
    for i in range(8):
        p = json.loads(tab.run_js(POLL) or "{}")
        if p.get("succ") or p.get("fail") or p.get("confirm_btn"):
            out(f"ACT12_poll{i}", p=p, shot=shot(tab, f"act12_p{i}"))
            if p.get("confirm_btn"):
                b = p["confirm_btn"]
                cdp_click(tab, b["x"] + b["w"] // 2, b["y"] + b["h"] // 2)
                time.sleep(2.5)
            break
        time.sleep(1.2)
    else:
        out("ACT12_no_followup", shot=shot(tab, "act12_nofollow"))

    time.sleep(3)
    q = json.loads(tab.run_js(QUERY) or "{}")
    tab.get(INDEX)
    time.sleep(5)
    v = json.loads(tab.run_js(DOM_PROBE) or "{}")
    gone = (not v.get("real0")) and (not v.get("live_texts"))
    out("RESTORED" if gone else "ACT12_STILL_PRESENT", verify=v, api=q,
        url=(tab.url or "")[:140], shot=shot(tab, "act12_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
