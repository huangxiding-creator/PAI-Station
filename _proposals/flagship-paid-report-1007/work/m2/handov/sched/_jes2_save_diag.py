# -*- coding: utf-8 -*-
"""_jes2_save_diag — acct05 保存接口网络诊断: 打开新建图文→JS注入网络拦截→点保存→dump响应."""
import json, re, sys, time
from DrissionPage import ChromiumPage, ChromiumOptions

KB = r"E:\AI-Station\电力KB收割"
co = ChromiumOptions()
co.set_local_port(9341)
co.set_user_data_path(r"F:\We-AIPO\autopub\data\browser_profiles\acct05")
page = ChromiumPage(co)

cred = json.load(open(rf"{KB}\mp_cred_acct05.json", encoding="utf-8"))
page.get("https://mp.weixin.qq.com/")
time.sleep(2)
if not re.search(r"token=(\d+)", page.url or ""):
    page.set.cookies(cred["cookies"]); time.sleep(1)
    page.get("https://mp.weixin.qq.com/"); time.sleep(3)
page.get("https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&lang=zh_CN")
time.sleep(3)
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
if not tok:
    m2 = re.search(r"token=(\d+)", page.html or "")
    tok = m2.group(1) if m2 else ""
if not tok:
    tok = str(cred.get("token", ""))
print("token:", tok or "DEAD")
if not tok or tok == "None":
    sys.exit(3)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_edit_v2&action=edit&isNew=1&type=77&token={tok}")
time.sleep(5)
# 注入 XHR/fetch 拦截
page.run_js("""
window.__saved_resp = [];
(function(){
  var ox = XMLHttpRequest.prototype.send;
  XMLHttpRequest.prototype.send = function(){
    this.addEventListener('load', function(){
      try {
        var u = this.responseURL || '';
        if (u.indexOf('cgi-bin') >= 0 && (u.indexOf('save') >= 0 || u.indexOf('appmsg') >= 0 || u.indexOf('editor') >= 0)) {
          window.__saved_resp.push({url: u.slice(0,120), status: this.status, body: (this.responseText||'').slice(0,300)});
        }
      } catch(e) {}
    });
    return ox.apply(this, arguments);
  };
})();
return 'hooked';
""")
# 填标题 + 点保存
page.run_js('e=document.getElementById("title"); e.value="诊断测试稿-勿发"; e.dispatchEvent(new Event("input",{bubbles:true})); return "title-ok";')
time.sleep(1)
r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els=document.querySelectorAll('button, .weui-desktop-btn, [role=button], a');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'').trim();
    if(t==='保存为草稿' && vis(els[i])){ els[i].click(); return 'clicked'; }
  }
  return 'notfound';
})()
""")
print("save click:", r)
time.sleep(8)
resp = page.run_js("return JSON.stringify(window.__saved_resp || [])")
print("network responses:")
try:
    for x in json.loads(resp or "[]"):
        print(" *", x.get("status"), x.get("url"))
        print("   body:", (x.get("body") or "")[:200])
except Exception:
    print(resp[:500] if resp else "(空)")
# 清理诊断稿? 未保存成功无需清理; 若保存成功则留着人工删
