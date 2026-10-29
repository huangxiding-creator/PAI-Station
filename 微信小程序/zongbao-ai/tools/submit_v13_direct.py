import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
tok = ""
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    m = re.search(r"token=(\d+)", t.url or "")
    if m:
        tok = m.group(1)
        page = t
        break
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
print(f"[1] token={tok}")

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""): return t

gt = find_tab("mp.weixin.qq.com") or page
gt.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(10)
gt = find_tab("getcodepage") or gt

# 精确找 1.3.0 行并点提交审核
r = gt.run_js("""
return (function(){
  // 找所有包含"1.3.0"的元素
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {
    var own = Array.prototype.filter.call(els[i].childNodes || [], function(n) {
      return n.nodeType === 3;
    }).map(function(n) { return n.nodeValue.trim(); }).join(' ');
    if (own === '1.3.0') {
      var row = els[i];
      for (var d = 0; d < 12 && row; d++) {
        var it = row.innerText || '';
        if (it.indexOf('提交审核') >= 0 && it.indexOf('1.3.0') >= 0) {
          var btn = row.querySelector('button.weui-desktop-btn_primary, .weui-desktop-btn_primary');
          if (btn) { btn.click(); return 'clicked-1.3.0'; }
        }
        row = row.parentElement;
      }
    }
  }
  return 'not-found';
})()
""")
print(f"[2] v1.3.0: {r}")
if r != 'clicked-1.3.0': sys.exit(3)

# 对话框舞步
for tick in range(300):
    time.sleep(1)
    ft = find_tab("get_class")
    if ft and tick > 5:
        v = ft.run_js("return (function(){var ta=document.querySelector('textarea');return ta?'form-open':'';})()")
        if v:
            print(f"[3] FORM @{tick}s")
            DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
            dj = json.dumps(DESC, ensure_ascii=False)
            ft.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
            r2 = ft.run_js("return (function(){var els=document.querySelectorAll('a.btn_primary,a.btn,button');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='提交审核'){els[i].click();return 'submitted';}}return 'not-found';})()")
            print(f"[4] submit: {r2}")
            for tk in range(30):
                time.sleep(1)
                c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                if c: print(f"[5] {tk}s {c}"); break
            time.sleep(6)
            gt2 = find_tab("getcodepage")
            if gt2:
                gt2.run_js("location.reload()"); time.sleep(8)
                truth = gt2.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,150));return JSON.stringify(o.slice(0,3));})()")
                print(f"[6] TRUTH: {truth[:400]}")
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
