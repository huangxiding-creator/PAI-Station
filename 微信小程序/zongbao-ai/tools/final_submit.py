import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)

page.get("https://mp.weixin.qq.com/")
for i in range(30):
    time.sleep(3)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    if m and "scanlogin" not in u:
        tok = m.group(1)
        print(f"[1] token={tok}")
        break
else:
    print("LOGIN_TIMEOUT"); sys.exit(1)

page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(12)

r = page.run_js("""
return (function(){
  var btns = document.querySelectorAll('button');
  for (var i = 0; i < btns.length; i++) {
    var t = (btns[i].innerText || '').trim();
    var rect = btns[i].getBoundingClientRect();
    if (t === '提交审核' && rect.width > 0) {
      var ev = new MouseEvent('click', {bubbles: true, cancelable: true, view: window});
      btns[i].dispatchEvent(ev);
      return 'CLICKED';
    }
  }
  return 'NOT_FOUND';
})()
""")
print(f"[2] click: {r}")
time.sleep(8)

for tick in range(600):
    time.sleep(1)
    try:
        for tid in page.browser.tab_ids:
            t = page.browser.get_tab(tid)
            if "get_class" in (t.url or ""):
                print(f"[3] FORM @{tick}s")
                time.sleep(3)
                DESC = "知识库蓝图设计优化：海报含完整目录结构+支付体验提升+页面分区更清晰"
                dj = json.dumps(DESC, ensure_ascii=False)
                t.run_js('return (function(){var ta=document.querySelector("textarea");if(!ta)return;ta.value=' + dj + ';ta.dispatchEvent(new Event("input",{bubbles:true}));})()')
                time.sleep(2)
                t.run_js("(function(){var els=document.querySelectorAll('button,a.btn_primary');for(var i=0;i<els.length;i++){var t=(els[i].innerText||'').trim();if(t==='提交审核'){var ev=new MouseEvent('click',{bubbles:true,cancelable:true,view:window});els[i].dispatchEvent(ev);return;}}})()")
                print("[4] form submit")
                time.sleep(3)
                for tk in range(60):
                    time.sleep(1)
                    c = t.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.dialog,.modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='确定，继续提交'){bs[b].click();return 'FINAL';}}}return '';})()")
                    if c:
                        print(f"[5] {tk}s {c}")
                        break
                time.sleep(10)
                for tid4 in page.browser.tab_ids:
                    t4 = page.browser.get_tab(tid4)
                    if "getcodepage" in (t4.url or ""):
                        t4.run_js("location.reload()")
                        time.sleep(8)
                        truth = t4.run_js("return (function(){var b=document.querySelectorAll('.code_version_log');var o=[];for(var i=0;i<b.length;i++)o.push((b[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));return JSON.stringify(o.slice(0,4));})()")
                        print(f"[6] TRUTH: {truth[:500]}")
                        break
                sys.exit(0)
    except:
        pass

    try:
        s = page.run_js("return (function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var txt=(mods[i].innerText||'').replace(/\\s+/g,' ').trim();if(!txt||txt.length<5)continue;var btns=mods[i].querySelectorAll('button');var bl=[];for(var b=0;b<btns.length;b++){var t=(btns[b].innerText||'').trim();if(t)bl.push(t);}if(bl.length)return txt.slice(0,80)+'||'+bl.join(',');}return '';})()")
    except:
        s = ""
    if not s:
        continue
    head, _, btns_s = s.partition("||")
    if "插件" in head and "确认" in btns_s:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='确认'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 插件→确认")
    elif "须知" in head:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('须知')<0)continue;var cb=mods[i].querySelector('input[type=checkbox]');if(cb&&!cb.checked)cb.click();var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){var t=(bs[b].innerText||'').trim();if(t==='下一步'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 须知→下一步")
    elif "继续提交" in btns_s:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='继续提交'){bs[b].click();return;}}}})()")
        print(f"  [{tick}s] 继续提交")
    elif "删除" in head and "取消" in btns_s:
        page.run_js("(function(){var mods=document.querySelectorAll('.weui-desktop-dialog,.weui-desktop-modal');for(var i=0;i<mods.length;i++){if((mods[i].innerText||'').indexOf('删除')<0)continue;var bs=mods[i].querySelectorAll('button');for(var b=0;b<bs.length;b++){if((bs[b].innerText||'').trim()==='取消'){bs[b].click();return;}}}})()")

print("[!] 超时")
