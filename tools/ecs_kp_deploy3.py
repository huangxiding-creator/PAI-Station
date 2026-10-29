# -*- coding: utf-8 -*-
"""kunpeng-bid 部署 v3 — 云助手 RunCommand（本项目成熟链路）+ venv/systemd。

v1 教训: docker build 拉镜像超过 CommandTimeout(180s) → 改 venv+systemd（服务器自带 python3.12）。
"""
from __future__ import annotations

import base64
import io
import json
import subprocess
import sys
import tarfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

REGION, INSTANCE = 'cn-heyuan', 'i-f8za6qhv365cwhti5y35'
REPO = Path(r'E:\AI-Station\kunpeng-bid')
REMOTE_DIR = '/opt/kunpeng-bid'
SHARD = 16000


def _aliyun(*args: str) -> dict:
    last = None
    for attempt in range(4):
        r = subprocess.run(['aliyun', *args], capture_output=True, text=True, encoding='utf-8', errors='replace')
        if r.returncode == 0:
            try:
                return json.loads(r.stdout)
            except json.JSONDecodeError as e:
                last = e
        else:
            last = RuntimeError(f'aliyun {args[:3]} failed: {r.stdout[:200]} {r.stderr[:200]}')
        time.sleep(3 * (attempt + 1))
    raise last


def run(script: str, timeout: int = 600) -> tuple[int, str]:
    res = _aliyun('ecs', 'RunCommand', '--RegionId', REGION, '--InstanceId.1', INSTANCE,
                  '--Type', 'RunShellScript', '--Name', 'kp-deploy',
                  '--Timeout', str(timeout), '--ContentEncoding', 'Base64',
                  '--CommandContent', base64.b64encode(script.encode('utf-8')).decode('ascii'))
    inv = res['InvokeId']
    t0 = time.time()
    while time.time() - t0 < timeout + 60:
        time.sleep(6)
        d = _aliyun('ecs', 'DescribeInvocations', '--RegionId', REGION, '--InvokeId', inv)
        st = d['Invocations']['Invocation'][0]
        if st.get('InvocationStatus') in ('Success', 'Finished', 'Failed', 'Cancelled'):
            break
    rec = _aliyun('ecs', 'DescribeInvocationResults', '--RegionId', REGION, '--InvokeId', inv)
    r = rec['Invocation']['InvocationResults']['InvocationResult'][0]
    code = r.get('ExitCode', -1)
    out = base64.b64decode(r.get('Output', '') or '').decode('utf-8', 'replace')
    return code, out


def sh(name: str, script: str, timeout: int = 600) -> str:
    print(f'──── {name} ────', flush=True)
    code, out = run(script, timeout)
    print(out[-3500:] if len(out) > 3500 else out, flush=True)
    if code != 0:
        raise SystemExit(f'[ABORT] {name} ExitCode={code}')
    return out


def main():
    key = subprocess.run(
        ['py', '-c', "import sys; sys.path.insert(0, r'E:\\AI-Station\\kunpeng-bid');"
                     "from kunpeng.config import CONFIG; print(CONFIG['llm']['api_key'])"],
        capture_output=True, text=True, encoding='utf-8').stdout.strip()
    assert key, 'api key missing'

    skip = {'data', 'venv', '.git', '__pycache__', '.pytest_cache'}
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for p in sorted(REPO.rglob('*')):
            rel = p.relative_to(REPO)
            if p.is_file() and not (set(rel.parts) & skip) and 'config.local' not in p.name \
                    and not p.name.startswith('e2e_export'):
                tf.add(p, arcname=str(rel))
    b64 = base64.b64encode(buf.getvalue()).decode('ascii')
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f'payload {len(buf.getvalue())}B -> {len(shards)} shards', flush=True)

    sh('prep', f'systemctl stop kunpeng 2>/dev/null; rm -rf {REMOTE_DIR}; mkdir -p {REMOTE_DIR}; rm -f /tmp/kp.b64')
    for i, chunk in enumerate(shards):
        sh(f'shard {i+1}/{len(shards)}', f"printf '%s' '{chunk}' >> /tmp/kp.b64", timeout=120)

    sh('install', f'''
set -e
base64 -d /tmp/kp.b64 | tar xz -C {REMOTE_DIR}
rm -f /tmp/kp.b64
cd {REMOTE_DIR}
python3 -m venv venv
./venv/bin/pip install -q -r requirements.txt 2>&1 | tail -2
echo CFG > config.local.yaml.b64 && rm config.local.yaml.b64
printf 'llm:\\n  api_key: "{key}"\\n' > config.local.yaml
cat > /etc/systemd/system/kunpeng.service << UNIT
[Unit]
Description=Kunpeng Bid
After=network.target
[Service]
WorkingDirectory={REMOTE_DIR}
ExecStart={REMOTE_DIR}/venv/bin/hypercorn --bind 0.0.0.0:5100 --worker-class asyncio server:app
Restart=always
RestartSec=3
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now kunpeng
sleep 4
systemctl is-active kunpeng
curl -s http://127.0.0.1:5100/api/health && echo
''', timeout=600)

    # security group
    d = _aliyun('ecs', 'DescribeInstances', '--RegionId', REGION, '--InstanceIds', f'["{INSTANCE}"]')
    sg = d['Instances']['Instance'][0]['SecurityGroupIds']['SecurityGroupId'][0]
    subprocess.run(['aliyun', 'ecs', 'AuthorizeSecurityGroup', '--SecurityGroupId', sg,
                    '--IpProtocol', 'tcp', '--PortRange', '5100/5100',
                    '--SourceCidrIp', '0.0.0.0/0', '--Priority', '10'], capture_output=True)
    print('sg 5100 ensured')

    for _ in range(8):
        r = subprocess.run(['curl', '-s', '--max-time', '8', 'http://47.120.43.20:5100/api/health'],
                           capture_output=True, text=True)
        if 'ok' in r.stdout:
            print('\nPUBLIC OK ==>', r.stdout.strip())
            print('==> http://47.120.43.20:5100 <==')
            return
        time.sleep(4)
    raise SystemExit('[ABORT] public health failed')


if __name__ == '__main__':
    main()
