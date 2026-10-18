# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.new_tab('https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token=1577852751&lang=zh_CN')
tab.wait(4.0)

# wujie 微前端：raw CDP 递归 iframe 取 body innerText
res = tab.run_cdp('Page.getFrameTree')
tree = res.get('frameTree', {})
frames = []
def walk(node):
    f = node.get('frame', {})
    if f.get('id'): frames.append((f.get('id'), (f.get('url') or '')[:100]))
    for c in node.get('childFrames', []): walk(c)
walk(tree)
out = ['FRAMES: ' + str(len(frames))]
for fid, furl in frames:
    out.append('  ' + furl)
for fid, furl in frames:
    try:
        r = tab.run_cdp('Runtime.evaluate',
                        expression='document.body ? document.body.innerText.slice(0, 2500) : "NOBODY"',
                        returnByValue=True, contextId=None) if False else None
    except Exception:
        pass
# Runtime.evaluate 默认主帧；逐 iframe 用 Session 绑定太重——先看主帧文本
r = tab.run_cdp('Runtime.evaluate',
                expression='document.body ? document.body.innerText.slice(0, 3000) : "NOBODY"',
                returnByValue=True)
out.append('=== MAIN FRAME TEXT ===')
out.append(str(r.get('result', {}).get('value', ''))[:3000])
print('\n'.join(out))
tab.get_screenshot(path=r'E:\AI-Station\WeAppForge\work\vp_goods.png')
