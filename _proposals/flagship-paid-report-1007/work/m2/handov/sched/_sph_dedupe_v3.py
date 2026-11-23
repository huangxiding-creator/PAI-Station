# -*- coding: utf-8 -*-
"""_sph_dedupe_v3 — 视频号删重复 (真鼠标坐标法): JS取删除钮rect → CDP真鼠标点击 →
shadow穿透点确认. 用户令「删重复」. 用法: py -X utf8 _sph_dedupe_v3.py
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium  # noqa: E402

KEYS = [
    ("EPC工程税务实务与跨境税务实战研究报告》上架", "主卡v3"),
    ("税率差利益归谁看合同怎么写", "税率卡v2"),
]

JS_HOVER = """
return (function(){
  var key=%(k)s;
  var hosts=[]; var els=document.querySelectorAll('*');
  for(var i=0;i<els.length;i++){var e=els[i],d=false;
    for(var j=0;j<e.childNodes.length;j++){if(e.childNodes[j].nodeType===3&&e.childNodes[j].textContent.indexOf(key)>=0){d=true;break;}}
    if(d)hosts.push(e);}
  if(!hosts.length)return 'nohost';
  var card=hosts[0];
  for(var d2=0;d2<10&&card;d2++){if(card.querySelectorAll('*').length>60)break;card=card.parentElement;}
  card.dispatchEvent(new MouseEvent('mouseover',{bubbles:true}));
  card.scrollIntoView({block:'center'});
  return 'ok';
})()
"""

JS_RECT = """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('*');
  for(var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').trim();
    if(t==='删除'&&vis(bs[i])){
      var r=bs[i].getBoundingClientRect();
      if(r.width>0&&r.height>0) return JSON.stringify({x:r.left+r.width/2,y:r.top+r.height/2});
    }
  }
  return '';
})()
"""


JS_POINTER_CLICK = """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('*');
  for(var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').trim();
    if(t==='删除'&&vis(bs[i])){
      var btn=bs[i]; var r=btn.getBoundingClientRect(); var x=r.left+r.width/2, y=r.top+r.height/2;
      try{ btn.dispatchEvent(new PointerEvent('pointerdown',{bubbles:true,cancelable:true,clientX:x,clientY:y,isPrimary:true,pointerId:1,pointerType:'mouse'})); }catch(e){}
      try{ btn.dispatchEvent(new PointerEvent('pointerup',{bubbles:true,cancelable:true,clientX:x,clientY:y,isPrimary:true,pointerId:1,pointerType:'mouse'})); }catch(e){}
      btn.dispatchEvent(new MouseEvent('mousedown',{bubbles:true,cancelable:true,clientX:x,clientY:y}));
      btn.dispatchEvent(new MouseEvent('mouseup',{bubbles:true,cancelable:true,clientX:x,clientY:y}));
      btn.dispatchEvent(new MouseEvent('click',{bubbles:true,cancelable:true,clientX:x,clientY:y}));
      return 'dispatched@'+Math.round(y);
    }
  }
  return 'novis';
})()
"""



def js_pointer_click_text(want: str):
    import json as _j
    w = _j.dumps(want, ensure_ascii=False)
    return f"""
return (function(){{
  function vis(el){{var e=el;while(e&&e!==document.body){{var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}}
  var bs=document.querySelectorAll('*');
  for(var i=0;i<bs.length;i++){{
    var t=(bs[i].innerText||'').replace(/\s+/g,'');
    if(t===@WANT@&&bs[i].getBoundingClientRect().height>0){{
      var btn=bs[i]; var r=btn.getBoundingClientRect(); var x=r.left+r.width/2, y=r.top+r.height/2;
      try{{btn.dispatchEvent(new PointerEvent('pointerdown',{{bubbles:true,cancelable:true,clientX:x,clientY:y,isPrimary:true,pointerId:1,pointerType:'mouse'}}));}}catch(e){{}}
      try{{btn.dispatchEvent(new PointerEvent('pointerup',{{bubbles:true,cancelable:true,clientX:x,clientY:y,isPrimary:true,pointerId:1,pointerType:'mouse'}}));}}catch(e){{}}
      btn.dispatchEvent(new MouseEvent('mousedown',{{bubbles:true,cancelable:true,clientX:x,clientY:y}}));
      btn.dispatchEvent(new MouseEvent('mouseup',{{bubbles:true,cancelable:true,clientX:x,clientY:y}}));
      btn.dispatchEvent(new MouseEvent('click',{{bubbles:true,cancelable:true,clientX:x,clientY:y}}));
      return 'dispatched';
    }}
  }}
  return 'novis';
}})()
""".replace('@WANT@', w)

JS_CONFIRM_SHADOW = """
return (function(){
  function deep(root, depth){
    if (depth>6) return '';
    var nodes = root.querySelectorAll ? root.querySelectorAll('*') : [];
    for (var i=0;i<nodes.length;i++){
      var n = nodes[i];
      var t = (n.innerText||'').replace(/\\s+/g,'');
      if ((t==='确认'||t==='确定'||t==='确认删除') && n.getBoundingClientRect().height>0){
        var r = n.getBoundingClientRect();
        if (r.width>0) return JSON.stringify({x:r.left+r.width/2,y:r.top+r.height/2,t:t});
      }
      if (n.shadowRoot){ var f = deep(n.shadowRoot, depth+1); if (f) return f; }
    }
    if (root.shadowRoot) return deep(root.shadowRoot, depth+1);
    return '';
  }
  return deep(document, 0);
})()
"""


def frames_of(t):
    out = [t]
    def walk(f, d=0):
        if d > 3:
            return
        try:
            for cf in f.get_frames() or []:
                out.append(cf)
                walk(cf, d + 1)
        except Exception:
            pass
    walk(t)
    return out


def main() -> int:
    import json as _j
    b = Chromium("127.0.0.1:9222")
    tab = b.new_tab("https://channels.weixin.qq.com/platform/post/list")
    time.sleep(16)
    frs = frames_of(tab)
    removed = 0
    for key, name in KEYS:
        host = None
        for fr in frs:
            try:
                if key in (fr.run_js("return document.body.innerText;") or ""):
                    host = fr
                    break
            except Exception:
                pass
        if not host:
            print(f"[skip] {name}: 帧未命中", flush=True)
            continue
        for i in range(2):
            js_h = JS_HOVER % {"k": _j.dumps(key, ensure_ascii=False)}
            h = host.run_js(js_h)
            time.sleep(1.5)
            # 完整 pointer 事件链 dispatch (1122: JS click无效=按钮绑pointer事件; 坐标法iframe系错位)
            clickr = host.run_js(JS_POINTER_CLICK)
            print(f"  [{name}#{i+1}] pointer链点击: {clickr}", flush=True)
            time.sleep(3)
            ok = False
            for tick in range(8):
                c = ""
                for fr2 in frames_of(tab):
                    try:
                        c = fr2.run_js(JS_CONFIRM_SHADOW) or ""
                    except Exception:
                        c = ""
                    if c:
                        break
                if c:
                    q = _j.loads(c)
                    print(f"    确认弹层「{q['t']}」", flush=True)
                    for fr3 in frames_of(tab):
                        try:
                            fr3.run_js(js_pointer_click_text(q['t']))
                        except Exception:
                            pass
                    time.sleep(2.5)
                    ok = True
                    break
                time.sleep(1.5)
            if ok:
                removed += 1
                print(f"    已删第{removed}条", flush=True)
            else:
                print("    未见确认弹层", flush=True)
                break
            time.sleep(3)
    time.sleep(6)
    counts = {}
    for key, name in KEYS:
        n = 0
        for fr in frames_of(tab):
            try:
                txt = fr.run_js("return document.body.innerText;") or ""
                n += txt.count(key)
            except Exception:
                pass
        counts[name] = n
    print("[verify] 描述计数:", counts, "(目标各1) | 本次删除:", removed, flush=True)
    tab.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
