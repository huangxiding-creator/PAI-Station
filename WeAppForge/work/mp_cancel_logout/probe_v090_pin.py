# -*- coding: utf-8 -*-
"""probe_v090_pin.py — 页面不存在复发诊断：版本页全量 dump（钉位/版本块/灰度横幅/审核态）。"""
import json
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch, shot  # noqa: E402
from watch_category import live_token  # noqa: E402

page = attach_or_launch()
tab = None
for tid in page.tab_ids:
    t = page.get_tab(tid)
    u = (t.url or "") if t else ""
    if "wacodepage/getcodepage" in u:
        tab = t
        break
if tab is None:
    for tid in page.tab_ids:
        t = page.get_tab(tid)
        u = (t.url or "") if t else ""
        if "mp.weixin.qq.com" in u:
            tab = t
            break
assert tab, "no mp tab; need re-login"

tok = live_token(tab)
print("token_alive:", bool(tok))
if tok:
    tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?lang=zh_CN&token={tok}")
    time.sleep(7)
else:
    time.sleep(2)
shot(tab, "probe_v090_nav")

r = tab.run_js(r"""
return (function(){
  function clean(s){ return (s||'').replace(/\s+/g,' ').trim(); }
  var out = {url: location.href.slice(0,140), blocks: [], gray: null, audit_card: null};
  var logs = document.querySelectorAll('.code_version_log');
  for (var i=0;i<logs.length && i<25;i++){
    var t = clean(logs[i].textContent);
    var b = {i:i, ver:(t.match(/版本号 ?([0-9.]+)/)||[])[1] || null,
             robot:(t.match(/ci机器人\d+/)||[])[0] || null,
             pinned: t.indexOf('取消体验')>=0,
             has_pin_btn: t.indexOf('选为体验版')>=0,
             cut:t.slice(0,300)};
    b.audit = /审核中|已通过|未通过|审核被撤回|已撤回|等待审核/.exec(t);
    b.audit = b.audit ? b.audit[0] : null;
    out.blocks.push(b);
  }
  var all = document.querySelectorAll('div');
  for (var j=0;j<all.length;j++){
    var d=all[j], t=d.textContent||'';
    if (t.indexOf('灰度发布')>=0 && t.length<600){ out.gray = clean(t).slice(0,300); break; }
  }
  for (var k=0;k<all.length;k++){
    var d2=all[k], t2=d2.textContent||'';
    if (t2.indexOf('审核版本')>=0 && t2.length<800){ out.audit_card = clean(t2).slice(0,400); break; }
  }
  return JSON.stringify(out);
})()
""")
print(json.dumps(json.loads(r), ensure_ascii=False, indent=1))
shot(tab, "probe_v090_pin")
