# -*- coding: utf-8 -*-
"""wizard_stage1_v120_tech.py — 总包科技 1.2.0 提审 stage1:
块锚定点提交审核 → 须知勾选下一步 → 安全测试继续提交 → (可能)问卷 → 主表单 dump 不提交。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

TARGET = "1.2.0"


def js(tab, code):
    return tab.run_js("return (function(){\n" + code + "\n})()")


page = attach_or_launch()
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

# ---- 1) 1.2.0 块内的「提交审核」主按钮（btn_primary，非下拉项）
r1 = js(tab, r"""
  var blocks = document.querySelectorAll('.code_version_log');
  var target = null;
  for (var i = 0; i < blocks.length; i++) {
    var t = blocks[i].textContent;
    if (t.indexOf('""" + TARGET + r"""') >= 0) { target = blocks[i]; break; }
  }
  if (!target) return JSON.stringify({step: 'find_block', ok: false});
  var btn = target.querySelector('button.weui-desktop-btn_primary');
  if (!btn) return JSON.stringify({step: 'find_submit_btn', ok: false});
  if ((btn.innerText || '').indexOf('提交审核') < 0) return JSON.stringify({step: 'btn_text', got: btn.innerText});
  btn.scrollIntoView({block: 'center'});
  btn.click();
  return JSON.stringify({step: 'submit_clicked'});
""")
print("s1:", r1)
time.sleep(3)
shot(tab, "wiz_s1")

# ---- 2) 须知弹窗: 勾选 checkbox → 下一步
r2 = js(tab, r"""
  var dlgs = document.querySelectorAll('.weui-desktop-dialog, [class*="dialog"]');
  var dlg = null;
  for (var i = 0; i < dlgs.length; i++) {
    if (dlgs[i].offsetParent !== null && (dlgs[i].innerText || '').indexOf('须知') >= 0) { dlg = dlgs[i]; break; }
  }
  if (!dlg) return JSON.stringify({step: 'no_notice_dialog', body_has: (document.body.innerText||'').indexOf('须知') >= 0});
  var boxes = dlg.querySelectorAll('input[type="checkbox"]');
  var checked = 0;
  for (var j = 0; j < boxes.length; j++) {
    boxes[j].click();
    time = null;
    checked++;
  }
  return JSON.stringify({step: 'notice_boxes', n: boxes.length});
""")
print("s2a:", r2)
time.sleep(1)
r2b = js(tab, r"""
  var dlgs = document.querySelectorAll('.weui-desktop-dialog, [class*="dialog"]');
  var dlg = null;
  for (var i = 0; i < dlgs.length; i++) {
    if (dlgs[i].offsetParent !== null && (dlgs[i].innerText || '').indexOf('须知') >= 0) { dlg = dlgs[i]; break; }
  }
  if (!dlg) return JSON.stringify({step: 'dlg_gone'});
  var boxes = dlg.querySelectorAll('input[type="checkbox"]');
  var okAll = true;
  for (var j = 0; j < boxes.length; j++) if (!boxes[j].checked) okAll = false;
  if (!okAll) return JSON.stringify({step: 'checkbox_not_eaten'});
  var btns = dlg.querySelectorAll('button, a');
  for (var k = 0; k < btns.length; k++) {
    var t = (btns[k].innerText || '').trim();
    if ((t === '下一步' || t === '确 定' || t === '确定') && btns[k].offsetParent !== null) {
      btns[k].click();
      return JSON.stringify({step: 'next_clicked', t: t});
    }
  }
  return JSON.stringify({step: 'no_next_btn'});
""")
print("s2b:", r2b)
time.sleep(3)
shot(tab, "wiz_s2")

# ---- 3) 安全测试提醒弹窗 → 继续提交
r3 = js(tab, r"""
  var dlgs = document.querySelectorAll('.weui-desktop-dialog, [class*="dialog"], [class*="modal"]');
  var cands = [];
  for (var i = 0; i < dlgs.length; i++) {
    if (dlgs[i].offsetParent !== null) {
      var t = (dlgs[i].innerText || '').replace(/\s+/g, ' ').slice(0, 120);
      cands.push(t);
    }
  }
  return JSON.stringify({overlays: cands});
""")
print("s3 overlays:", r3)

r3b = js(tab, r"""
  var btns = document.querySelectorAll('button, a');
  for (var k = 0; k < btns.length; k++) {
    var t = (btns[k].innerText || '').trim();
    if (t === '继续提交' && btns[k].offsetParent !== null) {
      btns[k].click();
      return JSON.stringify({step: 'continue_clicked'});
    }
  }
  return JSON.stringify({step: 'no_continue_btn'});
""")
print("s3b:", r3b)
time.sleep(4)
shot(tab, "wiz_s3")

# ---- 4) 可能的未成年人问卷：dump 题目，不代答不点击
r4 = js(tab, r"""
  var t = (document.body.innerText || '');
  var has = t.indexOf('未成年人') >= 0 || t.indexOf('未成年') >= 0;
  return JSON.stringify({has_minor_q: has});
""")
print("s4:", r4)

# ---- 5) 主表单判定：URL 或新标签页 get_class
time.sleep(2)
forms = []
for tid in page.tab_ids:
    t = page.get_tab(tid)
    u = t.url or ""
    if "get_class" in u or "wampsubmit" in u or "audit" in u.lower():
        forms.append({"tab": tid, "url": u[:140]})
print("s5 form tabs:", json.dumps(forms, ensure_ascii=False))

# dump 当前 tab 概览
r5 = js(tab, r"""
  var t = (document.body.innerText || '').replace(/\s+/g, ' ');
  return JSON.stringify({url: location.href.slice(0, 130), keys: {
    get_class: location.href.indexOf('get_class') >= 0,
    form_class: t.indexOf('类目') >= 0,
    form_desc: t.indexOf('版本描述') >= 0,
    snippet: t.slice(0, 400)}});
""")
print("s5 cur:", r5)
shot(tab, "wiz_s5")
