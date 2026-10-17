# -*- coding: utf-8 -*-
"""Remote full E2E executed server-locally (isolates my local network)."""
import base64
import sys
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from ecs_kp_deploy3 import run  # noqa: E402

# synthetic tender text (structured, ~900 chars)
TENDER = (
    '第一章 招标公告。项目名称：智慧水利监测平台建设项目。招标人：某市水务局。'
    '项目编号：ZHSL-2026-001。项目预算：980万元。工期：180日历天。质量标准：合格。'
    '投标保证金：18万元。资格审查方式：资格后审。评标办法：综合评标法，总分100分。'
    '第二章 评分办法。技术部分60分：施工组织设计25分，技术方案先进性与可行性15分，'
    '质量保证措施10分，安全文明施工10分。商务部分20分：项目管理机构10分（项目经理注册建造师'
    '水利水电专业二级及以上得5分，技术负责人高级职称得5分），企业类似业绩10分（2023年以来'
    '每项合同额300万以上水利信息化业绩得5分，最多10分）。报价部分20分：以有效投标报价平均值为'
    '基准价，每偏高1%扣0.5分，每偏低1%扣0.3分。第三章 技术要求。本项目建设内容包括水位监测站点'
    '42处、雨量站15处、视频监控12处、中心平台软件1套。要求采用物联网协议，数据采集频率不低于'
    '5分钟一次，平台支持GIS一张图展示。质保期3年。验收标准：符合SL 21-2015降水量观测规范、'
    'GB 50179水位观测标准。第四章 投标人资格要求。独立法人，具备电子与智能化工程专业承包二级'
    '及以上资质或水利工程施工总承包三级及以上资质，近三年无重大违法记录，项目经理无在建工程。'
) * 2

E2E = r'''
import json, time, urllib.request
BASE = 'http://127.0.0.1:5100'
def http(url, data=None, headers=None, method=None):
    req = urllib.request.Request(url, data=data, headers=headers or {}, method=method)
    with urllib.request.urlopen(req, timeout=1800) as r:
        return r.read()
def sse(url):
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req, timeout=1800) as r:
        buf = ''
        while True:
            chunk = r.read(8192)
            if not chunk: break
            buf += chunk.decode('utf-8', errors='replace')
            while '\n\n' in buf:
                raw, buf = buf.split('\n\n', 1)
                if raw.startswith('data:'):
                    try: yield json.loads(raw[5:])
                    except Exception: pass
t0 = time.time()
from docx import Document
d = Document()
for i in range(0, len(TENDER_TEXT), 500):
    d.add_paragraph(TENDER_TEXT[i:i+500])
d.save('/tmp/real_tender.docx')
body = open('/tmp/real_tender.docx','rb').read()
b = '----kp42'
parts = (f'--{b}\r\nContent-Disposition: form-data; name="file"; filename="tender.docx"\r\nContent-Type: application/octet-stream\r\n\r\n').encode() + body + f'\r\n--{b}--\r\n'.encode()
up = json.loads(http(BASE+'/api/upload', data=parts, headers={'Content-Type': f'multipart/form-data; boundary={b}'}, method='POST'))
assert up['code']==200, up
cid = up['cid']
print(f'[{time.time()-t0:6.1f}s] upload ok')
pd = set()
for ev in sse(f'{BASE}/api/task/{cid}/stream/explain'):
    if ev.get('event')=='part_done': pd.add(ev['part']); print(f'[{time.time()-t0:6.1f}s] explain {ev["part"]}: {ev["chars"]}c')
    elif ev.get('event')=='done': break
    elif ev.get('event')=='error': raise SystemExit('explain err '+str(ev))
assert len(pd)==3
tree=None
for ev in sse(f'{BASE}/api/task/{cid}/stream/outline'):
    if ev.get('event')=='done': tree=ev['outline']; break
    elif ev.get('event')=='error': raise SystemExit('outline err '+str(ev))
print(f'[{time.time()-t0:6.1f}s] outline {len(tree)} ch')
http(f'{BASE}/api/task/{cid}/outline', data=json.dumps({'outline':tree,'confirmed':True}).encode(), headers={'Content-Type':'application/json'}, method='PUT')
done=0; total=len(tree); tb=time.time()
for ev in sse(f'{BASE}/api/task/{cid}/stream/body'):
    if ev.get('event')=='section_done':
        done+=1; print(f'[{time.time()-t0:6.1f}s] ch {done}/{total}: {ev["title"][:20]} ({ev["chars"]}c)')
    elif ev.get('stage')=='review': print(f'    review-loop {ev.get("section_id","")[-3:]}')
    elif ev.get('event')=='all_done': break
    elif ev.get('event')=='error': print('    sec-err:', ev.get('message'))
assert done==total, f'{done}/{total}'
for st in ('blue','red'):
    blob = http(f'{BASE}/api/task/{cid}/export?style={st}')
    open(f'/tmp/e2e_{st}.docx','wb').write(blob)
    print(f'[{time.time()-t0:6.1f}s] export {st}: {len(blob)}B')
print(f'REMOTE-E2E-PASS {total}ch body={time.time()-tb:.0f}s total={time.time()-t0:.0f}s')
'''

# build remote script (ASCII contract): python code + tender b64 via env-like prefix
script = (
    'cd /opt/kunpeng-bid && cat > /tmp/e2e.py << \'PYEOF\'\n'
    'import base64\nTENDER_TEXT = base64.b64decode("' + base64.b64encode(TENDER.encode('utf-8')).decode('ascii') + '").decode("utf-8")\n'
    + E2E +
    '\nPYEOF\n'
    'rm -f /tmp/e2e.out /tmp/e2e.done\n'
    'nohup sh -c \'./venv/bin/python /tmp/e2e.py > /tmp/e2e.out 2>&1; echo DONE=$? > /tmp/e2e.done\' >/dev/null 2>&1 &\n'
    'echo LAUNCHED\n'
)
code, out = run(script, timeout=180)
print(out, 'EXIT', code)
if 'LAUNCHED' not in out:
    raise SystemExit('launch failed')

import time as _t
for i in range(90):
    _t.sleep(20)
    code, out = run('cat /tmp/e2e.done 2>/dev/null; tail -c 1200 /tmp/e2e.out 2>/dev/null', timeout=120)
    print(f'[poll {i+1}]', out[-600:], flush=True)
    if 'DONE=' in out:
        print('=== FINAL ===')
        code, out = run('cat /tmp/e2e.out', timeout=180)
        print(out)
        break
