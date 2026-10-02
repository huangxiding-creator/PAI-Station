# -*- coding: utf-8 -*-
"""v10 目检：重排后各产品段 + 价值/八位一体段整段截图"""
import io, sys
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    pg = b.new_page(viewport={"width":1440,"height":900}, device_scale_factor=1.5)
    pg.goto("file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1", wait_until="networkidle")
    pg.wait_for_timeout(1800)
    for sec, fn in [("value","v10-value"),("system","v10-system"),("leopard","v10-leopard"),
                    ("brain","v10-brain"),("zhiku","v10-zhiku"),("factory","v10-factory"),
                    ("aipo","v10-aipo"),("station","v10-station")]:
        pg.evaluate("(id)=>{const el=document.getElementById(id);window.scrollTo({top:el.getBoundingClientRect().top+scrollY-70,behavior:'instant'})}", sec)
        pg.wait_for_timeout(700)
        pg.screenshot(path="e:/AI-Station/%s.png" % fn); print("SHOT:", fn)
    # 顺序断言
    seq = pg.evaluate("()=>Array.from(document.querySelectorAll('section[id]')).map(s=>s.id)")
    print("DOM SEQ:", seq)
    b.close()
print("V10 SHOT DONE")
