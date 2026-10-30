# -*- coding: utf-8 -*-
"""kp_push_files — 受控文件级补丁推送（取代无校验的 kp_patch_deploy）

用法: py kp_push_files.py file1,file2,...
- tar 打包指定文件 → 校验分片上传（每片 wc -c 对账 + truncate 回滚重传）
- md5 终检 → 解压覆盖 /opt/kunpeng-bid → restart → 本地+公网健康
- 不碰 venv/pip（只适合代码/静态文件补丁）
"""
from __future__ import annotations

import base64
import hashlib
import io
import subprocess
import sys
import tarfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from ecs_kp_deploy3 import run, REPO, REMOTE_DIR  # noqa: E402

SHARD = 11000
REMOTE_B64 = '/tmp/kp_push.b64'

if len(sys.argv) < 2:
    raise SystemExit('usage: py kp_push_files.py file1,file2,...')
FILES = [f.strip() for f in sys.argv[1].split(',') if f.strip()]


def main() -> None:
    missing = [f for f in FILES if not (REPO / f).exists()]
    if missing:
        raise SystemExit(f'[ABORT] local files missing: {missing}')

    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for rel in FILES:
            tf.add(REPO / rel, arcname=rel)
    payload = buf.getvalue()
    b64 = base64.b64encode(payload).decode('ascii')
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f'push {FILES} payload {len(payload)}B -> {len(shards)} shards', flush=True)

    run(f'rm -f {REMOTE_B64}', 60)
    expected = 0
    for i, chunk in enumerate(shards):
        expected += len(chunk)
        cmd = f"printf '%s' '{chunk}' >> {REMOTE_B64} && wc -c < {REMOTE_B64}"
        for a in range(4):
            code, out = run(cmd, 120)
            try:
                size = int(out.strip().splitlines()[-1])
            except (ValueError, IndexError):
                size = -1
            if code == 0 and size == expected:
                break
            prev = expected - len(chunk)
            print(f'  [shard {i+1}] attempt{a+1} size={size} expect={expected} → retry', flush=True)
            run(f'truncate -s {prev} {REMOTE_B64}', 60)
        else:
            raise SystemExit(f'[ABORT] shard {i+1} failed 4x')

    out = run(f'md5sum {REMOTE_B64}', 120)[1]
    if not out.startswith(hashlib.md5(b64.encode('ascii')).hexdigest()):
        raise SystemExit(f'[ABORT] md5 mismatch: {out[:80]}')
    print('md5 verified', flush=True)

    code, out = run(f'''
set -e
base64 -d {REMOTE_B64} | tar xz -C {REMOTE_DIR}
rm -f {REMOTE_B64}
systemctl restart kunpeng
sleep 4
systemctl is-active kunpeng
curl -s --max-time 5 http://127.0.0.1:5100/api/health && echo
''', timeout=180)
    print(out.strip()[-200:], flush=True)
    if '"ok"' not in out:
        raise SystemExit('[ABORT] server-local health failed after push')

    for _ in range(8):
        r = subprocess.run(['curl', '-s', '--max-time', '8', 'http://47.120.43.20:5100/api/health'],
                           capture_output=True, text=True)
        if 'ok' in (r.stdout or ''):
            print('PUBLIC OK ==>', r.stdout.strip(), flush=True)
            return
        time.sleep(4)
    raise SystemExit('[ABORT] public health failed after push')


if __name__ == '__main__':
    main()
