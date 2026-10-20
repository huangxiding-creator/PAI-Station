# -*- coding: utf-8 -*-
import sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch
page = attach_or_launch()
# 在当前 tab 打开 wxfdb 版本管理页
page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=1727388897&lang=zh_CN'")
time.sleep(6)
print('url:', (page.url or '')[:110])
