import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_argument("--window-size=1200,900")
page = ChromiumPage(addr_or_opts=opts)

# 跳版本管理
tok = "1230337651"
page.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN")
time.sleep(12)
print(f"[1] URL: {page.url[:60]}")

# 找所有按钮
btns = page.eles('tag:button')
print(f"[2] 找到 {len(btns)} 个按钮")
for i, b in enumerate(btns):
    t = (b.text or '').strip()
    if t:
        try:
            rect = b.rect
            visible = rect and rect.get('width', 0) > 0
        except:
            visible = False
        if '提交' in t or '审核' in t:
            print(f"  btn[{i}]: '{t[:30]}' visible={visible}")

# 找可见的提交审核按钮
target = None
for b in btns:
    t = (b.text or '').strip()
    if t == '提交审核':
        try:
            rect = b.rect
            if rect and rect.get('width', 0) > 0:
                target = b
                break
        except:
            pass

if target:
    print(f"[3] 找到可见按钮: {target.text}")
    target.click()
    print("[4] 已点击")
else:
    # 降级：用 JS 点击可见按钮
    r = page.run_js("""
    return (function(){
      var btns = document.querySelectorAll('button');
      for (var i = 0; i < btns.length; i++) {
        var t = (btns[i].innerText || '').trim();
        var rect = btns[i].getBoundingClientRect();
        if (t === '提交审核' && rect.width > 0 && rect.height > 0) {
          // 模拟真实鼠标事件
          var ev = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
          btns[i].dispatchEvent(ev);
          return 'CLICKED: rect=' + rect.width + 'x' + rect.height;
        }
      }
      return 'NOT_FOUND';
    })()
    """)
    print(f"[3] JS点击: {r}")
    if 'NOT_FOUND' in r: sys.exit(1)

# 后续对话框
time.sleep(5)
for tick in range(600):
    time.sleep(1)
    # 检查 get_class tab
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "get_class" in (t.url or ""):
            print(f"[5] FORM @{tick}s")
            time.sleep(3)
            DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
            try:
                ta = t.ele('tag:textarea')
                if ta:
                    ta.clear()
                    ta.input(DESC)
            except: pass
            time.sleep(2)
            try:
                sb = t.ele('tag:button', text='提交审核')
                if sb: sb.click()
                print("[6] 表单提交")
            except:
                t.run_js("(function(){var els=document.querySelectorAll('button,a.btn_primary');for(var i=0;i<els.length;i++){var t=(els[i].innerText||'').trim();if(t==='提交审核'){els[i].click();return;}}})()")
                print("[6] JS表单提交")
            time.sleep(3)
            # 确认
            for tk in range(60):
                time.sleep(1)
                c = ""
                for tid3 in page.browser.tab_ids:
                    t3 = page.browser.get_tab(tid3)
                    if "get_class" in (t3.url or ""):
                        c = t3.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                        if c: break
                if c:
                    print(f"[7] {tk}s {c}")
                    break
            time.sleep(10)
            # TRUTH
            for tid4 in page.browser.tab_ids:
                t4 = page.browser.get_tab(tid4)
                if "getcodepage" in (t4.url or ""):
                    t4.run_js("location.reload()")
                    time.sleep(8)
                    truth = t4.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));return JSON.stringify(o.slice(0,4));})()")
                    print(f"[8] TRUTH: {truth[:500]}")
                    break
            sys.exit(0)

    # 当前页对话框
    try:
        s = page.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').trim();if(!txt||txt.length<5)continue;var btns=mods[i].querySelectorAll('button');var bl=[];for(var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim();if(t)bl.push(t);}if(bl.length)return txt.slice(0,80)+'||'+bl.join(',');}return '';})()")
    except: s = ""
    if not s: continue
    head, _, btns_str = s.partition('||')
    if '插件' in head and '确认' in btns_str:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确认'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 插件→确认")
    elif '须知' in head:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    elif '继续提交' in btns_str:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 继续提交")
    elif '删除' in head and '取消' in btns_str:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")

print("[!] 超时")
