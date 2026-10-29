import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions
opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1100,860")
opts.set_argument("--no-first-run")
page = ChromiumPage(addr_or_opts=opts)
# 强制跳到登录页
page.run_js("location.href='https://mp.weixin.qq.com/'")
time.sleep(5)
url = page.url or ""
print(f"URL: {url[:80]}")
title = page.run_js("return document.title || ''")
print(f"标题: {title}")
# 检查是否有二维码
qr = page.run_js("""
return (function(){
  var img = document.querySelector('.login__type__container__scan__qrcode img, .qrcode img, img[src*=qrcode]');
  if (img) return 'QR_FOUND: ' + (img.src || '').slice(0, 80);
  var iframe = document.querySelector('iframe');
  if (iframe) return 'IFRAME: ' + (iframe.src || '').slice(0, 80);
  var body = document.body.innerText || '';
  if (body.indexOf('扫码') >= 0) return 'HAS_SCAN_TEXT';
  return 'NO_QR: ' + body.slice(0, 100);
})()
""")
print(f"页面状态: {qr}")
# 如果没二维码，可能已被自动重定向到已登录页
if 'NO_QR' in qr:
    print("→ 可能还有残留登录态，强制清除...")
    page.run_js("location.href='https://mp.weixin.qq.com/misc/kfaction?action=logout'")
    time.sleep(3)
    page.get("https://mp.weixin.qq.com/")
    time.sleep(3)
    qr2 = page.run_js("""
return (function(){
  var img = document.querySelector('.login__type__container__scan__qrcode img, .qrcode img, img[src*=qrcode]');
  if (img) return 'QR_FOUND';
  var body = document.body.innerText || '';
  return 'STILL: ' + body.slice(0, 80);
})()
""")
    print(f"清除后: {qr2}")
