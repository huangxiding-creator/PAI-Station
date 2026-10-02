# -*- coding: utf-8 -*-
"""导航渐隐验证：390px 下 fade-end 应亮起；滚到底应摘除；桌面 1440px 应无渐隐"""
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

URL = "file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1"

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    # 移动端
    pg = b.new_page(viewport={"width": 390, "height": 844}, device_scale_factor=2)
    pg.goto(URL, wait_until="networkidle")
    pg.wait_for_timeout(600)
    r1 = pg.evaluate("""() => {
        const n = document.getElementById('tnav');
        const de = document.documentElement;
        return {fade: n.classList.contains('fade-end'),
                overflow: n.scrollWidth > n.clientWidth,
                scrollW: de.scrollWidth, clientW: de.clientWidth};
    }""")
    print("MOBILE 390 initial:", r1)
    # 滚到底 → 渐隐应消失
    pg.evaluate("() => { const n = document.getElementById('tnav'); n.scrollLeft = n.scrollWidth; n.dispatchEvent(new Event('scroll')); }")
    pg.wait_for_timeout(200)
    r2 = pg.evaluate("() => document.getElementById('tnav').classList.contains('fade-end')")
    print("MOBILE 390 scrolled-to-end fade:", r2)
    pg.screenshot(path="e:/AI-Station/v3-m-hero.png")
    print("SHOT: v3-m-hero.png")
    pg.close()
    # 桌面：不溢出 → 无渐隐
    pg2 = b.new_page(viewport={"width": 1440, "height": 900})
    pg2.goto(URL, wait_until="networkidle")
    pg2.wait_for_timeout(500)
    r3 = pg2.evaluate("""() => { const n = document.getElementById('tnav');
        return {fade: n.classList.contains('fade-end'), overflow: n.scrollWidth > n.clientWidth}; }""")
    print("DESKTOP 1440:", r3)
    b.close()
print("NAVFADE QA DONE")
