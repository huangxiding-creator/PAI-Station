# -*- coding: utf-8 -*-
"""_handov_probe_publish_flow — 点 publish-op 后 dump 确认浮层结构."""
import re, sys, time
from DrissionPage import ChromiumPage, ChromiumOptions

port = int(sys.argv[1]); key = sys.argv[2]
co = ChromiumOptions(); co.set_local_port(port)
page = ChromiumPage(co)
page.get("https://mp.weixin.qq.com/")
time.sleep(2)
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN&type=77")
time.sleep(4)
# 点击目标行的 publish-op
r = page.run_js("""
return (function(){
  var all=document.querySelectorAll('*'); var target=null;
  for (var i=0;i<all.length;i++){
    var t=(all[i].innerText||'');
    if(t.indexOf('KEYX')>=0 && (!target || all[i].innerText.length<target.innerText.length)) target=all[i];
  }
  if(!target) return 'row-not-found';
  var row=target;
  for (var d=0;d<10 && row;d++){
    var ops=row.querySelectorAll('.weui-desktop-publish__op, [class*=publish__op]');
    if(ops.length){ ops[0].click(); return 'clicked'; }
    row=row.parentElement;
  }
  return 'no-op';
})()
""".replace("KEYX", key))
print("click:", r)
for tick in range(6):
    time.sleep(2)
    dump = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var hits=[];
  var sels=['.weui-desktop-dialog','[class*=modal]','[class*=dialog]','[class*=popover]','[class*=overlay]','[class*=publish]','.weui-desktop-popover'];
  sels.forEach(function(s){
    try{
      document.querySelectorAll(s).forEach(function(el){
        if(!vis(el)) return;
        var txt=(el.innerText||'').replace(/\\s+/g,' ').slice(0,120);
        var btns=[]; el.querySelectorAll('*').forEach(function(x){
          var t=(x.innerText||'').trim();
          if(t && t.length<12 && ['发表','继续发表','取消','确定','确认','群发'].indexOf(t)>=0) btns.push(t);
        });
        if(txt) hits.push(s+' :: '+txt+' || '+btns.join(','));
      });
    }catch(e){}
  });
  return hits.slice(0,8).join('\\n');
})()
""")
    print(f"--- {tick*2+2}s ---")
    print(dump[:900] if dump else "(无浮层)")
    if "继续发表" in (dump or ""):
        break
