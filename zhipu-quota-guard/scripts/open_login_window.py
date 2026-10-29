# -*- coding: utf-8 -*-
"""为用户重开一次性登录窗口：预填账密、停在登录页、保持浏览器存活（不 quit）。"""
import json
import sys
import time
from pathlib import Path

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
ROOT = Path(__file__).resolve().parents[1]
BM = json.loads((ROOT / "secrets" / "zhipu_secrets.json").read_text(encoding="utf-8"))["bigmodel"]

from DrissionPage import ChromiumOptions, ChromiumPage  # noqa: E402

co = ChromiumOptions()
co.set_local_port(9341)
co.set_user_data_path(str(ROOT / ".chrome-profile"))
co.headless(False)
page = ChromiumPage(co)
page.get(BM["login_url"])
time.sleep(3)
tab = page.ele("text:账号登录", timeout=3)
if tab:
    tab.click()
    time.sleep(1.2)
acct = page.ele("css:input[placeholder='请输入用户名/邮箱/手机号']", timeout=4)
pwd = page.ele("css:input[placeholder='请输入密码']", timeout=3)
if acct and pwd:
    acct.clear().input(BM["phone"])
    pwd.clear().input(BM["password"])
print("[window] 登录窗口已备好（账密已填）→ 请人工点『登录』并完成点选验证码。窗口保持打开。")
