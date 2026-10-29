# -*- coding: utf-8 -*-
"""mp_session_keepalive.py — 9338 小程序控制台登录态保活守护（全自动提审常令的根因修复件）。
原理：微信扫码会话在持续使用下寿命长，隔天失效主因=长期不访问。
动作：连 9338 → 访问版本管理页 → 活=静默退（会话已续）；死=开 QR 页挂 10 分钟窗+企微报警请扫。
用法：py -3 -X utf8 tools/mp_session_keepalive.py（cron 每日 2 次驱动）"""
import sys, time, re
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage, ChromiumOptions

opts = ChromiumOptions()
opts.set_local_port(9338)
opts.set_user_data_path(r"E:\AI-Station\data\state\mp_qr_profile2")
page = None
try:
    try:
        page = ChromiumPage(addr_or_opts=opts)
        u = page.url or ""
    except Exception:
        page = ChromiumPage(addr_or_opts=opts)  # 浏览器未起则冷起
        u = ""
    m = re.search(r"token=(\d+)", u)
    if not m:
        page.get("https://mp.weixin.qq.com/")
        for i in range(5):
            time.sleep(3)
            m = re.search(r"token=(\d+)", page.url or "")
            if m: break
    if m and "scanlogin" not in (page.url or ""):
        # 活：访问版本页刷会话
        page.run_js("location.href='https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token=" + m.group(1) + "&lang=zh_CN'")
        time.sleep(6)
        print("ALIVE token=" + m.group(1))
    else:
        # 死：挂 QR 窗等扫 + 报警
        try:
            import subprocess
            subprocess.Popen(["py", "-3", "-X", "utf8", r"E:\AI-Station\tools\notify_approval_wecom.py",
                              "--title", "9338登录态失效待扫码(保活守护)",
                              "--body", "小程序控制台会话过期,9338浏览器已挂QR(10分钟窗),扫后全自动提审链恢复免打扰"],
                             creationflags=0x08000000)
        except Exception:
            pass
        print("DEAD_QR_WAITING")
        time.sleep(600)  # 挂 10 分钟窗给用户扫
        m2 = re.search(r"token=(\d+)", page.url or "")
        print("RENEWED" if m2 else "STILL_DEAD")
finally:
    try: page.quit()
    except Exception: pass