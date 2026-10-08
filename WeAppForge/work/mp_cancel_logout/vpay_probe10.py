# -*- coding: utf-8 -*-
"""vpay_probe10.py — 填「添加道具」表单（不提交）：对齐radio标签+四字段。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

CLICK_WORD = """
function findItem(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('a,span,div,li,p,button'); } catch (e) { return null; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    if (own.trim() === word) return {el: el, d: depth};
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var hit = findItem(frs[j].contentDocument, depth + 1, word);
      if (hit) return hit;
    }
  } catch (e) {}
  return null;
}
var hit = findItem(document, 0, WORD);
if (!hit) return JSON.stringify({found: false, word: WORD});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d, word: WORD});
"""

FILL = """
function fillByPh(doc, phPrefix, val, depth) {
  if (!doc || depth > 4) return false;
  var done = false;
  try {
    var inputs = doc.querySelectorAll('input[type=text],textarea');
    for (var i = 0; i < inputs.length; i++) {
      var el = inputs[i];
      if ((el.placeholder || '').indexOf(phPrefix) === 0) {
        var setter = Object.getOwnPropertyDescriptor(window.HTMLInputElement.prototype, 'value').set;
        setter.call(el, val);
        el.dispatchEvent(new Event('input', {bubbles: true}));
        el.dispatchEvent(new Event('change', {bubbles: true}));
        done = true;
      }
    }
  } catch (e) {}
  if (done) return true;
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) if (fillByPh(frs[j].contentDocument, phPrefix, val, depth + 1)) return true;
  } catch (e) {}
  return false;
}
var r1 = fillByPh(document, '\\u8bf7\\u586b\\u5199\\u9053\\u5177ID', 'unlock_once', 0);
var r2 = fillByPh(document, '\\u8bf7\\u586b\\u5199\\u9053\\u5177\\u540d\\u79f0', '\\u54a8\\u8be2\\u89e3\\u9501-\\u5355\\u6b21', 0);
var r3 = fillByPh(document, '\\u8bf7\\u586b\\u5199\\u9053\\u5177\\u4ef7\\u683c', '1', 0);
var r4 = fillByPh(document, '\\u5907\\u6ce8\\u4ec5\\u81ea\\u5df1\\u4f7f\\u7528', '\\u89e3\\u9501\\u5355\\u7bc7\\u54a8\\u8be2', 0);
return JSON.stringify({id: r1, name: r2, price: r3, remark: r4});
"""

DUMP = """
function walk(doc, parts, depth) {
  if (!doc || depth > 4) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) parts.push({d: depth, txt: txt.slice(0, 2500)});
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) walk(frs[j].contentDocument, parts, depth + 1);
  } catch (e) {}
}
var parts = [];
walk(document, parts, 0);
return JSON.stringify(parts);
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
    res = {"token": token}
    res["c1"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u57fa\\u672c\\u914d\\u7f6e'"))
    time.sleep(6)
    res["c2"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u9053\\u5177\\u914d\\u7f6e'"))
    time.sleep(5)
    res["c3"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u6dfb\\u52a0\\u9053\\u5177'"))
    time.sleep(4)
    res["fill"] = json.loads(tab.run_js(FILL) or "{}")
    time.sleep(2)
    res["docs"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot"] = shot(tab, "vpay_goods_filled")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
