# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = None
for t in page.get_tabs():
    if 'subApp/skit/manage/goods' in (t.url or ''):
        tab = t
        break

r = tab.run_cdp('DOM.getDocument', depth=-1, pierce=True)
root = r.get('root', {})

# 收集所有含目标文本/类名的节点
hits = []
def walk(node, path):
    name = node.get('nodeName', '')
    nid = node.get('nodeId', 0)
    if name == '#text':
        v = (node.get('nodeValue') or '').strip()
        if v and any(k in v for k in ('上架', '发布', '编辑', '道具', 'report_', 'export_once', 'unlock_once', '体验版', '新增')):
            hits.append((nid, 'TEXT', v[:70], path[-80:]))
        return
    attrs = node.get('attributes') or []
    amap = {}
    for i in range(0, len(attrs) - 1, 2):
        amap[attrs[i]] = attrs[i + 1]
    cls = amap.get('class', '')
    if name == 'BUTTON' or 'btn' in cls or 'table' in cls or 'modal' in cls or 'dialog' in cls:
        hits.append((nid, name, 'class=' + cls[:60], path[-80:]))
    for c in node.get('children', []) or []:
        walk(c, path + '/' + name)
    for c in node.get('shadowRoots', []) or []:
        walk(c, path + '/' + name + '<<SH')
    cd = node.get('contentDocument')
    if cd:
        walk(cd, path + '/' + name + '<<CD')

walk(root, '')
print('hits:', len(hits))
for h in hits[:70]:
    print(h[0], '|', h[1], '|', h[2], ' @', h[3])
