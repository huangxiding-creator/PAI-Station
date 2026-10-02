# -*- coding: utf-8 -*-
"""移动端 390x844 离屏验收：横向溢出检查 + 关键段截图（不弹窗铁律：--window-position 离屏）"""
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

URL = "file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1"

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    pg = b.new_page(viewport={"width": 390, "height": 844}, device_scale_factor=2)
    pg.goto(URL, wait_until="networkidle")
    pg.wait_for_timeout(800)

    # 1) 横向溢出检查
    ovf = pg.evaluate("""() => {
        const de = document.documentElement;
        const wide = [];
        document.querySelectorAll('body *').forEach(el => {
            const r = el.getBoundingClientRect();
            if (r.right > de.clientWidth + 1 && r.width > 4) {
                const cls = (el.className && el.className.split(' ')[0]) || el.tagName;
                wide.push(cls + '@' + Math.round(r.right));
            }
        });
        return {scrollW: de.scrollWidth, clientW: de.clientWidth, wide: wide.slice(0, 8)};
    }""")
    print("OVERFLOW:", ovf["scrollW"], ">", ovf["clientW"], "=", ovf["scrollW"] > ovf["clientW"])
    if ovf["wide"]:
        print("WIDE ELEMS:", ovf["wide"])

    # 2) seal 移动端应隐藏
    seal = pg.evaluate("() => { const s = document.querySelector('.seal'); return s ? getComputedStyle(s).display : 'none-dom'; }")
    print("SEAL DISPLAY:", seal)

    # 3) 关键段截图：hero / native / 一张产品 sheet（zhiku）
    pg.screenshot(path="e:/AI-Station/v2-m-hero.png")
    pg.evaluate("() => document.getElementById('native').scrollIntoView()")
    pg.wait_for_timeout(400)
    pg.screenshot(path="e:/AI-Station/v2-m-native.png")
    pg.evaluate("() => document.getElementById('zhiku').scrollIntoView()")
    pg.wait_for_timeout(400)
    pg.screenshot(path="e:/AI-Station/v2-m-zhiku.png")
    print("SHOTS: hero/native/zhiku saved")
    b.close()
print("MOBILE QA DONE")
