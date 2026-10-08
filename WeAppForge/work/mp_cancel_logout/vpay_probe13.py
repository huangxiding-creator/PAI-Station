# -*- coding: utf-8 -*-
"""vpay_probe13.py — JS诊断文件输入宿主iframe → 属性定位+NoneElement假值检查上传 → 提交 → 验证。"""
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

# 诊断+标记：DFS 枚举 iframe（DOM 序），找 input[type=file]，打 data-vpay 标
DIAG = """
function dfs(doc, out, depth) {
  if (!doc || depth > 4) return;
  var frs = [];
  try { frs = doc.querySelectorAll('iframe'); } catch (e) { return; }
  for (var j = 0; j < frs.length; j++) {
    var fr = frs[j];
    var rec = {idx: out.length, d: depth, src: (fr.src || '').slice(0, 90), name: fr.name || '', fid: fr.id || ''};
    try {
      var fi = fr.contentDocument.querySelectorAll('input[type=file]');
      rec.fileN = fi.length;
      if (fi.length) {
        rec.cls = (fi[0].className || '').toString().slice(0, 60);
        rec.acc = fi[0].getAttribute('accept') || '';
        fi[0].setAttribute('data-vpay', 'goodsfile');
      }
    } catch (e) { rec.err = String(e).slice(0, 60); }
    out.push(rec);
    dfs(fr.contentDocument, out, depth + 1);
  }
}
var out = [];
dfs(document, out, 0);
return JSON.stringify(out);
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
        res_nav = "re-navigated"
    else:
        res_nav = "dialog-assumed-open"
    res = {"token": token, "nav": res_nav}
    res["fill"] = json.loads(tab.run_js(FILL) or "{}")
    time.sleep(1)
    click(tab, "普通道具")
    time.sleep(1)
    click(tab, "自定义")
    time.sleep(1)
    print("== stage: diag ==", file=sys.stderr, flush=True)
    frames = json.loads(tab.run_js(DIAG) or "[]")
    res["frames"] = frames
    host_idx = [f["idx"] for f in frames if f.get("fileN")]
    res["host_idx"] = host_idx
    uploaded = False
    for idx in host_idx[:3]:
        try:
            fr = tab.get_frame(idx)
        except Exception as e:
            res.setdefault("frame_err", []).append({"idx": idx, "e": str(e)[:80]})
            continue
        for loc in ("@data-vpay=goodsfile", "x://input[@type='file']", "css:input[type='file']"):
            try:
                inp = fr.ele(loc, timeout=1.0)
            except Exception:
                continue
            if not inp:  # NoneElement 也是假值
                continue
            try:
                inp.input_files(ICON)
                res["upload"] = {"ok": True, "frame": idx, "loc": loc}
                uploaded = True
                break
            except Exception as e:
                res.setdefault("input_files_err", []).append({"idx": idx, "loc": loc, "e": str(e)[:150]})
        if uploaded:
            break
    if not uploaded:
        res["upload"] = {"ok": False}
    time.sleep(3)
    res["shot_pre"] = shot(tab, "vpay_goods_ready3")
    print("== stage: submit ==", file=sys.stderr, flush=True)
    res["submit"] = click(tab, "提交审核")
    time.sleep(8)
    res["docs_after"] = json.loads(tab.run_js(DUMP) or "[]")
    res["shot_post"] = shot(tab, "vpay_goods_submitted3")
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
