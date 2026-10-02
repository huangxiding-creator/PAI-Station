# -*- coding: utf-8 -*-
"""单账号 send_task 诊断: 登录→发送→失败现场截图+URL+toast 文本."""
import sys
import time

sys.path.insert(0, r"E:\AI-Station\Auto_Manus")
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
import epc50_corps as corps
import manus_lib as lib

page = lib.make_page()
creds = dict(lib.load_accounts("Manus账号（全部）260922_干净版.txt"))
email = next((e for e in creds
              if e not in corps.EXCLUDE_EMAILS
              and not corps.account_dispatched_today(e)), None)
print("账号:", email, flush=True)
try:
    lib.ensure_login(page, email, creds[email])
except Exception as e:
    print("登录EXC:", type(e).__name__, str(e)[:100], flush=True)
print("登录后 URL:", page.url, flush=True)
prompt = ("请搜集整理「中石化南京工程有限公司」EPC总承包业务的公开资料："
          "每条含来源名称、URL、发布时间与原文摘录。")
sid = None
try:
    sid, hits = lib.send_task(page, prompt)
    print("sid:", sid, flush=True)
except Exception as e:
    print("EXC:", type(e).__name__, str(e)[:120], flush=True)
time.sleep(3)
print("现场 URL:", page.url, flush=True)
print("标题:", page.title, flush=True)
try:
    page.get_screenshot(r"E:\AI-Station\Auto_Manus\probe_send_fail.png")
    print("截图落盘", flush=True)
except Exception as e:
    print("截图失败", e, flush=True)
for sel in ("tag:div@class^=toast", "tag:div@text():达", "tag:span@text():限"):
    try:
        els = page.eles(sel, timeout=1)
        for el in els[:3]:
            t = (el.text or "").strip()
            if t:
                print("提示文本:", t[:80], flush=True)
    except Exception:
        pass
