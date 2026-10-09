# -*- coding: utf-8 -*-
"""_pin094_probe — 9336 控制台会话体检：确认 wx5cee + 版本管理页 0.9.4 行结构。"""
import json
import re
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")

from driver import attach_or_launch  # noqa: E402
from vpay_common import pierce_dump  # noqa: E402

WANT = "wx5cee1574ce45819b"

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    u = t.url or ""
    if "mp.weixin.qq.com" in u and "token=" in u:
        tab = t
        break
if tab is None:
    print(json.dumps({"state": "ERROR", "msg": "no mp console tab"}))
    sys.exit(1)

m = re.search(r"token=(\d{8,})", tab.url or "")
token = m.group(1) if m else ""
html = tab.html or ""
apps = sorted(set(re.findall(r"(wx[0-9a-f]{16})", html)))
print(json.dumps({
    "url": (tab.url or "")[:120],
    "token": token,
    "want_appid_in_html": WANT in html,
    "apps_seen": apps[:8],
    "has_094": "0.9.4" in html,
    "has_093": "0.9.3" in html,
    "title_hint": ("总包AI顾问" in html),
}, ensure_ascii=False))

# 版本管理页若不在则导航
if "getcodepage" not in (tab.url or ""):
    tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={token}&lang=zh_CN")
    time.sleep(4)

d = pierce_dump(tab)
data = json.loads(d) if isinstance(d, str) else d
vis = data.get("vis", [])
print("visible interactive elements:", len(vis))
for v in vis:
    txt = v.get("txt", "")
    if any(k in txt for k in ("0.9.4", "0.9.3", "体验版", "选为", "上传", "开发者")):
        print(json.dumps(v, ensure_ascii=False))
