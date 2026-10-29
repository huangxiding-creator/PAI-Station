# -*- coding: utf-8 -*-
"""Quick frontend-only deploy: write app.html directly via multiple cloud assistant calls."""
import base64
import json
import subprocess
import time

REGION = 'cn-heyuan'
INSTANCE = 'i-f8zaqhv365cwhti5y35'

def run_cmd(script, timeout=120):
    """Single cloud assistant command, return (exit_code, output)."""
    b64cmd = base64.b64encode(script.encode('utf-8')).decode('ascii')
    r = subprocess.run(
        ['aliyun', 'ecs', 'RunCommand', '--RegionId', REGION,
         '--InstanceId.1', INSTANCE, '--Type', 'RunShellScript',
         '--Name', 'kp-fe', '--Timeout', str(timeout),
         '--ContentEncoding', 'Base64', '--CommandContent', b64cmd],
        capture_output=True, text=True, encoding='utf-8', errors='replace')
    if r.returncode != 0:
        return -1, f"CLI error: {r.stderr[:100]}"
    inv = json.loads(r.stdout).get('InvokeId', '')
    if not inv:
        return -1, f"No InvokeId: {r.stdout[:100]}"
    # Poll (max 10 tries × 10s)
    for _ in range(timeout // 10):
        time.sleep(10)
        r2 = subprocess.run(
            ['aliyun', 'ecs', 'DescribeInvocationResults', '--RegionId', REGION,
             '--InvokeId', inv],
            capture_output=True, text=True, encoding='utf-8', errors='replace')
        try:
            d = json.loads(r2.stdout)
            recs = d.get('Invocation', {}).get('InvocationResults', {}).get('InvocationResult', [])
            if recs:
                code = recs[0].get('ExitCode')
                if code is not None:
                    out = base64.b64decode(recs[0].get('Output', '') or b'').decode('utf-8', 'replace')
                    return code, out
        except (json.JSONDecodeError, KeyError):
            continue
    return -1, 'POLL_TIMEOUT'


# Read the app.html content
with open(r'E:\AI-Station\kunpeng-bid\static\app.html', 'rb') as f:
    html = f.read()

# Split into chunks that fit in cloud assistant commands (safe: 8KB per command)
CHUNK = 8000
chunks = [html[i:i+CHUNK] for i in range(0, len(html), CHUNK)]
print(f'app.html: {len(html)}B → {len(chunks)} chunks')

# Write chunks sequentially using base64 echo
fname = '/tmp/app_html.b64'
code, out = run_cmd(f'rm -f {fname} && echo -n "" > {fname}', timeout=30)
if code != 0:
    print(f'prep failed: {out}')
    exit(1)
print('prep OK')

for i, chunk in enumerate(chunks):
    b64chunk = base64.b64encode(chunk).decode('ascii')
    cmd = f"printf '%s' '{b64chunk}' >> {fname}"
    code, out = run_cmd(cmd, timeout=30)
    status = 'OK' if code == 0 else f'FAIL({code})'
    print(f'chunk {i+1}/{len(chunks)}: {status}')
    if code != 0:
        print(f'  error: {out[:100]}')
        exit(1)

# Assemble + deploy
final = f'''
set -e
base64 -d {fname} > /opt/kunpeng-bid/static/app.html
rm -f {fname}
echo "size: $(wc -c < /opt/kunpeng-bid/static/app.html)"
echo "features: $(grep -c 'btnFinalReview\\|btnEditor\\|btnPPT' /opt/kunpeng-bid/static/app.html)"
systemctl restart kunpeng || true
sleep 4
systemctl is-active kunpeng || true
curl -s --max-time 5 http://127.0.0.1:5100/api/health && echo
'''
code, out = run_cmd(final, timeout=120)
print(f'apply: exit={code}')
print(out[-300:])
