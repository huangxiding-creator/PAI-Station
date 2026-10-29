# -*- coding: utf-8 -*-
# zongbao-ai v1.0.0 (知识库工厂KB-FACTORY) 控制台自动提审
# 方法复刻自 WeAppForge/work/mp_cancel_logout/_new_browser_9338_submit.py（项目既有先例）
# 流程: 9338+mp_qr_profile2 → 登录(会话活则直进/否则QR) → 版本管理 → 1.0.0行提审 → 须知/插件/继续提交 → 表单(desc) → 终审 → 落账验证
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

PORT = 9338
PROFILE = r"E:\AI-Station\data\state\mp_qr_profile2"
MP_ROOT = "https://mp.weixin.qq.com/"
VER = "1.0.0"
VER_MARK = "知识库工厂"
DESC = ("知识库工厂新功能：输入一句话即可免费生成专业知识库目录蓝图与文件清单，"
        "可付费获取整理好的资料包（微信虚拟支付，iOS按规范隐藏付费入口）。"
        "已有功能：工程行业知识问答与研究报告查阅。")
VIS = """
function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
"""

opts = ChromiumOptions()
opts.set_local_port(PORT)
opts.set_user_data_path(PROFILE)
opts.set_argument("--window-size=1100,860")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)
page.get(MP_ROOT)
print("[0] browser up @9338（会话活=直进；已失效=弹出二维码请扫码）", flush=True)

tok = ""
deadline = time.time() + 600
while time.time() < deadline:
    time.sleep(5)
    try:
        u = page.url or ""
    except Exception:
        continue
    m = re.search(r"token=(\d+)", u)
    if m and "scanlogin" not in u and u.rstrip("/") != MP_ROOT.rstrip("/"):
        tok = m.group(1)
        break
    if "已失效" in (page.html or ""):
        page.get(MP_ROOT)
if not tok:
    print("[1] LOGIN_TIMEOUT"); sys.exit(3)
print("[1] LOGGED_IN token=" + tok, flush=True)

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""):
            return t

gt = find_tab("mp.weixin.qq.com") or page
gt.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=%s&lang=zh_CN'" % tok)
time.sleep(8)
gt = find_tab("getcodepage") or gt
rows = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,120));
  return JSON.stringify(out.slice(0,4));
})()
""")
print("[2] versions:", rows[:600], flush=True)
if VER_MARK not in (rows or ""):
    print("[2!] 当前账号未见本版本——可能需切账号（账号含 总包AI顾问/总包科技 请在窗口手动选中后 60s 内不动，脚本自动续跑）")
    # 宽限窗：给用户在 9338 窗口手动切号的机会
    for i in range(12):
        time.sleep(5)
        gt = find_tab("getcodepage") or gt
        rows = gt.run_js(r"""
return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\s+/g,' ').slice(0,120));return JSON.stringify(o.slice(0,4));})()
""") or ""
        if VER_MARK in rows:
            print("[2+] 切号后续跑 OK", flush=True)
            break
    if VER_MARK not in (rows or ""):
        print("[2X] 版本仍未找到，退出（请人工核认上传归属账号）"); sys.exit(4)

# 版本行 → 提交审核按钮
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='%VER%'){
      var row=els[i];
      for (var d=0;d<10 && row;d++){
        var it=(row.innerText||'');
        if (it.indexOf('提交审核')>=0 && it.indexOf('%MARK%')>=0){
          var btn=row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn && vis(btn)){btn.click(); return 'row-clicked';}
        }
        row=row.parentElement;
      }
    }
  }
  return 'no-btn';
})()
""".replace("%VER%", VER).replace("%MARK%", VER_MARK))
print("[3] row:", r, flush=True)
if r != "row-clicked":
    sys.exit(5)

stage = "dialogs"
for tick in range(300):
    time.sleep(1)
    ft = find_tab("get_class")
    if ft and tick > 5:
        v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea'); return ta && vis(ta) ? 'form-open' : '';})()
""")
        if v:
            print("[4] FORM @%ds" % tick, flush=True); stage = "form"; break
    try:
        s = gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i])) continue;
    var txt=(mods[i].innerText||'').replace(/\s+/g,' ');
    var btns=mods[i].querySelectorAll('button'); var bl=[];
    for (var b=0;b<btns.length;b++){if(vis(btns[b])){var t=(btns[b].innerText||'').trim(); if(t) bl.push(t);}}
    if (txt) return txt.slice(0,60)+'||BTN:'+bl.join(',');
  }
  return '';
})()
""")
    except Exception:
        s = ""
    if not s:
        continue
    head, _, btns = s.partition('||BTN:')
    if '相关须知' in head:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){
    if (!vis(mods[i]) || (mods[i].innerText||'').indexOf('相关须知')<0) continue;
    var cb=mods[i].querySelector('input[type=checkbox]'); if (cb && !cb.checked) cb.click();
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='下一步' && vis(bs[b])){bs[b].click(); return 1;} }
  }
  return 0;})()
""")
        print("  [%ds] 须知→下一步" % tick, flush=True)
    elif '插件' in head and '确认' in btns:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='确认' && vis(bs[b])){bs[b].click(); return 'ok';} } }
  return 'no';})()
""")
        print("  [%ds] 插件→确认" % tick, flush=True)
    elif '继续提交' in btns:
        gt.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='继续提交' && vis(bs[b])){bs[b].click(); return 'ok';} } }
  return 'no';})()
""")
        print("  [%ds] 继续提交" % tick, flush=True)

if stage != 'form':
    print("[5] NO-FORM"); sys.exit(6)

JS_FILL = """
return (function(){
  var DESC = %s;
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var ta=document.querySelector('textarea');
  if (!ta) return 'no-textarea';
  if ((ta.value||'') !== DESC) { ta.value = DESC; ta.dispatchEvent(new Event('input',{bubbles:true})); }
  return JSON.stringify({desc:(ta.value||'').length});
})()
""" % json.dumps(DESC, ensure_ascii=False)
ft = find_tab("get_class")
print("[6] form:", ft.run_js(JS_FILL)[:100], flush=True)
r2 = ft.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){ if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submitted';} }
  return 'not-found';
})()
""")
print("[7] submit:", r2, flush=True)
for tick in range(30):
    time.sleep(1)
    c = ft.run_js("return (function(){" + VIS + """
  var mods=document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal, .dialog, .modal');
  for (var i=0;i<mods.length;i++){ if (!vis(mods[i])) continue;
    var bs=mods[i].querySelectorAll('button, a, .btn');
    for (var b=0;b<bs.length;b++){ if ((bs[b].innerText||'').trim()==='确定，继续提交' && vis(bs[b])){bs[b].click(); return 'FINAL';} } }
  return '';})()
""")
    if c:
        print("[8] %ds %s" % (tick, c), flush=True); break
time.sleep(6)
gt = find_tab("getcodepage")
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab("getcodepage")
print("[9] TRUTH:", gt.run_js("""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,120));
  return JSON.stringify(out.slice(0,4));
})()
""")[:700], flush=True)
