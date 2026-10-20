# -*- coding: utf-8 -*-
# 新浏览器(9338+新profile)全链：QR登录 → 切号总包科技 → 1.4.2 提审 → 落账验证
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

PORT = 9338
PROFILE = r"E:\AI-Station\data\state\mp_qr_profile2"
MP_ROOT = "https://mp.weixin.qq.com/"
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
print("[0] browser up @9338, waiting QR scan ...", flush=True)

# 1) 等扫码登录（最长 10 分钟）
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

# 2) 切号到 总包科技
gt = page
gt.run_js('return (function(){var els=document.querySelectorAll(\'div[title="切换账号"]\'); if (els.length){ els[0].click(); return "opened";} return "no-div";})()')
picked = ""
for i in range(15):
    time.sleep(1.5)
    picked = gt.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var items=document.querySelectorAll('.account_item, [class*=account_item], [class*=account-item]');
  for (var i=0;i<items.length;i++){
    var t=(items[i].innerText||'').replace(/\s+/g,' ');
    if (t.indexOf('总包科技')>=0 && t.indexOf('当前登录')<0 && vis(items[i])){ items[i].click(); return 'tech@'+i; }
  }
  return '';
})()
""") or ""
    if picked:
        break
print("[2] switch:", picked or "FAIL", flush=True)
time.sleep(9)
gt2 = find_tab("mp.weixin.qq.com") or page
m = re.search(r"token=(\d+)", gt2.run_js("return location.href") or "")
tok = m.group(1) if m else tok
gt2.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=%s&lang=zh_CN'" % tok)
time.sleep(8)
gt = find_tab("getcodepage") or gt2
rows = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,90));
  return JSON.stringify(out.slice(0,3));
})()
""")
print("[3] versions:", rows[:500], flush=True)

# 3) 1.4.2 提交审核
DESC = '工程行业企业产品与服务展示小程序。本次更新：页面语言全面打磨，表述更凝练友好；全部分享功能完善。纯展示内容，无需登录，不采集用户信息。'
r = gt.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('*');
  for (var i=0;i<els.length;i++){
    if (ownText(els[i])==='1.4.2'){
      var row=els[i];
      for (var d=0;d<8 && row;d++){
        if ((row.innerText||'').indexOf('提交审核')>=0){
          var btn=row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn && vis(btn)){btn.click(); return 'row-clicked';}
        }
        row=row.parentElement;
      }
    }
  }
  return 'no-btn';
})()
""")
print("[4] row:", r, flush=True)

stage = "dialogs"
for tick in range(300):
    time.sleep(1)
    ft = find_tab("get_class")
    if ft and tick > 5:
        v = ft.run_js("return (function(){" + VIS + """
  var ta=document.querySelector('textarea'); return ta && vis(ta) ? 'form-open' : '';})()
""")
        if v:
            print("[5] FORM @%ds" % tick, flush=True); stage = "form"; break
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
    print("[6] NO-FORM"); sys.exit(1)

JS_FILL = """
return (function(){
  var DESC = %s;
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var ta=document.querySelector('textarea');
  if (!ta) return 'no-textarea';
  if ((ta.value||'') !== DESC) { ta.value = DESC; ta.dispatchEvent(new Event('input',{bubbles:true})); }
  var rs=document.querySelectorAll('input[type=radio]');
  function pick(w){ for (var k=0;k<rs.length;k++){ if (!vis(rs[k])) continue;
    var lbl=rs[k].closest('label')||rs[k].parentElement;
    if (((lbl.innerText)||'').indexOf(w)>=0 && !rs[k].checked){lbl.click(); return w;} } return ''; }
  pick('无需登录账号即可使用');
  return JSON.stringify({desc:(ta.value||'').length});
})()
""" % json.dumps(DESC, ensure_ascii=False)
ft = find_tab("get_class")
print("[7] form:", ft.run_js(JS_FILL)[:100], flush=True)
r2 = ft.run_js("return (function(){" + VIS + """
  function ownText(e){return Array.prototype.filter.call(e.childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}
  var els=document.querySelectorAll('a.btn_primary, a.btn, button');
  for (var i=0;i<els.length;i++){ if (ownText(els[i])==='提交审核' && vis(els[i])){els[i].click(); return 'submitted';} }
  return 'not-found';
})()
""")
print("[8] submit:", r2, flush=True)
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
        print("[9] %d s %s" % (tick, c), flush=True); break
time.sleep(6)
gt = find_tab("getcodepage")
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab("getcodepage")
print("[10] TRUTH:", gt.run_js("""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,100));
  return JSON.stringify(out.slice(0,3));
})()
""")[:600], flush=True)
