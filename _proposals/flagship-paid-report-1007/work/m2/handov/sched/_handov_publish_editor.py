# -*- coding: utf-8 -*-
"""_handov_publish_editor — 骑活会话+编辑器路径发表 (技能1119实战法).
列表页目标行悬停→点「编辑」(新标签打开编辑器)→编辑器内JS点「发表」→
确认框点「继续发表」(精确匹配)→金标准(草稿消失). 只用JS click 不抢焦点.
用法: py -X utf8 _handov_publish_editor.py <port> <title_short>
"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

PORT = int(sys.argv[1])
KEY = sys.argv[2]

co = ChromiumOptions()
co.set_local_port(PORT)
page = ChromiumPage(co)

def dump_btns(tag):
    try:
        r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, [role=button], a, .weui-desktop-btn');
  var names=[];
  for (var i=0;i<bs.length && names.length<18;i++){
    var t=(bs[i].innerText||'').replace(/\\s+/g,'').trim();
    if(t && vis(bs[i])) names.push(t.slice(0,16));
  }
  return names.join(',');
})()
""")
        print(f"[{tag}] {str(r)[:200]}", flush=True)
        return str(r or "")
    except Exception as e:
        print(f"[{tag}] err {str(e)[:50]}", flush=True)
        return ""

# 0. 新开 tab 操作 (骑活会话: 不污染永动机当前工作页)
try:
    tab = page.new_tab("about:blank")
    print("新tab已开:", tab.tab_id[:12] if tab else "?", flush=True)
except Exception:
    pass
time.sleep(1)

# 1. 登录态/token (骑活会话首页)
page.get("https://mp.weixin.qq.com/")
time.sleep(3)
m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
print("token:", tok or "DEAD", flush=True)
if not tok:
    sys.exit(3)

# 2. 列表页 → 目标行真鼠标hover → 点行内「编辑」(宿主A, 新标签)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN&type=77")
time.sleep(4)
tabs_before = page.tab_ids
r = "no-attempt"
try:
    # 找标题最小元素, 向上找卡片行, hover 后点编辑
    ele = page.ele(f"text:{KEY}")
    if not ele:
        print("row-not-found", flush=True)
        sys.exit(4)
    # 悬停标题元素本身 (激活卡片 hover 态)
    try:
        ele.hover()
    except Exception:
        page.actions.move_to(ele)
    time.sleep(1.5)
    # hover 后页面全局找可见「编辑」动作 (tooltip 浮层)
    ed = None
    try:
        ed = page.ele('text:编辑', timeout=3)
    except Exception:
        ed = None
    if not ed:
        try:
            ed = page.ele('css:.weui-desktop-popover [class*=edit]', timeout=2)
        except Exception:
            ed = None
    if ed:
        ed.click()
        r = "edit-hover-clicked"
    else:
        r = "no-edit-after-hover"
except Exception as e:
    r = "err:" + str(e)[:60]
print("edit:", r, flush=True)
if not str(r).startswith("edit-"):
    dump_btns("list")
    sys.exit(4)

# 3. 等新标签 (编辑器) 并切过去
time.sleep(4)
tabs_after = page.tab_ids
new_tabs = [t for t in tabs_after if t not in tabs_before]
if new_tabs:
    page.to_tab(new_tabs[0])
    print("编辑器新标签已切", flush=True)
else:
    # 可能同页跳转
    print("无新标签, 当前URL:", (page.url or "")[:80], flush=True)
time.sleep(5)
if "appmsg_edit" not in (page.url or "") and "edit" not in (page.url or ""):
    dump_btns("editor-probe")

# 4. 编辑器内点「发表」(技能JS法: btns.find(...).click())
r = ""
for tick in range(20):
    time.sleep(2)
    try:
        r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, .weui-desktop-btn, [role=button]');
  for (var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').replace(/[\\s\\u00a0]+/g,'');
    if(t==='发表' && vis(bs[i])){ bs[i].click(); return 'publish-clicked'; }
  }
  return 'wait';
})()
""")
    except Exception as e:
        r = "err:" + str(e)[:40]
    if str(r) == "publish-clicked":
        break
print("publish:", r, flush=True)
if str(r) != "publish-clicked":
    dump_btns("editor")
    sys.exit(5)

# 5. 确认框: 「继续发表」精确匹配 (技能: 发表子串匹配点不中)
final = ""
for tick in range(30):
    time.sleep(2)
    try:
        s = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent||el.getBoundingClientRect().height>0);}
  var bs=document.querySelectorAll('button, .weui-desktop-btn, [role=button]');
  for (var i=0;i<bs.length;i++){
    var t=(bs[i].innerText||'').replace(/[\\s\\u00a0]+/g,'');
    if(t==='继续发表' && vis(bs[i])){ bs[i].click(); return 'ok:继续发表'; }
  }
  var mods=document.querySelectorAll('.weui-desktop-dialog, [class*=modal], [class*=dialog]');
  for (var i=0;i<mods.length;i++){
    if(!vis(mods[i]))continue;
    var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').slice(0,60);
    if(txt) return 'layer:'+txt;
  }
  return '';
})()
""")
    except Exception:
        s = ""
    if str(s).startswith("ok:"):
        final = s
        print(f"[{tick*2}s] {s}", flush=True)
        break
    if s:
        print(f"[{tick*2}s] {str(s)[:70]}", flush=True)
print("final:", final, flush=True)

# 6. 金标准: 回列表页, 草稿消失
ok = False
for _ in range(6):
    time.sleep(8)
    try:
        page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
        time.sleep(2)
        raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN&begin=0&count=50', false);
  xhr.withCredentials = true; xhr.send(); return xhr.responseText;
})()
""" % tok)
        items = json.loads(raw or "{}").get("app_msg_list") or []
        if not any(KEY in (it.get("title") or "") for it in items):
            ok = True
            break
    except Exception:
        pass
print("金标准(草稿消失):", "PASS" if ok else "FAIL", flush=True)
try:
    # 关编辑器tab (不动永动机其他tab)
    pass
except Exception:
    pass
