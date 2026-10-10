# -*- coding: utf-8 -*-
"""wizard_final_verify.py — 关成功弹窗 → 回版本管理页终验 审核版本 1.2.0。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

page = attach_or_launch()

# 1) 在 get_class 表单 tab 上关掉「已提交审核」成功弹窗
form = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "get_class" in (t.url or ""):
        form = t
        break
if form:
    r = form.run_js(r"""
return (function(){
  var body = document.body.innerText || '';
  if (body.indexOf('已提交审核') < 0) return JSON.stringify({step: 'no_dialog'});
  var btns = document.querySelectorAll('button, a');
  for (var i = 0; i < btns.length; i++) {
    var t = (btns[i].innerText || '').replace(/\s+/g, '');
    if (t === '确定' && btns[i].offsetParent !== null) {
      btns[i].click();
      return JSON.stringify({step: 'ok_clicked'});
    }
  }
  return JSON.stringify({step: 'no_ok_btn'});
})()
""")
    print("dismiss:", r)
    time.sleep(2)

# 2) 版本管理页（getcodepage）终验
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "mp.weixin.qq.com" in (t.url or "") and "getcodepage" in (t.url or ""):
        tab = t
        break
if not tab:
    print(json.dumps({"tab": False}))
    raise SystemExit(1)

tab.get(tab.url)
time.sleep(6)
html = tab.html or ""
if "wxfdb55b184756e89e" not in html and "gh_5ebe2155780f" not in html:
    print(json.dumps({"guard": "APPID_MISMATCH"}))
    raise SystemExit(1)

r2 = tab.run_js(r"""
return (function(){
  var t = (document.body.innerText || '').replace(/\s+/g, ' ');
  var blocks = document.querySelectorAll('.code_version_log');
  var audit = [];
  for (var i = 0; i < blocks.length; i++) {
    var bt = blocks[i].textContent;
    if (bt.indexOf('审核中') >= 0 || bt.indexOf('审核版本') >= 0) {
      var ver = (bt.match(/1\.\d\.\d/) || ['?'])[0];
      audit.push({ver: ver, checking: bt.indexOf('审核中') >= 0});
    }
  }
  var ci = t.indexOf('审核版本');
  return JSON.stringify({
    audit_blocks: audit,
    trial120: t.indexOf('1.2.0') >= 0,
    ctx: ci >= 0 ? t.slice(Math.max(0, ci - 60), ci + 200) : null
  });
})()
""")
print("final:", r2)
shot(tab, "wiz_final_getcodepage")
