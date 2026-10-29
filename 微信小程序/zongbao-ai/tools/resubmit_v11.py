# -*- coding: utf-8 -*-
# v1.1.0 提审（9338 重登录版——等扫码后继续）
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

MP_ROOT = "https://mp.weixin.qq.com/"
tok = ""
page.get(MP_ROOT)
print("[0] 等登录（会话活=直进/失效=扫码）...")
deadline = time.time() + 300
while time.time() < deadline:
    time.sleep(5)
    try: u = page.url or ""
    except Exception: continue
    m = re.search(r"token=(\d+)", u)
    if m and "scanlogin" not in u and u.rstrip("/") != MP_ROOT.rstrip("/"):
        tok = m.group(1); break
    if "已失效" in (page.html or ""): page.get(MP_ROOT)
if not tok: print("[1] TIMEOUT"); sys.exit(3)
print(f"[1] LOGGED_IN token={tok}")

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""): return t

# 直跳版本管理
gt = find_tab("mp.weixin.qq.com") or page
gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(8)
gt = find_tab("getcodepage") or gt
rows = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,150));
  return JSON.stringify(out.slice(0,5));
})()
""")
print("[2] versions:", rows[:600] if rows else "EMPTY")

# 找 1.1.0 行
r = gt.run_js("return (function(){var els=document.querySelectorAll('*');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='1.1.0'){var row=els[i];for(var d=0;d<10&&row;d++){if((row.innerText||'').indexOf('提交审核')>=0){var btn=row.querySelector('button.weui-desktop-btn_primary,.weui-desktop-btn_primary');if(btn){btn.click();return 'clicked';}}row=row.parentElement;}}}return 'not-found';})()")
print(f"[3] 1.1.0 row: {r}")

if r != 'clicked': sys.exit(5)

# 对话框舞步
stage = "dialogs"
for tick in range(300):
    time.sleep(1)
    ft = find_tab("get_class")
    if ft and tick > 5:
        v = ft.run_js("return (function(){var ta=document.querySelector('textarea');return ta?'form-open':'';})()")
        if v: print(f"[4] FORM @{tick}s"); stage = "form"; break
    try:
        s = gt.run_js("""return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'').replace(/\\s+/g,' ');var btns=mods[i].querySelectorAll('button');var bl=[];for(var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim();if(t)bl.push(t);}if(txt)return txt.slice(0,60)+'||BTN:'+bl.join(',');}return '';})()""")
    except Exception: s = ""
    if not s: continue
    head, _, btns = s.partition('||BTN:')
    if '相关须知' in head:
        gt.run_js("""(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('相关须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='下一步'){bs[b].click();return;}}}})()""")
        print(f"  [{tick}s] 须知→下一步")
    elif '继续提交' in btns:
        gt.run_js("""(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()""")
        print(f"  [{tick}s] 继续提交")

if stage != 'form': print("[5] NO-FORM"); sys.exit(6)

DESC = "知识库工厂v2：文件驱动引擎上线——一句话从真实法规标准中提炼知识库蓝图，超越层架构，付费整库交付。"
ft = find_tab("get_class")
desc_json = json.dumps(DESC, ensure_ascii=False)
js_fill = 'var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + desc_json + ';ta.dispatchEvent(new Event("input",{bubbles:true}));'
ft.run_js("return (function(){" + js_fill + "})()")
print("[6] desc filled")
r2 = ft.run_js("return (function(){var els=document.querySelectorAll('a.btn_primary,a.btn,button');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='提交审核'){els[i].click();return 'submitted';}}return 'not-found';})()")
print(f"[7] submit: {r2}")
for tick in range(30):
    time.sleep(1)
    c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
    if c: print(f"[8] {tick}s {c}"); break
time.sleep(6)
gt = find_tab("getcodepage")
gt.run_js("location.reload()"); time.sleep(8)
gt = find_tab("getcodepage")
print("[9] TRUTH:", gt.run_js("""return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,150));return JSON.stringify(o.slice(0,4));})()""")[:600])
