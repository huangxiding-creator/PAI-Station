# -*- coding: utf-8 -*-
"""Fast patch deploy: only changed files (few shards), overwrite in place, restart."""
from __future__ import annotations

import base64
import io
import sys
import tarfile
import time
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from ecs_kp_deploy3 import run, sh, SHARD  # noqa: E402

REPO = Path(r'E:\AI-Station\kunpeng-bid')
FILES = sys.argv[1].split(',') if len(sys.argv) > 1 else [
    'kunpeng/workflow.py', 'server.py', 'static/app.html', 'static/index.html', 'config.yaml',
]


def main():
    buf = io.BytesIO()
    with tarfile.open(fileobj=buf, mode='w:gz') as tf:
        for rel in FILES:
            p = REPO / rel
            if p.exists():
                tf.add(p, arcname=rel)
    b64 = base64.b64encode(buf.getvalue()).decode('ascii')
    shards = [b64[i:i + SHARD] for i in range(0, len(b64), SHARD)]
    print(f'patch payload {len(buf.getvalue())}B -> {len(shards)} shards', flush=True)

    import time as _t
    _ts = int(_t.time())
    _remote = f'/tmp/kp_patch_{_ts}.b64'
    sh('prep', f'rm -f {_remote}')
    for i, chunk in enumerate(shards):
        sh(f'shard {i+1}/{len(shards)}', f"printf '%s' '{chunk}' >> {_remote}", timeout=120)
    sh('apply+restart', f'''
set -e
base64 -d {_remote} | tar xz -C /opt/kunpeng-bid
rm -f {_remote}
systemctl restart kunpeng || true
sleep 5
systemctl is-active kunpeng || systemctl restart kunpeng
sleep 3
curl -s --max-time 8 http://127.0.0.1:5100/api/health && echo
''', timeout=300)

    for i in range(10):
        import subprocess
        r = subprocess.run(['curl', '-s', '--max-time', '6', 'http://47.120.43.20:5100/api/health'],
                           capture_output=True, text=True)
        if 'ok' in r.stdout:
            print('PUBLIC OK ==>', r.stdout.strip())
            print('==> http://47.120.43.20:5100 <==')
            return
        time.sleep(4)
    raise SystemExit('[ABORT] public health failed after patch')


if __name__ == '__main__':
    main()
