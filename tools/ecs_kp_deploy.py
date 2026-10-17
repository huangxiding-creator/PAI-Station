# -*- coding: utf-8 -*-
"""kunpeng-bid ECS 部署编排器（复用 ecs_qw.run 云助手链路）。

链路: 本地打包源码(tar.gz→b64 分片) → 远端落位 /opt/kunpeng-bid → docker build
      → docker run -p 5100 --restart always → 安全组放行 5100 → 公网健康检查。
契约: 复用 RunCommand 24KB 上限（SHARD=16000 b64 字符）；fail-fast。
"""
from __future__ import annotations

import base64
import io
import subprocess
import sys
import tarfile
from pathlib import Path

REPO = Path(r'E:\AI-Station\kunpeng-bid')
sys.path.insert(0, str(Path(__file__).resolve().parent))
from ecs_qw import run  # noqa: E402

SHARD = 16000
REMOTE_B64 = '/opt/kunpeng_src.b64'
CONTAINER = 'kunpeng-bid'


def sh(name: str, script: str) -> str:
    print(f'──── {name} ────')
    code, out = run(script)
    print(out[-4000:] if len(out) > 4000 else out)
    if code != 0:
        raise SystemExit(f'[ABORT] {name} ExitCode={code}')
    return out


def main() -> None:
    key = subprocess.run(
        ['py', '-c', "import sys; sys.path.insert(0, r'E:\\AI-Station\\kunpeng-bid');"
                     "from kunpeng.config import CONFIG; print(CONFIG['llm']['api_key'])"],
        capture_output=True, text=True, encoding='utf-8').stdout.strip()
    assert key, 'api key missing'

    # 1) pack source (code only, no data/venv/git)
    skip_parts = {'data', 'venv', '.git', '__pycache__', '.pytest_cache', 'e2e_export_blue.docx', 'e2e_export_red.docx'}
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for p in sorted(REPO.rglob('*')):
            rel = p.relative_to(REPO)
            if p.is_file() and not (set(rel.parts) & skip_parts) and 'config.local' not in p.name:
                tf.add(p, arcname=str(rel))
    payload = buf.getvalue()
    b64 = base64.b64encode(payload).decode('ascii')
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f'payload {len(payload)}B gz -> {len(shards)} shards')

    # 2) upload shards
    sh('clean', f'rm -rf /opt/kunpeng-bid {REMOTE_B64} && mkdir -p /opt/kunpeng-bid')
    for i, chunk in enumerate(shards):
        sh(f'shard {i+1}/{len(shards)}', f"printf '%s' '{chunk}' >> {REMOTE_B64}")

    # 3) unpack + docker build + run
    sh('unpack+build+run', f'''
set -e
base64 -d {REMOTE_B64} | tar xz -C /opt/kunpeng-bid
rm -f {REMOTE_B64}
cd /opt/kunpeng-bid
docker rm -f {CONTAINER} 2>/dev/null || true
docker rmi kunpeng-bid:1 2>/dev/null || true
docker build -t kunpeng-bid:1 -f deploy/Dockerfile.local . 2>&1 | tail -5
docker run -d --name {CONTAINER} --restart always -p 5100:5100 \\
  -e ZHIPU_API_KEY='{key}' kunpeng-bid:1
sleep 3
docker ps --filter name={CONTAINER} --format '{{{{.Status}}}}'
curl -s http://127.0.0.1:5100/api/health && echo
''')

    # 4) security group: allow 5100
    sg = subprocess.run(['aliyun', 'ecs', 'DescribeInstances', '--RegionId', 'cn-heyuan',
                         '--InstanceIds', '["i-f8za6qhv365cwhti5y35"]'],
                        capture_output=True, text=True, encoding='utf-8')
    import json
    inst = json.loads(sg.stdout)['Instances']['Instance'][0]
    sg_id = inst.get('SecurityGroupIds', {}).get('SecurityGroupId', []) or [inst.get('SecurityGroupIds', {}).get('SecurityGroupId')]
    sg_id = sg_id[0] if isinstance(sg_id, list) else sg_id
    print('security group:', sg_id)
    subprocess.run(['aliyun', 'ecs', 'AuthorizeSecurityGroup', '--SecurityGroupId', sg_id,
                    '--IpProtocol', 'tcp', '--PortRange', '5100/5100',
                    '--SourceCidrIp', '0.0.0.0/0', '--Priority', '10'],
                   capture_output=True, text=True)
    print('security group rule ensured (5100/tcp)')

    # 5) public health
    import time
    for i in range(6):
        try:
            r = subprocess.run(['curl', '-s', '--max-time', '8', 'http://47.120.43.20:5100/api/health'],
                               capture_output=True, text=True)
            if 'ok' in r.stdout:
                print('PUBLIC HEALTH OK:', r.stdout.strip())
                print('\n==> http://47.120.43.20:5100 <==')
                return
        except Exception:
            pass
        time.sleep(5)
    raise SystemExit('[ABORT] public health check failed')


if __name__ == '__main__':
    main()
