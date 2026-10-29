import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

# 方法1：找页面上的"退出登录"链接
r = page.run_js("""
return (function(){
  // 找退出按钮
  var els = document.querySelectorAll('a, button, [class*=logout], [class*=exit]');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '退出' || t === '退出登录' || t === '登出') {
      els[i].click();
      return 'clicked: ' + t;
    }
  }
  // 找头像菜单（可能要点展开）
  var avatar = document.querySelector('[class*=avatar], [class*=user-info], [class*=account]');
  if (avatar) {
    avatar.click();
    return 'clicked avatar';
  }
  return 'not-found';
})()
""")
print(f"[1] 退出按钮: {r}")
time.sleep(3)

# 方法2：如果头像点了，再找退出
if r == 'clicked avatar':
    r2 = page.run_js("""
return (function(){
  var els = document.querySelectorAll('a, button, [class*=logout], [class*=exit], [class*=dropdown-item]');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t.indexOf('退出') >= 0 || t.indexOf('登出') >= 0 || t.indexOf('切换') >= 0) {
      els[i].click();
      return 'clicked: ' + t;
    }
  }
  return 'not-found';
})()
""")
    print(f"[2] 下拉菜单: {r2}")
    time.sleep(3)

# 方法3：直接清 cookie + 重定向
page.run_js("""
document.cookie.split(';').forEach(function(c) {
  document.cookie = c.replace(/^ +/, '').replace(/=.*/, '=;expires=' + new Date().toUTCString() + ';path=/');
});
""")
time.sleep(1)
page.get("https://mp.weixin.qq.com/")
time.sleep(5)
url = page.url or ""
title = page.run_js("return document.title || ''")
has_qr = page.run_js("""
return (function(){
  var body = document.body.innerText || '';
  if (body.indexOf('扫码登录') >= 0 || body.indexOf('二维码') >= 0) return 'QR_PAGE';
  return 'STILL_LOGGED: ' + body.slice(0, 60);
})()
""")
print(f"[3] 清cookie后: URL={url[:60]}, 标题={title}, 状态={has_qr}")

# 如果还是登录态，最后手段：新 profile
if 'STILL' in (has_qr or ''):
    print("[4] 清不掉！用新 profile...")
    import os, shutil
    old = r"E:\AI-Station\data\state\mp_qr_profile2"
    bak = old + "_bak"
    if os.path.exists(old):
        shutil.rename(old, bak)
        print(f"  重命名: {old} -> {bak}")
    # 新浏览器实例
    page2 = None
    try:
        page2 = ChromiumPage(addr_or_opts=opts)  # opts 还指向同一路径（现在空了）
        page2.get("https://mp.weixin.qq.com/")
        time.sleep(5)
        title2 = page2.run_js("return document.title || ''")
        url2 = page2.url or ""
        print(f"  新profile: {title2}, {url2[:60]}")
        qr2 = page2.run_js("""
return (function(){
  var body = document.body.innerText || '';
  if (body.indexOf('扫码') >= 0) return 'QR_READY';
  return body.slice(0, 60);
})()
""")
        print(f"  登录页: {qr2}")
    except Exception as e:
        print(f"  新profile失败: {e}")
