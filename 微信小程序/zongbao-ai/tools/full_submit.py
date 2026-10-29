import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1100,860")
page = ChromiumPage(addr_or-opts) if False else ChromiumPage(addr_or_opts=opts)

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
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
print(f"[1] token={tok}")

# 刷新版本管理页
gt = find_tab("mp.weixin.qq.com") or page
gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(10)
gt = find_tab("getcodepage") or gt

# 清除可能存在的对话框（先取消任何弹窗）
gt.run_js("""
(function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var btns = mods[i].querySelectorAll('button');
    for (var b = 0; b < btns.length; b++) {
      var t = (btns[b].innerText || '').trim();
      if (t === '取消' || t === '关闭') { btns[b].click(); return; }
    }
  }
})()
""")
time.sleep(3)

# 精确找 v1.3.0 的提交审核按钮（按文本匹配，非 CSS class）
r = gt.run_js("""
return (function(){
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {
    var own = '';
    try {
      own = Array.prototype.filter.call(els[i].childNodes, function(n) {
        return n.nodeType === 3;
      }).map(function(n) { return n.nodeValue.trim(); }).join(' ');
    } catch(e) {}
    if (own === '1.3.0') {
      var row = els[i];
      for (var d = 0; d < 12 && row; d++) {
        var it = row.innerText || '';
        if (it.indexOf('提交审核') >= 0 && it.indexOf('1.3.0') >= 0 && it.indexOf('删除') < 0) {
          var btns = row.querySelectorAll('button, a, [class*=btn]');
          for (var b = 0; b < btns.length; b++) {
            var bt = (btns[b].innerText || '').trim();
            if (bt === '提交审核') {
              btns[b].click();
              return 'CLICKED';
            }
          }
        }
        row = row.parentElement;
      }
    }
  }
  return 'NOT_FOUND';
})()
""")
print(f"[2] v1.3.0 submit: {r}")
if r != 'CLICKED': sys.exit(3)

# 全流程对话框处理
for tick in range(600):
    time.sleep(1)

    # 检查是否有表单页（get_class tab）
    ft = find_tab("get_class")
    if ft and tick > 10:
        v = ft.run_js("return (function(){var ta=document.querySelector('textarea');return ta?'FORM':'';})()")
        if v:
            print(f"[3] FORM @{tick}s")
            # 填备注
            DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
            dj = json.dumps(DESC, ensure_ascii=False)
            ft.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
            time.sleep(2)
            # 点提交审核
            r2 = ft.run_js("return (function(){var els=document.querySelectorAll('a.btn_primary,a.btn,button');for(var i=0;i<els.length;i++){var t='';try{t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');}catch(e){}if(t==='提交审核'){els[i].click();return 'SUBMITTED';}}return '';})()")
            print(f"[4] submit: {r2}")
            time.sleep(3)
            # 确认
            for tk in range(30):
                time.sleep(1)
                c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'||t==='确定'){bs[b].click();return 'FINAL:'+t;}}}return '';})()")
                if c:
                    print(f"[5] {tk}s {c}")
                    break
            time.sleep(10)
            # 验证
            for tid2 in page.browser.tab_ids:
                t2 = page.browser.get_tab(tid2)
                if "getcodepage" in (t2.url or ""):
                    t2.run_js("location.reload()")
                    time.sleep(8)
                    truth = t2.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));return JSON.stringify(o.slice(0,4));})()")
                    print(f"[6] TRUTH: {truth[:500]}")
                    break
            sys.exit(0)

    # 检查当前页面对话框
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
    except Exception: s = ""

    if not s: continue
    head, _, btns = s.partition('||BTN:')

    # 插件确认
    if ('插件' in head or '确认' in head) and '确认' in btns:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'');if((txt.indexOf('插件')>=0||txt.indexOf('确认')>=0)&&txt.indexOf('删除')<0){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确认'){bs[b].click();return;}}}}})()")
        print(f"  [{tick}s] 插件→确认")
    # 相关须知
    elif '相关须知' in head or '须知' in head:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'');if(txt.indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'||t==='同意并下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    # 继续提交
    elif '继续提交' in btns:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 继续提交")
    # 防误触删除
    elif '删除' in head and '取消' in btns:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")
        # 不打印，避免刷屏

print("[!] 超时（600s）")
