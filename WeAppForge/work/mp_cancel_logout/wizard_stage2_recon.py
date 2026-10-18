# -*- coding: utf-8 -*-
"""wizard_stage2_recon.py — get_class 主表单零点击侦查: appid校验+字段骨架 dump。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402

page = attach_or_launch()
form = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    if "get_class" in (t.url or ""):
        form = t
        break
if not form:
    print(json.dumps({"form_tab": False}))
    raise SystemExit(1)
print("form_url:", (form.url or "")[:150])

html = form.html or ""
guard = "wxfdb55b184756e89e" in html or "gh_5ebe2155780f" in html or "总包科技" in html
print("guard:", guard)

r = form.run_js(r"""
return (function(){
  var out = {textareas: [], selects: [], radios: [], inputs: [], btns: [], category: null};
  var tas = document.querySelectorAll('textarea');
  for (var i = 0; i < tas.length; i++) {
    var vis = tas[i].offsetParent !== null;
    out.textareas.push({vis: vis, ph: (tas[i].getAttribute('placeholder')||'').slice(0,60),
      len: tas[i].value.length, cls: (tas[i].className||'').slice(0,40)});
  }
  var sels = document.querySelectorAll('select');
  for (var i = 0; i < sels.length; i++) {
    var opts = [];
    for (var j = 0; j < sels[i].options.length; j++) opts.push(sels[i].options[j].text.slice(0,30));
    out.selects.push({vis: sels[i].offsetParent !== null, val: sels[i].value, opts: opts.slice(0,8)});
  }
  var rs = document.querySelectorAll('input[type="radio"]');
  for (var i = 0; i < rs.length; i++) {
    out.radios.push({name: rs[i].name, val: rs[i].value, checked: rs[i].checked,
      label: (rs[i].closest('label') ? rs[i].closest('label').innerText : '').replace(/\s+/g,' ').slice(0,60)});
  }
  var ips = document.querySelectorAll('input[type="text"], input:not([type])');
  for (var i = 0; i < ips.length; i++) {
    out.inputs.push({vis: ips[i].offsetParent !== null, ph: (ips[i].getAttribute('placeholder')||'').slice(0,50), val: (ips[i].value||'').slice(0,30)});
  }
  var as = document.querySelectorAll('a.btn, button');
  for (var i = 0; i < as.length; i++) {
    var t = (as[i].innerText || '').trim();
    if (t) out.btns.push({tag: as[i].tagName, t: t.slice(0,20), vis: as[i].offsetParent !== null, cls: (as[i].className||'').slice(0,50)});
  }
  var t = (document.body.innerText || '').replace(/\s+/g, ' ');
  var ci = t.indexOf('类目');
  out.category = ci >= 0 ? t.slice(Math.max(0,ci-40), ci+260) : null;
  out.snippet = t.slice(0, 700);
  return JSON.stringify(out);
})()
""")
print("form_dump:", r[:4200])
shot(form, "wiz_form_recon")
