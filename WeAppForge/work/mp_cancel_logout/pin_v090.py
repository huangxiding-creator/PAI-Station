# -*- coding: utf-8 -*-
"""pin_v090.py — 体验版钉位 0.7.6→0.9.0（§6 安全配方：0.9.0 文本锚定块内选按钮）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "wacodepage/getcodepage" in (t.url or ""):
        tab = t
        break
assert tab

FIND_BTN = """
function findBtn(doc, depth, word) {
  if (!doc || depth > 3) return null;
  var els = null;
  try { els = doc.querySelectorAll('span, a, button, div'); } catch (e) { return null; }
  var hit = null;
  for (var i = 0; i < els.length; i++) {
    var el = els[i];
    var own = '';
    try {
      for (var k = 0; k < el.childNodes.length; k++) {
        var n = el.childNodes[k];
        if (n.nodeType === 3) own += n.textContent;
      }
    } catch (e) {}
    if (own.trim() === word) {
      var real = el.closest('button') || el.closest('a');
      if (real) hit = real;
    }
  }
  return hit;
}
"""

# 1) 锚定 0.9.0 开发块（含「选为体验版本」的那块，非审核块）
r = tab.run_js(FIND_BTN + """
var blk = null;
var logs = document.querySelectorAll('.code_version_log');
for (var i = 0; i < logs.length; i++) {
  var t = logs[i].textContent;
  if (t.indexOf('0.9.0') >= 0 && t.indexOf('选为体验版') >= 0 && t.indexOf('ci机器人15') >= 0) { blk = logs[i]; break; }
}
if (!blk) return JSON.stringify({found: false, step: 'block'});
var btn = findBtn(blk, 1, '选为体验版本') || findBtn(blk, 1, '选为体验版');
if (!btn) return JSON.stringify({found: false, step: 'btn'});
btn.click();
return JSON.stringify({found: true, clicked: true});
""")
print("click:", r)
time.sleep(4)
shot(tab, "pin_v090_dialog")

# 2) 处理确认弹窗（如有「确定/确认」）
tab.run_js(FIND_BTN + """
var dlg = null;
var cands = document.querySelectorAll('[class*=dialog], [class*=modal], .weui-dialog');
for (var i = 0; i < cands.length; i++) {
  var el = cands[i];
  if (el.offsetParent === null) continue;
  var t = el.innerText || '';
  if (t.indexOf('体验版') >= 0 && (t.indexOf('确定') >= 0 || t.indexOf('确认') >= 0)) { dlg = el; break; }
}
if (!dlg) return JSON.stringify({confirm: false});
var b = findBtn(dlg, 1, '确定') || findBtn(dlg, 1, '确认');
if (!b) return JSON.stringify({confirm: false, btn: false});
b.click();
return JSON.stringify({confirm: true, clicked: true});
""")
time.sleep(5)
shot(tab, "pin_v090_after")

# 3) 回读验证：0.9.0 块出现体验版标记
r2 = tab.run_js("""
var logs = document.querySelectorAll('.code_version_log');
var out = [];
for (var i = 0; i < logs.length; i++) {
  var t = logs[i].textContent.replace(/\\s+/g, ' ');
  if (t.indexOf('0.9.0') >= 0 || t.indexOf('0.7.6') >= 0) {
    out.push({v: (t.match(/版本号 ?([0-9.]+)/) || [])[1],
              pinned: t.indexOf('体验版扫描访问体验版') >= 0 || t.indexOf('取消体验') >= 0,
              cut: t.slice(0, 100)});
  }
}
return JSON.stringify(out);
""")
print(json.dumps(json.loads(r2), ensure_ascii=False, indent=1))
