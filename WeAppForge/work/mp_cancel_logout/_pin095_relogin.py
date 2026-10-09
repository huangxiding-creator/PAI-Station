# -*- coding: utf-8 -*-
"""_pin095_relogin — 控制台会话过期后的重登等待器。
流程：MP_ROOT 开新页（赌一次自动续登）→ 仍 QR 则 notify_wecom 叫管理员扫一次码（只发一条）
→ 每 10s 轮询，见 token= URL 即 LOGGED_IN 退出 0；15 分钟超时退出 3。"""
import re
import subprocess
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch, MP_ROOT  # noqa: E402

page = attach_or_launch()
nt = page.new_tab(MP_ROOT)
time.sleep(8)
url = nt.url or ""


def logged_in(u):
    return "token=" in u and "scanlogin" not in u and u.rstrip("/") != MP_ROOT.rstrip("/")


if logged_in(url):
    print("AUTO_RELOGIN_OK", url[:120])
    sys.exit(0)

# 仍在二维码页：确认二维码新鲜（过期遮罩→重载换码）
def qr_fresh_text(t):
    try:
        return ("已失效" not in (t.html or "")) and ("点击刷新" not in (t.html or ""))
    except Exception:
        return True

if not qr_fresh_text(nt):
    nt.get(MP_ROOT)
    time.sleep(3)

# 叫人：企微一条（30 秒动作；Chrome 9336 常驻桌面窗口里扫）
try:
    subprocess.run(
        [sys.executable, r"E:\AI-Station\tools\notify_wecom.py",
         "小程序控制台需要扫一次码（30秒）",
         "v0.9.5 已上传（robot 20），控制台会话过期，钉体验版需要重新登录。"
         "请扫桌面 Chrome 窗口（标题带 mp.weixin / 微信公众平台）里的二维码，扫完我自动继续，无需其他操作。"],
        cwd=r"E:\AI-Station", timeout=30, check=False)
    print("WECOM_SENT")
except Exception as e:
    print("WECOM_SEND_ERR", str(e)[:120])

deadline = time.time() + 15 * 60
while time.time() < deadline:
    time.sleep(10)
    try:
        u = nt.url or ""
    except Exception:
        nt = page.new_tab(MP_ROOT)
        continue
    if logged_in(u):
        print("LOGGED_IN_AFTER_SCAN", u[:120])
        sys.exit(0)
    if not qr_fresh_text(nt):
        nt.get(MP_ROOT)
        time.sleep(3)

print("TIMEOUT_15MIN")
sys.exit(3)
