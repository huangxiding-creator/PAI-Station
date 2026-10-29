import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)

# Step 1: 获取 token（多 tab 搜索 + 首页兜底）
tok = ""
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    m = re.search(r"token=(\d+)", t.url or "")
    if m: tok = m.group(1); break
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(8)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    if m: tok = m.group(1)
if not tok:
    print("[1] NOT_LOGGED_IN - 请扫码")
    sys.exit(1)
print(f"[1] token={tok}")

# Step 2: 关闭多余 tab
for tid in list(page.browser.tab_ids)[1:]:
    try: page.browser.get_tab(tid).close()
    except: pass
time.sleep(1)

# Step 3: 跳版本管理
page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(12)

# Step 4: 用 DrissionPage 原生 .ele() 找提交审核按钮（非 JS）
try:
    btn = page.ele('text:提交审核')
    if btn:
        print(f"[2] 找到: {btn.text}")
        btn.click()
        print("[3] 已点击（DrissionPage 原生点击）")
    else:
        print("[2] ele 未命中，试 tag:button 过滤")
        btns = page.eles('tag:button')
        for b in btns:
            if '提交审核' in (b.text or ''):
                b.click()
                print("[3] 已点击（遍历 button）")
                break
        else:
            print("[2] 未找到提交审核按钮")
            # 截屏看看
            page.get_screenshot(path=r"E:\AI-Station\kb_rev\no_btn.png")
            sys.exit(1)
except Exception as e:
    print(f"[2] 点击异常: {e}")
    sys.exit(1)

time.sleep(5)

# Step 5: 对话框处理（插件→确认 / 须知→下一步 / 表单→提交）
for tick in range(600):
    time.sleep(1)

    # 检查新 tab（get_class = 表单页）
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if "get_class" in (t.url or ""):
            # 表单页！
            print(f"[4] FORM @{tick}s")
            time.sleep(3)
            DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
            try:
                ta = t.ele('tag:textarea')
                if ta:
                    ta.clear()
                    ta.input(DESC)
                    print("[5] DESC 已填")
            except: pass
            time.sleep(2)
            # 点提交
            try:
                sb = t.ele('text:提交审核')
                if sb:
                    sb.click()
                    print("[6] 表单提交已点击")
            except: pass
            time.sleep(3)
            # 确认
            for tk in range(60):
                time.sleep(1)
                try:
                    for tid3 in page.browser.tab_ids:
                        t3 = page.browser.get_tab(tid3)
                        if "get_class" in (t3.url or ""):
                            cb = None
                            try: cb = t3.ele('text:确定，继续提交')
                            except: pass
                            if cb:
                                cb.click()
                                print(f"[7] FINAL @{tk}s")
                                raise StopIteration
                except StopIteration: break
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
        s = page.run_js("""
return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = (mods[i].innerText || '').replace(/\\s+/g, ' ').trim();
    if (!txt || txt.length < 5) continue;
    var btns = mods[i].querySelectorAll('button');
    var bl = [];
    for (var b = 0; b < b < btns.length; b++) {
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

    # 插件确认
    if ('插件' in head or '微信同声传译' in head) and '确认' in btns:
        try:
            cb = page.ele('text:确认')
            if cb: cb.click()
            print(f"  [{tick}s] 插件→确认")
        except: pass
    # 须知
    elif '须知' in head or '同意' in head:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('须知')<0&&(mods[i].innerText||'').indexOf('同意')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'||t==='同意并下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    # 继续提交
    elif '继续提交' in btns:
        try:
            cb2 = page.ele('text:继续提交')
            if cb2: cb2.click()
            print(f"  [{tick}s] 继续提交")
        except: pass
    # 防误触删除
    elif '删除' in head and '取消' in btns:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")

print("[!] 超时（600s）")
