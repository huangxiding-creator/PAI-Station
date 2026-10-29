import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
opts.set_argument("--window-size=1200,900")
opts.set_argument("--no-first-run")
opts.set_argument("--start-maximized")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/")
time.sleep(5)
print("登录页已打开——请扫码")
