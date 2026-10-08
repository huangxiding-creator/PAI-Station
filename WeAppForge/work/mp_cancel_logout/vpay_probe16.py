# -*- coding: utf-8 -*-
"""vpay_probe16.py — 裸CDP喂文件：Runtime.evaluate递归找input→DOM.requestNode→setFileInputFiles→change派发→提交。"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

ICON = r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_goods_icon.png"
SECRET = Path(r"E:\AI-Station\data\secrets\virtual_pay.secret")
PRODUCT_ID = "unlock_once"

CLICK_WORD = """
function findItem(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('a,span,div,li,p,button,label'); } catch (e) { return null; }
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

FIND_INPUT = """
(function(){
  function find(doc, depth){
    if (!doc || depth > 5) return null;
    try { var f = doc.querySelector('input[type=file]'); if (f) return f; } catch (e) {}
    try {
      var frs = doc.querySelectorAll('iframe');
      for (var i = 0; i < frs.length; i++) { var r = find(frs[i].contentDocument, depth + 1); if (r) return r; }
    } catch (e) {}
    return null;
  }
  return find(document, 0);
})()
"""

DISPATCH_CHANGE = """
(function(){
  function find(doc, depth){
    if (!doc || depth > 5) return null;
    try { var f = doc.querySelector('input[type=file]'); if (f) return f; } catch (e) {}
    try {
      var frs = doc.querySelectorAll('iframe');
      for (var i = 0; i < frs.length; i++) { var r = find(frs[i].contentDocument, depth + 1); if (r) return r; }
    } catch (e) {}
    return null;
  }
  var inp = find(document, 0);
  if (!inp) return JSON.stringify({found: false});
  inp.setAttribute('data-vpay', 'goodsfile');
  var has = (inp.files && inp.files.length) || 0;
  inp.dispatchEvent(new Event('input', {bubbles: true}));
  inp.dispatchEvent(new Event('change', {bubbles: true}));
  return JSON.stringify({found: true, files: has, name: (inp.files[0] && inp.files[0].name) || ''});
})()
"""

DUMP = """
function walk(doc, parts, depth) {
  if (!doc || depth > 4) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) parts.push({d: depth, txt: txt.slice(0, 3000)});
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


def click(tab, word):
    return tab.run_js(CLICK_WORD.replace("WORD", f"'{word}'"))


def cdp_upload(tab):
    out = {}
    r = tab.run_cdp("Runtime.evaluate", expression=FIND_INPUT)
    res = (r or {}).get("result") or {}
    oid = res.get("objectId")
    out["cls"] = res.get("className", "")
    if not oid:
        out["err"] = "no objectId"
        return out
    rn = tab.run_cdp("DOM.requestNode", objectId=oid)
    node_id = (rn or {}).get("nodeId")
    out["nodeId"] = node_id
    if not node_id:
        out["err"] = "no nodeId"
        return out
    tab.run_cdp("DOM.setFileInputFiles", files=[ICON], nodeId=node_id)
    out["set_ok"] = True
    return out


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    cur = (tab.url or "")
    if "skit" not in cur:
        root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
        tab.get(root)
        time.sleep(10)
        click(tab, "基本配置")
        time.sleep(6)
        click(tab, "道具配置")
        time.sleep(5)
        click(tab, "添加道具")
        time.sleep(4)
        nav = "re-navigated"
    else:
        nav = "dialog-assumed-open"
    res = {"token": token, "nav": nav}
    res["fill"] = json.loads(tab.run_js(FILL) or "{}")
    time.sleep(1)
    click(tab, "普通道具")
    time.sleep(1)
    click(tab, "自定义")
    time.sleep(1)
    print("== stage: cdp upload ==", file=sys.stderr, flush=True)
    res["cdp"] = cdp_upload(tab)
    time.sleep(1)
    res["change"] = tab.run_js(DISPATCH_CHANGE)
    time.sleep(3)
    res["shot_pre"] = shot(tab, "vpay_goods_ready6")
    print("== stage: submit ==", file=sys.stderr, flush=True)
    res["submit"] = click(tab, "提交审核")
    time.sleep(8)
    res["docs_after"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot_post"] = shot(tab, "vpay_goods_submitted6")
    joined = "\n".join(p.get("txt", "") for p in res["docs_after"])
    res["row_seen"] = PRODUCT_ID in joined
    if "我知道了" in joined and PRODUCT_ID not in joined:
        click(tab, "我知道了")
        time.sleep(3)
        parts2 = json.loads(tab.run_js(DUMP) or "[]")
        joined2 = "\n".join(p.get("txt", "") for p in parts2)
        res["row_seen2"] = PRODUCT_ID in joined2
        joined = joined2
    if PRODUCT_ID in joined:
        cur_txt = SECRET.read_text(encoding="utf-8")
        pattern = re.compile(r"^product_id=.*$", re.M)
        if pattern.search(cur_txt):
            cur_txt = pattern.sub(f"product_id={PRODUCT_ID}", cur_txt)
        else:
            cur_txt += f"\nproduct_id={PRODUCT_ID}"
        SECRET.write_text(cur_txt.rstrip() + "\n", encoding="utf-8")
        res["secret_written"] = True
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
