# -*- coding: utf-8 -*-
"""env=0 部署验证:等新版本 normal+HasTraffic -> EnvParams 比对 -> health 200。"""
import json, subprocess, sys, time, urllib.request

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

NPM = r'C:\Users\91216\AppData\Roaming\npm\tcb.cmd'


def tcb_json(args):
    r = subprocess.run([NPM] + args, capture_output=True, text=True,
                       encoding='utf-8', errors='replace', timeout=120)
    try:
        return json.loads(r.stdout)
    except Exception:  # noqa: BLE001
        print('RAW:', (r.stdout or r.stderr)[:400], flush=True)
        return None


# ── 1) 等部署 normal(最多 8 分钟)──
deadline = time.time() + 480
ok = False
while time.time() < deadline:
    d = tcb_json(['cloudrun', 'detail', '-s', 'qianwen-engine', '--json'])
    if d:
        info = (d.get('data') or {}).get('OnlineVersionInfos') or []
        base = (d.get('data') or {}).get('BaseInfo') or {}
        ver = info[0].get('VersionName', '?') if info else '?'
        print('status=%s ver=%s upd=%s' % (base.get('Status'), ver,
              base.get('UpdateTime')), flush=True)
        # 新版本号 > 009 且 normal 即新部署生效
        if base.get('Status') == 'normal' and ver > 'qianwen-engine-009':
            ok = True
            break
    time.sleep(30)
print('DEPLOY NORMAL:', ok, flush=True)

# ── 2) EnvParams b64 双解比对 env 行──
d = tcb_json(['cloudrun', 'detail', '-s', 'qianwen-engine', '--json'])
import base64
if d:
    ep = json.loads((d.get('data') or {}).get('ServerConfig', {}).get('EnvParams') or '{}')
    inner = base64.b64decode(ep['SECRET_FILES_B64']).decode('utf-8')
    files = json.loads(inner)
    vp = base64.b64decode(files['virtual_pay.secret']).decode('utf-8')
    env_line = [l for l in vp.splitlines() if l.startswith('env=')]
    print('LIVE virtual_pay env:', env_line, flush=True)
else:
    print('detail read FAILED', flush=True)

# ── 3) health 200──
for url in ('https://ai.epcschool.top/api/health',
            'https://ai.epcschool.top/api/reports'):
    try:
        req = urllib.request.Request(url, headers={'User-Agent': 'curl/8'})
        with urllib.request.urlopen(req, timeout=30) as resp:
            body = resp.read()[:120]
            print(url, '->', resp.status, body[:80], flush=True)
    except Exception as e:  # noqa: BLE001
        print(url, 'ERR', str(e)[:150], flush=True)
