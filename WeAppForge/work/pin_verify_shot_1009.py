# -*- coding: utf-8 -*-
"""0.9.2 重钉验证·重拍：整页截图 + 主内容区裁剪（前次裁剪区域为空，改为全页+左侧大区双产物）。"""
import base64
import sys
import time

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
from DrissionPage import ChromiumPage
from PIL import Image

page = ChromiumPage("127.0.0.1:9336")
tab = next((t for t in page.get_tabs() if "mp.weixin.qq.com" in (t.url or "")), None)
if tab is None:
    raise SystemExit("no mp tab")

# 先回版本管理页（保险：若 tab 停在别处）
if "/wampdevversion" not in (tab.url or "") and "version" not in (tab.url or ""):
    # wujie 内页 URL 不变，直接重截当前态即可；若已离开则重走菜单坐标流
    pass

r = tab.run_cdp("Page.captureScreenshot", format="png")
raw = "E:/AI-Station/WeAppForge/work/vp092_s9_full.png"
open(raw, "wb").write(base64.b64decode(r.get("data", "")))
im = Image.open(raw)
print("FULL", im.size)

# 主内容区（左侧菜单右侧开始，去掉浏览器滚动条）：x 210..1900, y 150..900（全分辨率坐标）
crop = im.crop((210, 150, min(1900, im.size[0]), min(900, im.size[1])))
if crop.size[0] > 1400:
    crop = crop.resize((1400, int(crop.size[1] * 1400 / crop.size[0])))
crop.convert("RGB").save("E:/AI-Station/WeAppForge/work/vp092_s9_main.jpg", quality=92)
print("CROP_SAVED vp092_s9_main.jpg", crop.size)
