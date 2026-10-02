# -*- coding: utf-8 -*-
"""v7 验收：行话清零 + 冷门字符清零 + 图片变形测量 + 常规截图/溢出"""
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

# 3) 行话清零（大小写敏感）
jargon = ["尽调","路演","TAM","LTV","FERMI","费米","数据室","红队","ROADSHOW","经常性收入","收购溢价","DUE DILIGENCE","WHY NOW","MARKET SIZING","UNIT ECONOMICS","ACT NOW","STEP 0","审计","BP "]
left = [j for j in jargon if j in html]
print("JARGON LEFT:", left or "NONE")

# 4) 冷门字符清零（GBK 外字形 → 问号真凶）
cold = ["\u21b3","\u21ba","\u25c8","\u2713","\u00a7"]
coldleft = ["U+%04X" % ord(c) for c in cold if c in html]
print("COLD CHARS LEFT:", coldleft or "NONE")

# 5) 幕次齐全 + 新金句在位
print("ACTS:", sorted(set(re.findall(r'ACT 0\d', html))))
for kw in ["0PC","见面聊","想用、想聊、想合作","先泼三盆冷水","回头客飞轮","四重价值","总包说靠什么立足","三年时间差谁也抄不走","粮草先行十年","我们投的是粮草","LADDER 01","价值阶梯第八级","总包说科技","qrcode-zhiku.png","qrcode-brain-mini.png","shot-leopard.jpg","shot-factory-ui.jpg","shot-aipo.jpg","shot-station.jpg"]:
    print("KW [%s]:" % kw, "OK" if kw in html else "MISSING!")

# 6) 图片存在
imgs = re.findall(r'src="([^"]+\.(?:jpg|png))"', html)
missing = [i for i in set(imgs) if not os.path.exists(BASE + "/" + i)]
print("IMGS MISSING:", missing or "NONE")
print("SIZE:", os.path.getsize(BASE + "/index.html"), "bytes /", html.count("\n") + 1, "lines")

from playwright.sync_api import sync_playwright
with sync_playwright() as p:
    b = p.chromium.launch(args=["--window-position=-32000,-32000"])
    errors = []
    pg = b.new_page(viewport={"width":1440,"height":900})
    pg.on("pageerror", lambda e: errors.append(str(e)))
    pg.goto("file:///E:/AI-Station/website/zongbaoshuo/index.html", wait_until="networkidle")
    pg.wait_for_timeout(2200)
    pg.screenshot(path="e:/AI-Station/v7-d-hero.png"); print("SHOT: v7-d-hero.png")
    for sec, fn in [("glasses","v7-d-glasses"),("robot","v7-d-robot"),("team","v7-d-team"),("contact","v7-d-contact")]:
        pg.evaluate("(id)=>{const el=document.getElementById(id);window.scrollTo({top:el.getBoundingClientRect().top+scrollY-70,behavior:'instant'})}", sec)
        pg.wait_for_timeout(900)
        pg.screenshot(path="e:/AI-Station/%s.png" % fn); print("SHOT:", fn)
    # 图片变形测量：渲染宽高比 vs 原始宽高比
    dist = pg.evaluate("""()=>Array.from(document.images).map(i=>{
        const r=i.getBoundingClientRect();
        if(!i.naturalWidth||!r.width) return null;
        const nat=i.naturalWidth/i.naturalHeight, ren=r.width/r.height;
        return {img:i.src.split('/').pop(), nat:nat.toFixed(3), ren:ren.toFixed(3),
                pct:(Math.abs(nat-ren)/nat*100).toFixed(1)+'%'};
    }).filter(Boolean)""")
    bad = [d for d in dist if float(d["pct"][:-1]) > 2.0]
    print("IMG DISTORTION:", bad or "NONE (>2%)")
    for d in dist: print("  ", d)
    broken = pg.evaluate("()=>Array.from(document.images).filter(i=>i.complete&&i.naturalWidth===0).map(i=>i.src.split('/').pop())")
    print("BROKEN:", broken or "NONE")
    print("JS ERRORS:", errors or "NONE")
    pg.close()
    m = b.new_page(viewport={"width":390,"height":844}, device_scale_factor=2)
    m.goto("file:///E:/AI-Station/website/zongbaoshuo/index.html?qa=1", wait_until="networkidle")
    m.wait_for_timeout(900)
    r = m.evaluate("()=>({sw:document.documentElement.scrollWidth,cw:document.documentElement.clientWidth})")
    print("M OVERFLOW:", r["sw"], ">", r["cw"], "=", r["sw"] > r["cw"])
    b.close()
print("V7 QA DONE")
