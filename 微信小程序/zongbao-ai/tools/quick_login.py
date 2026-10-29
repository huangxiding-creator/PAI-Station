import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/")
time.sleep(5)

# 找"微信快捷登录"或类似按钮
r = page.run_js("""
return (function(){
  // 搜索所有可能的快捷登录入口
  var els = document.querySelectorAll('a, button, div, span, [class*=login], [class*=quick]');
  var found = [];
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t && t.length < 30 && (t.indexOf('快捷') >= 0 || t.indexOf('微信登录') >= 0 || t.indexOf('一键') >= 0)) {
      found.push({tag: els[i].tagName, text: t, cls: (els[i].className || '').slice(0, 40)});
    }
  }
  // 也找 iframe（快捷登录可能在 iframe 里）
  var iframes = document.querySelectorAll('iframe');
  return JSON.stringify({buttons: found, iframes: iframes.length, body: (document.body.innerText || '').slice(0, 300)});
})()
""")
print("页面搜索:", r[:500])

# 尝试点"微信快捷登录"
r2 = page.run_js("""
return (function(){
  var els = document.querySelectorAll('*');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '微信快捷登录' || t === '快捷登录') {
      els[i].click();
      return 'clicked: ' + t;
    }
  }
  return 'not-found';
})()
""")
print(f"快捷登录: {r2}")
time.sleep(3)

# 如果找不到，试试点击已有微信授权（可能在系统通知里）
if r2 == 'not-found':
    # 试找"授权"或"确认"按钮
    r3 = page.run_js("""
return (function(){
  var body = document.body.innerText || '';
  var els = document.querySelectorAll('button, a, [class*=btn]');
  var options = [];
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t && t.length < 20) options.push(t);
  }
  return JSON.stringify(options.slice(0, 15));
})()
""")
    print(f"页面按钮: {r3[:300]}")
