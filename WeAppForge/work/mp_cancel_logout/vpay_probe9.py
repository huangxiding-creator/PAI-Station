# -*- coding: utf-8 -*-
"""vpay_probe9.py — 打开「添加道具」表单，摸清字段结构（不提交）。"""
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

INSPECT = """
function walk(doc, out, depth) {
  if (!doc || depth > 4) return;
  try {
    var inputs = doc.querySelectorAll('input,textarea,select');
    for (var i = 0; i < inputs.length; i++) {
      var el = inputs[i];
      out.push({tag: el.tagName, type: el.type || '', name: el.name || '',
                ph: el.placeholder || '', val: (el.value || '').slice(0, 30),
                cls: (el.className || '').toString().slice(0, 40), d: depth});
    }
    var btns = doc.querySelectorAll('button,a.weui-desktop-btn,a[class*=btn],span[class*=btn]');
    for (var j = 0; j < btns.length; j++) {
      var b = btns[j];
      var t = (b.innerText || '').trim().replace(/\\s+/g, ' ');
      if (t && t.length < 20) out.push({btn: t, cls: (b.className || '').toString().slice(0, 40), d: depth});
    }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var m = 0; m < frs.length; m++) walk(frs[m].contentDocument, out, depth + 1);
  } catch (e) {}
}
var out = [];
walk(document, out, 0);
return JSON.stringify(out.slice(0, 60));
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
    time.sleep(5)
    res["form"] = json.loads(tab.run_js(INSPECT) or "[]")
    res["shot"] = shot(tab, "vpay_goods_form")
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
