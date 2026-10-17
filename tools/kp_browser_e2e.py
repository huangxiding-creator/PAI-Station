# -*- coding: utf-8 -*-
"""Browser-path final E2E: outline -> confirm -> body -> export readiness."""
import json
import time
import urllib.request
import websocket

ts = json.load(urllib.request.urlopen('http://127.0.0.1:9223/json/list'))
pg = next(t for t in ts if t.get('type') == 'page')
ws = websocket.create_connection(pg['webSocketDebuggerUrl'], timeout=60)
_id = [0]


def evaljs(expr, wait=False):
    _id[0] += 1
    ws.send(json.dumps({'id': _id[0], 'method': 'Runtime.evaluate',
                        'params': {'expression': expr, 'awaitPromise': wait, 'returnByValue': True}}))
    while True:
        m = json.loads(ws.recv())
        if m.get('id') == _id[0]:
            return m.get('result', {}).get('result', {}).get('value')


print('outline click:', evaljs("document.querySelector('#btnOutline').click(); 'ok'"))
t0 = time.time()
while time.time() - t0 < 180:
    time.sleep(10)
    st = evaljs("JSON.stringify({conf: !document.querySelector('#btnConfirm').classList.contains('hidden'), chapters: document.querySelectorAll('#outline > div').length, t: (document.querySelector('#btnOutline').textContent||'')})", False)
    print(f'[{time.time()-t0:5.0f}s]', st, flush=True)
    if '"conf":true' in st and '"chapters":' in st and '0' != st.split('"chapters":')[1][0]:
        break

print('confirm click:', evaljs("document.querySelector('#btnConfirm').click(); 'ok'"))
t0 = time.time()
last = ''
while time.time() - t0 < 1500:
    time.sleep(30)
    st = evaljs("JSON.stringify({progress: (document.querySelector('#progress').textContent||'').slice(0,80), cards: document.querySelectorAll('#body > div').length, exports: document.querySelectorAll('#exportBtns a').length})", False)
    if st != last:
        print(f'[{time.time()-t0:5.0f}s]', st, flush=True)
        last = st
    if '全部章节完成' in st:
        print('ALL DONE — browser E2E PASS', flush=True)
        break
print('final:', evaljs("(document.querySelector('#progress').textContent||'')", False))
