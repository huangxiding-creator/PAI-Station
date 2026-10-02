# -*- coding: utf-8 -*-
"""v6 投资人升级版全站验收：标签/ID/图片自检 + 桌面截图(hero终态+新五段) + 移动端溢出"""
import sys, io, re, os
sys.stdout = io.TextIOWrapper(sys.stdout.buffer, encoding='utf-8', errors='replace')
BASE = "E:/AI-Station/website/zongbaoshuo"
html = open(BASE + "/index.html", encoding="utf-8").read()

# 1) 标签配对
errs = []
for tag in ["section","div","span","figure","figcaption","ul","li","header","footer","nav","h1","h2","h3","h4","p","a","b","i","em","small","svg","g","canvas"]:
    o = len(re.findall(r"<%s(\s|>)" % tag, html)); c = len(re.findall(r"</%s>" % tag, html))
    if o != c: errs.append("%s %d/%d" % (tag, o, c))
print("TAG ERRORS:", errs or "NONE")

# 2) 重复 ID
ids = re.findall(r'id="([^"]+)"', html)
dup = [x for x in set(ids) if ids.count(x) > 1]
print("DUP IDS:", dup or "NONE")

# 3) 图片存在
imgs = re.findall(r'src="([^"]+\.(?:jpg|png))"', html)
missing = [i for i in set(imgs) if not os.path.exists(BASE + "/" + i)]
print("IMGS:", sorted(set(imgs)), "MISSING:", missing or "NONE")
print("SIZE:", os.path.getsize(BASE + "/index.html"), "bytes /", html.count("\n") + 1, "lines")
print("ROADSHOW:", re.findall(r'ROADSHOW 0\d', html))

from playwright.sync_api import sync_playwright
SECS = [("why","v6-d-why"),("market","v6-d-market"),("business","v6-d-business"),("team","v6-d-team"),("contact","v6-d-contact")]
with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    errors = []
    pg = b.new_page(viewport={"width":1440,"height":900})
    pg.on("pageerror", lambda e: errors.append(str(e)))
    pg.goto("file:///E:/AI-Station/website/zongbaoshuo/index.html", wait_until="networkidle")
    pg.wait_for_timeout(2200)  # 动画终态
    pg.screenshot(path="e:/AI-Station/v6-d-hero.png"); print("SHOT: v6-d-hero.png")
    for sec, fn in SECS:
        pg.evaluate("(id)=>{const el=document.getElementById(id);window.scrollTo({top:el.getBoundingClientRect().top+scrollY-70,behavior:'instant'})}", sec)
        pg.wait_for_timeout(800)
        pg.screenshot(path="e:/AI-Station/%s.png" % fn); print("SHOT:", fn)
    broken = pg.evaluate("()=>Array.from(document.images).filter(i=>i.complete&&i.naturalWidth===0).map(i=>i.src.split('/').pop())")
    print("BROKEN(after scroll):", broken or "NONE")
    print("JS ERRORS:", errors or "NONE")
    pg.close()
    # 移动端溢出
    m = b.new_page(viewport={"width":390,"height":844}, device_scale_factor=2)
    m.goto("file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1", wait_until="networkidle")
    m.wait_for_timeout(900)
    r = m.evaluate("()=>({sw:document.documentElement.scrollWidth,cw:document.documentElement.clientWidth})")
    print("M OVERFLOW:", r["sw"], ">", r["cw"], "=", r["sw"] > r["cw"])
    m.evaluate("()=>document.getElementById('why').scrollIntoView()"); m.wait_for_timeout(500)
    m.screenshot(path="e:/AI-Station/v6-m-why.png"); print("SHOT: v6-m-why.png")
    b.close()
print("V6 QA DONE")
