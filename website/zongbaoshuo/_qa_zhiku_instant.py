# -*- coding: utf-8 -*-
"""zhiku 移动端重截：instant scroll 消除 smooth 动画竞态，回读数字钉死后再截图"""
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

URL = "file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1"

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    pg = b.new_page(viewport={"width": 390, "height": 844}, device_scale_factor=2)
    pg.goto(URL, wait_until="networkidle")
    pg.wait_for_timeout(600)
    # instant 定位：滚到 zhiku 顶部贴近视口顶（留 header 高度 62px 余量）
    r = pg.evaluate("""() => {
        const z = document.getElementById('zhiku');
        const y = z.getBoundingClientRect().top + scrollY - 8;
        window.scrollTo({top: y, behavior: 'instant'});
        return {target: y};
    }""")
    pg.wait_for_timeout(300)
    rb = pg.evaluate("""() => {
        const z = document.getElementById('zhiku');
        const rail = document.querySelector('#zhiku .sheet-rail');
        return {scrollY: Math.round(scrollY),
                zhikuTop: Math.round(z.getBoundingClientRect().top),
                railH: rail ? Math.round(rail.getBoundingClientRect().height) : -1,
                railTxt: rail ? rail.textContent.trim().replace(/\\s+/g, ' ') : ''};
    }""")
    print("TARGET:", r["target"], "| READBACK:", rb)
    pg.screenshot(path="e:/AI-Station/v3-m-zhiku.png")
    print("SHOT: v3-m-zhiku.png")
    b.close()
print("ZHIKU RESHOT DONE")
