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

r = tab.run_cdp('DOM.getDocument', depth=-1, pierce=True)
root = r.get('root', {})

lines = []
def walk(node, depth):
    name = node.get('nodeName', '')
    nid = node.get('nodeId', 0)
    attrs = node.get('attributes') or []
    astr = ''
    if attrs:
        astr = ' ' + ' '.join(attrs[i] + '="' + attrs[i + 1][:50] + '"' for i in range(0, len(attrs), 2))
    txt = ''
    if name == '#text':
        txt = (node.get('nodeValue') or '').strip()
        if txt:
            lines.append('  ' * depth + '"' + txt[:80] + '"')
        return
    lines.append('  ' * depth + name + astr + ' #' + str(nid))
    for c in node.get('children', []) or []:
        walk(c, depth + 1)
    for c in node.get('shadowRoots', []) or []:
        lines.append('  ' * (depth + 1) + '<<SHADOWROOT ' + name + '>>')
        walk(c, depth + 2)
    cd = node.get('contentDocument')
    if cd:
        lines.append('  ' * (depth + 1) + '<<CONTENTDOC ' + name + '>>')
        walk(cd, depth + 2)

walk(root, 0)
out = '\n'.join(lines)
open('E:/AI-Station/WeAppForge/work/vp_tree.txt', 'w', encoding='utf-8').write(out)
print('tree lines:', len(lines), 'chars:', len(out), '-> vp_tree.txt')

# 关键词行预览
for i, l in enumerate(lines):
    if any(k in l for k in ('report_', 'export_once', '上架', '发布', '未上架', '体验版', '已通过', '审核')):
        print(l[:150])
