# -*- coding: utf-8 -*-
"""vpay_probe6.py — 基础配置页揭沙箱/现网AppKey，直写 virtual_pay.secret（值不进转录）。"""
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

SCAN_TXT = """
function walk(doc, parts, depth) {
  if (!doc || depth > 4) return;
  try {
    var txt = (doc.body && doc.body.innerText) || '';
    if (txt && txt.length > 30) parts.push(txt);
  } catch (e) {}
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) walk(frs[j].contentDocument, parts, depth + 1);
  } catch (e) {}
}
var parts = [];
walk(document, parts, 0);
return JSON.stringify(parts.join('\\n=====DOC=====\\n'));
"""

TOKEN_RE = re.compile(r"^[A-Za-z0-9_\-]{16,64}$")


def harvest_keys(big: str) -> dict:
    """从页面全文里定位 AppKey 值：沙箱AppKey/现网AppKey 标签后的短token。"""
    out = {}
    lines = [l.strip() for l in big.splitlines()]
    for i, l in enumerate(lines):
        if l in ("沙箱AppKey", "现网AppKey"):
            for j in range(i + 1, min(i + 4, len(lines))):
                cand = lines[j].strip()
                if cand and TOKEN_RE.match(cand) and cand not in ("查看沙箱AppKey", "查看现网AppKey"):
                    key = "sandbox_appkey" if l == "沙箱AppKey" else "prod_appkey"
                    out[key] = cand
                    break
    return out


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
    big1 = json.loads(tab.run_js(SCAN_TXT) or '""')
    res["cfg_before_len"] = len(big1)
    res["shot1"] = shot(tab, "vpay_basic_before")
    res["r1"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u67e5\\u770b\\u6c99\\u7bb1AppKey'"))
    time.sleep(4)
    res["r2"] = tab.run_js(CLICK_WORD.replace("WORD", "'\\u67e5\\u770b\\u73b0\\u7f51AppKey'"))
    time.sleep(4)
    big2 = json.loads(tab.run_js(SCAN_TXT) or '""')
    res["cfg_after_len"] = len(big2)
    res["shot2"] = shot(tab, "vpay_basic_after")
    keys = harvest_keys(big2) or harvest_keys(big1)
    res["keys_found"] = sorted(keys)
    if keys:
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
        for k, v in keys.items():
            put(k, v)
        SECRET.write_text(cur.rstrip() + "\n", encoding="utf-8")
        res["secret_written"] = True
    print(json.dumps(res, ensure_ascii=False))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
