# -*- coding: utf-8 -*-
"""kunpeng-bid 部署 v2 — 复用 Auto_Manus/ecs_exec.py 的 SSH+SFTP 直连模式。

链路: 本地 tar.gz → SFTP 上传 → SSH: venv+pip+systemd(kunpeng.service)
      → 安全组 5100 → 公网健康检查。
"""
from __future__ import annotations

import io
import json
import subprocess
import sys
import tarfile
import time
from pathlib import Path

import paramiko

sys.stdout.reconfigure(encoding="utf-8", errors="replace")
REPO = Path(r'E:\AI-Station\kunpeng-bid')
HOST, USER = '47.120.43.20', 'root'
PW = json.loads((Path(r'E:\AI-Station\data\secrets\aliyun_ecs_password.json')).read_text(encoding='utf-8'))['password']
REMOTE_DIR = '/opt/kunpeng-bid'


def cli() -> paramiko.SSHClient:
    c = paramiko.SSHClient()
    c.set_missing_host_key_policy(paramiko.AutoAddPolicy())
    c.connect(HOST, username=USER, password=PW, timeout=15)
    return c


def run(c, cmd: str, timeout: int = 300) -> tuple[int, str]:
    _, out, err = c.exec_command(cmd, timeout=timeout)
    o = out.read().decode('utf-8', 'replace')
    e = err.read().decode('utf-8', 'replace')
    code = out.channel.recv_exit_status()
    txt = (o + ('\n[stderr]\n' + e if e else '')).strip()
    print(txt[-3500:] if len(txt) > 3500 else txt)
    return code, txt


def sh(c, name, cmd, timeout=300):
    print(f'──── {name} ────')
    code, _ = run(c, cmd, timeout)
    if code != 0:
        raise SystemExit(f'[ABORT] {name} ExitCode={code}')


def main():
    key = subprocess.run(
        ['py', '-c', "import sys; sys.path.insert(0, r'E:\\AI-Station\\kunpeng-bid');"
                     "from kunpeng.config import CONFIG; print(CONFIG['llm']['api_key'])"],
        capture_output=True, text=True, encoding='utf-8').stdout.strip()
    assert key

    # 1) pack
    skip = {'data', 'venv', '.git', '__pycache__', '.pytest_cache'}
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for p in sorted(REPO.rglob('*')):
            rel = p.relative_to(REPO)
            if p.is_file() and not (set(rel.parts) & skip) and 'config.local' not in p.name \
                    and not p.name.startswith('e2e_export'):
                tf.add(p, arcname=str(rel))
    pkg = REPO / 'kp_src.tar.gz'
    pkg.write_bytes(buf.getvalue())
    print(f'packed {len(buf.getvalue())}B')

    c = cli()
    try:
        # 2) upload
        sftp = c.open_sftp()
        sftp.put(str(pkg), '/tmp/kp_src.tar.gz')
        sftp.close()
        print('[put] ok')

        # 3) install
        sh(c, 'stop-old', f'systemctl stop kunpeng 2>/dev/null; rm -rf {REMOTE_DIR}; mkdir -p {REMOTE_DIR}')
        sh(c, 'unpack', f'tar xzf /tmp/kp_src.tar.gz -C {REMOTE_DIR} && ls {REMOTE_DIR}')
        sh(c, 'venv', f'cd {REMOTE_DIR} && (python3 -m venv venv 2>/dev/null || true) && '
                      f'./venv/bin/pip install -q -r requirements.txt 2>&1 | tail -3 && echo PIP_OK', timeout=600)
        sh(c, 'config', f"cat > {REMOTE_DIR}/config.local.yaml << 'YAML'\nllm:\n  api_key: \"{key}\"\nYAML\necho CFG_OK")
        sh(c, 'systemd', f'''
cat > /etc/systemd/system/kunpeng.service << 'UNIT'
[Unit]
Description=Kunpeng Bid (Xique clone)
After=network.target
[Service]
WorkingDirectory={REMOTE_DIR}
ExecStart={REMOTE_DIR}/venv/bin/python server.py
Restart=always
RestartSec=3
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now kunpeng
sleep 3
systemctl status kunpeng --no-pager | head -6
curl -s http://127.0.0.1:5100/api/health && echo
''')

        # 4) security group 5100
        r = subprocess.run(['aliyun', 'ecs', 'AuthorizeSecurityGroup', '--SecurityGroupId',
                            _sg_id(), '--IpProtocol', 'tcp', '--PortRange', '5100/5100',
                            '--SourceCidrIp', '0.0.0.0/0', '--Priority', '10'],
                           capture_output=True, text=True)
        print('sg:', (r.stdout or r.stderr)[:120])

        # 5) public health
        for i in range(8):
            rr = subprocess.run(['curl', '-s', '--max-time', '8', 'http://47.120.43.20:5100/api/health'],
                                capture_output=True, text=True)
            if 'ok' in rr.stdout:
                print('\nPUBLIC HEALTH OK ==>', rr.stdout.strip())
                print('==> http://47.120.43.20:5100 <==')
                return
            time.sleep(4)
        raise SystemExit('[ABORT] public health failed')
    finally:
        c.close()


def _sg_id() -> str:
    r = subprocess.run(['aliyun', 'ecs', 'DescribeInstances', '--RegionId', 'cn-heyuan',
                        '--InstanceIds', '["i-f8za6qhv365cwhti5y35"]'],
                       capture_output=True, text=True, encoding='utf-8')
    ids = json.loads(r.stdout)['Instances']['Instance'][0]['SecurityGroupIds']['SecurityGroupId']
    return ids[0]


if __name__ == '__main__':
    main()
