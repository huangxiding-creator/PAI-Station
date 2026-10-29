import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

def find_tab(kw):
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        if kw in (t.url or ""): return t

gt = find_tab("getcodepage") or page

# 1. 取消删除对话框
r = gt.run_js("""
return (function(){
  var mods = document.querySelectorAll('.weui-desktop-dialog, .weui-desktop-modal');
  for (var i = 0; i < mods.length; i++) {
    var txt = (mods[i].innerText || '');
    if (txt.indexOf('删除') >= 0) {
      var btns = mods[i].querySelectorAll('button');
      for (var b = 0; b < btns.length; b++) {
        if ((btns[b].innerText || '').trim() === '取消') {
          btns[b].click();
          return 'cancelled-delete';
        }
      }
    }
  }
  return 'no-delete-dialog';
})()
""")
print(f"[1] 取消删除: {r}")
time.sleep(3)

# 2. 用文本精确匹配「提交审核」按钮（不用 CSS class，防误匹配删除按钮）
r2 = gt.run_js("""
return (function(){
  // 找 v1.3.0 所在的行
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
        if (it.indexOf('提交审核') >= 0 && it.indexOf('1.3.0') >= 0) {
          // 找行内的提交审核按钮——按文本匹配，不用class
          var btns = row.querySelectorAll('button, a');
          for (var b = 0; b < btns.length; b++) {
            var bt = (btns[b].innerText || '').trim();
            if (bt === '提交审核') {
              btns[b].click();
              return 'clicked-correct-submit';
            }
          }
        }
        row = row.parentElement;
      }
    }
  }
  return 'not-found';
})()
""")
print(f"[2] 正确点击提交审核: {r2}")
time.sleep(5)

# 3. 处理提交对话框舞步
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
            # 点提交审核
            for tk in range(20):
                time.sleep(1)
                r3 = ft.run_js("return (function(){var els=document.querySelectorAll('a.btn_primary,a.btn,button');for(var i=0;i<els.length;i++){var t=Array.prototype.filter.call(els[i].childNodes,function(n){return n.nodeType===3;}).map(function(n){return n.nodeValue.trim();}).join(' ');if(t==='提交审核'){els[i].click();return 'submitted';}}return 'waiting';})()")
                if r3 == 'submitted':
                    print(f"[4] submit: {r3}")
                    break
            # 确认
            for tk in range(30):
                time.sleep(1)
                c = ft.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button,a,.btn');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                if c: print(f"[5] {tk}s {c}"); break
            time.sleep(8)
            # 验证
            gt2 = find_tab("getcodepage")
            if gt2:
                gt2.run_js("location.reload()"); time.sleep(8)
                truth = gt2.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));return JSON.stringify(o.slice(0,4));})()")
                print(f"[6] TRUTH: {truth[:500]}")
            sys.exit(0)
    # 检查当前页面对话框
    try:
        s = gt.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'').replace(/\\s+/g,' ');var btns=mods[i].querySelectorAll('button');var bl=[];for(var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim();if(t)bl.push(t);}if(txt)return txt.slice(0,80)+'||BTN:'+bl.join(',');}return '';})()")
    except Exception: s = ""
    if not s: continue
    head, _, btns = s.partition('||BTN:')
    if '相关须知' in head:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('相关须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    elif '继续提交' in btns:
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 继续提交")
    elif '删除' in head and '取消' in btns:
        # 防再次误触删除
        gt.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 取消删除（防误触）")
