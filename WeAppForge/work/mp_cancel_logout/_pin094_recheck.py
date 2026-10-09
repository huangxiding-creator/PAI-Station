# -*- coding: utf-8 -*-
"""钉位复核：刷新页面，专取「体验版本」卡片区（线上/审核/体验/开发四区顺序解析）。"""
import json, re, sys, time
sys.stdout.reconfigure(encoding="utf-8", errors="replace")
sys.path.insert(0, r"E:\AI-Station\WeAppForge\work\mp_cancel_logout")
from driver import attach_or_launch

page = attach_or_launch()
tab = None
for t in page.get_tabs():
    if "mp.weixin.qq.com" in (t.url or "") and "token=" in (t.url or ""):
        tab = t; break
m = re.search(r"token=(\d{8,})", tab.url or "")
tab.get(f"https://mp.weixin.qq.com/wxamp/wacodepage/getcodepage?token={m.group(1)}&lang=zh_CN")
time.sleep(6)

# 按区块标题切分全文，取「体验版本」区段
txt = (tab.run_js("return document.body.innerText;") or "")
norm = txt.replace("\n", "|")
i = norm.find("体验版本")
j = norm.find("开发版本", i if i >= 0 else 0)
seg = norm[i:j] if (i >= 0 and j > i) else "(section not found)"
print(json.dumps({"trial_section": seg[:400]}, ensure_ascii=False))
tab.get_screenshot(path=r"E:\AI-Station\WeAppForge\work\mp_cancel_logout\_pin094_recheck.png")
