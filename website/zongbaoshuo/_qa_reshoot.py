# -*- coding: utf-8 -*-
"""hero 修正后重拍：桌面 hero（等动画终态2s）+ robot/assets 桌面截图；离屏铁律"""
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

URL = "file:///E:/AI-Station/website/zongbaoshuo/index.html"

SECTIONS = [("robot", "v5-d-robot.png"), ("assets", "v5-d-assets.png"), ("glasses", "v5-d-glasses2.png")]

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    errors = []
    pg = b.new_page(viewport={"width": 1440, "height": 900})
    pg.on("pageerror", lambda e: errors.append(str(e)))
    pg.goto(URL, wait_until="networkidle")
    pg.wait_for_timeout(2000)  # 等逐字动画+盖章入场终态
    # hero 滚回顶再截（确保 hero 完整可见）
    pg.evaluate("() => window.scrollTo({top:0, behavior:'instant'})")
    pg.wait_for_timeout(400)
    pg.screenshot(path="e:/AI-Station/v5-d-hero.png")
    print("SHOT: v5-d-hero.png")
    # 破图实拍复核（滚到位让 lazy 加载）
    for sec, fn in SECTIONS:
        pg.evaluate("(id) => { const el = document.getElementById(id); const y = el.getBoundingClientRect().top + scrollY - 70; window.scrollTo({top: y, behavior:'instant'}); }", sec)
        pg.wait_for_timeout(900)
        pg.screenshot(path="e:/AI-Station/" + fn)
        print("SHOT:", fn)
    # 破图终判（此时已滚过 lazy 阈值）
    broken = pg.evaluate("""() => Array.from(document.images)
        .filter(i => i.complete && i.naturalWidth === 0 && i.src && !i.src.startsWith('data:'))
        .map(i => i.src.split('/').pop())""")
    print("BROKEN IMGS (after scroll):", broken or "NONE")
    print("JS ERRORS:", errors or "NONE")
    b.close()
print("RESHOOT DONE")
