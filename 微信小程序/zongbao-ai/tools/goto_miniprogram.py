# -*- coding: utf-8 -*-
"""从公众号控制台切到小程序控制台 + 提审"""
import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

tok = ""
u = page.url or ""
m = re.search(r"token=(\d+)", u)
tok = m.group(1) if m else ""
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
print(f"[1] token={tok}, URL={u[:60]}")

# 方法1：直接跳小程序管理页（带 appid）
appid = "wx5cee1574ce45819b"
page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(8)
title = page.run_js("return document.title || ''")
print(f"[2] 跳后标题: {title}, URL={page.url[:60]}")

# 方法2：如果还在公众号，找左侧「小程序」入口
if '公众号' in title or '官方' in title:
    print("[3] 还在公众号！找小程序入口...")
    r = page.run_js("""
return (function(){
  // 找左侧菜单里包含"小程序"的链接
  var els = document.querySelectorAll('a, [class*=menu-item], [class*=nav-item], [class*=app-item]');
  for (var i = 0; i < els.length; i++) {
    var t = (els[i].innerText || '').trim();
    if (t === '小程序' || t === 'Mini Program') {
      els[i].click();
      return 'clicked:' + t;
    }
  }
  // 也许在「切换」或「更多」里
  var links = document.querySelectorAll('a[href*="wxamp"], a[href*="miniprogram"]');
  if (links.length) {
    links[0].click();
    return 'clicked:wxamp-link';
  }
  return 'not-found';
})()
""")
    print(f"[4] 小程序入口: {r}")
    time.sleep(5)
    title2 = page.run_js("return document.title || ''")
    print(f"[5] 点击后: {title2}")

# 方法3：如果还不行，试从「首页」进入小程序管理
u2 = page.url or ""
m2 = re.search(r"token=(\d+)", u2)
tok2 = m2.group(1) if m2 else tok

if '公众号' in (page.run_js("return document.title || ''") or ''):
    # 用首页 URL + 小程序参数
    page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/home?appid={appid}&token={tok2}&lang=zh_CN'")
    time.sleep(5)
    print(f"[6] appid直跳: {page.url[:60]}")

# 检查是否有版本列表
time.sleep(5)
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or "") or "wxamp" in (t.url or ""):
        page = t; break

rows = page.run_js(r"""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[]; for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\s+/g,' ').slice(0,100));
  return JSON.stringify(out.slice(0,3));
})()
""")
title3 = page.run_js("return document.title || ''")
print(f"[7] 标题={title3}, URL={page.url[:60]}")
print(f"[8] versions: {rows[:400] if rows else 'EMPTY'}")

if rows and '1.1.0' in (rows or ''):
    print("[9] 找到 1.1.0！")
    # 提审流程...
else:
    print("[!] 仍未找到版本——当前账号可能确实无此小程序管理权限")
    # 列出当前账号信息
    acct = page.run_js("""
return (function(){
  var nick = document.querySelector('.weui-desktop-account__name, .account_name, [class*=nickname]');
  return nick ? nick.innerText || '' : 'unknown';
})()
""")
    print(f"[10] 当前账号: {acct}")
