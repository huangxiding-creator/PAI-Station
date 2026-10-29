# -*- coding: utf-8 -*-
"""切换到有总包AI顾问的账号 + 提审 v1.1.0"""
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = ""
u = page.url or ""
m = re.search(r"token=(\d+)", u)
tok = m.group(1) if m else ""
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
if not tok: print("NOT_LOGGED_IN"); sys.exit(1)
print(f"[1] token={tok}")

# 检查当前是哪个小程序——看页面标题
gt = page
title = gt.run_js("return document.title || ''")
print(f"[2] 页面标题: {title}")

# 直跳版本管理看版本
gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(8)
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or ""):
        gt = t; break
rows = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,100));
  return JSON.stringify(out.slice(0,3));
})()
""")
print(f"[3] versions: {rows[:400] if rows else 'EMPTY'}")

if rows and rows != '[]':
    # 有版本 → 直接提审
    print("[4] 有版本！直接找 1.1.0 提审")
else:
    # 没版本 → 可能当前账号不对，尝试切换
    print("[4] 版本空！尝试切换账号...")
    gt.run_js("location.href='https://mp.weixin.qq.com/'")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else tok
    # 找"切换账号"按钮
    r = gt.run_js("""
return (function(){
  var els=document.querySelectorAll('div[title="切换账号"], [class*=switch-account], [class*=switch_account]');
  if(els.length){els[0].click();return 'clicked';}
  return 'not-found';
})()
""")
    print(f"[5] 切换账号: {r}")
    time.sleep(3)
    # 列出可选账号
    accounts = gt.run_js("""
return (function(){
  var items=document.querySelectorAll('.account_item,[class*=account-item],[class*=account_item]');
  var out=[];
  for(var i=0;i<items.length;i++){
    var t=(items[i].innerText||'').replace(/\\s+/g,' ');
    if(t)t=t.slice(0,80);
    if(t)out.push(t);
  }
  return JSON.stringify(out.slice(0,5));
})()
""")
    print(f"[6] 可选账号: {accounts[:400] if accounts else 'EMPTY'}")
    # 点含"总包"的账号（排除"当前登录"）
    picked = gt.run_js("""
return (function(){
  function vis(el){var e=el;while(e&&e!==document.body){var st=getComputedStyle(e);if(st.display==='none'||st.visibility==='hidden')return false;e=e.parentElement;}return !!(el.offsetParent);}
  var items=document.querySelectorAll('.account_item,[class*=account-item],[class*=account_item]');
  for(var i=0;i<items.length;i++){
    var t=(items[i].innerText||'').replace(/\\s+/g,' ');
    if(t.indexOf('总包')>=0&&t.indexOf('当前登录')<0&&vis(items[i])){
      items[i].click();return 'switched:'+t.slice(0,40);
    }
  }
  return 'not-found';
})()
""")
    print(f"[7] 切换: {picked}")
    time.sleep(10)
    # 重取 token
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        u2 = t.url or ""
        m2 = re.search(r"token=(\d+)", u2)
        if m2:
            tok = m2.group(1)
            gt = t
            break
    print(f"[8] 新token={tok}")
    # 重新跳版本管理
    gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
    time.sleep(8)
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "getcodepage" in (t.url or ""):
            gt = t; break
    rows = gt.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,150));
  return JSON.stringify(out.slice(0,5));
})()
""")
    print(f"[9] versions after switch: {rows[:500] if rows else 'EMPTY'}")

# 如果有版本了，找 1.1.0 提审
if rows and '1.1.0' in (rows or ''):
    print("[10] 找到 1.1.0！开始提审流程...")
    r = gt.run_js("return (function(){var els=document.querySelectorAll('*');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='1.1.0'){var row=els[i];for(var d=0;d<10&&row;d++){if((row.innerText||'').indexOf('提交审核')>=0){var btn=row.querySelector('button.weui-desktop-btn_primary,.weui-desktop-btn_primary');if(btn){btn.click();return 'clicked';}}row=row.parentElement;}}}return 'not-found';})()")
    print(f"[11] 1.1.0 row: {r}")
    if r == 'clicked':
        print("[12] 提审对话框处理中...")
        # 对话框舞步（同前）
        for tick in range(300):
            time.sleep(1)
            ft = None
            for tid in page.browser.tab_ids:
                t = page.browser.get_tab(tid)
                if "get_class" in (t.url or ""):
                    ft = t; break
            if ft and tick > 5:
                v = ft.run_js("return (function(){var ta=document.querySelector('textarea');return ta?'form-open':'';})()")
                if v:
                    print(f"[13] FORM @{tick}s")
                    # 填 desc
                    DESC = "知识库工厂v2：文件驱动引擎上线——从真实法规标准中提炼知识库蓝图，超越层架构。"
                    dj = json.dumps(DESC, ensure_ascii=False)
                    ft.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
                    # 提交
                    r2 = ft.run_js("return (function(){var els=document.querySelectorAll('a.btn_primary,a.btn,button');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='提交审核'){els[i].click();return 'submitted';}}return 'not-found';})()")
                    print(f"[14] submit: {r2}")
                    for tk in range(30):
                        time.sleep(1)
                        c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                        if c: print(f"[15] {tk}s {c}"); break
                    time.sleep(6)
                    gt2 = None
                    for tid in page.browser.tab_ids:
                        t = page.browser.get_tab(tid)
                        if "getcodepage" in (t.url or ""):
                            gt2 = t; break
                    if gt2:
                        gt2.run_js("location.reload()"); time.sleep(8)
                        truth = gt2.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,150));return JSON.stringify(o.slice(0,3));})()")
                        print(f"[16] TRUTH: {truth[:400]}")
                    break
            try:
                s = gt.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'').replace(/\\s+/g,' ');var btns=mods[i].querySelectorAll('button');var bl=[];for(var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim();if(t)bl.push(t);}if(txt)return txt.slice(0,60)+'||BTN:'+bl.join(',');}return '';})()")
            except Exception: s = ""
            if not s: continue
            head, _, btns = s.partition('||BTN:')
            if '相关须知' in head:
                gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('相关须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='下一步'){bs[b].click();return;}}}})()")
                print(f"  [{tick}s] 须知→下一步")
            elif '继续提交' in btns:
                gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()")
                print(f"  [{tick}s] 继续提交")
else:
    print("[!] 版本列表仍无 1.1.0——需要人工确认账号")
