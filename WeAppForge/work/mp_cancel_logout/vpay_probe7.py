# -*- coding: utf-8 -*-
"""vpay_probe7.py — 揭AppKey：input值+own-text双通道+点击前后差分，值直写secret。"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

SECRET = Path(r"E:\AI-Station\data\secrets\virtual_pay.secret")
OFFER_ID = "1450664233"

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

COLLECT = """
function collect(doc, out, depth) {
  if (!doc || depth > 4) return;
  try {
    var inputs = doc.querySelectorAll('input,textarea');
    for (var i = 0; i < inputs.length; i++) {
      var v = (inputs[i].value || '').trim();
      if (v.length >= 16 && v.length <= 128 && /^[A-Za-z0-9_\\-\\+=\\/]+$/.test(v)) out.push({src: 'input', v: v});
    }
    var all = doc.querySelectorAll('*');
    for (var j = 0; j < all.length; j++) {
      var el = all[j];
      var own = '';
      try {
        for (var k = 0; k < el.childNodes.length; k++) {
          var n = el.childNodes[k];
          if (n.nodeType === 3) own += n.textContent;
        }
      } catch (e) {}
      own = own.trim();
      if (own.length >= 16 && own.length <= 128 && /^[A-Za-z0-9_\\-\\+=\\/]+$/.test(own)) out.push({src: 'text', v: own});
    }
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var m = 0; m < frs.length; m++) collect(frs[m].contentDocument, out, depth + 1);
  } catch (e) {}
}
var out = [];
collect(document, out, 0);
return JSON.stringify(out.slice(0, 40));
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
    res["c2"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u57fa\\u7840\\u914d\\u7f6e'"))
    time.sleep(5)
    base = {(t["src"], t["v"]) for t in json.loads(tab.run_js(COLLECT) or "[]")}
    res["base_n"] = len(base)
    found = {}
    for word, key, shotname in (
        ("查看沙箱AppKey", "sandbox_appkey", "vpay_sandbox_key"),
        ("查看现网AppKey", "prod_appkey", "vpay_prod_key"),
    ):
        r = tab.run_js(CLICK_WORD.replace("WORD", f"'{word}'"))
        time.sleep(3)
        now = {(t["src"], t["v"]) for t in json.loads(tab.run_js(COLLECT) or "[]")}
        new = [v for (s, v) in (now - base) if s in ("input", "text")]
        res[f"click_{key}"] = {"r": r, "new_n": len(new)}
        res[f"shot_{key}"] = shot(tab, shotname)
        # 过滤：非纯数字、长度16-128、排除明显UI词
        cands = [v for v in new if not v.isdigit() and not v.startswith("http")]
        if cands:
            found[key] = sorted(cands, key=len, reverse=True)[0]
        base |= now
    res["keys_found"] = sorted(found)
    if found:
        cur = SECRET.read_text(encoding="utf-8") if SECRET.exists() else ""

        def put(line_key, val):
            nonlocal cur
            pattern = re.compile(rf"^{line_key}=.*$", re.M)
            newline = f"{line_key}={val}"
            if pattern.search(cur):
                cur = pattern.sub(newline, cur)
            else:
                cur += "\n" + newline

        put("offer_id", OFFER_ID)
        for k, v in found.items():
            put(k, v)
        SECRET.write_text(cur.rstrip() + "\n", encoding="utf-8")
        res["secret_written"] = True
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
