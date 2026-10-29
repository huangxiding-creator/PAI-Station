# -*- coding: utf-8 -*-
# 查审核状态（只读——DrissionPage@9338 进版本管理页）
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
if not m:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
tok = m.group(1) if m else ""
if not tok:
    print("NOT_LOGGED_IN"); sys.exit(1)

page.run_js(f"location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN'")
time.sleep(8)

# 找含"审核"的版本块
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or ""):
        rows = t.run_js("""
return (function(){
  var blocks=document.querySelectorAll('.code_version_log');
  var out=[];
  for (var i=0;i<blocks.length;i++) out.push((blocks[i].innerText||'').replace(/\\s+/g,' ').slice(0,200));
  return JSON.stringify(out.slice(0,5));
})()
""")
        print("版本日志:")
        for line in json.loads(rows or "[]"):
            print(" ", line[:180])
        break
