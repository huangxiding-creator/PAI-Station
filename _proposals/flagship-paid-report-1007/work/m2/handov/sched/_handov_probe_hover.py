# -*- coding: utf-8 -*-
"""_handov_probe_hover — 悬停目标稿行, 列出行内动作按钮形态."""
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
info = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  // 找含 key 的最小元素
  var all=document.querySelectorAll('*'); var target=null;
  for (var i=0;i<all.length;i++){
    var t=(all[i].innerText||'');
    if(t.indexOf('KEYX')>=0 && (!target || all[i].innerText.length<target.innerText.length)) target=all[i];
  }
  if(!target) return 'row-not-found';
  // 向上找卡片行
  var row=target;
  for (var d=0;d<8 && row;d++){
    var btns=row.querySelectorAll('button, [role=button], a, [class*=btn], [class*=action] *, [class*=operate] *');
    var names=[];
    for (var b=0;b<btns.length;b++){
      var n=(btns[b].innerText||'').trim() || (btns[b].getAttribute('aria-label')||'') || (btns[b].className||'').toString().slice(0,30);
      if(n) names.push((vis(btns[b])?'[V]':'[H]')+n.slice(0,24));
    }
    if(names.length){
      return 'depth'+d+' rowtext='+ (row.innerText||'').replace(/\\s+/g,' ').slice(0,60) +' || '+ names.join(' , ');
    }
    row=row.parentElement;
  }
  return 'no-btns';
})()
""".replace("KEYX", key))
print(info[:600])
