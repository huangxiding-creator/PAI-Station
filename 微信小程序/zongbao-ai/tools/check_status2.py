import sys, time, re, json
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

# 获取 token
tok = ""
u = page.url or ""
m = re.search(r"token=(\d+)", u)
tok = m.group(1) if m else ""
if not tok:
    for tid in page.browser.tab_ids:
        t = page.browser.get_tab(tid)
        m2 = re.search(r"token=(\d+)", t.url or "")
        if m2:
            tok = m2.group(1)
            page = t
            break
if not tok:
    page.get("https://mp.weixin.qq.com/")
    time.sleep(5)
    u = page.url or ""
    m = re.search(r"token=(\d+)", u)
    tok = m.group(1) if m else ""
print(f"token={tok}")

# 新 tab 打开版本管理
page.run_js(f"window.open('https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={tok}&lang=zh_CN','_blank')")
time.sleep(10)
# 找新 tab
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or ""):
        page = t; break

# 读全部页面文本
body = page.run_js("return (document.body.innerText || '').replace(/\\s+/g, ' ').slice(0, 1000)")
print(f"页面内容:\n{body[:600]}")
