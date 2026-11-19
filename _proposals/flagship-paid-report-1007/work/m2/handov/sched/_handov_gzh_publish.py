# -*- coding: utf-8 -*-
"""_handov_gzh_publish — 草稿箱指定稿一键发表 (通用参数化版, 照 mp_publish_draft 生产法).
链路: 起Chrome(profile+口) → cookie重注入 → 草稿箱同源list_ex找稿 → 行内「发表」
→ 确认弹窗(确定/确认/发表; 注意技能: 确认框须点「继续发表」精确匹配——本脚本按
可见按钮名逐轮尝试, 命中即点) → 发布记录验证 + 截图.
用法: py -X utf8 _handov_gzh_publish.py <acct01|acct05|acct07> <稿题名片段>
"""
import json
import re
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions  # noqa: E402

KB = r"E:\AI-Station\电力KB收割"
PROFILE_DIR = r"F:\We-AIPO\autopub\data\browser_profiles"
PORTS = {"acct01": 9342, "acct05": 9341, "acct07": 9343}

ACCT = sys.argv[1]
TITLE_KEY = sys.argv[2]
PORT = PORTS[ACCT]
RIDE = len(sys.argv) > 3  # 第3参=骑活会话端口
if RIDE:
    PORT = int(sys.argv[3])
CRED = Path(rf"{KB}\mp_cred_{ACCT}.json")
SHOTS = Path(KB)

opts = ChromiumOptions()
opts.set_local_port(PORT)
if not RIDE:
    opts.set_user_data_path(rf"{PROFILE_DIR}\{ACCT}")
    opts.set_argument("--start-minimized")
page = ChromiumPage(addr_or_opts=opts)

def shot(name):
    try:
        page.get_screenshot(str(SHOTS / f"handov_pub_{ACCT}_{name}.png"))
        print(f"[shot] {name}")
    except Exception as e:
        print(f"[shot] {name} 失败 {str(e)[:60]}")

# 1. 登录态
cred = json.loads(CRED.read_text(encoding="utf-8"))
page.get("https://mp.weixin.qq.com/")
time.sleep(4)
tok = ""
m = re.search(r"token=(\d+)", page.url or "")
if not m:
    try:
        page.set.cookies(cred["cookies"])
    except Exception as e:
        print("[cookie] 注入异常:", str(e)[:80])
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    m = re.search(r"token=(\d+)", page.url or "")
tok = m.group(1) if m else ""
print("[1] token:", tok or "DEAD(需重扫)", flush=True)
if not tok:
    sys.exit(3)

# 2. 草稿箱 (活会话同源拉取)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN")
time.sleep(3)
raw = page.run_js("""
return (function(){
  var xhr = new XMLHttpRequest();
  xhr.open('GET', '/cgi-bin/appmsg?action=list_ex&type=77&token=%s&lang=zh_CN', false);
  xhr.withCredentials = true;
  xhr.send();
  return xhr.responseText;
})()
""" % tok)
d = json.loads(raw or "{}")
items = ((d.get("app_msg_list")) or [])
print("[2] 草稿数:", len(items))
hit = next((it for it in items if TITLE_KEY in (it.get("title") or "")), None)
if not hit:
    for it in items[:6]:
        print("   -", (it.get("title") or "")[:40])
    print("[2X] 未找到目标稿"); sys.exit(4)
print("[2] 命中:", hit.get("title")[:44], "| appmsgid:", hit.get("appmsgid"))

# 3. 列表页行内「发表」
page.get(f"https://mp.weixin.qq.com/cgi-bin/appmsg?t=media/appmsg_list&action=list_card&token={tok}&lang=zh_CN&type=77")
r = ""
for tick in range(30):
    time.sleep(2)
    try:
        r = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    var t=(els[i].innerText||'');
    if (t.indexOf('%TITLE%')>=0 && t.length < 400){
      var row=els[i];
      for (var d=0;d<8 && row;d++){
        var bs=row.querySelectorAll('button, .weui-desktop-btn, a.weui-desktop-link, [role=button]');
        for (var b=0;b<bs.length;b++){
          var bt=(bs[b].innerText||'').trim();
          if (bt==='发表' && vis(bs[b])){ bs[b].click(); return 'row-clicked-发表'; }
        }
        row=row.parentElement;
      }
    }
  }
  var anyBtn=[]; document.querySelectorAll('button').forEach(function(b){var x=(b.innerText||'').trim(); if(x)anyBtn.push(x);});
  return 'wait:' + anyBtn.slice(0,10).join(',');
})()
""".replace("%TITLE%", TITLE_KEY))
    except Exception as e:
        r = "err:" + str(e)[:40]
    if str(r).startswith("row-clicked"):
        break
    if tick % 5 == 4:
        print(f"  [{(tick+1)*2}s] {str(r)[:70]}", flush=True)
print("[3]", r, flush=True)
if not str(r).startswith("row-clicked"):
    sys.exit(5)

# 4. 确认弹窗 (含「继续发表」精确匹配优先)
final = ""
for tick in range(40):
    time.sleep(1)
    try:
        s = page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').slice(0,80);
    var bs=mods[i].querySelectorAll('button');
    var names=[]; for (var b=0;b<bs.length;b++){ if(vis(bs[b])){var t=(bs[b].innerText||'').trim(); if(t)names.push(t);} }
    if (txt) return txt + '||' + names.join(',');
  }
  return '';
})()
""")
    except Exception:
        s = ""
    if not s:
        continue
    head, _, btns = s.partition("||")
    print(f"  [{tick}s] modal: {head[:50]} | btns: {btns}", flush=True)
    for want in ("继续发表", "发表", "确定", "确认"):
        if want in (btns or ""):
            page.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){
      var t=(bs[b].innerText||'').trim();
      if (t==='%WANT%' && vis(bs[b])){ bs[b].click(); return 'ok:'+t; }
    }
  }
  return '';
})()
""".replace("%WANT%", want))
            final = want
            time.sleep(3)
            break
    if "成功" in (s or ""):
        break
shot("confirm")

# 5. TRUTH
time.sleep(8)
page.get(f"https://mp.weixin.qq.com/cgi-bin/appappmsgpublish?sub=list&type=101_1_102_103&token={tok}&lang=zh_CN&f=json"
         if False else
         f"https://mp.weixin.qq.com/cgi-bin/appmsgpublish?sub=list&type=101_1_102_103&token={tok}&lang=zh_CN&f=json")
time.sleep(3)
body = (page.html or "")
print("[5] 发布记录含题名:", TITLE_KEY in body)
shot("done")
print("[done] last-confirm:", final)
if not RIDE:
    try:
        page.quit()
    except Exception:
        pass
