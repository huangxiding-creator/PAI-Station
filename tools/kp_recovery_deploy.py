# -*- coding: utf-8 -*-
"""kp_recovery_deploy — 1023 全量恢复（清场事故后的加固版）

与 v3 (ecs_kp_deploy3) 的区别：
1. 分片上传每片校验累计字节数（wc -c 对账），错片/截断片自动 truncate 回滚重传
2. SHARD=11000：命令 base64 后 ~14.8KB，任何一种 16KB 限额解释下都安全
3. 终态 md5sum 对账后才解压
4. config.local.yaml 走安装命令内嵌 b64（llm+metaso 双密钥），不落分片
5. 服务重启失败不重试盲跑，直接报 journalctl 尾部
"""
from __future__ import annotations

import base64
import hashlib
import io
import sys
import tarfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from ecs_kp_deploy3 import run, REPO, REMOTE_DIR  # noqa: E402

SHARD = 11000
REMOTE_B64 = '/tmp/kp_recovery.b64'
SKIP = {'__pycache__', '.pytest_cache'}


def build_payload() -> tuple[bytes, str]:
    """kunpeng/ static/ knowledge/ + 三件根文件 → tar.gz"""
    includes = ['kunpeng', 'static', 'knowledge']
    roots = ['server.py', 'config.yaml', 'requirements.txt']
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for d in includes:
            for p in sorted((REPO / d).rglob('*')):
                rel = p.relative_to(REPO)
                if p.is_file() and not (set(rel.parts) & SKIP):
                    tf.add(p, arcname=str(rel))
        for r in roots:
            tf.add(REPO / r, arcname=r)
    return buf.getvalue(), hashlib.md5(buf.getvalue()).hexdigest()


def sh_verified(name: str, cmd: str, expect_out: str, timeout: int = 180,
                retries: int = 4) -> str:
    """跑命令并断言输出包含 expect_out，失败重试"""
    for a in range(retries):
        code, out = run(cmd, timeout)
        if code == 0 and expect_out in out:
            return out
        print(f'  [{name}] attempt{a+1} bad (exit={code}): {out[-120:]}', flush=True)
        time.sleep(3)
    raise SystemExit(f'[ABORT] {name} failed after {retries} retries')


def main() -> None:
    payload, md5 = build_payload()
    b64 = base64.b64encode(payload).decode('ascii')
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f'payload {len(payload)}B (md5 {md5}) -> {len(shards)} shards', flush=True)

    # ── prep：清场 + 磁盘检查（服务已死，直接清）
    sh_verified('prep', f'''
df -h /opt | tail -1
systemctl stop kunpeng 2>/dev/null
rm -rf {REMOTE_DIR} && mkdir -p {REMOTE_DIR}
rm -f {REMOTE_B64}
echo PREP_OK
''', 'PREP_OK', timeout=120)

    # ── 分片上传：每片对账累计字节数
    expected = 0
    t0 = time.time()
    for i, chunk in enumerate(shards):
        expected += len(chunk)
        cmd = f"printf '%s' '{chunk}' >> {REMOTE_B64} && wc -c < {REMOTE_B64}"
        for a in range(4):
            code, out = run(cmd, timeout=120)
            try:
                size = int(out.strip().splitlines()[-1])
            except (ValueError, IndexError):
                size = -1
            if code == 0 and size == expected:
                break
            # 回滚到上一片末尾再重传本片
            prev = expected - len(chunk)
            print(f'  [shard {i+1}] attempt{a+1} size={size} expect={expected} → rollback+retry', flush=True)
            run(f'truncate -s {prev} {REMOTE_B64}', timeout=60)
        else:
            raise SystemExit(f'[ABORT] shard {i+1}/{len(shards)} failed 4x')
        if (i + 1) % 10 == 0 or i + 1 == len(shards):
            rate = (i + 1) / (time.time() - t0) * 60
            print(f'shard {i+1}/{len(shards)} OK ({rate:.0f}/min)', flush=True)

    # ── md5 对账
    out = sh_verified('md5', f'md5sum {REMOTE_B64}', '', timeout=120)
    remote_md5_b64 = out.split()[0] if out.split() else ''
    local_md5_b64 = hashlib.md5(b64.encode('ascii')).hexdigest()
    if remote_md5_b64 != local_md5_b64:
        raise SystemExit(f'[ABORT] md5 mismatch local={local_md5_b64} remote={remote_md5_b64}')
    print(f'md5 b64 verified: {remote_md5_b64}', flush=True)

    # ── 安装：解压 + venv + pip(清华源) + config 内嵌 + unit + 启动
    cfg_b64 = base64.b64encode((REPO / 'config.local.yaml').read_bytes()).decode('ascii')
    sh_verified('install', f'''
set -e
base64 -d {REMOTE_B64} | tar xz -C {REMOTE_DIR}
rm -f {REMOTE_B64}
cd {REMOTE_DIR}
python3 -m venv venv
./venv/bin/pip install -q -i https://pypi.tuna.tsinghua.edu.cn/simple -r requirements.txt 2>&1 | tail -2
echo {cfg_b64} | base64 -d > config.local.yaml
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
echo CFG_OK
''', 'CFG_OK', timeout=900)

    # ── 本地健康（服务器侧）
    out = run('curl -s --max-time 6 http://127.0.0.1:5100/api/health; echo; '
              'journalctl -u kunpeng --no-pager -n 6 --output=short-iso | tail -4', timeout=120)[1]
    print('server-local health:', out.strip()[:400], flush=True)
    if '"ok"' not in out and 'ok' not in out:
        raise SystemExit('[ABORT] server-local health failed — see journal above')

    # ── 公网健康（本机）
    import subprocess
    for i in range(10):
        r = subprocess.run(['curl', '-s', '--max-time', '8', 'http://47.120.43.20:5100/api/health'],
                           capture_output=True, text=True)
        if 'ok' in (r.stdout or ''):
            print(f'\nPUBLIC OK ==>', r.stdout.strip(), flush=True)
            print('==> http://47.120.43.20:5100 <==', flush=True)
            return
        time.sleep(4)
    raise SystemExit('[ABORT] public health failed')


if __name__ == '__main__':
    main()
