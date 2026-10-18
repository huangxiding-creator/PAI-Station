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

# 穿透 closed shadow + iframe 的完整节点树
r = tab.run_cdp('DOM.getDocument', depth=-1, pierce=True)
root = r.get('root', {})

hits = []
def walk(node, path):
    name = node.get('nodeName', '')
    nid = node.get('nodeId', 0)
    if name in ('#text',):
        v = (node.get('nodeValue') or '').strip()
        if v and any(k in v for k in ('发布', '上架', '保存', '取消', '编辑', '道具', 'report_', '体验版')):
            hits.append((path, 'TEXT', v[:60], nid))
    attrs = node.get('attributes') or []
    for i in range(0, len(attrs) - 1, 2):
        if attrs[i] in ('id', 'class'):
            val = attrs[i + 1]
            if any(k in val for k in ('btn', 'modal', 'dialog', 'publish', 'edit')):
                hits.append((path, 'ATTR', attrs[i] + '=' + val[:60], nid))
    for c in node.get('children', []) or []:
        walk(c, path + '/' + name)
    # shadow root 子树
    for c in node.get('shadowRoots', []) or []:
        walk(c, path + '/' + name + '<<SH')
    # iframe 内容文档
    for c in node.get('contentDocument', []) and [node.get('contentDocument')] or []:
        walk(c, path + '/' + name + '<<CD')

walk(root, '')
print('total hits:', len(hits))
for h in hits[:80]:
    print(h[3], '|', h[1], '|', h[2], ' @', h[0][-90:])
