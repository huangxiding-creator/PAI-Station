# -*- coding: utf-8 -*-
"""vpay_probe8.py — 揭AppKey全值：XHR监听+剪贴板双通道，值直写secret。"""
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
TOKEN_RE = re.compile(r"[A-Za-z0-9_\-]{20,64}")

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

CLICK_COPY = """
function findCopy(doc, depth) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('span,div,a,button,i'); } catch (e) { return null; }
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    var t = own.trim() || (el.getAttribute('aria-label') || '').trim();
    if (t === '\\u590d\\u5236') return {el: el, d: depth};
  }
  try {
    var frs = doc.querySelectorAll('iframe');
    for (var j = 0; j < frs.length; j++) {
      var hit = findCopy(frs[j].contentDocument, depth + 1);
      if (hit) return hit;
    }
  } catch (e) {}
  return null;
}
var hit = findCopy(document, 0);
if (!hit) return JSON.stringify({found: false});
hit.el.click();
return JSON.stringify({found: true, depth: hit.d});
"""


def grab_packets(tab, seconds=4):
    out = []
    deadline = time.time() + seconds
    while time.time() < deadline:
        try:
            p = tab.listen.wait(timeout=1.0)
        except Exception:
            break
        if not p:
            continue
        try:
            body = p.response.body
        except Exception:
            body = ""
        out.append({"url": (p.url or "")[:120],
                    "body": (body or "")[:600] if isinstance(body, str) else str(body)[:600]})
    return out


def tokens_from(texts):
    toks = set()
    for t in texts:
        for m in TOKEN_RE.findall(t or ""):
            if not m.isdigit():
                toks.add(m)
    return toks


def main():
    page = attach_or_launch()
    tab = page.latest_tab
    token = live_token(tab)
    if not token:
        print(json.dumps({"login_wall": True}, ensure_ascii=False))
        return 1
    try:
        tab.run_cdp("Browser.grantPermissions", permissions=["clipboardReadWrite", "clipboardSanitizedWrite"])
    except Exception as e:
        print(json.dumps({"cdp_perm_err": str(e)[:100]}, ensure_ascii=False))
    root = f"https://mp.weixin.qq.com/wxamp/subApp/skit?token={token}&lang=zh_CN"
    tab.get(root)
    time.sleep(10)
    res = {"token": token}
    tab.run_js(CLICK_WORD.replace("WORD", "'\\u57fa\\u672c\\u914d\\u7f6e'"))
    time.sleep(6)
    tab.run_js(CLICK_WORD.replace("WORD", "'\\u57fa\\u7840\\u914d\\u7f6e'"))
    time.sleep(5)

    found = {}
    for word, key, shotname in (
        ("查看沙箱AppKey", "sandbox_appkey", "vpay_sb_reveal"),
        ("查看现网AppKey", "prod_appkey", "vpay_pd_reveal"),
    ):
        print(f"== stage: {key} ==", file=sys.stderr, flush=True)
        try:
            tab.listen.start(True)
        except Exception as e:
            print(f"listen_start_err: {e}", file=sys.stderr, flush=True)
        print(f"== {key}: click reveal ==", file=sys.stderr, flush=True)
        r = tab.run_js(CLICK_WORD.replace("WORD", f"'{word}'"))
        time.sleep(2)
        print(f"== {key}: click copy ==", file=sys.stderr, flush=True)
        try:
            c = tab.run_js(CLICK_COPY)
        except Exception as e:
            c = f"copy_err: {str(e)[:80]}"
        time.sleep(2)
        print(f"== {key}: grab packets ==", file=sys.stderr, flush=True)
        try:
            pk = grab_packets(tab)
        except Exception as e:
            pk = [{"err": str(e)[:100]}]
        tab.run_js("navigator.clipboard.readText().then(function(t){window.__clip=t;}).catch(function(e){window.__clip='ERR:'+String(e).slice(0,60);}); return 'launched';")
        time.sleep(1.5)
        clip = tab.run_js("return window.__clip || '';")
        tab.listen.stop()
        res[f"{key}_click"] = r
        res[f"{key}_copy"] = c
        res[f"{key}_clip_len"] = len(clip) if isinstance(clip, str) else -1
        res[f"{key}_pk_n"] = len(pk)
        res[f"shot_{key}"] = shot(tab, shotname)
        cands = tokens_from([clip if isinstance(clip, str) else ""] + [p.get("body", "") for p in pk])
        cands = {t for t in cands if len(t) >= 20}
        if cands:
            found[key] = sorted(cands, key=len, reverse=True)[0]
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
