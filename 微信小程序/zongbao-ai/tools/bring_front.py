import sys, time, subprocess
sys.stdout.reconfigure(encoding="utf-8", errors="replace")

# 先杀掉所有 9338 浏览器
result = subprocess.run(['powershell', '-Command',
    'Get-Process chrome -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -match "9338" } | Stop-Process -Force'],
    capture_output=True, text=True)
print("清理完成")

time.sleep(3)

# 重新启动（新窗口，最大化）
from DrissionPage import ChromiumPage, ChromiumOptions
opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
opts.set_argument("--no-first-run")
opts.set_argument("--start-maximized")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/")
time.sleep(8)

# 截屏看实际界面
page.get_screenshot(path=r"E:\AI-Station\kb_rev\login_page.png", full_page=True)
print("截屏已保存: kb_rev/login_page.png")

# 确认状态
title = page.run_js("return document.title || ''")
url = page.url or ""
body = page.run_js("return (document.body.innerText || '').slice(0, 200)")
print(f"标题: {title}")
print(f"URL: {url[:80]}")
print(f"页面内容: {body[:150]}")
