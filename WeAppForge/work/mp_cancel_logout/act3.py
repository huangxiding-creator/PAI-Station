# -*- coding: utf-8 -*-
"""act3.py — 全新导航让注销横幅重新渲染，趁热定位「取消注销」链接并点击。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
HERE = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout"
sys.path.insert(0, HERE)
from driver import attach_or_launch, shot, out  # noqa: E402

TOKEN = "91558662"
INDEX = f"https://mp.weixin.qq.com/wxamp/index/index?token={TOKEN}&lang=zh_CN"

# 无上限扫描：任何 innerText 含「取消注销」的元素 + 其可点子链接
SCAN = """
var seen = [];
var all = document.querySelectorAll('*');
for (var i = 0; i < all.length; i++) {
  var el = all[i];
  if (el.children.length > 6) continue;
  var t = (el.innerText || '').trim();
  if (t.indexOf('取消注销') < 0 && t.indexOf('自主注销流程') < 0) continue;
  var r = el.getBoundingClientRect();
  var style = window.getComputedStyle(el);
  seen.push({tag: el.tagName, cls: el.className.toString().slice(0, 60),
             text: t.split('\\n').join('|').slice(0, 60),
             x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height),
             disp: style.display, vis: style.visibility});
  if (seen.length >= 20) break;
}
return JSON.stringify(seen);
"""


def find_cancel(tab):
    try:
        return json.loads(tab.run_js(SCAN) or "[]")
    except Exception as e:
        return [{"err": str(e)[:120]}]


def click_confirm(tab):
    """点确认弹窗的确定/确认按钮（只要可见的）。"""
    js = """
var btns = document.querySelectorAll('a, button, .weui-desktop-btn, .weui-dialog__btn');
var hit = null;
for (var i = 0; i < btns.length; i++) {
  var t = (btns[i].innerText || '').trim();
  if (t === '确定' || t === '确认' || t === '是') {
    var r = btns[i].getBoundingClientRect();
    if (r.width > 0 && r.height > 0) { hit = {text: t, x: Math.round(r.x), y: Math.round(r.y), w: Math.round(r.width), h: Math.round(r.height)}; break; }
  }
}
if (hit) { hit.clicked = true; }
return JSON.stringify(hit);
"""
    r = tab.run_js(js)
    if r and json.loads(r):
        tab.run_js("""
var btns = document.querySelectorAll('a, button, .weui-desktop-btn, .weui-dialog__btn');
for (var i = 0; i < btns.length; i++) {
  var t = (btns[i].innerText || '').trim();
  if (t === '确定' || t === '确认' || t === '是') {
    var r = btns[i].getBoundingClientRect();
    if (r.width > 0 && r.height > 0) { btns[i].click(); break; }
  }
}
return true;
""")
        time.sleep(2)
    return r


def main():
    page = attach_or_launch()
    tab = page.latest_tab

    # 1) 全新导航（非 reload）：让注销横幅重新渲染
    tab.get(INDEX)
    time.sleep(4)
    cands = find_cancel(tab)
    out("ACT3_scan", n=len(cands), shot=shot(tab, "act3_scan"))

    # 2) 挑可见且最小的目标（w>0 且 h>0；text 恰为 取消注销 的链接最优先）
    target = None
    for c in cands:
        if c.get("w", 0) > 0 and c.get("h", 0) > 0:
            if c.get("text", "").replace("|", "").strip() == "取消注销":
                target = c
                break
    if target is None:
        for c in cands:
            if c.get("w", 0) > 0 and c.get("h", 0) > 0 and "取消注销" in c.get("text", ""):
                target = c
                break
    if target is None:
        out("NEED_USER", note="act3_no_visible_cancel", cands=cands[:8],
            shot=shot(tab, "act3_novisible"))
        print(json.dumps({"cands": cands}, ensure_ascii=True))
        return 1

    # 3) 物理坐标点击目标中心
    cx = target["x"] + target["w"] // 2
    cy = target["y"] + target["h"] // 2
    tab.actions.move_to(cx, cy).click().perform()
    time.sleep(3)
    out("ACT3_clicked", target=target, xy=[cx, cy], shot=shot(tab, "act3_after_click"))

    # 4) 确认弹窗（若有）
    conf = click_confirm(tab)
    out("ACT3_confirm", conf=conf, shot=shot(tab, "act3_confirm"))

    # 5) 再来一轮确认（防止双弹窗）
    conf2 = click_confirm(tab)
    if conf2 and json.loads(conf2 or "null"):
        out("ACT3_confirm2", conf=conf2, shot=shot(tab, "act3_confirm2"))

    # 6) 验证：全新导航重开首页，看渲染层是否还有注销字样
    tab.get(INDEX)
    time.sleep(4)
    verify = tab.run_js("""
var t = document.body.innerText || '';
return JSON.stringify({cancel_flow: t.indexOf('自主注销') >= 0, freeze: t.indexOf('冻结') >= 0,
  pause: t.indexOf('暂停服务') >= 0, cancel_link: t.indexOf('取消注销') >= 0});
""")
    v = json.loads(verify or "{}")
    gone = not (v.get("cancel_flow") or v.get("freeze") or v.get("pause") or v.get("cancel_link"))
    out("RESTORED" if gone else "ACT3_STILL_PRESENT", verify=v,
        url=(tab.url or "")[:140], shot=shot(tab, "act3_verify"))
    return 0


if __name__ == "__main__":
    sys.exit(main())
