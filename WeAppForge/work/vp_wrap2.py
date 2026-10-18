# -*- coding: utf-8 -*-
import sys, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from DrissionPage import ChromiumPage

page = ChromiumPage('127.0.0.1:9336')
tab = page.new_tab('https://mp.weixin.qq.com/wxamp/subApp/skit/manage/goods?token=1577852751&lang=zh_CN')
tab.wait(8.0)

tree = tab.run_cdp('Page.getFrameTree').get('frameTree', {})
frames = []
def walk(node):
    f = node.get('frame', {})
    if f.get('id'):
        frames.append((f.get('id'), (f.get('url') or '')))
    for c in node.get('childFrames', []):
        walk(c)
walk(tree)
print('FRAMES:')
for fid, furl in frames:
    print('  ', furl[:110])

JS = r"""
(function(){
  var out = [];
  var ifs = document.querySelectorAll('iframe');
  for (var i = 0; i < ifs.length; i++) {
    var src = (ifs[i].src || '').slice(-70);
    try {
      var d = ifs[i].contentDocument;
      if (!d) { out.push('IF' + i + ' ' + src + ' NODOC'); continue; }
      var t = (d.body && d.body.innerText) || '';
      out.push('IF' + i + ' ' + src + ' LEN=' + t.length + '\n' + t.slice(0, 1800));
    } catch (e) { out.push('IF' + i + ' ' + src + ' ERR=' + e.message); }
  }
  return out.join('\n@@@@\n');
})()
"""
r = tab.run_cdp('Runtime.evaluate', expression=JS, returnByValue=True)
if r.get('exceptionDetails'):
    print('EXC:', json.dumps(r['exceptionDetails'])[:300])
print(str(r.get('result', {}).get('value', ''))[:4500])
tab.get_screenshot(path=r'E:\AI-Station\WeAppForge\work\vp_wrap2.png')
