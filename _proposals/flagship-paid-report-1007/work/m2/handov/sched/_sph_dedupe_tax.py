# -*- coding: utf-8 -*-
"""_sph_dedupe_tax v2 — 视频号删重复卡, 全JS帧内操作 (ele定位进不了cross-origin iframe).
用法: py -X utf8 _sph_dedupe_tax.py [--dry]
"""
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import Chromium  # noqa: E402

DRY = "--dry" in sys.argv
KEYS = [
    ("EPC工程税务实务与跨境税务实战研究报告》上架", "主卡v3组"),
    ("税率差利益归谁看合同怎么写", "税率卡v2组"),
]

def js_count(key: str) -> str:
    import json as _j
    k = _j.dumps(key, ensure_ascii=False)
    return f"""
return (function(){{
  var key = {k};
  var els = document.querySelectorAll('*');
  var n = 0;
  for (var i=0;i<els.length;i++){{
    var t = els[i].childNodes;
    for (var j=0;j<t.length;j++){{
      if (t[j].nodeType===3 && t[j].textContent.indexOf(key)>=0){{ n++; break; }}
    }}
  }}
  return n;
}})()
"""


def js_hover_card(key: str) -> str:
    import json as _j
    k = _j.dumps(key, ensure_ascii=False)
    return f"""
return (function(){{
  var key = {k};
  var hosts = [];
  var els = document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){{
    var e = els[i];
    var direct = false;
    for (var j=0;j<e.childNodes.length;j++){{
      if (e.childNodes[j].nodeType===3 && e.childNodes[j].textContent.indexOf(key)>=0){{ direct=true; break; }}
    }}
    if (direct) hosts.push(e);
  }}
  if (!hosts.length) return 'no-host';
  var card = hosts[0];
  for (var d=0; d<10 && card; d++){{
    if (card.querySelectorAll('*').length > 60) break;
    card = card.parentElement;
  }}
  var ev1=new MouseEvent('mouseover',{{bubbles:true}}); var ev2=new MouseEvent('mouseenter',{{bubbles:true}});
  card.dispatchEvent(ev1); card.dispatchEvent(ev2);
  return 'hovered';
}})()
"""


def js_click_visible_del() -> str:
    return """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('*');
  for (var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').trim();
    if(t==='删除' && vis(bs[i])){
      var r=bs[i].getBoundingClientRect();
      if(r.width>0){ bs[i].click(); return 'clicked@'+Math.round(r.top); }
    }
  }
  return 'no-visible-del';
})()
"""

JS_CONFIRM = """
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var wants=['确认','确定','删除'];
  var bs=document.querySelectorAll('button, [role=button], .weui-btn, a');
  for (var w=0;w<wants.length;w++){
    for (var i=0;i<bs.length;i++){
      var t=(bs[i].innerText||'').replace(/\\s+/g,'').trim();
      if(t===wants[w] && vis(bs[i])){ bs[i].click(); return 'ok:'+wants[w]; }
    }
  }
  return '';
})()
"""


def frames_of(tab):
    out = [tab]
    def walk(fr, d=0):
        if d > 3:
            return
        try:
            for cf in fr.get_frames() or []:
                out.append(cf)
                walk(cf, d + 1)
        except Exception:
            pass
    walk(tab)
    return out


def main() -> int:
    b = Chromium("127.0.0.1:9222")
    tab = b.new_tab("https://channels.weixin.qq.com/platform/post/list")
    time.sleep(16)
    frs = frames_of(tab)
    print("帧数:", len(frs), flush=True)
    removed = 0
    for key, name in KEYS:
        host = None
        for fr in frs:
            try:
                n = int(fr.run_js(js_count(key)) or 0)
            except Exception:
                n = 0
            if n >= 3:
                host = fr
                break
        if host is None:
            print(f"[skip] {name}: 无帧含>=3条", flush=True)
            continue
        print(f"[{name}] 命中, 删最新2条", flush=True)
        for i in range(2):
            if DRY:
                print(f"  [dry] 第{i+1}条将删", flush=True)
                continue
            h = host.run_js(js_hover_card(key))
            time.sleep(1.5)
            r = host.run_js(js_click_visible_del())
            print(f"  [del{i+1}] hover={h} click={r}", flush=True)
            if r == "clicked":
                time.sleep(2.5)
                # 确认弹窗 (可能多层)
                for tick in range(6):
                    c = ""
                    for fr2 in frames_of(tab):
                        try:
                            c = fr2.run_js(JS_CONFIRM) or ""
                        except Exception:
                            c = ""
                        if c:
                            break
                    if c:
                        print(f"    [confirm] {c}", flush=True)
                        time.sleep(2)
                    else:
                        break
                removed += 1
            time.sleep(3)
    # 验证
    time.sleep(6)
    counts = {}
    for key, name in KEYS:
        for fr in frames_of(tab):
            try:
                counts[name] = counts.get(name, 0) + int(fr.run_js(js_count(key)) or 0)
            except Exception:
                pass
    print("[verify] 各组条数:", counts, "(目标各1) | 本次删除:", removed, flush=True)
    tab.close()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
