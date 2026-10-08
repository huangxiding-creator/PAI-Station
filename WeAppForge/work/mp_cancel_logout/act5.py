# -*- coding: utf-8 -*-
"""act5.py — act4 修复版：先接可能已开的确认弹窗，否则重走 JS click 链。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot, out  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

DIALOG_STATE = """
var ds = document.querySelectorAll('.weui-desktop-dialog__wrp, .weui-desktop-dialog, .weui-dialog');
var res = [];
for (var i = 0; i < ds.length; i++) {
  var el = ds[i];
  var st = window.getComputedStyle(el);
  var r = el.getBoundingClientRect();
  var t = (el.innerText || '').split('\\n').join('|').slice(0, 90);
  if (t.indexOf('注销') >= 0 || t.indexOf('确定') >= 0 || t.indexOf('暂停') >= 0 || (r.width > 0 && st.display !== 'none')) {
    res.push({cls: el.className.toString().slice(0, 45), disp: st.display, w: Math.round(r.width), h: Math.round(r.height), text: t});
  }
}
return JSON.stringify(res.slice(0, 8));
"""

CLICK_CANCEL = """
var hit = [];
var all = document.querySelectorAll('a, span, button, div[data-msgid]');
for (var i = 0; i < all.length; i++) {
  var el = all[i];
  var t = (el.innerText || el.textContent || '').trim();
  var mid = el.getAttribute && (el.getAttribute('data-msgid') || '');
  if (t === '取消注销' || mid === '取消注销') {
    try { el.click(); hit.push({tag: el.tagName, mid: mid, text: t}); } catch (e) { hit.push({err: String(e).slice(0, 60)}); }
  }
}
return JSON.stringify(hit);
"""


def click_visible_confirm(tab):
    js = """
var hit = null;
var sels = ['.weui-desktop-dialog__ft a', '.weui-desktop-dialog__ft button',
            '.weui-dialog__btn', 'a.weui-desktop-btn', 'button.weui-desktop-btn',
            '.weui-desktop-modal__ft a', 'a', 'button'];
for (var s = 0; s < sels.length && !hit; s++) {
  var els;
  try { els = document.querySelectorAll(sels[s]); } catch (e) { continue; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var t = (el.innerText || '').trim();
    if (t !== '确定' && t !== '确认' && t !== '是' && t !== '继续') continue;
    var r = el.getBoundingClientRect();
    if (r.width <= 0 || r.height <= 0) continue;
    var st = window.getComputedStyle(el);
    if (st.display === 'none' || st.visibility === 'hidden') continue;
    el.click();
    hit = {sel: sels[s], text: t, x: Math.round(r.x), y: Math.round(r.y)};
    break;
  }
}
return JSON.stringify(hit);
"""
    r = tab.run_js(js)
    return json.loads(r) if r else None


def verify(tab):
    tab.get(INDEX)
    time.sleep(4)
    v = json.loads(tab.run_js("""
var t = document.body.innerText || '';
return JSON.stringify({cancel_flow: t.indexOf('自主注销') >= 0, freeze: t.indexOf('冻结') >= 0,
  pause: t.indexOf('暂停服务') >= 0, cancel_link: t.indexOf('取消注销') >= 0,
  restored_tip: t.indexOf('恢复正常') >= 0});
""") or "{}")
    gone = not (v.get("cancel_flow") or v.get("freeze") or v.get("cancel_link"))
    return v, gone


def main():
    page = attach_or_launch()
    tab = page.latest_tab

    # 1) 先看当前是否已有确认弹窗（act4 的 click 可能已触发）
    dlg = json.loads(tab.run_js(DIALOG_STATE) or "[]")
    out("ACT5_dialog_now", dlg=dlg, shot=shot(tab, "act5_now"))

    conf = click_visible_confirm(tab)
    if conf:
        out("ACT5_confirm_caught", conf=conf, shot=shot(tab, "act5_caught"))
        time.sleep(2.5)
        conf2 = click_visible_confirm(tab)
        if conf2:
            out("ACT5_confirm2", conf=conf2, shot=shot(tab, "act5_conf2"))
            time.sleep(2)
    else:
        # 2) 无弹窗 → 重新导航 + 重走 click 链
        tab.get(INDEX)
        time.sleep(4)
        hits = json.loads(tab.run_js(CLICK_CANCEL) or "[]")
        out("ACT5_reclick", hits=hits, shot=shot(tab, "act5_reclick"))
        time.sleep(3)
        dlg2 = json.loads(tab.run_js(DIALOG_STATE) or "[]")
        out("ACT5_dialog_after", dlg=dlg2, shot=shot(tab, "act5_dialog"))
        conf = click_visible_confirm(tab)
        if conf:
            out("ACT5_confirm1", conf=conf, shot=shot(tab, "act5_c1"))
            time.sleep(2.5)
            conf2 = click_visible_confirm(tab)
            if conf2:
                out("ACT5_confirm2", conf=conf2, shot=shot(tab, "act5_c2"))
                time.sleep(2)

    # 3) 验证
    v, gone = verify(tab)
    out("RESTORED" if gone else "ACT5_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act5_verify"))
    return 0 if gone else 2


if __name__ == "__main__":
    sys.exit(main())
