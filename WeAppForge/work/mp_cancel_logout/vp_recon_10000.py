# -*- coding: utf-8 -*-
"""vp_recon_10000.py — 侦察 report_10000 行的操作按钮（只读，不点击）。

复用 vp_publish_10000.py 的进入配方（skit 根页 → 基本配置 → 道具配置），
然后跨 iframe 找含 report_10000 的表格行，枚举行内可点元素（文案+rect），
外加整页所有「编辑/发布/更多」类按钮坐标清单，为编辑动线落点做准备。
"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402
from vpay_item_create import click  # noqa: E402

PRODUCT_ID = "report_10000"

ROW_JS = """
function inRow(doc, depth) {
  if (!doc || depth > 4) return [];
  var out = [];
  try {
    var trs = doc.querySelectorAll('tr');
    for (var i = 0; i < trs.length; i++) {
      var tr = trs[i];
      if ((tr.innerText || '').indexOf('PID') < 0) continue;
      var els = tr.querySelectorAll('a,button,span[class*=link],div[class*=btn]');
      var acts = [];
      for (var j = 0; j < els.length; j++) {
        var el = els[j];
        var t = (el.innerText || '').trim();
        if (!t || t.length > 12) continue;
        var r = el.getBoundingClientRect();
        acts.push({t: t, x: Math.round(r.x + r.width / 2), y: Math.round(r.y + r.height / 2)});
      }
      out.push({depth: depth, row_txt: (tr.innerText || '').slice(0, 200).replace(/\\n/g, '|'), acts: acts,
                rect: (function () { var r = tr.getBoundingClientRect();
                  return {x1: Math.round(r.x), y1: Math.round(r.y), x2: Math.round(r.x + r.width), y2: Math.round(r.y + r.height)}; })()});
      return out;  // 命中一行即止（跨 iframe 都会各查一遍，取最深命中）
    }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var k = 0; k < frs.length; k++) {
      var sub = inRow(frs[k].contentDocument, depth + 1);
      if (sub.length) out = out.concat(sub);
    }
  } catch (e) {}
  return out;
}
return JSON.stringify(inRow(document, 0));
"""

ALLBTN_JS = """
function scan(doc, acc, depth) {
  if (!doc || depth > 4) return;
  try {
    var els = doc.querySelectorAll('a,button');
    for (var i = 0; i < els.length; i++) {
      var el = els[i];
      var t = (el.innerText || '').trim();
      if (!t || t.length > 10) continue;
      if (!/编辑|发布|上架|更多|操作|下架|保存/.test(t)) continue;
      var r = el.getBoundingClientRect();
      if (r.width === 0 || r.height === 0) continue;
      acc.push({d: depth, t: t, x: Math.round(r.x + r.width / 2), y: Math.round(r.y + r.height / 2)});
    }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) scan(frs[j].contentDocument, acc, depth + 1);
  } catch (e) {}
}
var acc = [];
scan(document, acc, 0);
return JSON.stringify(acc.slice(0, 60));
"""


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)

    res = {"token": token, "pid": PRODUCT_ID}
    res["c_base"] = click(tab, "基本配置")
    time.sleep(6)
    res["c_itemcfg"] = click(tab, "道具配置")
    time.sleep(5)

    row = tab.run_js(ROW_JS.replace("PID", PRODUCT_ID))
    res["row"] = json.loads(row) if row else []
    btns = tab.run_js(ALLBTN_JS)
    res["btns"] = json.loads(btns) if btns else []
    res["shot"] = shot(tab, "vp_recon10000")
    print(json.dumps(res, ensure_ascii=False, indent=1))
    return 0


if __name__ == "__main__":
    sys.exit(main())
