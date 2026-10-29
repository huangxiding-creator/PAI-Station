import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/")
time.sleep(5)

# 点「使用账号登录」切换到账号密码模式
r = page.run_js("""
return (function(){
  var els = document.querySelectorAll('a, span, div, [class*=login_type]');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '使用账号登录' || t.indexOf('账号登录') >= 0) {
      els[i].click();
      return 'clicked: ' + t;
    }
  }
  return 'not-found';
})()
""")
print(f"[1] 切换账号登录: {r}")
time.sleep(3)

# 检查是否出现账号密码输入框
inputs = page.run_js("""
return (function(){
  var inputs = document.querySelectorAll('input[type=text], input[type=password], input[name*=account], input[name*=user], input[name*=email], input[name*=pwd], input[name*=pass]');
  var out = [];
  for (var i = 0; i < inputs.length; i++) {
    out.push({
      type: inputs[i].type,
      name: inputs[i].name || '',
      placeholder: inputs[i].placeholder || '',
      visible: !!(inputs[i].offsetParent)
    });
  }
  return JSON.stringify(out);
})()
""")
print(f"[2] 输入框: {inputs[:400]}")

# 截屏确认
page.get_screenshot(path=r"E:\AI-Station\kb_rev\account_login.png")
print("[3] 截屏已保存: kb_rev/account_login.png")
