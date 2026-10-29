# -*- coding: utf-8 -*-
"""kp_e2e_tail — 续跑E2E尾部六关(ppt/三导出/编辑器×2), 与已绿的七关合成13关全证"""
from __future__ import annotations

import json
import subprocess
import sys
import time
from urllib.parse import quote

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

BASE = 'http://47.120.43.20:5100'
CID = sys.argv[1] if len(sys.argv) > 1 else '3ea5cc70cc394a949e222de72d2f0c6d'
results = []


def sh(cmd, timeout=60):
    r = subprocess.run(cmd, capture_output=True, text=True, encoding='utf-8',
                       errors='replace', timeout=timeout)
    return r.returncode, (r.stdout or '')


def rec(name, ok, note=''):
    results.append((name, ok, note))
    print(f'{"✔" if ok else "✘"} {name} {note}', flush=True)


def task():
    return json.loads(sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{CID}'], 30)[1])


t0 = time.time()

# 1) ppt: EventSource式重连 + GET轮询(孤儿安全版管线,断流不停)
TERMS = ('"event": "ppt_done"',)
ppt_ok = False
note = ''
deadline = time.time() + 600
while time.time() < deadline:
    rc, out = sh(['curl', '-s', '-N', '--max-time', '300',
                  f'{BASE}/api/task/{CID}/stream/ppt'], 315)
    lines = [l for l in (out or '').splitlines() if l.startswith('data:')]
    if any(any(t in l for t in TERMS) for l in lines):
        ppt_ok = True
        note = f'events={len(lines)} tail={lines[-1][:80]}'
        break
    # 连接结束后轮询落库(孤儿管线可能在跑)
    for _ in range(12):
        rc2, out2 = sh(['curl', '-s', '--max-time', '15', f'{BASE}/api/task/{CID}/ppt'], 30)
        if '"code":200' in out2:
            ppt_ok = True
            note = f'via-store-poll events={len(lines)}'
            break
        time.sleep(5)
    if ppt_ok:
        break
    if '"event": "error"' in (out or '') and '请先生成标书正文' in (out or ''):
        break
    time.sleep(1)
rec('ppt(SSE+GET)', ppt_ok, note)

# 2) 三导出
for label, url, magic in [
    ('export-docx', f'{BASE}/api/task/{CID}/export?style=blue', b'PK'),
    ('export-pdf', f'{BASE}/api/task/{CID}/export/pdf', b'%PDF'),
    ('export-pptx', f'{BASE}/api/task/{CID}/ppt/export?style=blue', b'PK'),
]:
    r = subprocess.run(['curl', '-s', '--max-time', '60', url], capture_output=True, timeout=90)
    ok = r.returncode == 0 and len(r.stdout) > 4000 and r.stdout.startswith(magic)
    rec(label, ok, f'{len(r.stdout)}B magic={r.stdout[:4]}')

# 3) 编辑器两关
secs = (task().get('sections') or [])
sid = quote(secs[0]['id'], safe='') if secs else ''
rc, out = sh(['curl', '-s', '--max-time', '90', '-X', 'POST', '-H', 'Content-Type: application/json',
              '-d', json.dumps({'action': 'polish', 'text': '渠道衬砌采用C25现浇混凝土，厚度十厘米，底部铺设复合土工膜防渗。'}, ensure_ascii=False),
              f'{BASE}/api/task/{CID}/edit/{sid}'], 120)
try:
    ok_edit = json.loads(out).get('code') == 200
except Exception:
    ok_edit = False
rec('editor-ai-edit', ok_edit, out[:80])

rc, out = sh(['curl', '-s', '--max-time', '30', '-X', 'POST', '-H', 'Content-Type: application/json',
              '-d', json.dumps({'content': 'E2E尾部回写验证段落：本段由kp_e2e_tail写入。'}, ensure_ascii=False),
              f'{BASE}/api/task/{CID}/save/{sid}'], 60)
rec('editor-save', rc == 0 and '"code":200' in out, out[:60])

n_pass = sum(1 for _, ok, _ in results if ok)
print(f'\n[TAIL {"PASS" if n_pass == len(results) else "FAIL"}] {n_pass}/{len(results)} · {time.time()-t0:.0f}s · cid={CID}', flush=True)
sys.exit(0 if n_pass == len(results) else 1)
