import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1100,900")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""): return t

# 获取 token
tok = ""
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    m = re.search(r"token=(\d+)", t.url or "")
    if m: tok = m.group(1); break
print(f"[1] token={tok}")

# 关闭多余 tab（只留一个）
tabs = list(page.browser.tab_ids)
for tid in tabs[1:]:
    try: page.browser.get_tab(tid).close()
    except: pass
time.sleep(2)

# 刷新版本管理页
gt = find_tab("mp.weixin.qq.com") or page
gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(12)
gt = find_tab("getcodepage") or gt

# 用 DrissionPage 原生元素点击（非 JS 注入）
btn = gt.ele('text:提交审核')
if btn:
    print(f"[2] 找到提交审核按钮: {btn.text}")
    btn.click()
    print(f"[3] 已点击")
else:
    print("[2] 未找到提交审核按钮")
    sys.exit(1)

time.sleep(5)

# 处理后续对话框
for tick in range(600):
    time.sleep(1)

    # 检查 get_class tab（表单页）
    ft = find_tab("get_class")
    if ft and tick > 5:
        v = ft.run_js("return (function(){var ta=document.querySelector('textarea');return ta?'FORM':'';})()")
        if v:
            print(f"[4] FORM @{tick}s")
            DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
            dj = json.dumps(DESC, ensure_ascii=False)
            ft.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
            time.sleep(2)
            # 点提交
            try:
                btn2 = ft.ele('text:提交审核')
                if btn2:
                    btn2.click()
                    print(f"[5] 表单提交已点击")
            except:
                pass
            time.sleep(3)
            # 确认
            for tk in range(30):
                time.sleep(1)
                try:
                    c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                except: c = ""
                if c:
                    print(f"[6] {tk}s {c}")
                    break
            time.sleep(10)
            # 验证
            for tid2 in page.browser.tab_ids:
                t2 = page.browser.get_tab(tid2)
                if "getcodepage" in (t2.url or ""):
                    t2.run_js("location.reload()")
                    time.sleep(8)
                    truth = t2.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));return JSON.stringify(o.slice(0,4));})()")
                    print(f"[7] TRUTH: {truth[:500]}")
                    break
            sys.exit(0)

    # 检查当前页对话框
    try:
        s = gt.run_js("""
return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
    if (!txt || txt.length < 5) continue;
    var btns = mods[i].querySelectorAll('button');
    var bl = [];
    for (var b = 0; b < btns.length; b++) {
      var t = (btns[b].innerText || '').trim();
      if (t) bl.push(t);
    }
    if (bl.length > 0) return txt.slice(0, 80) + '||BTN:' + bl.join(',');
  }
  return '';
})()
""")
    except: s = ""

    if not s: continue
    head, _, btns = s.partition('||BTN:')

    if ('插件' in head or '确认' in head) and '确认' in btns and '删除' not in head:
        try:
            cb = gt.ele('text:确认')
            if cb: cb.click()
        except: pass
        print(f"  [{tick}s] 插件→确认")
    elif '须知' in head:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'||t==='同意并下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    elif '继续提交' in btns:
        try:
            cb2 = gt.ele('text:继续提交')
            if cb2: cb2.click()
        except: pass
        print(f"  [{tick}s] 继续提交")
    elif '删除' in head and '取消' in btns:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")

print("[!] 超时")
