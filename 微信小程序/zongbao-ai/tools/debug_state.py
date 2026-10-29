import sys, time, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)

for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    u = t.url or ""
    title = ""
    try: title = t.run_js("return document.title || ''") or ""
    except: pass
    print(f"tab: {u[:80]} | {title[:20]}")

# 截屏第一个 tab
for tid in page.browser.tab_ids:
    t = page.browser.get_tab(tid)
    if "getcodepage" in (t.url or "") or "get_class" in (t.url or ""):
        t.get_screenshot(path=r"E:\AI-Station\kb_rev\current_state.png")
        print("screenshot saved")
        break
