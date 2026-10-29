import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1100,860")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/")
time.sleep(5)
url = page.url or ""
title = page.run_js("return document.title || ''")
status = page.run_js("""
return (function(){
  var body = document.body.innerText || '';
  if (body.indexOf('扫码') >= 0 || body.indexOf('二维码') >= 0) return 'QR_READY';
  if (url.indexOf('token=') >= 0) return 'LOGGED_IN';
  return body.slice(0, 60);
})()
""")
print(f"标题={title}, 状态={status}")
if status != 'QR_READY':
    # 还在登录态 → 点退出
    r = page.run_js("""
return (function(){
  var els = document.querySelectorAll('a, button');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '退出登录' || t === '退出') { els[i].click(); return 'logged-out'; }
  }
  return 'still';
})()
""")
    print(f"退出: {r}")
    time.sleep(3)
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    title2 = page.run_js("return document.title || ''")
    has_qr = '扫码' in (page.run_js("return document.body.innerText || ''") or '')
    print(f"退出后: 标题={title2}, 二维码={has_qr}")
