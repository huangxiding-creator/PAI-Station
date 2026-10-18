# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or '') and 'xframe' not in (t.url or ''):
        tab = t
        break

tree = tab.run_cdp('Page.getFrameTree').get('frameTree', {})
frames = []
def walk(node, depth):
    f = node.get('frame', {})
    frames.append((depth, f.get('id'), f.get('url') or '', f.get('name') or ''))
    for c in node.get('childFrames', []):
        walk(c, depth + 1)
walk(tree, 0)
for d, fid, furl, name in frames:
    print('  ' * d + 'id=' + fid[:12] + ' name=' + name[:20] + ' url=' + furl[:120])
