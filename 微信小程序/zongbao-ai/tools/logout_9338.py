import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions
opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = ChromiumPage(addr_or_opts=opts)
page.get("https://mp.weixin.qq.com/misc/kfaction?action=logout&lang=zh_CN")
time.sleep(3)
page.get("https://mp.weixin.qq.com/")
time.sleep(3)
print("已登出——请扫码（用管理总包AI顾问小程序的微信号）")
