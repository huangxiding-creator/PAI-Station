# -*- coding: utf-8 -*-
"""v4 全站离屏验收：JS错误捕获 + 移动端溢出 + 关键段截图（桌面+移动）"""
import sys, io
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
from playwright.sync_api import sync_playwright

URL = "file:///E:/AI-Station/website/zongbaoshuo/index.html"
SECTS = ["assets","leopard","zhiku","brain","factory","glasses","station","aipo","robot","prospect","contact"]

with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    # ---- 移动端 390x844 ----
    pg = b.new_page(viewport={"width":390,"height":844}, device_scale_factor=2)
    errs = []
    pg.on("pageerror", lambda e: errs.append(str(e)))
    pg.on("console", lambda m: errs.append("console.error: "+m.text) if m.type=="error" else None)
    pg.goto(URL, wait_until="networkidle")
    pg.wait_for_timeout(900)
    ovf = pg.evaluate("""() => {
        const de = document.documentElement;
        const wide = [];
        document.querySelectorAll('body *').forEach(el => {
            const r = el.getBoundingClientRect();
            if (r.right > de.clientWidth + 1 && r.width > 4) {
                const cls = (el.className && String(el.className).split(' ')[0]) || el.tagName;
                wide.push(cls + '@' + Math.round(r.right));
            }
        });
        return {scrollW: de.scrollWidth, clientW: de.clientWidth, wide: wide.slice(0, 8),
                imgsBroken: [...document.images].filter(i=>!i.complete||i.naturalWidth===0).map(i=>i.getAttribute('src'))};
    }""")
    print("M OVERFLOW:", ovf["scrollW"], ">", ovf["clientW"], "=", ovf["scrollW"] > ovf["clientW"], "| WIDE:", ovf["wide"])
    print("M BROKEN IMGS:", ovf["imgsBroken"] if ovf["imgsBroken"] else "NONE")
    # 各段 instant 滚动 + 截图
    for s in ["glasses","robot","assets","prospect"]:
        pg.evaluate(f"() => {{ const z=document.getElementById('{s}'); window.scrollTo({{top: z.getBoundingClientRect().top+scrollY-6, behavior:'instant'}}); }}")
        pg.wait_for_timeout(250)
        pg.screenshot(path=f"e:/AI-Station/v4-m-{s}.png")
    print("M SHOTS: glasses/robot/assets/prospect")
    r_tnav = pg.evaluate("() => { const n=document.getElementById('tnav'); return {fade:n.classList.contains('fade-end'), ov:n.scrollWidth>n.clientWidth}; }")
    print("M NAV:", r_tnav)
    pg.close()
    # ---- 桌面 1440x900 ----
    pg2 = b.new_page(viewport={"width":1440,"height":900})
    pg2.on("pageerror", lambda e: errs.append("desktop: "+str(e)))
    pg2.goto(URL, wait_until="networkidle")
    pg2.wait_for_timeout(800)
    ovf2 = pg2.evaluate("() => ({scrollW: document.documentElement.scrollWidth, clientW: document.documentElement.clientWidth})")
    print("D OVERFLOW:", ovf2["scrollW"], ">", ovf2["clientW"], "=", ovf2["scrollW"] > ovf2["clientW"])
    pg2.screenshot(path="e:/AI-Station/v4-d-hero.png")
    pg2.evaluate("() => { const z=document.getElementById('glasses'); window.scrollTo({top: z.getBoundingClientRect().top+scrollY-6, behavior:'instant'}); }")
    pg2.wait_for_timeout(350)
    pg2.screenshot(path="e:/AI-Station/v4-d-glasses.png")
    pg2.evaluate("() => { const z=document.getElementById('robot'); window.scrollTo({top: z.getBoundingClientRect().top+scrollY-6, behavior:'instant'}); }")
    pg2.wait_for_timeout(350)
    pg2.screenshot(path="e:/AI-Station/v4-d-robot.png")
    pg2.evaluate("() => { const z=document.getElementById('assets'); window.scrollTo({top: z.getBoundingClientRect().top+scrollY-6, behavior:'instant'}); }")
    pg2.wait_for_timeout(350)
    pg2.screenshot(path="e:/AI-Station/v4-d-assets.png")
    print("D SHOTS: hero/glasses/robot/assets")
    b.close()
print("JS ERRORS:", errs if errs else "NONE")
print("V4 QA DONE")
